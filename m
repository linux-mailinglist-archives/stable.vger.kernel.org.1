Return-Path: <stable+bounces-93935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD29D21A5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4808B1F22802
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0D19AD8C;
	Tue, 19 Nov 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paiECvLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95819ABC3;
	Tue, 19 Nov 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005356; cv=none; b=h0h/96muifc9MqZS2V36QR/pO8McUZthP2sIZ6BwJbiavIuUWwpl9O9ebeMc39N8Vccx6HFCWq5Olrhiy5LQktKhltoND18KoRKkS7RGmKeuu8joaKrc6mR9WOGMCIUW9LyHMRe0UPJJWCJ83i1JI29ulP1pLirojaWKGfuxBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005356; c=relaxed/simple;
	bh=XeSq6g08rYcyGJPUGhZKPGFUNTzIhSo4GdUbpdQC7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDKLn9lO35xkOkEtpeq3dSO9BfXy0BxyveG5K50OW+75bevVkkt2HiRAMLtpt7pwwvuHSu1qWly/2MaIjdNKoGiQoLhkCZNYxyC1nDPkCZ5LfcDPim0ukSIivVB2u8BTgaWHNu9VykwC5+TFhkEO13AK10nBkF5fbMyNSEbMLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paiECvLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EF6C4CECF;
	Tue, 19 Nov 2024 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005356;
	bh=XeSq6g08rYcyGJPUGhZKPGFUNTzIhSo4GdUbpdQC7yk=;
	h=From:To:Cc:Subject:Date:From;
	b=paiECvLE607jyQ9nCU9GzHdLKI0VWq2Tsp60UBue7jV3r5VxDrgYTiWxOR2J3ISfA
	 G2nwvOsNSwwSPG7rr3Ki6bqzH4dS8QDbtUXHbzvI0cqw3iZHJSdtQHPr1bK48sFqrq
	 7MzueudRouBO6ToAwef9AZrrXMvtBeoYzO+5fFOe6042goVJR0O8WlYyghateFKeku
	 aczC+eNMOnBPx0FpYPQin8x+V3wKwS+wDd/LDvC4uUQIhCsRNPEGE3GyrbUpGLllu8
	 DdS51qJt+xiHtj0TDBwXbTlHjDJu9j5G+cUJuZYWYMPkKPU1xhmHHkQwifPqSqtqfd
	 IYAOQVPpEFYug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/7] mptcp: fix recent failed backports
Date: Tue, 19 Nov 2024 09:35:48 +0100
Message-ID: <20241119083547.3234013-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=matttbe@kernel.org; h=from:subject; bh=XeSq6g08rYcyGJPUGhZKPGFUNTzIhSo4GdUbpdQC7yk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3ja0kt8bdWm/nnUgNd5WeywbroOc47vwRPE TZTPHWoIneJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN4wAKCRD2t4JPQmmg c9AOD/0Uiakfoornwx9HdgS9QzeFBgzG5BypWxP3Zn2V+ayBHvsvnb+T5kJFwqLDo/09XgBUU1m VQVjn5xpDNexQqD8SsbPakMeGf7kSO9o+tg99tizXvxKpAKq0eQ2N0i/S9TbKGaybdAsIQuo+zD 2Y3UPJJajdcPTtKrmhtQBN2oG7sZMWmyC8envSYl/CDEMrWBrr8KqY2NVwsGzRbJ+phW+QT4H6f GQLZ02EWUl8hSYLN6Yjr/aj6bV6hkZqSlt12JqFsZUUC2adnfj4wvEukrKvNhXMUgp1VO9UAkWX yBdubGR2e9c9Yqf62PuDsSMcoOyx1dZuA7JiFgOS6jFF7lvGi47NjA7HGavYJIkqAhypfbHUjET gVo19j3VE7aUYjnzEjkImzTtdl6b4Xng0UYRPB7pjVxys3ciRMWC2UccBpCPKG/Nwm8oOhraYCI GKtJks4HEbTArGSWhe8wb8EjqfHRZBWQ61Udwsu9CaqB5CoQ7524f10s1OqVd5XQQCGJ0+drEQn 1n17BCzykLwdudRZrTIjx65TSYZLuYcCSZ4tSJ1e6RSGS8kBBKKOfedFc38v26S/mMFu412guPW +vMf7su6KZpd2PZceLm1onif1mUuL7/71W2v5I45Clh/udBBjCPGKYdiWNdwoEO7IKy34cfEABu jWTdG5SPq1+k8QA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflict in v6.1:

 - e0266319413d ("mptcp: update local address flags when setting it")
 - f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
 - db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")

Conflicts, if any, have been resolved, and documented in each patch.

Note that there are 3 extra patches added to avoid some conflicts:

 - 14cb0e0bf39b ("mptcp: define more local variables sk")
 - 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
 - af250c27ea1c ("mptcp: drop lookup_by_id in lookup_addr")

The Stable-dep-of tags have been added to these patches.

1 extra patch has been included, it is supposed to be backported, but it
was missing the Cc stable tag and it had conflicts:

 - ce7356ae3594 ("mptcp: cope racing subflow creation in
   mptcp_rcv_space_adjust")

Geliang Tang (5):
  mptcp: define more local variables sk
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: update local address flags when setting it
  mptcp: hold pm lock when deleting entry
  mptcp: drop lookup_by_id in lookup_addr

Matthieu Baerts (NGI0) (1):
  mptcp: pm: use _rcu variant under rcu_read_lock

Paolo Abeni (1):
  mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

 net/mptcp/pm_netlink.c   | 15 ++++----
 net/mptcp/pm_userspace.c | 77 ++++++++++++++++++++++++++--------------
 net/mptcp/protocol.c     |  3 +-
 3 files changed, 60 insertions(+), 35 deletions(-)

-- 
2.45.2


