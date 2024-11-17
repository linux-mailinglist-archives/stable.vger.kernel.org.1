Return-Path: <stable+bounces-93722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B079D05D7
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC5A1F218D5
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED11CACE0;
	Sun, 17 Nov 2024 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6aKuQYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312318054
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875492; cv=none; b=ppuFd1B6Ds+j0qKtPLTCXm0OnPCBNX00jhegNueahQJc1Dm4WRIRpEi2RgVpjEVtAoaY370C9dSkTkrqmxoC3ikUPbN7wDOga+oFdVp8ua0wYq8qZ9lxHuOkJPLMwRwTpBIPZ0LWl4rViTQ6ImxqzRKoPih1QoXF4ECGsd59LGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875492; c=relaxed/simple;
	bh=DhtGv7ZBWpznPl/kiEHLOHa0sK5Gnm/w3TDGJznt60w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c+HPtrUQOtEyKvAugACfiHXsj7UT2bn84eoaSi6kIMOHj54vOSU3rklPBrFUU3Nrq/0G889zgFvPidy/21A0R2KRI56LVXjSBdrWauL1ncejxsJO8vJwMfHG/vbnxlczCrNaT1KZSxNFFmoT1rymC91Dj1kgGm0hKR7R7itxOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6aKuQYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A51C4CECD;
	Sun, 17 Nov 2024 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875491;
	bh=DhtGv7ZBWpznPl/kiEHLOHa0sK5Gnm/w3TDGJznt60w=;
	h=Subject:To:Cc:From:Date:From;
	b=r6aKuQYYYKJN+db3hcfHUfJd2ksGyBQ6FakBNVoO3Mx7qu9XOrAgtVTIP7+snICsl
	 4XRkkHKRxvPqSx1M5hG2rMzojv1nPq8V40/derEi7i2PlNsseR4hGq21111e3Qzp54
	 P4NBkk4NdsbihLSJENzqrRBi+UXGO+NjPl6QTLzI=
Subject: FAILED: patch "[PATCH] mptcp: update local address flags when setting it" failed to apply to 6.1-stable tree
To: geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:30:59 +0100
Message-ID: <2024111759-tummy-survey-9bee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e0266319413d5d687ba7b6df7ca99e4b9724a4f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111759-tummy-survey-9bee@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0266319413d5d687ba7b6df7ca99e4b9724a4f2 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang@kernel.org>
Date: Tue, 12 Nov 2024 20:18:33 +0100
Subject: [PATCH] mptcp: update local address flags when setting it

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 56dfea9862b7..3f888bfe1462 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -560,6 +560,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct net *net = sock_net(skb->sk);
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -601,6 +602,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);


