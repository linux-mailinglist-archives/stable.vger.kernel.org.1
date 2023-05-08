Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C06FA547
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjEHKHp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjEHKHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1383046B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FF362379
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D170C433EF;
        Mon,  8 May 2023 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540461;
        bh=dP45R4CZV3DPKlDDdDnH2kNxm0zUoQ0wH1+hA9ul/Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQkDEZWr0iUPWuQgs7LBh5qCdNFV2YOxm9dlV/tFE2ZdLFka6xdE0R5rpmxqzZEQJ
         Y6doCt2bobbul7oSAPlOlSZt3WgkyZIBYb1ENzOzAaoe3+8wAVSR5p2Mti3lnv9D/a
         CjPxLi3csLIYsbsxfDKBMnpZiPSEzSc/+xG+43Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 373/611] netfilter: conntrack: fix wrong ct->timeout value
Date:   Mon,  8 May 2023 11:43:35 +0200
Message-Id: <20230508094434.479732834@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 73db1b8f2bb6725b7391e85aab41fdf592b3c0c1 ]

(struct nf_conn)->timeout is an interval before the conntrack
confirmed.  After confirmed, it becomes a timestamp.

It is observed that timeout of an unconfirmed conntrack:
- Set by calling ctnetlink_change_timeout(). As a result,
  `nfct_time_stamp` was wrongly added to `ct->timeout` twice.
- Get by calling ctnetlink_dump_timeout(). As a result,
  `nfct_time_stamp` was wrongly subtracted.

Call Trace:
 <TASK>
 dump_stack_lvl
 ctnetlink_dump_timeout
 __ctnetlink_glue_build
 ctnetlink_glue_build
 __nfqnl_enqueue_packet
 nf_queue
 nf_hook_slow
 ip_mc_output
 ? __pfx_ip_finish_output
 ip_send_skb
 ? __pfx_dst_output
 udp_send_skb
 udp_sendmsg
 ? __pfx_ip_generic_getfrag
 sock_sendmsg

Separate the 2 cases in:
- Setting `ct->timeout` in __nf_ct_set_timeout().
- Getting `ct->timeout` in ctnetlink_dump_timeout().

Pablo appends:

Update ctnetlink to set up the timeout _after_ the IPS_CONFIRMED flag is
set on, otherwise conntrack creation via ctnetlink breaks.

Note that the problem described in this patch occurs since the
introduction of the nfnetlink_queue conntrack support, select a
sufficiently old Fixes: tag for -stable kernel to pick up this fix.

Fixes: a4b4766c3ceb ("netfilter: nfnetlink_queue: rename related to nfqueue attaching conntrack info")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_core.h |  6 +++++-
 net/netfilter/nf_conntrack_netlink.c      | 13 +++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_core.h b/include/net/netfilter/nf_conntrack_core.h
index b2b9de70d9f4d..a36f87af415c2 100644
--- a/include/net/netfilter/nf_conntrack_core.h
+++ b/include/net/netfilter/nf_conntrack_core.h
@@ -90,7 +90,11 @@ static inline void __nf_ct_set_timeout(struct nf_conn *ct, u64 timeout)
 {
 	if (timeout > INT_MAX)
 		timeout = INT_MAX;
-	WRITE_ONCE(ct->timeout, nfct_time_stamp + (u32)timeout);
+
+	if (nf_ct_is_confirmed(ct))
+		WRITE_ONCE(ct->timeout, nfct_time_stamp + (u32)timeout);
+	else
+		ct->timeout = (u32)timeout;
 }
 
 int __nf_ct_change_timeout(struct nf_conn *ct, u64 cta_timeout);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index a68391e228f0e..cb4325b8ebb11 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -176,7 +176,12 @@ static int ctnetlink_dump_status(struct sk_buff *skb, const struct nf_conn *ct)
 static int ctnetlink_dump_timeout(struct sk_buff *skb, const struct nf_conn *ct,
 				  bool skip_zero)
 {
-	long timeout = nf_ct_expires(ct) / HZ;
+	long timeout;
+
+	if (nf_ct_is_confirmed(ct))
+		timeout = nf_ct_expires(ct) / HZ;
+	else
+		timeout = ct->timeout / HZ;
 
 	if (skip_zero && timeout == 0)
 		return 0;
@@ -2253,9 +2258,6 @@ ctnetlink_create_conntrack(struct net *net,
 	if (!cda[CTA_TIMEOUT])
 		goto err1;
 
-	timeout = (u64)ntohl(nla_get_be32(cda[CTA_TIMEOUT])) * HZ;
-	__nf_ct_set_timeout(ct, timeout);
-
 	rcu_read_lock();
  	if (cda[CTA_HELP]) {
 		char *helpname = NULL;
@@ -2319,6 +2321,9 @@ ctnetlink_create_conntrack(struct net *net,
 	/* we must add conntrack extensions before confirmation. */
 	ct->status |= IPS_CONFIRMED;
 
+	timeout = (u64)ntohl(nla_get_be32(cda[CTA_TIMEOUT])) * HZ;
+	__nf_ct_set_timeout(ct, timeout);
+
 	if (cda[CTA_STATUS]) {
 		err = ctnetlink_change_status(ct, cda);
 		if (err < 0)
-- 
2.39.2



