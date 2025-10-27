Return-Path: <stable+bounces-189942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA8C0C778
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F121188A217
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3666315D5D;
	Mon, 27 Oct 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrWhnroA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250EC315D23
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554737; cv=none; b=aOJww9pe5cKcKUFWPsIrjcI2V0yaja4U/eT7els0JGADkBILRxZJhqZECffODaVQaqAmlorufwiFM3xOB4ubH/f+DJ1jOeQto2jT9DBPbdteHTqBxXSkx6JfKMZGEMHf/rVmD5kwV+Vz1hLVzhSqPzg/h+rRHtMJ336NpgROcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554737; c=relaxed/simple;
	bh=ly8Hr2ywwPol+OOs8cEqDSSykysMh6TpsVP/PGQVACo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjDUc5sVT8WXlsUHSR3wxa6tkfuH1ZyJiEHoWL7gocWJCmgrEb5EjUB7wy4U8klBP7THvAqkxbVor6eHkLNZhvD44GqOXHN/ikIZNn2QUUhxEntKGygBD46noA8ET00VkSDho5+gEMnWjZOMJzLQh+6j9zKhZvX1vqjGij/Cb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrWhnroA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3181841b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554735; x=1762159535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DU0KscrGihyZoXJMago0IWkiGUoidqfLwL76Wss1j/4=;
        b=QrWhnroAXJlnaAQd1X6cggmCZDoDH7RHA8A2ZmAoKtPCphlb9vz9UPcqaf1dHcGEo1
         fjEyZOPDELWIcVFSluUH8SiqDgmyUUGyZohlD/cb+VfG718TavzbW+UiBx0piw7LqOpm
         lEKAnlDOtCGB3M+Ul6GjA31wW+TjZZPJCtFo0ilYBo0gbb7aeClVajhz0vFXGbqNYyKU
         x0wiWwVS4NxmguXDKcv5ZegdZLHLriCfcMNEuyI9+qVaPzeURGMs80Kc50w+B3j+BoCF
         WVooy1brKc0tyMO0GO/hXmO/ZW+NiNp4p1sG4OlcM/VT83r37bLNxrp5CqnzXkc5OIKG
         VcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554735; x=1762159535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU0KscrGihyZoXJMago0IWkiGUoidqfLwL76Wss1j/4=;
        b=hhHAwTyRLsYHsUEI9Zntml8d9gpAp44ziXlWk3uYUjQ3DgVcUSHWNeHTnWSu85UscU
         //SmRQmWUHowowWAz23RaKAv1NN4vyUuJAqQgWwj6zuzQL/0HY2vKlNzXHv9pQiRUIwp
         yOajhTswALzyNsxUKqf/7zOuUi8PfcFtRDNzoaF8dsHVjwVuwWt6DLnm9m806RsLUGES
         /4K333qZYllZo+LAqIZ0n4t96Lji8CZAx9au+tABvnnqnbLFMyQcPJHKBeYM1TBvlfcx
         XGYtik9z+tUmEXyPy/HQ6YuDQu/vCKIbBn+S3pJbwatkAJ9uVaVK0ozvBaR0IEsHGDgu
         jv4g==
X-Forwarded-Encrypted: i=1; AJvYcCVrQvdFopVk/VP7hU5Fbti9wVvg7pPuW2LPAuKThOVIXY/X1AT+CkuLiX8Pu56dahmEFh4r2NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDqM7SE1jSTNVGxIXwLzwT5IiumQXU3UuSdSit9lcAyk31QvD
	oitOWcCuNohZ2J2/PcbiLB2nv66sjkjI1Hy26G7wq8IymKRk0YZ/WWkG
X-Gm-Gg: ASbGnctP+9/8RP48jRi7Y6o0Dpeos4mnpP0xdhav9F3EJQcWpvv9Uu//GLmAHzbKtFL
	GNm20XZGUxMIEMRgqg6ouOPnk0qyc2HS4Z14n7ZSwLkdxCW1QyWbE7pqoY79LFkRy+y6DC1nOAI
	tSZy/HttH9uvb7dxAucpTDxiatS05Sd/AZI1HSTdlprtD9zYGPm5To8HLLL4j0UB3JxpFAhUlPo
	M6l9YYn5/I2vJcSZ+4kmsj2iRA0ddXpqzVUS389e/RJJD/j/nI60l58XIfH+d4xcB0nYS40AYRt
	/LbOQbRoCSTWWkC4NznNP2JNhcV9s5LgMk3ebSn1avzvbCzzxHdRqk2X8AZ0pDmgoC23TrsjSCW
	KBoqnJIexnhfqlxZRvsB30fR45kuuUE0lo57+J9bbFM/sdHS7ZNVEk0ZhX/i9ClPNmlMItx8jvJ
	WGDF0GzmMGB+IHA0gVYvKq379k7sM8qArV
X-Google-Smtp-Source: AGHT+IFlSNyx/m40xKYC6OWXlqmRmI+SM7/L6vothAHVO/hXw1MzPva0O5TbGE0SIfNFUBdqckDGkQ==
X-Received: by 2002:a05:6a00:2d1d:b0:7a2:73a9:96c with SMTP id d2e1a72fcca58-7a273a90b4cmr13811317b3a.3.1761554735303;
        Mon, 27 Oct 2025 01:45:35 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm7300209b3a.38.2025.10.27.01.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:45:34 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix reference count leak in tegra_dc_couple
Date: Mon, 27 Oct 2025 16:45:18 +0800
Message-Id: <20251027084519.80009-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_find_device() function returns a device with its reference
count incremented. The caller is responsible for calling put_device()
to release this reference when done. Fix this leak by adding the missing
put_device() call.

Found via static analysis.

Fixes: f68ba6912bd2 ("drm/tegra: dc: Link DC1 to DC0 on Tegra20")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 59d5c1ba145a..6c84bd69b11f 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3148,6 +3148,7 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 		dc->client.parent = &parent->client;
 
 		dev_dbg(dc->dev, "coupled to %s\n", dev_name(companion));
+		put_device(companion);
 	}
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


