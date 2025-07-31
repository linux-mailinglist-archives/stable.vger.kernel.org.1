Return-Path: <stable+bounces-165645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5358B1704F
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D214E37C8
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17562C08A8;
	Thu, 31 Jul 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAaC4Db1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6C24BC09;
	Thu, 31 Jul 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961056; cv=none; b=pLxjiN8CUD1ugB03iSPXwGYeHZh48JZ7DQOZt8NJipmr9SDxYeH6n+9HHHGirsehYSlCLA2ltUGMSoMLGW4BQJavibZRcnQ7TdKd8fvJ4rZfXQ+fTwQMXSfFejZpm7PyIPiPCniikSmpVL8z3RwLC8OZ8LwHpAsJUIV1Ljfjp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961056; c=relaxed/simple;
	bh=R3GjpU8cp4HEkJsw5ea3JcnCRdAbqK8spRb6UBa1TQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tY43uiLrwvCUxEd4U2UujuR6XFvWvKFi9+850STOeLOypF2kCnGT+sy1oCtjt42EOG/mpk73/Rt2nsAWvj83RWaMkfrk2gh1AgKs3sbFeBeZOpsgO46N6/nBkvvGGXRVmIuSm2hMxP0GnK2tgYC0zw4V9QNK72FhloZEDFsP8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAaC4Db1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017CFC4CEEF;
	Thu, 31 Jul 2025 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961056;
	bh=R3GjpU8cp4HEkJsw5ea3JcnCRdAbqK8spRb6UBa1TQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=tAaC4Db1JKqqSwJAiuZP+kpXTyK7h5VNtXsbj6j+sgKN/tJh+VNnTO6yGqgyNRvoL
	 Kck2p/kO4KRqUtk1JK7V8RTqIpbdn86kPG+GzoabNEw0U9p/dxlRKPzTYsvfQjiUNP
	 KTJf2Q9hP27yJ5DTMH1RzuKaiPtFyM8qFq1COM8cdpNjhijHF7Fvw6yuxSn/MJpBEo
	 EQN2+mm25UUClx2rmGvlB4vuO2KN8ClWAXdqkymxoj1Bd2LAALTpOqn3qtT7uK0zPw
	 cL1Ilv+sfgwlTDku4PZrW5cItHA+7zZQ8rzBP1SfC4/bhyBfiMO6T4CMR8gdbVOylp
	 81OLkqthIdYBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/6] Old missing backports
Date: Thu, 31 Jul 2025 13:23:54 +0200
Message-ID: <20250731112353.2638719-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=matttbe@kernel.org; h=from:subject; bh=R3GjpU8cp4HEkJsw5ea3JcnCRdAbqK8spRb6UBa1TQ0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g7xEIv6qr9lrtPzkOc4164NsD4kyr/n6PH6/qLL6k gkLGXOfd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkxC5Ghu378wtjjfqe3tT4 wryCreCB6uXpwnMnTo9xdDq3tfaUGz8jw1GncPOMe24K4mskn0htWRNyVWa+bp1PseCBT96zDS6 J8wEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When working on an issue in the MPTCP selftests due to a recent
backport, I noticed it was due to a missing backports. A few years ago,
we were not properly monitoring the failed backports, and we missed a
few patches:

- 857898eb4b28 ("selftests: mptcp: add missing join check")
- 0c1f78a49af7 ("mptcp: fix error mibs accounting")
- 31bf11de146c ("mptcp: introduce MAPPING_BAD_CSUM")
- fd37c2ecb21f ("selftests: mptcp: Initialize variables to quiet gcc 12 warnings")
- c886d70286bf ("mptcp: do not queue data on closed subflows")

An extra patch has been added to ease the other backports:

- b8e0def397d7 ("mptcp: drop unused sk in mptcp_push_release")

Geliang Tang (1):
  mptcp: drop unused sk in mptcp_push_release

Mat Martineau (1):
  selftests: mptcp: Initialize variables to quiet gcc 12 warnings

Matthieu Baerts (1):
  selftests: mptcp: add missing join check

Paolo Abeni (3):
  mptcp: fix error mibs accounting
  mptcp: introduce MAPPING_BAD_CSUM
  mptcp: do not queue data on closed subflows

 net/mptcp/options.c                           |  1 +
 net/mptcp/protocol.c                          | 17 ++++++++++------
 net/mptcp/protocol.h                          | 11 ++++++----
 net/mptcp/subflow.c                           | 20 +++++++++----------
 .../selftests/net/mptcp/mptcp_connect.c       |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  1 +
 6 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.50.0


