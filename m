Return-Path: <stable+bounces-76229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B797A0B1
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FF7281CDD
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED214F12F;
	Mon, 16 Sep 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fFQv5AJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6647A62;
	Mon, 16 Sep 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487997; cv=none; b=U9uKAS6QrTzVkFuRU+7zmeIOWCkqox6Mr5jOol/kD78LxjpYDGc/naSIlisH95A1MlzRZ2iI5fz8b7IMpPpja7H4nP9KnNGlMhXSfaPTHrW6CAFPWxQ0MlETq1ECrfxGxf4GiMqkX+vj3wU9Hca/ANYg6Kj+LwlCAygeUyJqA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487997; c=relaxed/simple;
	bh=XfSw/SnaA5Qyp9WjPorYGSqVQF26Nrohd0xmQQYHMZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgg6c8b7HpaDlpZLG5iv5IHCRcFMsHA0B/50SOj/0cpRbQ00uDYibs/3982envBWQ3VdmFvsSRathw5kJsGyaUpptlWshATlT0ti5xA9LaaxbpvnW6A1Q0cSgQl3rbMlJt5bT+trBcNA8PMROYFt3+Z0nw8iTKJ83RGrEd9GsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fFQv5AJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA9C4CEC4;
	Mon, 16 Sep 2024 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726487997;
	bh=XfSw/SnaA5Qyp9WjPorYGSqVQF26Nrohd0xmQQYHMZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFQv5AJKwuRcqkzfncnpyqR2pQQJW6qvlrSbXLQ96tuf45BS3EWNO8w5A1ae6wOPV
	 1dGneNzUZkbrywV1glKV4NqbEzAALIAEoKWhNL37biU1j260r8FeSX91oQ0kvuK3GZ
	 IeyQaAhcmUekLCBHNUx7GMSeWZT5sWuE1v7ARcCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Subject: [PATCH 6.1 23/63] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Mon, 16 Sep 2024 13:44:02 +0200
Message-ID: <20240916114221.888873612@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

commit b4cd80b0338945a94972ac3ed54f8338d2da2076 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -349,15 +349,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock
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
@@ -1488,7 +1494,6 @@ static bool remove_anno_list_by_saddr(st
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}



