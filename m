Return-Path: <stable+bounces-94034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AA9D288C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D3280A8F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751571CFED1;
	Tue, 19 Nov 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W//Wp5Hn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F31C2DB2
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027633; cv=none; b=FBQUHbwmAMNDITvHyBRa7qA2bA35FMYEV4at7JPEWb414XHZvIxGQpa17jleSTS91YDy3guCMopVZe5JMjz1xffhZUIxp7LFh5uTuEFdN1REtRJN6QcOGdnlgNkXdqq2ICelUjlt6o0SoOp7oZBGU15qyJS88pzZ8tNbFdNRgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027633; c=relaxed/simple;
	bh=js9GPzhkvgyKDdz3XeL7xX9Ib3a3Rl8RXERSUc9yQDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iff33EkGvMuyhCidXA4UFxE9s/eqrBZBNttNbvrgJIOInaaG7EqR2+qw/6jpPLM66Pt5l4BPoa4HGnwOxEVRlP11p8IZ2qSd2g/Ba+KhKmSp6CguM62waWKqTJoTpMUMgaVvsT1Gsbdax427oE5LFAeduSBnrHmMdoBSGe7cnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W//Wp5Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF9C4CED2;
	Tue, 19 Nov 2024 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027633;
	bh=js9GPzhkvgyKDdz3XeL7xX9Ib3a3Rl8RXERSUc9yQDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W//Wp5HnmznGuMgYkp4dvC/F3QReAMLrtiN360F9Auj54PGRuMdaLpLvhYZGdJK9N
	 vznkeMwGLWKMW//qAnCD4i9dQiOWKbj85yA+boR4VT9gd/rU1dJ+tJ6f2ginB+e37H
	 ubSDwgMGsQ6iEkM2wOlWdi1dCAZsYX7UYM504Wa5+eNLjauzCc0f/nKnltF8pZbsY5
	 rQB5gHo2lSZJcsRsk0qbNy0iR0F+MjkMm5OQGoixelkuQ4X+9K4U9N7QOZU7WBnxF/
	 6G24xgFev7YsvThVygO8GKQPJuwr92RdobrCatBWLHS/Kz4sP2WhNsVdE+EdoDr7lI
	 /DNNnHfMek7NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Tue, 19 Nov 2024 09:47:11 -0500
Message-ID: <20241119105858.3494900-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119105858.3494900-2-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: ce7356ae35943cc6494cc692e62d51a734062b7d

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>


Status in newer kernel trees:
6.11.y | Present (different SHA1: 8cccaf4eb99b)
6.6.y | Present (different SHA1: 4e86acecbba9)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:12:45.655104079 -0500
+++ /tmp/tmp.Rh1DhZx01T	2024-11-19 08:12:45.650999675 -0500
@@ -1,3 +1,5 @@
+commit ce7356ae35943cc6494cc692e62d51a734062b7d upstream.
+
 Additional active subflows - i.e. created by the in kernel path
 manager - are included into the subflow list before starting the
 3whs.
@@ -15,21 +17,29 @@
 Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Conflicts in protocol.c, because commit f410cbea9f3d ("tcp: annotate
+  data-races around tp->window_clamp") has not been backported to this
+  version. The conflict is easy to resolve, because only the context is
+  different, but not the line to modify. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/protocol.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
 
 diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
-index 95a5a3da39447..48d480982b787 100644
+index 34c98596350e..bcbb1f92ce24 100644
 --- a/net/mptcp/protocol.c
 +++ b/net/mptcp/protocol.c
-@@ -2082,7 +2082,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
+@@ -1986,7 +1986,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
  				slow = lock_sock_fast(ssk);
  				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
- 				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
+ 				tcp_sk(ssk)->window_clamp = window_clamp;
 -				tcp_cleanup_rbuf(ssk, 1);
 +				if (tcp_can_send_ack(ssk))
 +					tcp_cleanup_rbuf(ssk, 1);
  				unlock_sock_fast(ssk, slow);
  			}
  		}
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

