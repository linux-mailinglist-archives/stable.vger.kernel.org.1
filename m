Return-Path: <stable+bounces-67709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175549522FA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85C428589E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC501BF32B;
	Wed, 14 Aug 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hgmn2X+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070E1BE25F
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665511; cv=none; b=gwGfxYvFslChvXQQCg7QdXDw1lvJSFUgs4SvFI08tTUXKGguD10cTvsVeR+Qkp4Ep9FONTAsG+q2nlhZwZ/jarfHGAFJJ7hCckdpTLR0PZCkzz0g2WKnh3t+ND4PshLC4uybNGgmp6ey3aLsJzR3FV9Ch96tbNjg1Mu1Y9xg8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665511; c=relaxed/simple;
	bh=v6yCN++aTWIn2HL04PVf4IrdFZo3E5raTygn8B9Fh9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmHo+CufyL3xy6/iJOlIPCO8VY+xYSBLcu6ng2MSR2aXDI6Cp8Gn3uxSqRS90ODmyohZDn3cw9h0Bja2XdQPPE0F12Ne/D18zRmkgI5l26RMWMPHIXg8e1rxFJXdCoEqhtPKmDY2f9Wj3UH3/B0JoggNET8Gr+XL/GfNWjNrq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hgmn2X+m; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36ba3b06186so139909f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723665508; x=1724270308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4hCGRVnEuxwiy7oU4DBiRNiiuMGKwjKKo5OtTueCic=;
        b=Hgmn2X+mgImXg7PDDf71MjzTpzcRO8nSqKN3eXuP1Jfz0NA8MIzG3wyT4Y302KKNGU
         Yo5/lSjjaCqwMCF27bdvPHheNnh0T0YJsQNlEWfNjxiXY/oKtP2jM6ikFOVjxfCiLqKi
         xjyZY7PnRT6bi3CpRvsrpFs+v4EZGvPqpNA+WmDoo7tUynKnoyn32z+XLZv+2R/MR/dm
         AKrD4jvuFUX5K5PUaQdtM3yI0KCNkkxI04/C3OdqtBIfgE34GU5i/nDYBs7mEjHn6yGf
         w5t9cqjjpEcMuZlBgVzXMvKNUEv+uW19MwnlnfEGv9M/PhdFbiGX5mArzgE+G61bd5rM
         7RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665508; x=1724270308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4hCGRVnEuxwiy7oU4DBiRNiiuMGKwjKKo5OtTueCic=;
        b=kNKUP0kn1yCTqfYVO1/fYeDY+KS6m7KFTUjuvLXbxzCfU4l4W8mi5/HGZ0WF6mnSVb
         nfr0gE7LA7SvMkU2TI+2kE1WQg9sKYV58z4A/xqRriDPwU8GU6OXJjbPJ9iaIey5kz4o
         0yA9byJ0WKkdnhBruzVgfM1pSrrm7AnR/RmX64EJiLzCOnek2b0LMoTkG8qX6vBvf3Hp
         qBUKvQGrBKV2pJ3pBQxwqVtYgzKBW6yHkwsPq0InlNvoyf+oCKhoi5IHl4y6Cp+fXtAF
         do42dpwQ2P4m1CTeskwRpubfmNeaiK+HDchiPFbgIpJn5a8C3zHH1a3iGm9CLDM1coo8
         Scxw==
X-Forwarded-Encrypted: i=1; AJvYcCXiwSyk5E2qaG+6D4OwWUH7/oz261OPlgjK/k2QCkIHkRrAYZiExQ5Bj/yJUX5bFmfhAO0oqX2jPxxym9wSqgU4MxPuHNjp
X-Gm-Message-State: AOJu0YyqhCz1JowQK7E8ie9GLzw9m2mTar9uFo5nnZuQ9sxc3rVlY7j2
	mG4OgLmPiJYuNkxG9QRJb3hq3M+APoWCu/wb0M2Tr4GUk8KfKnuzb9kHWpyEtik=
X-Google-Smtp-Source: AGHT+IE3BzsR7UafBAgIAWRDl6haElUv/rAMn14EgEbQx6m7ZWfdFr9PhRc5eYrYxjkWsVukGaOw0w==
X-Received: by 2002:a05:6000:2a7:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-37177783998mr2835327f8f.29.1723665507702;
        Wed, 14 Aug 2024 12:58:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm13482263f8f.59.2024.08.14.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:58:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] thermal: of: Fix OF node leak in thermal_of_trips_init() error path
Date: Wed, 14 Aug 2024 21:58:21 +0200
Message-ID: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminating for_each_child_of_node() loop requires dropping OF node
reference, so bailing out after thermal_of_populate_trip() error misses
this.  Solve the OF node reference leak with scoped
for_each_child_of_node_scoped().

Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..30f8d6e70484 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -125,7 +125,7 @@ static int thermal_of_populate_trip(struct device_node *np,
 static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
 {
 	struct thermal_trip *tt;
-	struct device_node *trips, *trip;
+	struct device_node *trips;
 	int ret, count;
 
 	trips = of_get_child_by_name(np, "trips");
@@ -150,7 +150,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	*ntrips = count;
 
 	count = 0;
-	for_each_child_of_node(trips, trip) {
+	for_each_child_of_node_scoped(trips, trip) {
 		ret = thermal_of_populate_trip(trip, &tt[count++]);
 		if (ret)
 			goto out_kfree;
-- 
2.43.0


