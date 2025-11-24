Return-Path: <stable+bounces-196736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DDC80D92
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8EB3A5CCA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760C30B51E;
	Mon, 24 Nov 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J3N7UXNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598230B517
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992246; cv=none; b=GjpBoFg24JSy8mZuy9xbWP90htmw6S6BH1GqwhFtcgy+SNGJFXA2w8WXyx5FW4pHYpE/6mMtNL5MJ/IedRKoofp3udmqB5isewOj8IEvQWCKu/Gs+9sxTaY/f9F/0ns2Yh+N2ImVJBi1OYEIapdhmo2KP3SFX4AgDrh5RGaO8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992246; c=relaxed/simple;
	bh=C1mwNlGkEm4YCb7bTxWUUmKj6ZyS8FdDRos5F/fnNhQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EnjpbEHmMN/Ft5JWtn3/5mHGW0S1+WyQ/zS8loY3Jmusp2z4zW0x7THebuOjCteNxUVDqDwqtPHSJkH264hxomA+wTJy6oYAZV9EZdoBZ3PYk0NNmBE9d3qC99ToEvPqEGTIk6IQgliWn1diGe2vKCYDaNOdlHX/KoLzC2v4icQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J3N7UXNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D060C4CEF1;
	Mon, 24 Nov 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992245;
	bh=C1mwNlGkEm4YCb7bTxWUUmKj6ZyS8FdDRos5F/fnNhQ=;
	h=Subject:To:Cc:From:Date:From;
	b=J3N7UXNa1rwAs2MPCtIpwTb+DR0zSQheaVAqIXBdybiv3VzT5Kjd9pl6SDE86u1qT
	 z3q4nyq4roQdLQu+dLSpRuyY2BDy58UvL8WCeGmAhdrIruFtYui6cCNJfIbMpUcCsF
	 fQsWkoQLOcUSSh25fuzxwQoMLnHEPQv/dInCUnfs=
Subject: FAILED: patch "[PATCH] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr" failed to apply to 6.17-stable tree
To: yangang@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:50:35 +0100
Message-ID: <2025112435-stray-aflutter-0f77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 92e239e36d600002559074994a545fcfac9afd2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112435-stray-aflutter-0f77@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92e239e36d600002559074994a545fcfac9afd2d Mon Sep 17 00:00:00 2001
From: Gang Yan <yangang@kylinos.cn>
Date: Tue, 18 Nov 2025 08:20:28 +0100
Subject: [PATCH] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr

Fix inverted WARN_ON_ONCE condition that prevented normal address
removal counter updates. The current code only executes decrement
logic when the counter is already 0 (abnormal state), while
normal removals (counter > 0) are ignored.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Fixes: 636113918508 ("mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-10-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 2ae95476dba3..0a50fd5edc06 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -672,7 +672,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
-	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+	if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		u8 limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 


