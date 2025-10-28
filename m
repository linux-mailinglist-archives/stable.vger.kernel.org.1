Return-Path: <stable+bounces-191383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FFC12BAF
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635955881F3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474B277009;
	Tue, 28 Oct 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9fGlCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992419D065
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621401; cv=none; b=VrWOblF+C7tir8Bl0fsfsUttINOnd9M36rDoTdvD3MFmDZ5UoCaiMCQsil0WUFPx0HJLXX3DlpnmwGnXypNLMZ1KsTyZF3+dQgmJH/hmF2LG7tNSrC42ckkqWBu2VOr/gwGw1vgFRPPKjBfP2Drnb35sfmMaZTC+OvByqTabLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621401; c=relaxed/simple;
	bh=cHHkD30AaxNGfUjFD9KtWlH0G5zDyjXDYQiWrVKJSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPXLd+ntTmRvM4VDCK0QTS9dRqEFZA59yNWROTPkNsB+/iPoszz4dmSi5FNqLiOUimNGBCzJpTTB+txm0xO8mv5dCBFyZ3I6epy/aLWJYwMbwJpb4e4ikmW28Y+IOLEtZPeb3acq8QAnKVVxYccViOOZroXx/qb5foD+pJQg1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9fGlCp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso6846056b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761621399; x=1762226199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=Lv9fGlCpfXzsi6PkQ0jGtnCEf6t0rev5XwPG5y0I4hHwY/Y4ImeoGsil/3jeKiJygC
         ovZuqV4YvhZQrD3ILzoS/sMiLFwLBpjKd5Brcu6N9LJhbKXh9+O6bht+vOlRRIJ+znef
         JUR7wPR8aSUT/bbevN9Qi1Gb5PjPx81Y0UHNzXpnfEOqa/ttjrxHbVDY5qFc7ZQ9QL+Y
         zV1tWc410U4XxTdojpFIvWviPsiRIDuAC3qR+GSqOfMd23964ciyz41sI6upV07lTmDq
         xXcgEhhNLsS+id6X7A9yqhsnsOQ5GdoiKZkorcpVeDxgQ2IWQKFCZ843FlL/HlxoDH17
         AXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761621399; x=1762226199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=koPl5Gu9KqZLT1SVx7cLVx8bMySm5oPQI3tdZcu3oGBKefdFAsgPRPogz8UuhiNUb/
         M/uL+1ZedIiV6LhJ4OZyXGhI1esp/TOpQtKQ6iv818S6klgyh8L9hY1zShBymIzWOufj
         qD29WEg2aS4btqZMfdJ52eQrhqsb1uBRUTvBZpjm3GKh3Ylg5rG4HeFqekhzUxoT1r/F
         fbXzOzU2xEr0PQTKKVxYjlaVvK5G/rIEp79aj+nteEmsOAY6hjfJdobF8mwoSBEheKIv
         8jg4K0i+B9/zxAOnQIBXXAFDyvWa1MiqIkN6IKxFARJ4WlyMGqrGYbTcd6k8PB51JQMi
         bZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVoKEDnjCAKpW2JXPOtgO2wrFbKIlXUADDWePMUfR1CPvCY5V+lS6nrCyQqRCOo+Rvlavyp2qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZG2PSkjD5dvbx3YBAa5Jzlmt/3CH+KUuBfzhf16gfHVsQIvWK
	AVV9r+0WGUglKw9hsui40w1T7jlPN2lEIVjmzB3PlctQteA0smvpNteC
X-Gm-Gg: ASbGncvAPEij8duM7fcDtU27wuXBmQRV9FMjSF5KDquOy+hn0iqzuf0lNvXUAWhPbAS
	LrhjPhUXhE7LnT/bwcDSqp/Oat5C/lWAtcvkuxgh9wqrwUJpRS3y/2CsTc3ae0GTXtEDU0+fAtL
	qaBXtIQV2QTJK1xKc7dIO5TAt9Dh9UNxAxhR5Fcn51mlFrf6JtuWGoC0xCy3uB03v5PhCGUB/ey
	FwWzN+d4WrxQd/VRhs3CZquhfwOghSodZT+ElL1z74YOFiRUm2LpLjaNq/DMkJEm6pVPs6BCbu8
	YAtSaX0+1fS4nbpfmQ5DCrzjDIsqLJVoFUNCWUMQbw2aO1cqgOmqugFsrLXluMC2bryScePGUGO
	xCwz6z8Wl4BRFuM0MDpU8c9HxQ8W57quO2otthr06ImFSeKLm4ENNOBXj7cevQKxMFywbqzd0IV
	r29HcHnx+wWrywedzHPoXDeQ==
X-Google-Smtp-Source: AGHT+IGeeElAGdz52QvzDON6TZ6X2VN+9KdN3tRsb9MvpzKrX+azsLuImQoCuSHnyIB4CWg/XHY7mQ==
X-Received: by 2002:a05:6a00:c8d:b0:7a2:6b48:5359 with SMTP id d2e1a72fcca58-7a441c46a7cmr2594121b3a.24.1761621399271;
        Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm9818276b3a.65.2025.10.27.20.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 20:16:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
Date: Tue, 28 Oct 2025 11:16:20 +0800
Message-Id: <20251028031623.43284-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pmdomain/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 33991f3c6b55..a34b260274f7 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
 			return;
 		}
 	}
+
+	of_node_put(pgc_node);
 }
 
 static struct platform_driver imx_gpc_driver = {
-- 
2.39.5 (Apple Git-154)


