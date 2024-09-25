Return-Path: <stable+bounces-77383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBC985C8F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B28288A47
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD51D0DEC;
	Wed, 25 Sep 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaTdeK8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71921D0DE5;
	Wed, 25 Sep 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265588; cv=none; b=mQaddU6FVEXP/WAfjHZdWa3uY+p3w5VwKS2TBiOUlAM/4qvcygMHnP7fYaJXb78HS9SXH4lKaXCleM3ZJing0w4ivkyFdpld3ECeBDR//5xLzsJ4zI3BVQQUPZyQERKNtmsmH4GK0XxkydnIt+smZXrAoUp750brnVscpgzOtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265588; c=relaxed/simple;
	bh=tH+8dhPdj/JhWy6xc84AHQPMNwr4o6vP7XY04izVe5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGSzXO5JRe4LWqDkN5sgkzZHZa+4ZhhO1MMyI89jtPON93n9pZW/jVwgPqk/zmmsi8l3MRU24x3xyq9HrIHCRyk/LwDEK4Wx0Vc0o51lIRJP5xQwN4Z93/489rFv8vK1Zdhx29lh19QNf0mXREz76b+pIoq65l5RhEV9xWZHfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaTdeK8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D255C4CEC7;
	Wed, 25 Sep 2024 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265588;
	bh=tH+8dhPdj/JhWy6xc84AHQPMNwr4o6vP7XY04izVe5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaTdeK8IpDgZCuMVRg1vL/8EkysYjQpmUPE/fUtOanN2UlPHJKUiykS1W8RIoBdRw
	 T3m+7xrLZdtXFx7pEQcTJAeywoQwCKUa6H9YTe5z+R1MyU/8YraorCuc+egta1+yNq
	 8qqDpLQbyM1gFAYSeJ7i8ALbGoiufEvfoOSyqSk+ejRivQrg5PViABhIF/PxE5FNAI
	 HXeiL7T6WehvoHdbhSy6SEEZ9Meu0npxa1Ve3nsSlpdFmfALsvZR/t8FGFNK6fgW1u
	 Gad0O6M17zYReVcsK4CxQC6KrGu9e7FsBpVmwV3wYOs71x7JfY+9nG6v6SrP+uMDfQ
	 kNDzBCGOIYF0A==
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
Subject: [PATCH AUTOSEL 6.10 038/197] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
Date: Wed, 25 Sep 2024 07:50:57 -0400
Message-ID: <20240925115823.1303019-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index d09f557eaa779..73effd2d2994a 100644
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


