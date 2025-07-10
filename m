Return-Path: <stable+bounces-161587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5131BB00544
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF1A177EA2
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A07272E53;
	Thu, 10 Jul 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRgHudIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA1155393;
	Thu, 10 Jul 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157677; cv=none; b=gllsfqiCvl9uITXLpmwnxtx+2uiAnmzLGQxSh/ONupr5HEiH5e8E275rBbqFdnQzsXrVQOIkOuWOYL3F8Pqak12RrU/5tJ7x7BjQxXCXzID6kP8XJvMgdZHyn2NY3hZv5eXSnWZnJeJYcLUFHHvf2SFET5VXw90qfplsoS7Ykfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157677; c=relaxed/simple;
	bh=GwBMvy20Q/f/c1GU3NkoI7HQv3lLgVKLQbRdgOgSdwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=frvP/IvSoUA9so6lPtmi6orMICOU1KvKl3+p8AJAWMbW/eJdbgbUNtr6vTEN1bwsBqaGhoAnjXbr2c4AG1uuHMdOITES+cX713ynqmAyedDrucMeZx7hCFgTnB6npgmvjEOMZK4Dn3cJZWXsVOmMbrlsa8AaDATrM4VhOlEj874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRgHudIX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a582e09144so689968f8f.1;
        Thu, 10 Jul 2025 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752157673; x=1752762473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orrC1npzIwvmqyAqWmCWEDiAyuGU8oStshxiTAKdYmc=;
        b=iRgHudIXy1/N1t3n+5R+kkR8TETQq3BtuHKTB4CW5L+Z0l2JoUCv1UeSsPCRcHiTQo
         3TD89p2PRaNE3zaQ4BCC1ekNGAbQ/JpoK8OED0IGuyh9mzQoPsrEl7rRbccH6pLbfFSo
         ChksrPSajJm0mezSE9lmjqw997pzUXbHh0W+IjEUjvUBlbor0F7gM+JL4Tn0uN7CmfH2
         p6ne7Tmjzn/viRqe+cNuEdLDjXeIt4B6Cp5jajBfwmspewxfDsU3v5SkoQ/6F1SGYycG
         awPXFK9C2ldkJAv/6oO6FcSrg158fv0nq9ViSSiF+rztCV5BO+HAJlKRw1o7FOMXSO4d
         37Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157673; x=1752762473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orrC1npzIwvmqyAqWmCWEDiAyuGU8oStshxiTAKdYmc=;
        b=P2k7ffLliwowOOnnYMT1z7KyR5kXXcD82/J0j2EXr7J7qbwGE/y1R6OftRLCPa4MsQ
         LAzNryEb5z+U+UvtGpiH3+P76Pf07LfyFHBcFmLQukAACYV1vExi8goxDAjyCCyxoPp+
         yKmVKNvXqIbRwnsbKv1NCki9dq7S3qsGqqxqNdskMA+LLQ0tWrXjv91LS96MnNIEyB1U
         3Wz3yWtj/FUTc6l4o7Zi2buVKBiKG2SN0CKb5Xk2zAUr40kD/Vx+/EtUWp1tR/CcThs1
         Oj/DGXjsu4BsrIty2rd7ANhnFJrokdzSGUTftakAXmIubSw/5D4gjlq7eQTh8jLQ38YU
         r1JA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5+KPff9qttz46KSS1nve9sM0zvjVWR7Ae2blwbsZq0ChkVfwaIp3F/ZW1utz2ZP5dnyu/ABCJ32cEx8=@vger.kernel.org, AJvYcCXm8FIMT3pL1QCrlbNNd+rvOzErE1A9Kn1fE6vvj0Pbhxsd4CED6WEjVqij6aiaHvzJUY7cvbYR@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7/euyfAw2noU+8lQjyH/bZKLZfNxSkuCKr3NfXreMlbhw1RT
	hFHBuGGj7eeoFns5tB7mo9vtb/fitkWFBTWNsN0X5nS7oI9n7NpW5KbI7mzRgxnM
X-Gm-Gg: ASbGncvXwEVzZ+KoDmlrwWoW+5UufBhzxZN5kX/+u3KyHEWYh15LFdV59lDK9hLAyvW
	xsY5JYk+kbjN1RvSxSdjXaimjGAEwFtcNuJPQHwmoR8DOvia4gwTD40RvIEPOkGDuURiDuYCdl9
	hkEixTKqzv642Q13/hN2QmjlH0k17KjdPqLW3yCOVn8yWzlpElllYEeO7KlnzAKKRFJvFstT7vF
	qlzGe6f2tJnGcx7CcRVbAJ+EEGUZdujtg1DKU1uozM323NS7/ccLIjLgSl2vOWVNGdGA3FnhlX/
	6N4aNadNiVpFReKltOPt793+ShqSUnLAL5iQZVTrxZgkOgCPX/iSJ+v1HEp5G1touxwSvTXLiH0
	=
X-Google-Smtp-Source: AGHT+IFqegt08FZUc/tpQUlIrrnmY12UW8TaO7t2hQkdpXNU5sSuz3Mgpfu4LbfnrJCoJWQo7jLZdg==
X-Received: by 2002:adf:b607:0:b0:3b5:e7c4:3419 with SMTP id ffacd0b85a97d-3b5e867c284mr2280167f8f.17.1752157672416;
        Thu, 10 Jul 2025 07:27:52 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm21237845e9.39.2025.07.10.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:27:52 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 1/2] net: ipv4: fix incorrect MTU in broadcast routes
Date: Thu, 10 Jul 2025 16:27:13 +0200
Message-Id: <20250710142714.12986-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, __mkroute_output overrules the MTU value configured for
broadcast routes.

This buggy behaviour can be reproduced with:

ip link set dev eth1 mtu 9000
ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2
ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2 mtu 1500

The maximum packet size should be 1500, but it is actually 8000:

ping -b 192.168.0.255 -s 8000

Fix __mkroute_output to allow MTU values to be configured for
for broadcast routes (to support a mixed-MTU local-area-network).

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 64ba377cd..f639a2ae8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2588,7 +2588,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
-- 
2.39.5


