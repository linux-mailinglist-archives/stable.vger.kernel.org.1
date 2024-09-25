Return-Path: <stable+bounces-77582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F26985F88
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE91B2A9A7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB98216A1B;
	Wed, 25 Sep 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOd7l7v3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D94216A11;
	Wed, 25 Sep 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266374; cv=none; b=s4lAszWvC4S7/f8bLx6FH4eHydLxC0hrxj0urui/Fa11AOUAD+RO6s+UIdgUlUDN1iNunTcAY1ww5OR9UUQovyjt3ONytsWgbXTu2SsdsJ8Q6GyKD+WglJRV9A/KLRBYWo8K/kxWSEQwp31cIdlFVdrOqDAHeSHFkSedbjEDW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266374; c=relaxed/simple;
	bh=xHO4gj1Zn7Caetfzh+ubln7rUIK+I0vPdmEHXe2zqqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUG+qU/YzEYDB2WVBr/ov6wftE182Z66DNL3yjiTYn4+DDcM2qKE8I1WRwGgsXFvZ3qSFz2sSkpmq4MIdrJvpLJ/C5akIrlhnO+PzM9pmGQ8qv6ONVXINjOEHLC2LC6vgHXvqlWyR3SHQ1dxzEP6EU705sbSinkGU8n4VFOrtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOd7l7v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C2C4CEC3;
	Wed, 25 Sep 2024 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266374;
	bh=xHO4gj1Zn7Caetfzh+ubln7rUIK+I0vPdmEHXe2zqqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOd7l7v38voGpqBflyJ+2Le3DTB2z739Og0clGK1ug1eRPoMhXFy4KAf+NeF0c5il
	 ZhsgiTvRdIcKQXnj6ueClY+csCTg2batA3jLxLn4lOHdJ6idlc5uTVCI8BzhPEuH4e
	 v7ixjDIxsipX5Tu9cY43wlV77kDiDI9E63R5iacV9s/MhrpzanZ7d9uwuOdNeUNSyL
	 wyr3AflpWSNxZxmHyt7Y+sSbxVTrOadoFd1IzppZk1O8EtIu+E6s4N0gn+K3c5qwcw
	 t8CXPT7xUaELh0vSZXDP7h2FYBybGtzXkl7jrqDaEGDWyYbVoHH3hQHreOfbZyg+bc
	 ehW5tmUzZhUFg==
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
Subject: [PATCH AUTOSEL 6.6 036/139] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
Date: Wed, 25 Sep 2024 08:07:36 -0400
Message-ID: <20240925121137.1307574-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index bc74f131fe4df..cb0c80328eebf 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -569,10 +569,6 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 
-	if (!in_dev) {
-		inet_free_ifa(ifa);
-		return -ENOBUFS;
-	}
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
 	if (ifa->ifa_dev != in_dev) {
@@ -1174,6 +1170,8 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 		if (!ifa) {
 			ret = -ENOBUFS;
+			if (!in_dev)
+				break;
 			ifa = inet_alloc_ifa();
 			if (!ifa)
 				break;
-- 
2.43.0


