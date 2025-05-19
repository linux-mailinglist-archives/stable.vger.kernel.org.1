Return-Path: <stable+bounces-144884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B4ABC49D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11A63A2FCF
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30C286D65;
	Mon, 19 May 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC/A6Asa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03C286D49
	for <stable@vger.kernel.org>; Mon, 19 May 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672373; cv=none; b=aq7/3zLiu/1XL9W6OYhhayiP/JNCx5pRBgQ3YmCGrPi+gTbf1ojd7pWzX3PUgG1e9/1lw5iDQy4/gLYQEQDZ3RfB125b7VMxRs9DkQQ8rGjYGfH1XfQlXpwIyzJRT3L+qTQRwn3hpixgNXGUCpg710G+bYuUnA6m3nR9EJ6wYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672373; c=relaxed/simple;
	bh=ogshyGEpR3ONbY9x1ruDXH1dH4NB9DxiRmxVBO2sDEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+4ShFUGcMmbDy5V47v+EY8CH0WtoVWEGxMiVgleTqNFyPohF0LlYlpmM0NCBZayEQoRPoGKJ+PvYH9a29qQiuJyspy6aF1n96zExF4/cn7OaJFvYomV/vhZTI94yblqNE/KgHeCtNx6UE9C84/Qq/rc6wXQFGOqbypOVr/L2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC/A6Asa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7cad6a4fae4so771234185a.2
        for <stable@vger.kernel.org>; Mon, 19 May 2025 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672370; x=1748277170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUhtdPr5F3eGFJMnOLZSvEJdo5rH3NylNOZm3EEGSVU=;
        b=hC/A6AsarjiW0TMniAuYoIh6Z2LrwGsyC0b63D0lEU0Lhl8WlrIYNnZBCzg7MKjuwg
         wQm191RTufiHDAkmSOH3bVnhIiAmt59kQSUGmhWFi4/qoH0xFUMfjWX51btlZRNGN7ur
         4cgpPSCqbSAgrShFSX3aQ1WUoyNIcvCURAUh6zUb44xueF2k1beOmjqjZyorzwmR77rD
         GhBXPfTtipkSruz3NAGJ7H+qpKNVLogtAzQOytz9TOPVlJBJfaCe4ZSB4nI+CAf4Toq/
         Aopbszswc711575JKWzGiEHgZEDUEM5P/mtGK9LnhSabK/EfI9H0IrzJTm6zDYgUqeiq
         eEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672370; x=1748277170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUhtdPr5F3eGFJMnOLZSvEJdo5rH3NylNOZm3EEGSVU=;
        b=jBVrcq4fheNZe1kNAp+ayP4/bIN/tXHQAmXsYLoVIB6tSDakmGVFXYpl1g4I6w4eIt
         LVDb7bYKurEt56F3FQwRXyex1Vtd8OFy9n20Q0Hh7gAgZ0HjkJt1QARnIIZv4xEu8DoB
         RY6autucheXlIVX3pmz90xxXP0KJ6LtWLH+VPuozzGuzOM48bHLv0plYk5pDNW65H8Hz
         Pl+grZaRj8oARhrfnJ3p8lOC+c5w4Qv3n1aFVE5OCWjTkHL74+giLKFtMJEXghlV+5yf
         29KkCLqhCp0CkJ3m44c2Z0S71JqfqZY272fX5L9udyQe11imiSFPY92GNxfP/Nvjb/hZ
         JFIg==
X-Gm-Message-State: AOJu0YzgWct21/rGLbvAf5rB+qwdMbQcufqkzP/SxWhBaYDXOcNEYJXf
	AzfespRDDy8XRzrHD5cwDMQ7/LEPKQ4XoMNznpohGGR51YTaEzXlhC0KhwvAgw==
X-Gm-Gg: ASbGncv88RT//kRLDhyF6790iOJlDohOz+YGfEK57Xu3bAiR0eDhTd/SSwwHe2gHYsT
	EtLeobjV7hjEh8TAnaliVXkmfOijNFGiwBdDX7WmKMntM51AGn9UA1Pn5oZeME3DzovGmDm+OI9
	ypPwkuX9if3EFy+MxmdBC2CSllpw9HB9y66zMzl9fmbZofX+3IGQ2oQQ61tp/DbACGbSsVgBRtl
	j5z45+HRlfjeTgH038LK1+d+1P88eNvb3EWqvJO6leJHgyVTOy0uzImjbjjgpWn09jZRe0dcpIO
	WIpxR8i2iCVoArw5onx7Ylx4eKivrIonZJFeNfNQp42SVQoXRIsXC3Vhao7wrNSXVQ==
X-Google-Smtp-Source: AGHT+IFlPqq6ceDtzVziGfJAdepMk/a5xiiItedo0xMldU7IqNpdY6UHQtVr00Sqdzise2IkT2Qljg==
X-Received: by 2002:a05:6214:260e:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-6f8b2c95b78mr232537296d6.23.1747672360084;
        Mon, 19 May 2025 09:32:40 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:276e:c8c9:6d13:9b45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e953sm6906606e0c.38.2025.05.19.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:32:39 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: tzimmermann@suse.de,
	javierm@redhat.com,
	gregkh@linuxfoundation.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 6.12.y 2/3] drm/panel-mipi-dbi: Run DRM default client setup
Date: Mon, 19 May 2025 13:32:29 -0300
Message-Id: <20250519163230.1303438-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519163230.1303438-1-festevam@gmail.com>
References: <20250519163230.1303438-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 1b0caa5f5ac20bcaf82fc89a5c849b21ce3bfdf6 uptream.

Call drm_client_setup() to run the kernel's default client setup
for DRM. Set fbdev_probe in struct drm_driver, so that the client
setup can start the common fbdev client.

v5:
- select DRM_CLIENT_SELECTION

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-32-tzimmermann@suse.de
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/gpu/drm/tiny/Kconfig          | 1 +
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f6889f649bc1..ce17143d47a8 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -67,6 +67,7 @@ config DRM_OFDRM
 config DRM_PANEL_MIPI_DBI
 	tristate "DRM support for MIPI DBI compatible panels"
 	depends on DRM && SPI
+	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index f753cdffe6f8..e66729b31bd6 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_client_setup.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -264,6 +265,7 @@ static const struct drm_driver panel_mipi_dbi_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &panel_mipi_dbi_fops,
 	DRM_GEM_DMA_DRIVER_OPS_VMAP,
+	DRM_FBDEV_DMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "panel-mipi-dbi",
 	.desc			= "MIPI DBI compatible display panel",
@@ -388,7 +390,7 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_dma_setup(drm, 0);
+	drm_client_setup(drm, NULL);
 
 	return 0;
 }
-- 
2.34.1


