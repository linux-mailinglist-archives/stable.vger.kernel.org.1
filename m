Return-Path: <stable+bounces-173734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59766B35EFC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B647AFB2B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80A30F55C;
	Tue, 26 Aug 2025 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwwh6apj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E921CD208;
	Tue, 26 Aug 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210705; cv=none; b=YDOCQyRPtnmL9xZDzEn8nupymKRoz1SsHk6ES8YQTTuWopKPRz6/VtZpnF0svV4WmQZbUXBIrj83SA0XJacJbB5nONiETfEOEFC4Kt3O0M4BoxIs3HlycbMJl8AaKPYv3VvWFdlZZM92RLVUmYrQrx9GafiwwPqqp0gd0Flx5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210705; c=relaxed/simple;
	bh=WNRFfbyB1JScy1/30FZa+Ntq9RVZSUi/ijHlpcIjNBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhA6v8u+MwIA3XFFt6yzOkFkNXiJAqp20rmDS3IQ0ooRi84DogDyqS9NOF7J/IJkaZ7tnt8DgxErs62+0ldxv4RmNWPr/SC5MHuYuhpLFJvzQeU58gSVaxcD+5VJPRIiNFf7cufR2O3cfzXoOwdsV0gJMabIts1qJHtY/xPsMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwwh6apj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso47500575e9.3;
        Tue, 26 Aug 2025 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210702; x=1756815502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LChTYlNX7jpHHdvqfK7E+ehTE+2KqMA/oVeIigfrSAA=;
        b=Vwwh6apjEzOY1ejGoB3TWth+uhkUqSfL9BHmDogpwT3Q1g678z/gnMe1dwrNSHfFTL
         TGgFNlB1x9SYmNP6dkHxAxmVcYRY/q5iOGMYGdgJNRDycgcJrN1iHwDKk1afLs+zqlqV
         1vPTrYY68U3Gh9psxtdEfbhUl4u7dxLRKmSJwQmgVEsyoUW4DqcW8n3iAg8lzYCvOZpr
         X4H6yH63L7N7C0z8EQnKpTb4QWhnx89ScfzJHmF1qHdpVu5M8/79IWp6MLO9gKO634KI
         a72iezuUgQr0QwBy/5NatOPljLgF35NDI6eow6+WcOl8iuUdS+EK0QcxDdCORGqjBf2o
         jzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210702; x=1756815502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LChTYlNX7jpHHdvqfK7E+ehTE+2KqMA/oVeIigfrSAA=;
        b=t+7K6Ok/Q47tQSG80Y0POoS1KWc6yAtAgO4PXV3qex2gYYwuVLYSeA4K8NRbzIEE2k
         JxN/JG4iEtG5Ioizy1SO51ywYDyVOMvUTje8WMpaT+YTCROwW4kh/Q9wWZ6/9EufFY5E
         k3KZL3dzRlmb4LFUm9eSnppWyVpG8vPAItOkxSfYvVjqpRp+7g6huM6EdZh3JzEhJUDH
         ZoaAK2rhL2/57go/HBChrCRYdU/xWUFice3iRq69Zk3pY4ITOHIOZYOq/aBvjkFt7ebd
         impS9ttQ2YV/3+74ncTgj65VfduHpZZ2QOAV5ml2UMJeQvEHGfY3XrnZEesLdI1A/0EO
         eTPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4h3x2ab+2G5A1otY62Qd/ycSYRi6ayRy0xIqtbt19ejUHyhFmwRa1M8/u1zP1n075SrUJCzw=@vger.kernel.org, AJvYcCWdU/lafvNpJIaUmPN1OAmMv5wngkyR3L8ai55ubIe1s0Ig1O0j9L6FaXp9c0mv3oA6avNCpUvc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbj2Ek7oGwgFXm7L2TW8LXkc9W6HTNJXo1ES6dEVULHbPAkhxn
	suAHTJWrisAo+j0Y7UoNdCSkLEjxbNUIcDrjeAO0qcvUQ9DtRRH/arLUzNPV2NXx
X-Gm-Gg: ASbGncur/E9ezq3LUsOzdsf2NgIwDgCin+olJ8hjmjqr167CYroH42VNrD3QnqwVF0W
	wMwg1XsIAgtHmR3WoCAyTFpKoFeUvverTiF0F+ZJlBCiPNK7naAdf6NSeL4Ylf/u9UqJHTmueJ6
	3QmKmhMvskGhh4lBEpwfqf8v7Lk6IIwvMS4fDnCKFl87F/O0RsvzZM3s/D3xL8FqEjZ0RoPSDwY
	sdODnHgJtCCwyQAdbXRoEgT4S70ja/aOM9+RRSX2009yWFg1cP9mFxJ/NNM/AUj93YksWHIsUIx
	jz0QtyUqo0AnFEjLLo05kKKgu2ds7zyw8YUSH1Y5AQTgIbFXTI+46b2tPcL59G0Q4Ajfk4njC1M
	prydCUsGZ1PrZf0wlZAdUJA==
X-Google-Smtp-Source: AGHT+IGDspJcry+lZbYtZeVg4+4kmcTBPmZuyilfg0+W2o8HlDsbRsJZkF4781x4cl6MBUZul/po1A==
X-Received: by 2002:a05:600c:3b2a:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b5179f3d1mr194717105e9.16.1756210702258;
        Tue, 26 Aug 2025 05:18:22 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5758a0bfsm149513675e9.20.2025.08.26.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:18:21 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v2 1/2] net: ipv4: fix regression in local-broadcast routes
Date: Tue, 26 Aug 2025 14:17:49 +0200
Message-Id: <20250826121750.8451-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826121126-oscmaes92@gmail.com>
References: <20250826121126-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
introduced a regression where local-broadcast packets would have their
gateway set in __mkroute_output, which was caused by fi = NULL being
removed.

Fix this by resetting the fib_info for local-broadcast packets. This
preserves the intended changes for directed-broadcast packets.

Cc: stable@vger.kernel.org
Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
Reported-by: Brett A C Sheffield <bacs@librecast.net>
Closes: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---

Thanks to Brett Sheffield for finding the regression and writing
the initial fix!
---
 net/ipv4/route.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1f212b2ce4c6..24c898b7654f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2575,12 +2575,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr)) {
 		type = RTN_MULTICAST;
-	else if (ipv4_is_zeronet(fl4->daddr))
+	} else if (ipv4_is_zeronet(fl4->daddr)) {
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


