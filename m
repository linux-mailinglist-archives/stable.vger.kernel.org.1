Return-Path: <stable+bounces-172779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E9B33635
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C2F1899C6C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2F27A915;
	Mon, 25 Aug 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK3S5aNS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1127A129;
	Mon, 25 Aug 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102177; cv=none; b=fBEORQdMNUgkml6D16msf5k8NgEZJfuTMq9n5Fq2Td9ipz8KQfCzaz4A7qtV+s56+cNPioY737o72smaLNz+2fS0HV0OdCIsqYEnFGLidJJz1gQLupEwG/OoGHGXArKB8do9vtFFmMzcf0bUziQNPd8OWDs69yRzrdyqQnwhj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102177; c=relaxed/simple;
	bh=GCvqI9LIIcr7RmgcrjbPhHIv6c68uYZzl5LroXdpD94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ag0YrkWTJd+WS1rGlf3BIJoVjaXEDAF+mSOTArvm0VBbiJ0C/00ByCvrvkOJVveAAHn+fZ1/3YDfM1nO9ulvH15Ol8HbChGSwV8LsMjUINJCqRucbUDfLWvCERfz6Sfp+pEa3npP+3f/B0WvR6K2aSnHqXIrG+cc4Z2iHnnmQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK3S5aNS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so567286f8f.1;
        Sun, 24 Aug 2025 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756102173; x=1756706973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJflyOH2olAF4o2o2OC784zNhJJjVPpCQxbeLhg+070=;
        b=DK3S5aNSV1sssB0aCF2lj0qucpGKEyHLYWK8Ny+aNEYkJIr1FFgkAs9J1NjxHoNXeS
         8uUgfQOP81vnlfzA7gAniYpHqbTRsI8uxpZgl7gBf1RI9Yv3xF4BY3hCAfsxFbd5Pb+I
         jhrYVCND4kxWDQtc8mu9YoVdwwxZhu1xRucdfbab0pGU18rIDcbyC6HuvktlSooKaqNJ
         Rh7VYImwvV3QSDJQqQ7Gd2NFLU5DCNTJ0ykJjJDSsQrLQ0waOCMDg+IKP+ZfYjhQLhdW
         x2ZQQzUuB1CFT0/VydEVfnkb/mQQ4gV+m55GIMHmBql4DBQpj/RHC6lL34MZnY5e9lRZ
         9czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102173; x=1756706973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJflyOH2olAF4o2o2OC784zNhJJjVPpCQxbeLhg+070=;
        b=BzCJdq/lOwENTrAFXtQXRuP4JUmgO5QVP+6uPD25UZTC0urPpVhbntdUU3ZLPneZaV
         j41PQwRl7apMoa/ncPSONFkk32Q73p7goCUe07FJ1BEV+r9AtWE1NN8AUkTLkJxOB8Ba
         C/9L7BCK5fw/Y67SQMdqbgd/g03H0Okk0nHMVC07ZjusyDinRWIOh+yBMcqzyDrkttbK
         2rVz0nGgb2WtnKKB8fYx2QdAruCNpJaTL5XPHDCqOH/bt0uhSYqojh4wv3QzDVkDEzYb
         kok2R1ZfjcHoxSh0IN7BuGKpkBcr4aKhTlqI9JBQJfDRAeGso1C4Ql4L4U6Xn+UDJ8/G
         MEyg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFk7y/Is5pmC3pZeMpM6eYB1+6UK6nfFckDWcVlf2TV4ZUUGKFxlLLVky8tjLOUhldLx1k9Q=@vger.kernel.org, AJvYcCXM0pWubr1AxEMEon1u0dYTQmVDLNmh9QDMcefy0/JYrUasC2+RdqG0YtU1EOmf6fgsbjEF81J+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5zZcRQhqvwd3xU+L+y/bDCW8AGdBNWj6r8P31PNSsB9XwIyE
	Sww42f+i1ecmixNdKQBEMElR/IO5r9um0JQDAeiAPzkry+JVI2wz5f0G
X-Gm-Gg: ASbGnctBrCgn9tnwY0Ff3YvtBWda47zKj+WMkBNjxoB42ISW6MdYF6/31Rs3q7JnfeG
	Gol6mYPQMQ01OKPFWpyB5w1D/2M2t8d+S0CehRoTzatTQJFXyyO3ABBTzN/T6lAAAT7w0B06Hzm
	ZOG8dVZ7yNbb1u/zqt0PWbpcT9p/nrM4eFkNCq755QJEbrJywU/pt8kTlbwK21pftnQxV5pbwHZ
	NG5nl33YaTfkPnqcwaWh0DidkzPKd7OrNZ6zS7R2Q+WRW2iU/dhzLNz1x6tBQcQMuc2vL5EHWF0
	6niygY8qXx2G9jwWCiowZvMRku+k024msKf8cwpoefMHIIDnCwj2hQ87WbTXtvMGc5uzZYoFkV/
	EcWIxgVTOiUf553vjcqyUmA==
X-Google-Smtp-Source: AGHT+IHk9OUQ90jg7LRzgDU//gkduX/UvzafGmuDf940gqmXNFg932t9Yqo3ZGaSy7X1C72aV9dTKw==
X-Received: by 2002:a05:6000:2f83:b0:3c8:2667:4e25 with SMTP id ffacd0b85a97d-3c826675498mr4204272f8f.31.1756102173243;
        Sun, 24 Aug 2025 23:09:33 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5759274asm94690775e9.23.2025.08.24.23.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:09:30 -0700 (PDT)
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
Subject: [PATCH net 1/2] net: ipv4: fix regression in local-broadcast routes
Date: Mon, 25 Aug 2025 08:09:17 +0200
Message-Id: <20250825060918.4799-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250825060229-oscmaes92@gmail.com>
References: <20250825060229-oscmaes92@gmail.com>
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

Fix this by resetting the fib_info for local-broadcast packets.

Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
Reported-by: Brett A C Sheffield <bacs@librecast.net>
Closes: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/route.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..98d237e3ec04 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2575,9 +2575,12 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr))
 		type = RTN_MULTICAST;
 	else if (ipv4_is_zeronet(fl4->daddr))
 		return ERR_PTR(-EINVAL);
-- 
2.39.5


