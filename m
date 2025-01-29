Return-Path: <stable+bounces-111121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B0A21D0D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FC018857D2
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2C1D9A5D;
	Wed, 29 Jan 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqr+dzEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CD18C31;
	Wed, 29 Jan 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153488; cv=none; b=shCi1+NaVE+u7DPysZyBo/zOk7FTMCCCle6mRwkBWrQazdqPOxQ7CyD1MqPwhSiFQ46UMjegzh6qM39Ax9jHbpO8EJEiJAbMIw88Cgs6FoWteBFZJgjyKQ+juMrc/cG7OYRJ4+8c0UO9H7xLbUcITNuS06vtqABO/GSAAPQQqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153488; c=relaxed/simple;
	bh=Xd19OZKWuut9/ZzoZ0Vz3sTx3A/Z+hSrwoa0yLGPA2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tkzBEiy95GRPjLOrQQ/N7xoawcsjXTGqzggxsUZ6oZl2IarjXqmrZ8P5dUh3fWrmsNUjr7m+ipVAsyBzlQ9rR4Hw1q+kUzBJhkHHofiCiO8wBh8aQLBTwkBlYZ+sjzW6xAOvq5dUDFK6bGGT5nwVMZbe/yDfxUdS5YK0UX88RBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqr+dzEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C9C4CED3;
	Wed, 29 Jan 2025 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738153488;
	bh=Xd19OZKWuut9/ZzoZ0Vz3sTx3A/Z+hSrwoa0yLGPA2g=;
	h=From:Subject:Date:To:Cc:From;
	b=aqr+dzEKeojrPAidC0db9VAEU5tEe0F3vU8PuoErBwT8MZl1VgDawFbF2jF/JUDDu
	 tkodiHRm5yd8GYJpfhchPfG4LcQ64qN1S/CcuiWWFnwqRXcYI13HM2YM1oPauRm+qm
	 Cs8HQmAHvmK8E06zCgaBSG2BOqkCfPxVzxzkCOG+4dWCjZzJNGUnHzAksE0mbPjszP
	 +6BYgAPWbzqEIutCPS6F7irI+NCc76CGxW0/9FtHInbk+nyknuj3z6UwbjbCV80LLK
	 G804wKBDFSZUE/ex6qmnMqGnyPnuDMTDooGih2p7M1KbaN28hrrkToA4yfKz7eBlgR
	 D3ocDW5z+3Rqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: blackhole only if 1st SYN retrans w/o MPC
 is accepted
Date: Wed, 29 Jan 2025 13:24:31 +0100
Message-Id: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8dmmcC/x2MSQqAMAwAvyI5G6gV16+IB62pBrWWVkQQ/27wO
 AMzD0QKTBHa5IFAF0c+nECWJmCWwc2EPAmDVrpQma7R0Ym7P43HcRvMuhwboeUb8zK3qqktVbo
 EqX0g0f+5A4mgf98PdkfAfm4AAAA=
X-Change-ID: 20250128-net-mptcp-blackhole-fix-363f098fe726
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Xd19OZKWuut9/ZzoZ0Vz3sTx3A/Z+hSrwoa0yLGPA2g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnmh4I7Gi7VWoCsNhoXhXuTEgQ9TsWiUcNmpMjh
 oEhO6T3p9WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5oeCAAKCRD2t4JPQmmg
 c6+nEADPC0EtDguixrsMsnjAJHrsFPQSGV4aymISHWII0cIskSGSlWTAH4NoE/wnjJ8bPJPRz0f
 GYWgbx5am3PhAV3hZ+vIdZm0aObULKYZCL17e+q8BhNieW5DGZjaqUm1QUfAL8WBoINnMYxeMgH
 A6Q0heRKtg2P30FdMWv7vZ1sqJ4s1CNC9mZrS5DmvRCXUHgRnPPsiuywp6Qz9XWitG04b6gMq7d
 61DO4GgVr0XTV38YzSMVI0+Od8ffwt+yZdENN61YVNzeLWuEMu36PuUJ9YABgTTDJeeHjm4urt/
 Iw3UpK/wPEOMF5B2Pwy3E6mEUMvbjIKXxzGUAF+dngQnvym/zSbESkLk0D3UJE7GSG+Znnzyav5
 K1LmAqI4BpbtLbQ2dWJ/MKfARg2gW0dynDCaj9JI+uQXhBIK/jCcpfpyIaGw8ggweynhQ4qIvuD
 jBzWYnh388jvUScFLwg+NIjeb7bQTCvLrwqr1kNSMDUPI2LzQSz3jGqWg8Mw8vkNRVBORPOfXxx
 7y45dXh4HPObv3cX0R/kzH+XDe0fydKDob4x7GTlggNYaZIbycLJNfOycQQowsguA8tK2xM5gPy
 K9V9buYWG4h10xBSS20zoHVGum/jWGSA/wp1ATkrPaOIao9XXDk8QOtJCDjUx0/icVxhJzEVTnJ
 GHl3Tx/kD6qPGbA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two small fixes for issues introduced in v6.12.

- Patch 1: reset the mpc_drop mark for other SYN retransmits, to only
  consider an MPTCP blackhole when the first SYN retransmitted without
  the MPTCP options is accepted, as initially intended.

- Patch 2: also mention in the doc that the blackhole_timeout sysctl
  knob is per-netns, like all the others.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- The Cc stable tag has only been added to the first patch, I don't
  think it is usually added on fixes related to the doc, right?
- A Fixes tag is present in both patches: I hope that's also OK for the
  one modifying the doc. It can be removed if preferred.

---
Matthieu Baerts (NGI0) (2):
      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
      doc: mptcp: sysctl: blackhole_timeout is per-netns

 Documentation/networking/mptcp-sysctl.rst | 2 +-
 net/mptcp/ctrl.c                          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a
change-id: 20250128-net-mptcp-blackhole-fix-363f098fe726

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


