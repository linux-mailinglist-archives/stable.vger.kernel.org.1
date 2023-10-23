Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA57D3155
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjJWLIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjJWLIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:08:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03D10CB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:08:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F59C433C8;
        Mon, 23 Oct 2023 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059286;
        bh=76C/8/vIbCsMcOp6LBk/nkmDv3YDpPxq1qA3UmfYU3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAFPw/R/zWdePsIkal55zR3+SkNNEfsIlfAESK1n88MpXV2ea4HrCH4r0MIVswi+4
         y3is/2o53MGZBNli+8cWLZDeo8FDGFaQ6imzKfgOxW5q4kJjG87W1kBk8EQUsQUb3n
         3S3mJeMmk9h7Qo8yKXyUQmC3f+hcG9ZL2P+Z1HiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 127/241] SUNRPC/TLS: Lock the lower_xprt during the tls handshake
Date:   Mon, 23 Oct 2023 12:55:13 +0200
Message-ID: <20231023104836.966801988@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit 26e8bfa30dac2ccd29dd25f391dfc73475c33329 ]

Otherwise we run the risk of having the lower_xprt freed from underneath
us, causing an oops that looks like this:

[  224.150698] BUG: kernel NULL pointer dereference, address: 0000000000000018
[  224.150951] #PF: supervisor read access in kernel mode
[  224.151117] #PF: error_code(0x0000) - not-present page
[  224.151278] PGD 0 P4D 0
[  224.151361] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  224.151499] CPU: 2 PID: 99 Comm: kworker/u10:6 Not tainted 6.6.0-rc3-g6465e260f487 #41264 a00b0960990fb7bc6d6a330ee03588b67f08a47b
[  224.151977] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[  224.152216] Workqueue: xprtiod xs_tcp_tls_setup_socket [sunrpc]
[  224.152434] RIP: 0010:xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc]
[  224.152643] Code: 00 00 48 8b 7c 24 08 e9 f3 01 00 00 48 83 7b c0 00 0f 85 d2 01 00 00 49 8d 84 24 f8 05 00 00 48 89 44 24 10 48 8b 00 48 89 c5 <4c> 8b 68 18 66 41 83 3f 0a 75 71 45 31 ff 4c 89 ef 31 f6 e8 5c 76
[  224.153246] RSP: 0018:ffffb00ec060fd18 EFLAGS: 00010246
[  224.153427] RAX: 0000000000000000 RBX: ffff8c06c2e53e40 RCX: 0000000000000001
[  224.153652] RDX: ffff8c073bca2408 RSI: 0000000000000282 RDI: ffff8c06c259ee00
[  224.153868] RBP: 0000000000000000 R08: ffffffff9da55aa0 R09: 0000000000000001
[  224.154084] R10: 00000034306c30f1 R11: 0000000000000002 R12: ffff8c06c2e51800
[  224.154300] R13: ffff8c06c355d400 R14: 0000000004208160 R15: ffff8c06c2e53820
[  224.154521] FS:  0000000000000000(0000) GS:ffff8c073bd00000(0000) knlGS:0000000000000000
[  224.154763] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.154940] CR2: 0000000000000018 CR3: 0000000062c1e000 CR4: 0000000000750ee0
[  224.155157] PKRU: 55555554
[  224.155244] Call Trace:
[  224.155325]  <TASK>
[  224.155395]  ? __die_body+0x68/0xb0
[  224.155507]  ? page_fault_oops+0x34c/0x3a0
[  224.155635]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  224.155793]  ? exc_page_fault+0x7a/0x1b0
[  224.155916]  ? asm_exc_page_fault+0x26/0x30
[  224.156047]  ? xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.156367]  ? xs_tcp_tls_setup_socket+0x2fe/0x7e0 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.156697]  ? __pfx_xs_tls_handshake_done+0x10/0x10 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.157013]  process_scheduled_works+0x24e/0x450
[  224.157158]  worker_thread+0x21c/0x2d0
[  224.157275]  ? __pfx_worker_thread+0x10/0x10
[  224.157409]  kthread+0xe8/0x110
[  224.157510]  ? __pfx_kthread+0x10/0x10
[  224.157628]  ret_from_fork+0x37/0x50
[  224.157741]  ? __pfx_kthread+0x10/0x10
[  224.157859]  ret_from_fork_asm+0x1b/0x30
[  224.157983]  </TASK>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9f010369100a2..f392718951b1e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2645,6 +2645,10 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	rcu_read_lock();
 	lower_xprt = rcu_dereference(lower_clnt->cl_xprt);
 	rcu_read_unlock();
+
+	if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE))
+		goto out_unlock;
+
 	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
 	if (status) {
 		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
@@ -2654,6 +2658,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	status = xs_tcp_tls_finish_connecting(lower_xprt, upper_transport);
 	if (status)
 		goto out_close;
+	xprt_release_write(lower_xprt, NULL);
 
 	trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
 	if (!xprt_test_and_set_connected(upper_xprt)) {
@@ -2675,6 +2680,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	return;
 
 out_close:
+	xprt_release_write(lower_xprt, NULL);
 	rpc_shutdown_client(lower_clnt);
 
 	/* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
-- 
2.40.1



