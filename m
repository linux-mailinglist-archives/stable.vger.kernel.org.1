Return-Path: <stable+bounces-161873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E675DB045A9
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48A11A65CBE
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A92620EE;
	Mon, 14 Jul 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/u7aCve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1A2609E3;
	Mon, 14 Jul 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511321; cv=none; b=MoCR02PJO2kmptNE3mygUVYKUYCQ+Li7g+s+o9+O8ziKlO/07YUYPhAN//WC3n3m81c2ywUpfvru+t1tuvhe324ii9f89BTRK67AZDkD/iWVtj4QgrTbP/BfU8qW+NAqA/GQfUauaPys2E7pQ/+jo0Vp3qgFhQL+WjtmDK1gYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511321; c=relaxed/simple;
	bh=2EOAy82sG12ecn/YE8SEYP+OpV0Z+qqZsuPDPtp0P/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TOOzAI5I8mb+z9MCxY9Rh6JQ0ItUg12vmgUPRf2COJcAZ5X4zOrY7eRY+59Qg4oScyIKT7cYLcyFQywbbehOq8K3z/ZvOS7DwKLdKrz1/onDLcxBWxP4+xsHYI3NbtFc0NDPQ6NAve2sGINC+crPkE6tpG/cZFMA0THZ8b8YhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/u7aCve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AACFC4CEED;
	Mon, 14 Jul 2025 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752511320;
	bh=2EOAy82sG12ecn/YE8SEYP+OpV0Z+qqZsuPDPtp0P/A=;
	h=From:Subject:Date:To:Cc:From;
	b=j/u7aCveKSxlzfEctu0Um7YInZyuu2HHcTbGWt4oA9wR/SSknUq/O+0Ze3b7EwnXP
	 jFqZ7diHzvcmImHN0lAfzM/pqZJ/6nqDW35iTCB8/T6xGyHUJTOoT/hleU71KxjYxJ
	 LYZ6JicvGlcE7PdJYEzlMwl21Ymc/0vxv9/Wo1hrCdZEirZJKKUMoakX0bDR+ICLcZ
	 4s5Ip2QpcgVmc0Idl/j+6Gz1A9tWh1FiLBe92oLEqEHztohUD8byj0M+pthBojd1Yh
	 1N3Zc+kZtf1zHHYjNwl60laZsEGh/5xPG5GVpVNPx9sJRBxPVd89D03WZ+BWwgyqF0
	 c++XcFmmuPLXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: fix fallback-related races
Date: Mon, 14 Jul 2025 18:41:43 +0200
Message-Id: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEczdWgC/x3MwQpAQBCA4VfRnE1ZkXgVOYwxy4S17UpK3t3m+
 B++/4EoQSVClz0Q5NKoh0th8gx4ITcL6pQayqKsi8ZU6OTE3Z/s0dK2jcQrBmKJSG1rTWPY1ky
 QuA9i9f7XPSQFw/t+Lx9x7m8AAAA=
X-Change-ID: 20250714-net-mptcp-fallback-races-a99f171cf5ca
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2EOAy82sG12ecn/YE8SEYP+OpV0Z+qqZsuPDPtp0P/A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJKjQPf7GRx6mS+fV84qVwlcnPzrkWeCW+e/tC9OHGFt
 tGn18fVOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACay6QsjQ9v6BGGmoqduf9zP
 2BVdd36mvSLX5XbY9fhJf8MlSpur4xj+8MU9erY8YWlC4sND6cIpqq+kj+vZbahX03NfvSzn99K
 bbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series contains 3 fixes somewhat related to various races we have
while handling fallback.

The root cause of the issues addressed here is that the check for
"we can fallback to tcp now" and the related action are not atomic. That
also applies to fallback due to MP_FAIL -- where the window race is even
wider.

Address the issue introducing an additional spinlock to bundle together
all the relevant events, as per patch 1 and 2. These fixes can be
backported up to v5.19 and v5.15.

Note that mptcp_disconnect() unconditionally clears the fallback status
(zeroing msk->flags) but don't touch the `allows_infinite_fallback`
flag. Such issue is addressed in patch 3, and can be backported up to
v5.17.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (3):
      mptcp: make fallback action and fallback decision atomic
      mptcp: plug races between subflow fail and subflow creation
      mptcp: reset fallback status gracefully at disconnect() time

 net/mptcp/options.c  |  3 ++-
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 56 ++++++++++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 29 ++++++++++++++++++++-------
 net/mptcp/subflow.c  | 30 +++++++++++++++++-----------
 5 files changed, 98 insertions(+), 28 deletions(-)
---
base-commit: b640daa2822a39ff76e70200cb2b7b892b896dce
change-id: 20250714-net-mptcp-fallback-races-a99f171cf5ca

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


