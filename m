Return-Path: <stable+bounces-133043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D175A91AB5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893EE17E803
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC023C8AC;
	Thu, 17 Apr 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xP7A1A2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328223C385
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889066; cv=none; b=NqcErlhDn3dl/bSnSrJgwdOPH08j1Ad1ThwWA26C9HsOAIyVpWpAYhQlW3P/Q2hPfDoOpfmmw42Bu/GzU+pdzk3khqYHBHzGfVXUXQ/h5Efm7Fveyt8sah46V8SK408bZxtG2w3cOuHc5JEca/AGVRqTHpopnnH6C1c9pHMgTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889066; c=relaxed/simple;
	bh=A3jyd7Rcr/aWklF4tEuzt5MqigIvCV5OMSDBH/vR3VY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RhoVMPdBVjCK0+/M9eX2E1FpHzqci1hpw1DrTRdHP5FcqNuJIFK5/jN1vwPpICAfPZRcxcailycPeBY74rLJx2AoCVDPAX/7TF2kKaxxfEsmmfqcst/H8ou9XWWwOdjoU92p4QeJbOCI1Tr/7jq3Wif022LR3V05qDi2npycurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xP7A1A2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011E7C4CEE4;
	Thu, 17 Apr 2025 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889065;
	bh=A3jyd7Rcr/aWklF4tEuzt5MqigIvCV5OMSDBH/vR3VY=;
	h=Subject:To:Cc:From:Date:From;
	b=xP7A1A2S+4APCH3TFsT7sjHLYJ/tQ8qKtupQ8m3VafH/iR3mb3PTCpCeWEc/L0261
	 pws8HTme0oxne1c5z6ArIKZLs3SxPspPU501ChiLpDAMEnmqCqWtkXB28eLbn8OjQG
	 p8QLU8/VoTpP7JKWGDN3nubRMTwxfBE4T/Fj5zPY=
Subject: FAILED: patch "[PATCH] mptcp: only inc MPJoinAckHMacFailure for HMAC failures" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,geliang@kernel.org,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:08:52 +0200
Message-ID: <2025041752-shortwave-buddhist-9b7d@gregkh>
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
git cherry-pick -x 21c02e8272bc95ba0dd44943665c669029b42760
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041752-shortwave-buddhist-9b7d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21c02e8272bc95ba0dd44943665c669029b42760 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 7 Apr 2025 20:26:32 +0200
Subject: [PATCH] mptcp: only inc MPJoinAckHMacFailure for HMAC failures

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was not zero on the server side. The
counter was in fact incremented when the PM rejected new subflows,
because the 'subflow' limit was reached.

The fix is easy, simply dissociating the two cases: only the HMAC
validation check should increase MPTCP_MIB_JOINACKMAC counter.

Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subflow()")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250407-net-mptcp-hmac-failure-mib-v1-1-3c9ecd0a3a50@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d..24c2de1891bd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -899,13 +899,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt) ||
-			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+			if (!subflow_hmac_valid(req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}
 
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;


