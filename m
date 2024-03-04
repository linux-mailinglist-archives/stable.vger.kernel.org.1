Return-Path: <stable+bounces-25870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF486FDC3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602412817B2
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AF224EE;
	Mon,  4 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmLfcZ+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FC19BA6
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544621; cv=none; b=cEK5vs6CavOEXq5xra0M++793p6+Ft2KIQgcYoORsajnnnozVSQK/5UC9w0kYwjfK+0cg4c+rMDBlUXN9886KWlFWn9r8NyJbtRnPXZOKGDtgz929uXkPj+l2R0EmarjeKLs/tXPEw/H2S+ApEENoxT3wXYC/Oz0Iwxgj3aYeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544621; c=relaxed/simple;
	bh=RhiptP6lU57QdkXL4e9hoYZ6SasBAIIF6eegaIGmisA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S+GW7At/GLdHUyctKgkT6surThjQ7eoF/cWA2duPPuiaBOtZpMvQiKpNDGHnKTJDLZiPVaSbGvRSCeCVD01pGR5MR3FJ+bIaIlIMEQhPR5TjT1ZoINaXQ9eugnFnnjSQYSYS5qiTjR6Yd6o103RU+tXvlJzbjrF1m+fnvFb+Fc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmLfcZ+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B16DC433F1;
	Mon,  4 Mar 2024 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709544620;
	bh=RhiptP6lU57QdkXL4e9hoYZ6SasBAIIF6eegaIGmisA=;
	h=Subject:To:Cc:From:Date:From;
	b=qmLfcZ+AxPdrc5xWEOSV+R9vPsSTgMBhNavbvXNy+YrNO+EuYeluhzRNpA87Ese/F
	 qnaQMFF6wtmFP5FfGh8gj3vF3ZfadGRdzueBG5M0qaY6fJTPUo+0sNPCiZgsyx3iEw
	 rRgYAAGA+rMuPvpIA4+pFLg8j74vc6X5juouPMF4=
Subject: FAILED: patch "[PATCH] mptcp: fix snd_wnd initialization for passive socket" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 10:30:17 +0100
Message-ID: <2024030417-jaws-icky-a0f2@gregkh>
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
git cherry-pick -x adf1bb78dab55e36d4d557aa2fb446ebcfe9e5ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030417-jaws-icky-a0f2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

adf1bb78dab5 ("mptcp: fix snd_wnd initialization for passive socket")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From adf1bb78dab55e36d4d557aa2fb446ebcfe9e5ce Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 23 Feb 2024 17:14:15 +0100
Subject: [PATCH] mptcp: fix snd_wnd initialization for passive socket

Such value should be inherited from the first subflow, but
passive sockets always used 'rsk_rcv_wnd'.

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-5-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 442fa7d9b57a..2c8f931c6d5b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3211,7 +3211,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
 	msk->snd_una = msk->write_seq;
-	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
+	msk->wnd_end = msk->snd_nxt + tcp_sk(ssk)->snd_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 


