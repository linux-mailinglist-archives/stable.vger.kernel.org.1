Return-Path: <stable+bounces-17621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C3845F0F
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11601F291F4
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE684FA5;
	Thu,  1 Feb 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdN3piP4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7984FA7
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810464; cv=none; b=VXAqrFsWVur8pE+GtdQMA5yALGCNhM+/iLbSlruoCg2kEqX0g6DyLZ63oLoIZYSeG8hHBwSXGuokvdiiIxgzoYHZ0K+UB52n0bwIhQqDfxYWo15ryAY8TQANtGwNAhbwD2o2QrILebUUoBEbA+dvg2qbmYFbNmi8cYqprZuE7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810464; c=relaxed/simple;
	bh=oSa6ZDNvV33EJ7VE68enRAj3m4o9UAc2377tfNBC5pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7+lcMzrd2ZcMCopBdgy9Ve0GN/FCoeo/HJjgCmqZVJorQKIDCl37L4GUagKm6Q4C5omDRKBF5egPJWYLpq/Hc6vJ0S6Cr40Qx1uhnlg2znV4FA2Xi0zz0xShIv6aHiTJPBJCrZ67rw/4T8ijLu+5uNlUxIqIBZ3ruI7nAE0hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdN3piP4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8b2f392b3so1036965ad.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 10:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706810462; x=1707415262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8AtnYKuWwLvOFGHJm4I7X5AjAku8k1q8BzaAoKy0qw=;
        b=GdN3piP40WBs6Ska1VXIkYF1bK/jxRc6VKNY2vViWJ3DieWRNEEblyFELOKepGajFu
         xbHfebCFiWFHgy2Ql7K3pk1NqIfCekzgyiM4gG2X4D7ORdcfgC/8A6Bmox0t19rhPc2A
         e1Kqj1s2S6wiEImIUy8LeMK183v+xMtwpX5t1caYbM8GtGvNr0MCneriIUrotgMOAD0y
         C2qqHqQZVU5ur0qtTYZbsbshRpfk8HM1Wamxop5YKweodepfAh1VukZx0rTmxij0SmMf
         PYUxGWTpEmbAFP1zHbPdIPfoxBfGMcv53xrkr+TOZXoRY+x3MctpteK0X4ZUHaUtUPha
         1n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810462; x=1707415262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8AtnYKuWwLvOFGHJm4I7X5AjAku8k1q8BzaAoKy0qw=;
        b=WZdVwd8IH7KxellFrQZGthoXouFfaBR2c8Kq9mrfZ2sZzJwq5YlCE7grJFYs9USBoT
         keIndw6D7L80262cY0BA58PEsDfvQoSwY0DP+yf6YHrINM4qabqnFA/MYn60deoM0jlM
         z3a9chcYBj7v9kBUi2Glacfqemq5qH0pVGAVfQ5paDT/BEA/miUzRcNMgoeUoPdBkdJ/
         XHqEj2BmGBwOAlnVpp90N57X2V/plIh/Hr63Orz8DK8fIb273dnSZWAxyXpePFJzltXP
         uhmVpNfQBp9Lx8jiU1uCRMGux6A2plkXecu/igFRgemn8wZyQk8rGAI24kiGMfihwttO
         /9cA==
X-Forwarded-Encrypted: i=0; AJvYcCVgaZuQ42sIpVs6V+5W7kfFe6fT7LDuOjNkk+DanepdNnk6qGXWFFQSISmAzYQo1qWV8fuvZpT9ixnG6oFJtLE+em2MAyi4
X-Gm-Message-State: AOJu0YxTeVWOe4gnIHnhDdutQiSORvYgfp4b7Jpr0eHnUPW3OkeVlWTA
	3sIpncOQvDjOsVsFjPoFREtEM2okc/POaZT3IRnP0T/SGTzUke7d
X-Google-Smtp-Source: AGHT+IHx1EIhl8h8vbGB6p8xSNyMSmc3qM5MwaM7Obgq8/QtT62P2MLyObE3z6Mk5o8+/Q8AbLiUwA==
X-Received: by 2002:a17:902:7289:b0:1d7:1480:6538 with SMTP id d9-20020a170902728900b001d714806538mr3535586pll.1.1706810462023;
        Thu, 01 Feb 2024 10:01:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0MMgsJpPaOMaYRm/POZ6AOIchflU+XXc1d7NO68ALh9eqRsQM6ULJnsje9kS20Svo7FEUn7wRteIt71cSHlIKcJYORTJy3if/2FC8ddVj4/Zz7ABsq0o6ejnn1BOT/CDcGWy1TmNnq9RAtkg4BrfZyGbfhlSLtLLhtkY14ffnKIrUSWBQ40fvS/J9MD4bgYkR
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8e7a:352d:b9a0:297a])
        by smtp.gmail.com with ESMTPSA id jb18-20020a170903259200b001d8a93fa5b1sm93518plb.131.2024.02.01.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:01:01 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Cc: kernel@pengutronix.de,
	linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Restore CONFIG_BACKLIGHT_CLASS_DEVICE
Date: Thu,  1 Feb 2024 15:00:54 -0300
Message-Id: <20240201180054.3869350-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Since commit bfac19e239a7 ("fbdev: mx3fb: Remove the driver") backlight
is no longer functional.

The fbdev mx3fb driver used to automatically select 
CONFIG_BACKLIGHT_CLASS_DEVICE.

Now that the mx3fb driver has been removed, enable the
CONFIG_BACKLIGHT_CLASS_DEVICE option so that backlight can still work
by default.

Tested on a imx6dl-sabresd board.

Cc: stable@vger.kernel.org
Fixes: bfac19e239a7 ("fbdev: mx3fb: Remove the driver")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..8f9dbe8d9029 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -297,6 +297,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.34.1


