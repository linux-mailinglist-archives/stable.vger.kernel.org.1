Return-Path: <stable+bounces-73016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65296B9B7
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5834EB245CD
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9D1CF7B7;
	Wed,  4 Sep 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCF/16cN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507181CEEAB;
	Wed,  4 Sep 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448293; cv=none; b=rg0GV4AnGuU0gfDEz6N6WC7b4Q6UpV31Uoq7S1sO+LPiHxRLinkQxmmJsJVqf+ulVDQgu2RaiCJlLJsOV3/gQjrC7bZcd1EE5OOY/1sk54dZWcixlDlLJUSUE2Ci1lHFpOgG69effGEbQu7A2mTVWFM1k7X8cZFm1hY+jsk3BhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448293; c=relaxed/simple;
	bh=ZlJI8Flwqqy5QrpUOdU/GE6cBQy9u2ni3/4iIR2bdKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xwn9CoBNBBEwmreZYctmHNULQ33zsRslbiEa9/nmJtmUPLoYXfBXcCu1lidDlTxvotzwzM7V93JEu/bQOzyYiqX7JTFVf24pkNP/DN+ls26X81UbUWkkKD0N1GuZVVfQvIi0jw0QW+aanYq/x4z/Unf8fu+7TToSknYpREEEuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCF/16cN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E1C4CEC2;
	Wed,  4 Sep 2024 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448292;
	bh=ZlJI8Flwqqy5QrpUOdU/GE6cBQy9u2ni3/4iIR2bdKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCF/16cNIoK1BHms5dA47egc8uPq0R3daJct9DXehRIF+P5GDE5dVawMLAPiPjo/U
	 IalU0Gkw7yOs1cAXLnmlL6wGG01s2+ryHjD2a0jMmmGCJiKmZRa+PgY4ta0JSG/UOj
	 FJrJBiqkrVtRMU2wdpe+az1ifbvg4fJj0CWZX2FqKMBtcgmgmdOE2iOzLEXyOzet/u
	 249BIOkXIz1lIEz3qyZQEbhHPHxzHlSsBggpJayg/Fgd1JRgGMBlzxVrGZjvsKjfGI
	 LgrQOjKoCyo4WoLUQC1wnvK4/lb/zav5G5vOGqZPCkFMcIZfWpSxqAtuVN9Ryt+eNQ
	 61TBTokJKF/xQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] mptcp: avoid duplicated SUB_CLOSED events
Date: Wed,  4 Sep 2024 13:11:14 +0200
Message-ID: <20240904111113.4092725-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083028-coauthor-moving-1474@gregkh>
References: <2024083028-coauthor-moving-1474@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=matttbe@kernel.org; h=from:subject; bh=ZlJI8Flwqqy5QrpUOdU/GE6cBQy9u2ni3/4iIR2bdKU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EBRzXuXqBp2OUo7C145rkwP1Lypb2dMJ645y c0n96TAeciJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAUQAKCRD2t4JPQmmg c+phD/40k/jeWQ4nqcgzeI3IuYIKbhQL5su91tY7yt6SkF4jEH3ygalbB4uBAc9fMGd6fJeStnM fCi9k5D/XnaPoSdtpmu9PXWT0KnxuP1gkHusT+/cfmbvjNRs2fj/PcRTsrvBq3XrTlxe55CvK0/ /pdyb9ady9LbN640uNCOh3E72OT/Rx8Jr/M6NlHwbyJcuDWdVf4DASghi6HXibjFJdunuj/OxDt 9UzUhf9zIWuEpxoU6nNn232s1ZzPUs1H4L6bU6q9TSjDzE3a2ztKUbyphXTiJeEzlrlXTXZCXTK y3it6fUmkLNT+FKPT5mrELT3HhCNKz2jg083BybW+PsjWT3qgbeuGWD4w37VSJtzB6Llas3oQRH pjKEXRfrkR35APHeGNCVNSBzmsYzTcsvUecvWYFpE7ck+pZxiMcWs80dJHGptiSVLbN5BFpVejH nMM9ndkvYP0FY8HhZHC4KFW69QLItoSWUaii0thIGNZJo/aONgE+d4CV3BbH4Z08kMkBFaVN13t YrD6nI4QCnKTqNehL398RJQlMShtDjdt5Ggw6IDtRI/yHTKxH65LkiNdKKNqLygnmZEPB+RzDVy YiZrgQA2zKkKEo8Bw4bF0FSJi/oDXft+FScIEdPHBCBror6TVlIFyLk1GBp7bqQ6feUbMN5mZmB RHeXr4nQuQQrQ0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflict in protocol.h due to commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum"), commit dfc8d0603033 ("mptcp:
  implement delayed seq generation for passive fastopen") and more that
  are not in this version, because they modify the context and the size
  of __unused. The conflict is easy to resolve, by not only adding the
  new field (close_event_done), and __unused. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c1b35ca952b4..62a2da0f2b54 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2503,6 +2503,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9a367405c1e0..ee3974b10ef0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -479,7 +479,9 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
-- 
2.45.2


