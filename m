Return-Path: <stable+bounces-172297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B34B30E76
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F8EAC1757
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C4271472;
	Fri, 22 Aug 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BlGAmzdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13A1662E7
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842688; cv=none; b=eTgW+pSDdYd+jMlboQXhWndOu+/YyRlbcc+RMI/6QTEeLqfDYlc1QxbbOju0nptYojIpdCRuFtqKYFir0PZj3movN2Y4zkRVAg9e5ZCZF3N14Cl6Q++XPxy9vqiXPnzjjKYh0hc5rJJ9BSHJyqOwpFLVql0MDw0/wDDx+Qj1+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842688; c=relaxed/simple;
	bh=Kh0nzZFCmmTZJaryupNJ2SIn3dOsasJzlzttYse5o7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lP/qk9ndTZozzv3KBhncKZzuC+9j+4HrjVbFwsgv8tPKd8liFoFIGPTyjLesLmhE8ldoguJjJ6E4an73ECEVqnaBUXoFeAPJsqqORMhFUG9WnMELIXir9gwrsvLuZAfEf0LZhSBzFIP3GwA1fbTWZsjSPbn5c/9Rv8FEIRm77i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BlGAmzdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5E8C4CEF1;
	Fri, 22 Aug 2025 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842687;
	bh=Kh0nzZFCmmTZJaryupNJ2SIn3dOsasJzlzttYse5o7o=;
	h=Subject:To:Cc:From:Date:From;
	b=BlGAmzdii1et5YbK+fE3Qj7+Sii/GWHQ7NIOkX+9qSsQytc55pLSJQDl90PiBXHNz
	 C2vQhimngiA+x0K2qSdyQhBHSUqrfrBNdfH6gUweM4nvaZOHOVqzO3Edt4H/dx7eB8
	 5LEPosES3Mt1UZeoF5AghoGp3Jp+F0CLf8HRywU0=
Subject: FAILED: patch "[PATCH] mptcp: remove duplicate sk_reset_timer call" failed to apply to 6.1-stable tree
To: geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:04:30 +0200
Message-ID: <2025082230-overlay-latitude-1a75@gregkh>
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
git cherry-pick -x 5d13349472ac8abcbcb94407969aa0fdc2e1f1be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082230-overlay-latitude-1a75@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d13349472ac8abcbcb94407969aa0fdc2e1f1be Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang@kernel.org>
Date: Fri, 15 Aug 2025 19:28:22 +0200
Subject: [PATCH] mptcp: remove duplicate sk_reset_timer call

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 420d416e2603..c5f6a53ce5f1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -353,9 +353,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -369,6 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 


