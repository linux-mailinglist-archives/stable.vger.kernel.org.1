Return-Path: <stable+bounces-81694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA99948DA
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D08F2815AC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B031DE4D7;
	Tue,  8 Oct 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k277+Md3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF81E485;
	Tue,  8 Oct 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389823; cv=none; b=mt5K1gAM34kjLzBkoP8iM17LtruYuvE4gabY+pVzYNLnXvg4zW/i/nGTiTD27mn34QXe5FDtr9GQr8TqldOVcrhbIx+q7YbhYwuUJbkEsZ0X6MB8Nzd7RmnvOCnvQxidOOojF+QhzXjWj6N0k0tdfKuWVvDC/a3txIu7uLCAKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389823; c=relaxed/simple;
	bh=eviq3kMMjDnFI8ReSAGazku1VnsRrx7OUa+74uVL4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVIcyq6txrZdZ1HMQXcBQlegw0uaA7VmZuPiF+NuZr6WK4q+K9i1vvZdYXDArBhAG+KwP4nqrp478crytBN28Skoe/19tn4p+goHE91IvXYzpFVXj3KAdf57cXsimrEJdph3mBKAp2XPLZg5YYPxB9+iRufz4I5bEWjWuG6fEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k277+Md3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BCEC4CEC7;
	Tue,  8 Oct 2024 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389823;
	bh=eviq3kMMjDnFI8ReSAGazku1VnsRrx7OUa+74uVL4iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k277+Md3T4JjfAnD/zGMUpMd6s/+75QNsIH2oHOknVzYGf9bMlsvu0m0bv95HTHVg
	 y2/Bai21Gf8yfN/yBGnLvodeWSG0incSzQ1yBvkYEJWWdYAUKFcT+pdyfBg9o+iZOf
	 N+bGAuuU0ZGa9xPn4tu8+hJfwPiLEXjsrG9TTheE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 106/482] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
Date: Tue,  8 Oct 2024 14:02:49 +0200
Message-ID: <20241008115652.480395201@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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




