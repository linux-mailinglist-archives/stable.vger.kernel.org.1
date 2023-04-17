Return-Path: <stable+bounces-56050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44191B675
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6CB24A7A
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA54436B;
	Fri, 28 Jun 2024 05:46:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1B1D54A;
	Fri, 28 Jun 2024 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553577; cv=none; b=Es1eEhlYJcQaIb2LBOdlwJ0ZK2X0svQPXSJdnHo0CLJgq+hZD7ABWy4UtP91Ri8BjlNsT5ddfNGhdYpBG7wcU4O3fSdyxmzh4TYuZgWaeYbgweXo42zTf3C9R8BWnTBg/7UUcdeK+Ds8DpO/cjxxqm3znyhW98/6kXD4FG1ZqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553577; c=relaxed/simple;
	bh=U5hS3UzvV/uQFpn/yWv7Sjy5/9tSeCMjHwAdKO//6ws=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OlbReAOsqBErWbYF2r1ur9UDoWkpqNR7dhvoj5wRyrvGimOCIt0Y+HjCtclmmNlu1LSPBQBjX/aNdC6PWFlTVpW+MQ/b9kIzrRSwZXqw7uo4cOQZhSt4lWQd9LcAafhE4Owdu1OrOFVZ9DK5tMpPOfQrcMk7vGPOZ3vVf/c5IKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 1F9DA1400A8;
	Fri, 28 Jun 2024 14:38:41 +0900 (JST)
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hiraku.toyooka@miraclelinux.com,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.10 0/3] ipv6/v4: Fix data races around sk->sk_prot and icsk->icsk_af_ops
Date: Mon, 17 Apr 2023 16:50:31 +0000
Message-Id: <20230417165034.26123-1-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

For 5.10 kernel, this series includes backports of CVE-2022-3566 and
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


