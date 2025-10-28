Return-Path: <stable+bounces-191397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D6C1321C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD38C3AAE04
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA028751F;
	Tue, 28 Oct 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUN2/fHi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3C1BC2A
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632725; cv=none; b=kxiPdjC2P2oCdYh5//OqlgLBz+wqYBlyx7FEiZ8ukB3X0fiODJD+hg0hcs4AQ6BdZq/7o5VM0zAKF40CMry6tdzBUYMcXEUdWT+1xMAISdKEbhXeemakfGaei9HyXHMNltan/sZqZKP0JPLydYycqI4lehwC+pdQz9SZLXgBduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632725; c=relaxed/simple;
	bh=6yCWrSKh0Tfap3i52NTXvTHCY9J1YImnfu2v1lxtHks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYOO1wBHvEL011Cp9MmwDUpt9ET0H0h1pygJ3Q6TVzftJoD+EETGtvOpF7gE+w35YeJyMvaJ+rlltN0FYqOIM/SVPWHXj46s7DJcsK6CtS0WHqfDodewuAJEi7C0oz8wxROtHnHKt6P8Yu82FxaSSwU8ndT5VpSeAihlgbDbbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUN2/fHi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so4016092a12.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761632723; x=1762237523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLfGh1leNUsZjwbIktpxp1n7uZcLFRPeUCzP02QzPMk=;
        b=ZUN2/fHitejLqnYb5G6HsOGak4DENjC5Vk1CBZYFSbt6s+UxORveiPR6hEZz/vT+7W
         ZRmWMwCFO9mHpqTKXZPqjn3spgG781RIukMiADlW52saShC/cWvfy11U6wiz2pnWKy1g
         iPTw4fEdQZG4Qp8JAiFH2HnU1eEadDqSZYRXdvCbwUw+xoSlhMZBZ6NNAokBaJAmlaru
         C0uvdpa2KS9UsrM2WTFx9VyecWKznI5i2BLGR/iXSfnV0yGSALuTowZOMymmX7SeiXxg
         ZcNCQD68DiZrRmSxWvGUXtt8OpqwJhv7/UWhpDGnQWGZKH8TPi8+zaXdrSjXwJ/0ZRUT
         Rsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632723; x=1762237523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLfGh1leNUsZjwbIktpxp1n7uZcLFRPeUCzP02QzPMk=;
        b=hhUliqZv4laiT830k9mkE/dRgELQ1LlxI5y9tnXRdUNRtcMJEhjdpcR1eF8NGSmCAp
         nkFGpkJvK95HKs7DL/5M5u6+Fu3+hPmVdFYEXMQEvfoJzsoUKx9c8W4AguYsh62sNoRm
         0yThR/8na+kUHdPhP9Mkjk4UJxEvRi7HyQA9lPmYXWadkR03Fq6bIzBgJ+fwPPq4v6mI
         +gdbjOmISRiyn0+oZyyd5zmMTpXbr+lBAheF8buuf/GFJAFViQ2E5KPGIJPsEM+0EoPU
         mh9m5tK1cb+0wEWllqCtAXJYz2WKK69eG7fQfoJ1OwUJChffPR7XmO4RvliHS25Rkqy7
         Vnaw==
X-Forwarded-Encrypted: i=1; AJvYcCVOtUZPqIFuZnGv7U137S9lDdyZ1BFcC/IrWXTCGTgOedGVy/d5qyw+701f9J/ooVvt/wkP8ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubVcClSpGBa7lAdCuxoiftPFMMRUoGDyrgcTGlvc9b4YTYf0u
	btzUKYCSHzvUiUoDZ/k14q5Y8p5TSHx7U/eQ65Lls/FmrEPYZAqQfqbn
X-Gm-Gg: ASbGncv33p5lM2uZyC8yaG9S4RSVwUQKmXKdimOKys16uB+wA7KEClIRZ7MYZ603n9G
	aCd8xItk4X84HjQxe3TxbimrUtpjq8zqMHyE3/AgWkrjat46/cYJb4x23NWBO/YfySIOAEoPgnu
	1pGAWG8fNa8U9B/45pBE35WPIDSRZ939c2gROwOfwAUdxnYu50oBqpJIkVJW7eAEpI3KVJT9Rd8
	/IXiUTaAP9fUAHKyr7tFne6vkRjoZLTiiqa5sgTqdwLKI89SAJLNtt3MbQrMKZAKawfqskvL8rp
	+BqNQORAXE9w+cK/AeWvfINlxA2WmGFWZbW19CILtYHZiaj0VKzsUZ2PS7yIWV4K95pbyTgBlW9
	2S0XLf8J1oayWjukgDLjqKAzApHvBZRouUAT28hq1+dxthYJPxrYbBhHEW3N3F5UyVwg6YVgXYo
	o/qxKKovcv0t69qjD4uGveWhy+eaZ660CD
X-Google-Smtp-Source: AGHT+IHSAuBgHpUbQhJC9STJdSs05Hy2t30Op7zl+T/wUnVSBrW32g8WMe3rf9WtP6Q8+DGepqzUJA==
X-Received: by 2002:a17:902:cece:b0:24b:164d:4e61 with SMTP id d9443c01a7336-294cb378c42mr33310415ad.13.1761632723109;
        Mon, 27 Oct 2025 23:25:23 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm103004975ad.15.2025.10.27.23.25.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:25:22 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roger Quadros <rogerq@ti.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] phy: ti: omap-usb2: Fix device node reference leak in omap_usb2_probe
Date: Tue, 28 Oct 2025 14:25:06 +0800
Message-Id: <20251028062508.69382-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In omap_usb2_probe(), of_parse_phandle() returns a device node with its
reference count incremented. The caller is responsible for releasing this
reference when the node is no longer needed.

Add of_node_put(control_node) after usage to fix the
reference leak.

Found via static analysis.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 1eb252604441..660df3181e4f 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -426,6 +426,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		}
 
 		control_pdev = of_find_device_by_node(control_node);
+		of_node_put(control_node);
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			return -EINVAL;
-- 
2.39.5 (Apple Git-154)


