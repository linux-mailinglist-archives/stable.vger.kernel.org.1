Return-Path: <stable+bounces-66523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2994ED2D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387061C21DB5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736417B4EB;
	Mon, 12 Aug 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6O9L7Wm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BB17B43F
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466362; cv=none; b=sB6QFFEUqqPM00F3tOoCige+jCOE1PqT78tyIgFR4GzYokHzNl/svEOvIDLtg7td88VP2mF3ZYxo7QdrEaeccYU6Urj5PMsvm2oNBME/BlDs0crH7xA9WOQiE2aSTBU1sIaDXU13s7zFBGXHHCadEaRrov5rJ684RprUnjolGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466362; c=relaxed/simple;
	bh=I1c81XM0K8Hd5ygonZD9qyqd0kSbw+6K6ry2Y0bDAmY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tg7HYnjBBWpgyrJipL81Ai8VkCAZRnOnBf9mQRx1koHt8dJJ+K5h7OOZoSbBO+y15x0qS90CHfa2aaUn4mkqL+zNYCy+kUqsmCjRBm/VKzONePJk1oK/aXPh9vLkos5Gxx9bB1fHVIBcne41Aq1AzsRhVhHc8Zyyvufy/V7f044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6O9L7Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC89C32782;
	Mon, 12 Aug 2024 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466362;
	bh=I1c81XM0K8Hd5ygonZD9qyqd0kSbw+6K6ry2Y0bDAmY=;
	h=Subject:To:Cc:From:Date:From;
	b=T6O9L7Wm/zjK3WrRfvdsUi7hGSBuAxMjcIB5PpgUyECvl+4D2YhYL3g7Qx1M0YRQL
	 vk6/Dx3PpJTMIsG1rGXBkpWwo1BQre5Z3sf/0aROQ79QxDVE9GVH6m/K5PAHmAwp4B
	 NHzJlQfZPPAUOLxsYyD5OAf8Uo+zq9hEOn3YIIw4=
Subject: FAILED: patch "[PATCH] mptcp: fully established after ADD_ADDR echo on MPJ" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:39:09 +0200
Message-ID: <2024081209-wrongly-zen-35f3@gregkh>
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
git cherry-pick -x d67c5649c1541dc93f202eeffc6f49220a4ed71d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081209-wrongly-zen-35f3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d67c5649c154 ("mptcp: fully established after ADD_ADDR echo on MPJ")
b3ea6b272d79 ("mptcp: consolidate initial ack seq generation")
f3589be0c420 ("mptcp: never shrink offered window")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d67c5649c1541dc93f202eeffc6f49220a4ed71d Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:53 +0200
Subject: [PATCH] mptcp: fully established after ADD_ADDR echo on MPJ

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a68382a4fe9..ac2f1a54cc43 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -958,7 +958,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (subflow->remote_key_valid &&
 	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	      (!mp_opt->echo || subflow->mp_join)))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */


