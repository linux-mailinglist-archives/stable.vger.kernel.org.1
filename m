Return-Path: <stable+bounces-199133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D5CA011F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9E713000933
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95934EF14;
	Wed,  3 Dec 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KH467UIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD530B51F;
	Wed,  3 Dec 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778802; cv=none; b=W004eRpYmY5yrdcWvccPXh+fUqCJ3YCzfccVzjG7BaktcyEQRbOYsUO9kYHDoWt+IjOd0NbKu4/eS197eRmrtEOV1J35gq2acoJC+qGXDzTtToCjjnpjVNa2zidF7H39jTvVhOyMWe71Kzp+Y/eaHhr+5olbxmV8wYze4OIcdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778802; c=relaxed/simple;
	bh=Fi/OQ9NHxWFEbwYaZtK2kCz7qysznrRr3gGgRHObC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgqYav+qeGJ5ooZy+89obUT2I0hwsQhvzLUmH7rxxJeO6HrouTcVTqfgOcDXbp57DGQyl5bFMrtQiBbvqv6m1wYAImVpjlgFYNGFFcLjtAHtMfbpTeuNRZ6fxzFBRKU2TCfSd7pswMg7+StToGjwhNtPkYcT3kGtMzy+hF2us7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KH467UIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2ABC4CEF5;
	Wed,  3 Dec 2025 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778801;
	bh=Fi/OQ9NHxWFEbwYaZtK2kCz7qysznrRr3gGgRHObC7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH467UIk7uvv97AUJsh9OiPrsbCI7E6jFilBWcQZHHEKR+nb/wIdGqi566I5WoMBB
	 gUbg4yxBJDEVWLR9GvDtZK+8zZ4/Sx7o8XnA7VpGTYtJG5eHvdKZJa5f1XEqbiQWSE
	 IALHMD6M2Mkq4M/NoHSmAYxliqBgvKIragBJ0ZCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Geliang Tang <geliang.tang@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/568] mptcp: change first as a parameter
Date: Wed,  3 Dec 2025 16:21:04 +0100
Message-ID: <20251203152442.971840359@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <geliang.tang@suse.com>

[ Upstream commit 73a0052a61f98354f39f461e03f1a7e513b84578 ]

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27b0e701d387 ("mptcp: drop bogus optimization in __mptcp_check_push()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1706,7 +1706,7 @@ out:
 		mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1715,7 +1715,6 @@ static void __mptcp_subflow_push_pending
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1725,8 +1724,7 @@ static void __mptcp_subflow_push_pending
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
@@ -3501,16 +3499,10 @@ void __mptcp_check_push(struct sock *sk,
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3605,7 +3597,7 @@ void mptcp_subflow_process_delegated(str
 	if (status & BIT(MPTCP_DELEGATE_SEND)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);



