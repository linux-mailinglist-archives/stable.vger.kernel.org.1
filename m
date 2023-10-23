Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A07D352C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjJWLpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjJWLpc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:45:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A3B0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECC9C433C7;
        Mon, 23 Oct 2023 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061528;
        bh=5vmSEBd/dQIea0U1HIYo2z0XXL+n4KgxplVwl8bVUgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdttTEvAdKoN8HBAmT9kS9ov5lkNZe+xYtvURdUbhGHlY098r2imm5+LPz1qpPyVL
         VVgBazpsddU/rMJoZKzy8HlYOU7jSwIGltV2RMmkhC75Rugn6J0iWysGIQB27NukTY
         0wHycvqcZYKy20tG7B9HDxuoLVEllxVvNc+RzRJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Yang <yangx.jy@fujitsu.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.10 078/202] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Date:   Mon, 23 Oct 2023 12:56:25 +0200
Message-ID: <20231023104828.827711040@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>

commit 12f35199a2c0551187edbf8eb01379f0598659fa upstream.

This change fixes the following kernel NULL pointer dereference
which is reproduced by blktests srp/007 occasionally.

BUG: kernel NULL pointer dereference, address: 0000000000000170
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Not tainted 6.0.0-rc1+ #37
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
Workqueue:  0x0 (kblockd)
RIP: 0010:srp_recv_done+0x176/0x500 [ib_srp]
Code: 00 4d 85 ff 0f 84 52 02 00 00 48 c7 82 80 02 00 00 00 00 00 00 4c 89 df 4c 89 14 24 e8 53 d3 4a f6 4c 8b 14 24 41 0f b6 42 13 <41> 89 87 70 01 00 00 41 0f b6 52 12 f6 c2 02 74 44 41 8b 42 1c b9
RSP: 0018:ffffaef7c0003e28 EFLAGS: 00000282
RAX: 0000000000000000 RBX: ffff9bc9486dea60 RCX: 0000000000000000
RDX: 0000000000000102 RSI: ffffffffb76bbd0e RDI: 00000000ffffffff
RBP: ffff9bc980099a00 R08: 0000000000000001 R09: 0000000000000001
R10: ffff9bca53ef0000 R11: ffff9bc980099a10 R12: ffff9bc956e14000
R13: ffff9bc9836b9cb0 R14: ffff9bc9557b4480 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9bc97ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000170 CR3: 0000000007e04000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 __ib_process_cq+0xb7/0x280 [ib_core]
 ib_poll_handler+0x2b/0x130 [ib_core]
 irq_poll_softirq+0x93/0x150
 __do_softirq+0xee/0x4b8
 irq_exit_rcu+0xf7/0x130
 sysvec_apic_timer_interrupt+0x8e/0xc0
 </IRQ>

Fixes: ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
Link: https://lore.kernel.org/r/20220831081626.18712-1-yangx.jy@fujitsu.com
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
Acked-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1955,7 +1955,8 @@ static void srp_process_rsp(struct srp_r
 		if (scmnd) {
 			req = scsi_cmd_priv(scmnd);
 			scmnd = srp_claim_req(ch, req, NULL, scmnd);
-		} else {
+		}
+		if (!scmnd) {
 			shost_printk(KERN_ERR, target->scsi_host,
 				     "Null scmnd for RSP w/tag %#016llx received on ch %td / QP %#x\n",
 				     rsp->tag, ch - target->ch, ch->qp->qp_num);


