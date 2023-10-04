Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4110B7B8955
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbjJDSYz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjJDSYz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E91A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF577C433C9;
        Wed,  4 Oct 2023 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443891;
        bh=Ya/C+ivrtOVhKh3vMf5raxjiG4WvYa/2+zIlCOd6CLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1ZoR7KlwBgcukixORU8+Iunl9jO5SSMB+CxDzKSvX8jLCDRubAVpSsj2XbwspUeK
         rumPOJ3ph2priFHo134loKhjMC0yzvFYEF6ORnNT/lNI4hz34Qj20A3JWcBbCiSPV+
         yVqWTS8DF+e+DYDB4S6KGNTlhAlkmkWa1g/dpsP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com,
        Eduard Zingerman <eddyz87@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 028/321] bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
Date:   Wed,  4 Oct 2023 19:52:53 +0200
Message-ID: <20231004175230.473588679@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 1a49f4195d3498fe458a7f5ff7ec5385da70d92e ]

Fix for a bug observable under the following sequence of events:
1. Create a network device that does not support XDP offload.
2. Load a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
   (such programs are not offloaded).
3. Load a device bound XDP program with zero flags
   (such programs are offloaded).

At step (2) __bpf_prog_dev_bound_init() associates with device (1)
a dummy bpf_offload_netdev struct with .offdev field set to NULL.
At step (3) __bpf_prog_dev_bound_init() would reuse dummy struct
allocated at step (2).
However, downstream usage of the bpf_offload_netdev assumes that
.offdev field can't be NULL, e.g. in bpf_prog_offload_verifier_prep().

Adjust __bpf_prog_dev_bound_init() to require bpf_offload_netdev
with non-NULL .offdev for offloaded BPF programs.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20230912005539.2248244-2-eddyz87@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8a26cd8814c1b..e842229123ffc 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -198,12 +198,14 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
 	offload->netdev = netdev;
 
 	ondev = bpf_offload_find_netdev(offload->netdev);
+	/* When program is offloaded require presence of "true"
+	 * bpf_offload_netdev, avoid the one created for !ondev case below.
+	 */
+	if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
+		err = -EINVAL;
+		goto err_free;
+	}
 	if (!ondev) {
-		if (bpf_prog_is_offloaded(prog->aux)) {
-			err = -EINVAL;
-			goto err_free;
-		}
-
 		/* When only binding to the device, explicitly
 		 * create an entry in the hashtable.
 		 */
-- 
2.40.1



