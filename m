Return-Path: <stable+bounces-93724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF119D05D9
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163141F217EB
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD61CACE0;
	Sun, 17 Nov 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+UOskZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C718054
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875505; cv=none; b=GE1CAGyY+oPWvXwWyq01jxxZnB2tbNOKzP5hELs2c1DMU1L2Jwt3U+SnhN6f3cqBaeoWPSSxl7hXYmypz7OZsni2KO2DeDGwHqgtalEFtO9goxV06f5qL9w2gFYGqejrYXWwC3QG6rjG6RzwUKbi9csxIQG2i09uV0EpFeriStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875505; c=relaxed/simple;
	bh=THY4lNuV4hRsJtZyCXSk3ESS8XdQjgoPJADaHHm6Qjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kz8to++yXl8k48Np9Y1//S3pVq/pfAb7ok8HDgXRE71dTGesLX7lOF6M+TzX8wWxVo4bjGKM2P4dA6qIe1OuMEi70gL8vAqiKqpchnB4FktUyETgHq/+cCTUxM5byt7eiNKny7TQqEgHuJFHZystNj6ii0U2C87TVEZK6e3qgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+UOskZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CD5C4CECD;
	Sun, 17 Nov 2024 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875504;
	bh=THY4lNuV4hRsJtZyCXSk3ESS8XdQjgoPJADaHHm6Qjs=;
	h=Subject:To:Cc:From:Date:From;
	b=F+UOskZoK/c1oyIcLuizIJtdGjpgnZ8pA8IGXAKS6tT/gy0ynqqslSbo98igml8Tq
	 HlUjuQtnDrLQfEkHpor10bBAHhzjDxctsnqD1xsVRtRnq750SYo43c95pjuYVH7NLQ
	 UzeLD3o5j/DEt/XkTuLt5CvknP8GOBSUU2VMaA2Q=
Subject: FAILED: patch "[PATCH] mptcp: hold pm lock when deleting entry" failed to apply to 6.1-stable tree
To: geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:31:12 +0100
Message-ID: <2024111712-unnerving-implicate-ad47@gregkh>
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
git cherry-pick -x f642c5c4d528d11bd78b6c6f84f541cd3c0bea86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111712-unnerving-implicate-ad47@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang@kernel.org>
Date: Tue, 12 Nov 2024 20:18:34 +0100
Subject: [PATCH] mptcp: hold pm lock when deleting entry

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f888bfe1462..e35178f5205f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -308,14 +308,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 


