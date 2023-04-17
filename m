Return-Path: <stable+bounces-56042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4691B647
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E68DB214E6
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612C4502D;
	Fri, 28 Jun 2024 05:40:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3F41A87;
	Fri, 28 Jun 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553240; cv=none; b=Va/swkU7PM0xIj87eSrBYYKwVAEiipRGu6gXOnnvZBSJ26wsLYQv5ZQlttt8HpUetkE1gqV5R3wA3U0kMf4HQU8DQl6B0yA7LdlhKHeIM8Ud1eMBuQ0h+xT2S63yAMlIl02BisTUPRDRTzh+hSinTx4B7l1pFzX23rE88EEypBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553240; c=relaxed/simple;
	bh=j2KQoB7sQ7vOFXqtkJpxWWFcgkzq3y0sEsAS0BIcycA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qc3+BHXh/gcB9nL7YvT43K6A/eh6P0DGdpWZMcXh+2uLYZFXqe9Y0Ufn5le2pEC55/nMvV0R5/pOAT+WJzPx7q67rAFq0ual8OZL0FbWP5BWm+PxGsMUS9f0s2tM2CHa4K08Z6G2m4B2rGMGkGv3we9Yupe1p4wqj6FHBV0JZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 7BAAF1400F0;
	Fri, 28 Jun 2024 14:40:37 +0900 (JST)
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hiraku.toyooka@miraclelinux.com,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.4 0/3] ipv6/v4: Fix data races around sk->sk_prot and icsk->icsk_af_ops
Date: Mon, 17 Apr 2023 16:54:03 +0000
Message-Id: <20230417165406.26237-1-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

For 5.4 kernel, this series includes backports of CVE-2022-3566 and
CVE-2022-3567 fixes.

Eric Dumazet (1):
  ipv6: annotate some data-races around sk->sk_prot

Kuniyuki Iwashima (2):
  ipv6: Fix data races around sk->sk_prot.
  tcp: Fix data races around icsk->icsk_af_ops.

 net/core/sock.c          |  6 ++++--
 net/ipv4/af_inet.c       | 23 ++++++++++++++++-------
 net/ipv4/tcp.c           | 10 ++++++----
 net/ipv6/af_inet6.c      | 24 ++++++++++++++++++------
 net/ipv6/ipv6_sockglue.c |  9 ++++++---
 net/ipv6/tcp_ipv6.c      |  6 ++++--
 6 files changed, 54 insertions(+), 24 deletions(-)

-- 
2.39.2


