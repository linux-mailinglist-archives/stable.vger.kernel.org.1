Return-Path: <stable+bounces-86900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273CC9A4C94
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303B81C21125
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108118DF7B;
	Sat, 19 Oct 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWEN378y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A120E30B;
	Sat, 19 Oct 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330255; cv=none; b=eMgdfEDQ77Jrf57LDdh0kg2oxc9FzGt9qaIqhFKfMyi/O9fvop5zofKEwguJ+BWl3SeQV2M4Ey8uSNkprykPsKu8UkvfwsHHhfyxrFSB7Pk5Yt+dpEMcWGZ28nuUx6hRDdAwqm9qrWSjJOkaM8+Rf3x234LbSc847dc0dJqWGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330255; c=relaxed/simple;
	bh=0My0whXDQH06lynWlRyLmzuIXr/nPZNmBYCppcqKwIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJBwI3bIE1Zsi6mcZP5ssgApPh+6KXYeCavLacK1KZ4iJdoLj5EWM3KrN3/GhiXKWZncvlNSGrH6qptTP9WlvX2W/t8rT21fALR3pperGBXnAcIl7251nuWuhJcvB1HcpGE25KDHkrsklgRwicd2LG6Nnxj49uXH4qG3skLL82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWEN378y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3E9C4CEC5;
	Sat, 19 Oct 2024 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330254;
	bh=0My0whXDQH06lynWlRyLmzuIXr/nPZNmBYCppcqKwIc=;
	h=From:To:Cc:Subject:Date:From;
	b=lWEN378yWETs1F6NxPtvJVTkQPa8FAY54mqYNV2eYq/PJLkNw8Hw2V/yumXq+pM7F
	 YT6LKa+vpdVqW7+LG6NFPZH0H6+f1BZoTkwYv09JR6i5gBdFc4m+Q26+H7G1jxL1xn
	 8ZZWHPwPDRq50YBUQ7icyauUuKw53Qrzqb7PtSLde6MDeneFdCzPX4tB4yyMR2PfBl
	 5CKp1uQ40TvM1EL3WcetYcJogsJavij0Ph1x+3eozES8ISAmJ4r5b0UsrwJiDYsdNT
	 9vrwsS4HVZNEfIyZxja89fWve+IwDjuWYJDKDLlY4O1GwOl0xWtDsmD0HtaMgm869d
	 mdMrXdjjYxNfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/6] mptcp: fix recent failed backports
Date: Sat, 19 Oct 2024 11:30:46 +0200
Message-ID: <20241019093045.3181989-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=matttbe@kernel.org; h=from:subject; bh=0My0whXDQH06lynWlRyLmzuIXr/nPZNmBYCppcqKwIc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE3xFZkZVKZ4ojbiF8Y5rbmUWiUyjEC9yWCJIm Llk/DKdf2mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxN8RQAKCRD2t4JPQmmg c9/zD/0VLZkYBGNhUvkqvxduBXbHggSRoAOJ9oBw6u0RoV3SrtU5z1gP5Du+VsgX72wJU6RCGYc 1uYWQGgk0FuPjkdcNMWcCemVY8uLx+lQr38cqk3LgCx9+Rl+4IgqPoQQZDDqKVhVpjXVSM/bX7W 5au/k73U3GSTPx05quDHy0pZ158doSLvDPGD7corUwlH93mj/rimFGZsLObeqm9Kny9PrdlSf+o ZDlIwmjoA8w8Xvt5FbXx1rMUcUKDZV3WdBKe5pJlpnv+tPOfcn/s/6f2n6q6BaXjK1I6p9ug6uH ueqtRls5ffhE4oxPCalnKMpNbPQrcyrAbHgHF4sxrsfkdBy2qCY7u0RS3fkelgtmFkZmpPkayQd tMhH7+Xb5wg5b6ZvTamCpunlJ5DAkvqYCtz1o6wAXj1IrrqPUI1qen1U1EmI4R3kReQE6yWdeKG smZPgVh5bzS8fUpHsLKcEd2s+ARxe915Nupk8HboX4iiQF0fBDPWn8Penp7iKTPMSP9emYHffyX mol5ylyqklO2AzTh3i9amuTm61dLUL+JqliuKYU3xFiPwDQEV/bZPP1HxOKX82W2AdQeZohohD/ c+Dm1P3SrBZZxwGQ6scmCybqUtnBcCrykDBSZTxg2Yf/n1IJNWTZ8eDcn4RciWZO5xEZ9joME0J UjjTZKpbG2mVm0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 6 patches that could not be applied without
conflicts in v5.15:

 - e32d262c89e2 ("mptcp: handle consistently DSS corruption")
 - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
 - 119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after 1st
   data")
 - 7decd1f5904a ("mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow")
 - 3d041393ea8c ("mptcp: prevent MPC handshake on port-based signal
   endpoints")
 - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
   port-based endp")

Conflicts have been resolved for the 5 first ones, and documented in
each patch.

The last patch has not been backported: this is an extra test for the
selftests validating the previous commit, and there are a lot of
conflicts. That's fine not to backport this test, it is still possible
to use the selftests from a newer version and run them on this older
kernel.

One extra commit has been backported, to support allow_infinite_fallback
which is used by two commits from the list above:

 - 0530020a7c8f ("mptcp: track and update contiguous data status")

Geliang Tang (1):
  mptcp: track and update contiguous data status

Matthieu Baerts (NGI0) (2):
  mptcp: fallback when MPTCP opts are dropped after 1st data
  mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Paolo Abeni (3):
  mptcp: handle consistently DSS corruption
  tcp: fix mptcp DSS corruption due to large pmtu xmit
  mptcp: prevent MPC handshake on port-based signal endpoints

 net/ipv4/tcp_output.c  |  2 +-
 net/mptcp/mib.c        |  3 +++
 net/mptcp/mib.h        |  3 +++
 net/mptcp/pm_netlink.c |  3 ++-
 net/mptcp/protocol.c   | 23 ++++++++++++++++++++---
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    | 19 ++++++++++++++++---
 7 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.45.2


