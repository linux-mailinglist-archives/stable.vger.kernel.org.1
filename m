Return-Path: <stable+bounces-58141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93901928AF3
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C628334D
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91016C694;
	Fri,  5 Jul 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MiDoomCe"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA816A938
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191187; cv=none; b=GFS6cYeQ9sOByu6+ZGACIO0csxCmtgLJ5d603eUTkXm5Cv9ni4rZ3ClEPgNoORXn0ZQG1LRdheHGG247Jq2hiOhTGjoaxEBg9HgzxxXO+9ndGBY9NQhAw+vz7J8UOlbkzphKQ5Tr9aqg6o4jgJV3eU9gjygoNIdVT1Z6EsZOeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191187; c=relaxed/simple;
	bh=YnwMFx7v27V6FYvekKLIctK4MfTa3mGutFv4M3UNWRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU3GKC44nN38XBBy3Hgs6uP2T3+KFUd6V5+k78OApMyaZUdOPVlwAn/XwiUB/XamyS0MNPmqI7MgQtc9DVYaGKyh/VekI88b7GQ69DFsBC4vxPzcqlr5lPAlEA+ksb3WCk3mQj8XBtZUiQBkooRr29JMwnTiCeIkoz5CKxtnlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MiDoomCe; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso17992791fa.2
        for <stable@vger.kernel.org>; Fri, 05 Jul 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720191184; x=1720795984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=MiDoomCel6w9+aRHVNVbTfORc3gy3a82JHaZynw9/DJaJWN6lNRerFWtG9mEcSM24X
         6IcZBJPFAYrTqGQ/W+rwmtjbbh+e3PxMYHFbG767gqej7Ehn2bXP64RA4a72kjKSKOIK
         bEkDyzCUkEdZseV5KLe1iti0/6muZxpF6omx5IgUj9Iea6HPrndskXjbymiBvQdHhzBY
         pdbXk0ZniYRyIFBHLIYNWI0nNq+MUIZ+EfAfRfUhB/DmQczABBFP7IBOdN9yANIPebEj
         Pju+6bbE/9bI6Nw5wETaY6JKJHptrAfUQmFf1qH5IjguNU4RkXaW6gDqQ3h1N+RcRJqN
         tMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191184; x=1720795984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=G778YZeRjZFVZIsRwZ0MOaOUaoRLJUq5JGB+/KejMmPkUULcaP6A+EVgDHXp02qgnS
         L1wDmoo80E2MQEc5CZvDIIXe88ZtLYljNDuwobiR43Hsb4mKCgRWgn7re2TOdt1rgp/H
         umt8gIadahowfuWN4iMekj4coAho1O0sjKFdDCkRKsSEli6AgDFmMXdVEf67+r80YUW5
         YLDNKlSuhFeWrh4PZfdoRN/xxFl4uPAdryf0xy5dZmd8ceShB+hN8SQ4pUAcvoS3nQnw
         RxbwqXUOSg4jzv/c7RDj9bFA3ia6IYqG/2hW9t8BzF5iNxwCSU6N1lh8M8ihsHLT5Gwf
         auhg==
X-Forwarded-Encrypted: i=1; AJvYcCVeOfJdyOhW4JwOFcyyXf13X97icNgdCjFQTADIydb60Gux/GjTGl5GrYesgW8jEvx94yOvetJEsfrR0ZjylE9dX/hq976F
X-Gm-Message-State: AOJu0YxmA6kn/zkWCnaMdTbLkoSQEcMBN9VPeKF2F5TwjCTLF6th3mJu
	u4eaxIT4JJaB2PZ32x9UzbzDlaqWlcdNia9Mb5tz6/6QAPxUXod6B72oqHwMGqgNeXjmd5Fg3ro
	jZ3bkDuUZauU4WJTKABJqUdnJZrsVqQGK
X-Google-Smtp-Source: AGHT+IGji/Z26xmcHkogAm1ph3V9tH1xVRRQ4vhiw7Ca6Bt3O5MaNV6QuT7XVhbCJCQIekjB7oeT9Zkt9rMM
X-Received: by 2002:a2e:86c8:0:b0:2eb:dabb:f2b2 with SMTP id 38308e7fff4ca-2ee8eda88famr29149391fa.30.1720191184198;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4264a22720dsm1381455e9.27.2024.07.05.07.53.03;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D748660440;
	Fri,  5 Jul 2024 16:53:03 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sPkJ5-007Cqm-IL; Fri, 05 Jul 2024 16:53:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] ipv6: take care of scope when choosing the src addr
Date: Fri,  5 Jul 2024 16:52:14 +0200
Message-ID: <20240705145302.1717632-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the source address is selected, the scope must be checked. For
example, if a loopback address is assigned to the vrf device, it must not
be chosen for packets sent outside.

CC: stable@vger.kernel.org
Fixes: afbac6010aec ("net: ipv6: Address selection needs to consider L3 domains")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5c424a0e7232..4f2c5cc31015 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1873,7 +1873,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
-- 
2.43.1


