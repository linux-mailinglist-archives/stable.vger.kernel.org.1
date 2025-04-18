Return-Path: <stable+bounces-134619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F85A93B36
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C8D19E0CBB
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E2211479;
	Fri, 18 Apr 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqQ6bU4e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D92CCC0;
	Fri, 18 Apr 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994767; cv=none; b=tvmai8nR28LCMFEovoh/l16DZApO+XxkhBc7wbnAtlJDcTh/DFt6uMKLUa5enq9Y0e70jUaFEBbwM1iKrdQ92XhKhDZ/jkvOdA2EdbdpOy8bAIluNk1qPQGvFCNehWiRVclSwPVNDdWBlzhKiFBlS/8AI7pIIjmh1LleAu0Rzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994767; c=relaxed/simple;
	bh=TWKHGFmX/NS544kNEaz6/YQPxD8BLfeTSNfWB0ic8JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3Pp+IKATwhuUKE9jXR2PuVXeu5iHpvYvFXj8Amfe0qstxDtZdmcZn+Z42cIUVaNMseOU//60DXEFKmagOGy2ViIlrHAjS2LN7af7qv0qMfrgd2PBBS5ex1p4kFpUupEPrBDNkCfPvhIp+oHdqBxrDkNskJX7ZV0oXdrVQOrQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqQ6bU4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17CEC4CEE2;
	Fri, 18 Apr 2025 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994767;
	bh=TWKHGFmX/NS544kNEaz6/YQPxD8BLfeTSNfWB0ic8JA=;
	h=From:To:Cc:Subject:Date:From;
	b=TqQ6bU4e/JdK74AYP5WyL9xC/SkgqMeP0fa16Bu/3ry+jhT/atH1a9dW8zIZ+UPQT
	 sX3SAzpD53CAqAhCMx3Q/hQ/GYwYuGrXP0OjGJWKrGVxO6LatLeaTv4C8RnL+BjYe/
	 jOWdUoiC/UPVehQ27i25e7e815VhYGlzTdysnk4eJi7VdV5WZ7FcCjzSxHWVV6RTdc
	 SDRFYTU48u5/ejFoRWOrsv/MLspk+40VNph+ZYteaIiSAsSW31e8axyrw/Tn5g3F4k
	 3WBdqzmkYwxOWwdkxRW6u1EyV3aOaRP8qGdPU08OJU5K01ckkz+qslBAEpYywmA/hU
	 kTxcRG9yhoPcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.10.y 0/3] mptcp: fix recent failed backports
Date: Fri, 18 Apr 2025 18:45:57 +0200
Message-ID: <20250418164556.3926588-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=matttbe@kernel.org; h=from:subject; bh=TWKHGFmX/NS544kNEaz6/YQPxD8BLfeTSNfWB0ic8JA=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAoHEDOd6BWSqqR0KAjHEq8zgtC97tZT5qgVlk +Ys+AQc3p6JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAKBxAAKCRD2t4JPQmmg c/NaD/9W/9Hp1ZSjtgmFsRR7tOf6YdFbmX5DprMX7AnbN/SeejVa0UAlKaNFv4ieOflF7ckQNGX gD/P59+hvFfn4mw5BZTGQT8A/paXt7zI2apcnGnwShFuYjLc40R4YNYVHR8vDexvUp3WQ9TTXyi G9mFMgYLxhfTP9M8j3LA2deZtxiD7dy5wv8v/87IsqYnd6gnWymOyYsBC+8qCpHo+gXSxzOKFeN voGk/PJKUsIQ/AcvQaevxNq1xnXd+6stSoiv7xzyWq+Bxzrk4ln8DdZheerrBnstsvKrlZanuIb ADnMwPNFXau1cM/nMwDp93C4NWbEdkr6s9tOxhO4n2PjFfnTh1X32rZnQTSRhVLvoss9MMC4WOp XyYCpakGc0AqguMiI3UOjd83sAsuSDBUzLh39zPLp5hvG/jBAi/2tdnVeXHBrbCvgnLidvcZlYB 4fXUi0ZLZ8WL2/9CK97t8VVtiNj9Upv+rZE16UeAJ0YEWnJu8lehJBaUtkryPfhUz8vb4DZ2uCt 5opwlIkFX5DfydYq83d91mE4YwwxyP/Y/neekYqkhJgcQoUijQD6fKqKBPgppHPzrDEj2WdjgVx 2P2bXN4Q8pLWauX3cnSUgOCKeNSeZ1pnQaqx55HjkE8LBowAJLcwqAdLR/CWqreC7Kuab8Ya/og 91iM/rRehRFrJtw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflicts in v5.10:

 - 443041deb5ef ("mptcp: fix NULL pointer in can_accept_new_subflow")
 - 21c02e8272bc ("mptcp: only inc MPJoinAckHMacFailure for HMAC failures")
 - 8c3963375988 ("mptcp: sockopt: fix getting IPV6_V6ONLY")

Conflicts have been resolved, and documented in each patch.

Gang Yan (1):
  mptcp: fix NULL pointer in can_accept_new_subflow

Matthieu Baerts (NGI0) (2):
  mptcp: only inc MPJoinAckHMacFailure for HMAC failures
  mptcp: sockopt: fix getting IPV6_V6ONLY

 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 15 +++++++++------
 2 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.48.1


