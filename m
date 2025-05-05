Return-Path: <stable+bounces-140391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B19AAA838
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2882318856CE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E54349B82;
	Mon,  5 May 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mftCi3QO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C7349B77;
	Mon,  5 May 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484758; cv=none; b=DhII05acxfYsK0T8jJpQWaxay8CvHnT9Z7H0htLh4ZHsG3asx5DUxc+LQwonse6vX/DL3tQHfM5YGMLVL6zYW30masGU5/cZeiN6xR8C9h6Dmv8qYhlxNXLMcu2mZGeUfklTZVo7TPPiig1iw/zFNFrk14tk0NTaTPP2MomU9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484758; c=relaxed/simple;
	bh=ywexBUzYrqkZI7OIwHPb5OJ1EGlVD5NLhiZhN4R+bxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3iJqH7KtOfogOoKQuozSycoDZv5JEajFiHfkSn+clvfjVf/lcZLM+hgGqKHMBjif3bB3GuezCZC+fjyenUky6mMbOCH2fxLzZOgnW0Fp1/W1n3AoOltMwafC4TH4fvEvzMvAjPrWKDfS9yUeBLbwbiJTURiEtw+Q9nYd1DzaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mftCi3QO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002B4C4CEE4;
	Mon,  5 May 2025 22:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484758;
	bh=ywexBUzYrqkZI7OIwHPb5OJ1EGlVD5NLhiZhN4R+bxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mftCi3QO2l70qsLHvUnjvh9WVQ6UNDfAfSvUVFK5cdIjFcajUFJwsyYxaaNjiv6zL
	 1HFfkfdAxKisPzUNBQhRYXDAkT07fCahEPjEQjZx9ys4G6tOLpi+OOt/yWUKseW2G7
	 IeqwpKjeNjNNnvovGNVG7jl+hl1uoCY1hLkhdoB/1B6AbeWVO6zTtqPRviWGr4R4pN
	 xjMP6B2qsnQG6IQQxEnSNgeLcyLJvogaOE6n+T/hcimFYCS+qLlEM7v9TGegMbyMo9
	 S6hNO5MCQTTCu4aVo9VNrqtd0vJ8vfGIJ1BcT+l/k68r2dq6ZYiJdSvgXFKqOvgmxj
	 6oSAbOYFBDFZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Marco Leogrande <leogrande@google.com>,
	Antoine Tenart <atenart@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 642/642] net-sysfs: restore behavior for not running devices
Date: Mon,  5 May 2025 18:14:18 -0400
Message-Id: <20250505221419.2672473-642-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 75bc3dab4e49b4daccb27ad6ce8ce2fcd253fc1b ]

modprobe dummy dumdummies=1

Old behavior :

$ cat /sys/class/net/dummy0/carrier
cat: /sys/class/net/dummy0/carrier: Invalid argument

After blamed commit, an empty string is reported.

$ cat /sys/class/net/dummy0/carrier
$

In this commit, I restore the old behavior for carrier,
speed and duplex attributes.

Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attributes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Marco Leogrande <leogrande@google.com>
Reviewed-by: Antoine Tenart <atenart@kernel.org>
Link: https://patch.msgid.link/20250221051223.576726-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net-sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index cedbe7d9ae670..474824e88959f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -313,12 +313,13 @@ static ssize_t carrier_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
-	int ret = -EINVAL;
+	int ret;
 
 	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		/* Synchronize carrier state with link watch,
 		 * see also rtnl_getlink().
@@ -349,6 +350,7 @@ static ssize_t speed_show(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
@@ -376,6 +378,7 @@ static ssize_t duplex_show(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
-- 
2.39.5


