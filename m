Return-Path: <stable+bounces-196734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F8C80D8C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F128F3A6194
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490130B539;
	Mon, 24 Nov 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcyPkRM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0930B525
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992228; cv=none; b=b3e52+7Ojydw9U3EUB5WWFijw5IExZRqJhAVcTzc3P6GDNahdwP2xtq/79PPypf3hK1xAKOSlCgER1WBu57z7kC3diwxbwPXXJFhKqmWBwxMPzcI/jO7x/WO9O9VfIkkMgnCM8pT5UYcJAXgLdZL0zAxGcmaDAw+Nv9QvEGJCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992228; c=relaxed/simple;
	bh=G91fBBFcovU9n244U+t5TdpeJaS2oS8Kp4XNaffsHNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ryvJslWRNMcQ/wLHvlI3WLm60rYmhpMK3QbZp3gcQKKPbOVk0hFtVWof3MjuHPs11Kn57XU6OmN79gbYTt0OZOvd+kyR/0ly82CHEh8GOHDXc6pmmx+gvXQhNBUTWQCab99/M5naNbe3EdSJ+GASY0avVVnKzGMco0RRncTRZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CcyPkRM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B49DC4CEF1;
	Mon, 24 Nov 2025 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992228;
	bh=G91fBBFcovU9n244U+t5TdpeJaS2oS8Kp4XNaffsHNM=;
	h=Subject:To:Cc:From:Date:From;
	b=CcyPkRM7VM24vMN8STBAR8TD1dDRx0cJ+HY/L2YEl+a28feyDTCXiQieaAO5sw1Lb
	 zV0LO/73GnjgVXWmuHYNe7Msv2DLM/icf/IqNfeaTqhpvonGpEewIvmGcmApSJ0txG
	 JY1bGbCUW49N8RR2SwSlNS1wvQUKCLnpo4Oxt0vc=
Subject: FAILED: patch "[PATCH] mptcp: do not fallback when OoO is present" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:50:25 +0100
Message-ID: <2025112425-math-lasso-c3b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1bba3f219c5e8c29e63afa3c1fc24f875ebec119
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112425-math-lasso-c3b8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bba3f219c5e8c29e63afa3c1fc24f875ebec119 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:22 +0100
Subject: [PATCH] mptcp: do not fallback when OoO is present

In case of DSS corruption, the MPTCP protocol tries to avoid the subflow
reset if fallback is possible. Such corruptions happen in the receive
path; to ensure fallback is possible the stack additionally needs to
check for OoO data, otherwise the fallback will break the data stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-4-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e30e9043a694..6f0e8f670d83 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -76,6 +76,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);


