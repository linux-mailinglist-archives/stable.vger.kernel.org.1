Return-Path: <stable+bounces-76069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763797800A
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D921F22069
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7961DA0E7;
	Fri, 13 Sep 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7FDN+9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20F1D932B
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230813; cv=none; b=UUIYmQmJ2r8Gl8vU9zG9PDNNOTrvLgTmBdpLtmiWDxCeAZ2xrh2yvuWlZzpa1DJ72SyRetR7r+kwGWSzAo9vEIRLhByvD3oeMDB+6yLz1gjGZMU7fjaF2ofbWrjQJJFqjbiveJAu09D9yCOJB9lRymvIMSDnWbgcQfukIrfjRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230813; c=relaxed/simple;
	bh=LK5w4M4IgqEWSRC0F2CDTAVUPtVZBqImJTv0nQ/iFfA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WAdWLCVrO78GFfavnxIGZY2f21ztJimG/9zGGVN1Lab+dYUSs//91ceBs4nI4Puf68pZ0riivn4bCGYRwGDKZTfvN8W5grre7pP1JQa2qVllBtMrx9yRvnbuJVfa9KiA1IKWrwhAOHi8c97do66t1MOvUShLnRPObvKtcNERYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7FDN+9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136A0C4CEC0;
	Fri, 13 Sep 2024 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726230813;
	bh=LK5w4M4IgqEWSRC0F2CDTAVUPtVZBqImJTv0nQ/iFfA=;
	h=Subject:To:Cc:From:Date:From;
	b=B7FDN+9szBHdQCR+Ka81SfkDi+syvyxp+35SwadMcGJOr5q1IxmSChekL1m9lJqOM
	 UUoXoywwcIlGn69SkyT8ta8TPXiF8XPzWfNyieoV7hdYjvOYYamGqkgoKC7AohXwbJ
	 xhNIfZvMk+7RMw+OXLY29ifbnpwAVSOAp03VvCSg=
Subject: FAILED: patch "[PATCH] mptcp: pm: Fix uaf in __timer_delete_sync" failed to apply to 5.10-stable tree
To: eadavis@qq.com,kuba@kernel.org,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:33:30 +0200
Message-ID: <2024091330-reps-craftsman-ab67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b4cd80b0338945a94972ac3ed54f8338d2da2076
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091330-reps-craftsman-ab67@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
d58300c3185b ("mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer")
f7dafee18538 ("mptcp: use mptcp_addr_info in mptcp_options_received")
dc87efdb1a5c ("mptcp: add mptcp reset option support")
557963c383e8 ("mptcp: move to next addr when subflow creation fail")
d88c476f4a7d ("mptcp: export lookup_anno_list_by_saddr")
efd13b71a3fa ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4cd80b0338945a94972ac3ed54f8338d2da2076 Mon Sep 17 00:00:00 2001
From: Edward Adam Davis <eadavis@qq.com>
Date: Tue, 10 Sep 2024 17:58:56 +0800
Subject: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync

There are two paths to access mptcp_pm_del_add_timer, result in a race
condition:

     CPU1				CPU2
     ====                               ====
     net_rx_action
     napi_poll                          netlink_sendmsg
     __napi_poll                        netlink_unicast
     process_backlog                    netlink_unicast_kernel
     __netif_receive_skb                genl_rcv
     __netif_receive_skb_one_core       netlink_rcv_skb
     NF_HOOK                            genl_rcv_msg
     ip_local_deliver_finish            genl_family_rcv_msg
     ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
     tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
     tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
     tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
     tcp_data_queue                     remove_anno_list_by_saddr
     mptcp_incoming_options             mptcp_pm_del_add_timer
     mptcp_pm_del_add_timer             kfree(entry)

In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
zone protected by "pm.lock", the entry will be released, which leads to the
occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).

Keeping a reference to add_timer inside the lock, and calling
sk_stop_timer_sync() with this reference, instead of "entry->add_timer".

Move list_del(&entry->list) to mptcp_pm_del_add_timer and inside the pm lock,
do not directly access any members of the entry outside the pm lock, which
can avoid similar "entry->x" uaf.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..ad935d34c973 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -334,15 +334,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1462,7 +1468,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}


