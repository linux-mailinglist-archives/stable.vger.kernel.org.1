Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6372C207
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjFLLCS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjFLLCC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F44C16
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E605B624DC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0387AC433EF;
        Mon, 12 Jun 2023 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566956;
        bh=MXGF0WC2bwzTIbBJ7Uvj47hsej7sr4aHviW7dj42Uwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpRrG1Vni7/5Mg3k9/ijyWJ+6s+5czvf8MJqxcHSojKvJRgyV6hrYbtUbN9UyPdat
         dnq94OxPYNJ6iPvqnAHTKVZaVTJ3p0SpmCFoP7VPgXRRn6XY5rrHCoP4obpn1U6dFB
         s2W6gJzjD9FLy7MBySdtCrOGTNTe2HH959x9YGog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Geliang Tang <geliang.tang@suse.com>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 096/160] mptcp: only send RM_ADDR in nl_cmd_remove
Date:   Mon, 12 Jun 2023 12:27:08 +0200
Message-ID: <20230612101719.402198656@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

commit 8b1c94da1e481090f24127b2c420b0c0b0421ce3 upstream.

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c   |   18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |    2 +-
 net/mptcp/protocol.h     |    1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1558,6 +1558,24 @@ static int mptcp_nl_cmd_del_addr(struct
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		remove_anno_list_by_saddr(msk, &entry->addr);
+		if (alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,6 +835,7 @@ int mptcp_pm_announce_addr(struct mptcp_
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 


