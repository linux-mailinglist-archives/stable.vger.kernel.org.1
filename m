Return-Path: <stable+bounces-77144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DB985907
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635CB1C236E8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23520194C96;
	Wed, 25 Sep 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9aswQ7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4C194A63;
	Wed, 25 Sep 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264299; cv=none; b=IH8sDDgdjorAV20EebVTDmUzBVK9QbGPyxNdr5JakOBKpetYw+TZXY6sd4q6346xMkKrqJ02lUV2UkUQrxcyUXiu7JgVEU2pNt9RVvlNYhv7Pv0TGjKlRG9OvuJmFROjfniRmtzKJSRuFwn2Sl3NAn8k2VAJAE0dOlgWk+Yit5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264299; c=relaxed/simple;
	bh=XYgJouEEaZpcOL6t1GbI+MFBhY3y7V0305ISbxza6Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXPQ9dSQJrCUjKeP35EVNGXAyLo822YPsWbGPcmDHzRc4Int1+YfQiAXeFd0YObfSThX9aLiWBpLkLHCfD1kZ8bDEGXZRIJxV4Kn+XxSdq2GeWG3Uu/+Q5JKb8HIJqrt1OP9Hse3u6LuIkeDEpu4r74xAch2xnqBPAhW+Kdpuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9aswQ7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7C3C4CEC7;
	Wed, 25 Sep 2024 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264299;
	bh=XYgJouEEaZpcOL6t1GbI+MFBhY3y7V0305ISbxza6Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9aswQ7bYiK9YW/04XJwPuYQ6OaVSO7xpC0gt3ZwhlXt35OZTj6/U55k30f09Ndra
	 I7ridKrzg4MIJP3uXnAyBjWDEL6Hn4GwP5vUeqhp6d9bFTxvIJDzSuU5YHG5cHFN/U
	 bgHTKmfbzf0aMDg6OxckhwjqY7MErS9zYJAzFVLDx4h+ZasiCNvMf93VFrYyS85b+x
	 Fbl7F56Ou4n8s1XIrd6ncCWxZMZlUWJYWGXsRdoQOMSDqO9qAymltcjt3+ztTEH/c4
	 VdRlCS2/0exjywTgD/zRm1Df4Ykmi+pzVUHVdfXxCilh8EO4Fy10snRym5//ZcGmWg
	 +E2vF90GyY2Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 046/244] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
Date: Wed, 25 Sep 2024 07:24:27 -0400
Message-ID: <20240925113641.1297102-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e3af3d3c5b26c33a7950e34e137584f6056c4319 ]

dev->ip_ptr could be NULL if we set an invalid MTU.

Even then, if we issue ioctl(SIOCSIFADDR) for a new IPv4 address,
devinet_ioctl() allocates struct in_ifaddr and fails later in
inet_set_ifa() because in_dev is NULL.

Let's move the check earlier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20240809235406.50187-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/devinet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d96f3e452fef6..ddab151164542 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -574,10 +574,6 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 
-	if (!in_dev) {
-		inet_free_ifa(ifa);
-		return -ENOBUFS;
-	}
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
 	if (ifa->ifa_dev != in_dev) {
@@ -1184,6 +1180,8 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 		if (!ifa) {
 			ret = -ENOBUFS;
+			if (!in_dev)
+				break;
 			ifa = inet_alloc_ifa();
 			if (!ifa)
 				break;
-- 
2.43.0


