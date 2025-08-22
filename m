Return-Path: <stable+bounces-172298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B188EB30E71
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E317ABEF2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8F284B39;
	Fri, 22 Aug 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyVVDkOJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C165284B25
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842691; cv=none; b=d8Tg352kRyO2hF/CbrLVLijTI+OgBw1yQ11aD4pPcOemrcQZ0kTVmELKe5vu5VCCbvhKMCtFnf7dO7m4uiwb58EH6xlMYLR2bh/75ogzI2O7Bf75ZDmFgeLWr5X/d5UeyR5EKqXlrk9aO9lWM72bbUKhwt2wPG8Tj6GHiHkx55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842691; c=relaxed/simple;
	bh=HbMpma3/PdHsmUdHTZOIs6JS3RGR7Q6b/Mwi7sAb+ok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MWEkT7VoOdDLuRNe/32nIsduCVR0CS19XzSZAL67DN7ho/7/U3PpK1x32bHxYz1e3F1I3asFvQPrlmtugxfhnSJIjiImCeOOYZmyDiTvrLg2hTX0czjRRY5KMpy8Xwzp+D0MJVDkzquu2fESC2bDo5APcs/5uDHdEnIMgNyA+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WyVVDkOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4D3C4CEF1;
	Fri, 22 Aug 2025 06:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842691;
	bh=HbMpma3/PdHsmUdHTZOIs6JS3RGR7Q6b/Mwi7sAb+ok=;
	h=Subject:To:Cc:From:Date:From;
	b=WyVVDkOJg20190SfulcdlNexTbCH4Wg/I3keStRr+4TSPxHEyz8pq9A/fbaL7C2tk
	 GMm8QzvnpTAqBqIypQG7yQxORuBBc4D5b3Kz/HGAdpamoZL4p1y9Je7DkICgCJJMqu
	 rlSeRxhfm7yCFl1LxPAFqGt5de9pM1ud+DkxvKOI=
Subject: FAILED: patch "[PATCH] mptcp: remove duplicate sk_reset_timer call" failed to apply to 5.10-stable tree
To: geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:04:31 +0200
Message-ID: <2025082231-attempt-trickily-0b68@gregkh>
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
git cherry-pick -x 5d13349472ac8abcbcb94407969aa0fdc2e1f1be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082231-attempt-trickily-0b68@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


