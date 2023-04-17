Return-Path: <stable+bounces-56038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4D91B63C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A83DB22FB3
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0F44369;
	Fri, 28 Jun 2024 05:40:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC5249F5;
	Fri, 28 Jun 2024 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553220; cv=none; b=fjxFqJZ3mKNtCXpibO38FrmfJSAjspmzG5QeK4VVQfptNfAz5wSse2kGWHtEDI52+OAuOdmpE454+Ej9lNJlx9kKRQ7WQ6voGgD/wpAcZa/tTMbvOXMI8rJEsbgky+6QIon9EfjZV4T6ZqFE1ed3aaDb0FISUss6VTUVGBLkprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553220; c=relaxed/simple;
	bh=4WshrxamUHjgnfRKFc1jFOSQNncT4vZ0/25Do+eKwJg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VR4bAwmqjCCIksy27lk3gv40aPrzKrjdYxDUbeL9asKkLia8l0vCsBSdTWy/T6zRgev+ZVNYSWpW+ze2flql1veC5je6AB9m1hvzVcOlSqsC8KuUlIOjtvlbXek8uT80ldSIae35MvvAZFMpDSl2Hiwdk2nkS8o1Hkfu0Dc1P44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 8CA781400F0;
	Fri, 28 Jun 2024 14:40:17 +0900 (JST)
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hiraku.toyooka@miraclelinux.com,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.15 0/3] ipv6/v4: Fix data races around sk->sk_prot and icsk->icsk_af_ops
Date: Mon, 17 Apr 2023 16:53:45 +0000
Message-Id: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

For 5.15 kernel, this series includes backports of CVE-2022-3566 and
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


