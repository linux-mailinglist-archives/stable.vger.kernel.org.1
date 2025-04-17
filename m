Return-Path: <stable+bounces-133969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B0A928DE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4843A42AD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0D2620C3;
	Thu, 17 Apr 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlMgkuVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B192261576;
	Thu, 17 Apr 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914695; cv=none; b=sKCV1kB9d37L7O9wjfrm+t9BhhsNs2RKrVSleV9a1N4+52im8VskGjflzEBFKdLMCS7cQcgrM/zh0mmK6e3t2oXZo0y0bOMQVCmxYSVNY18Pc8b/rIRUwgSZQJkZ8Ytp79t6anY5KQwEMwt4bJ8j61b9G0ll/vGa3dI5FB9dBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914695; c=relaxed/simple;
	bh=97xUqS45uDIBVsVZ0KMjF4N48gQ/OwZOB3RG+nU+xuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZIwarqMwn5hDlNDuJ2fFAuvl4hfRBe7tZlXdh125yzIaMSRLVEzrCsqgE1+nUxWrEmfGTaXqqM6fdUfwhJmUI7lZYO3EUXoVbmQ98OfFAG0koAgWcqwlhHgxwGu0sdlwCOeKY7dWru53FXgqZHfZy5SedpVw/06zsnNyDcUdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlMgkuVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96417C4CEE4;
	Thu, 17 Apr 2025 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914695;
	bh=97xUqS45uDIBVsVZ0KMjF4N48gQ/OwZOB3RG+nU+xuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlMgkuVWtgNjuP5XneRgpagzotjJhRlwm/TseAcTeQcJl+frV/izSPpsd8X61jjSU
	 Ny/a5ny3pZztksYxA98vtw3wAwWMWGYRXXSfhNNNHgYg4RRGb1dIRNQzM3m46HKa4L
	 7s4Ww89rNla83xJ/y6Qkig/nnMviKXLtOjObrJlY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 300/414] mptcp: only inc MPJoinAckHMacFailure for HMAC failures
Date: Thu, 17 Apr 2025 19:50:58 +0200
Message-ID: <20250417175123.498034504@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 21c02e8272bc95ba0dd44943665c669029b42760 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -902,12 +902,16 @@ create_child:
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt) ||
-			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+			if (!subflow_hmac_valid(req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}
+
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
 
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;



