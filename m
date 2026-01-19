Return-Path: <stable+bounces-210282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A350DD3A18E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A26A3002A57
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C933D4FC;
	Mon, 19 Jan 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtrVACOT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E933D51B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811171; cv=none; b=OWuXxfKIBCM4etj+yun6ug78/o5fC8Ny7/qAzuLeb0FDuNGYOgN8BZOpzkLvvhBiRraoFIb9OnWH6j0XkPHgy0t4VjjnETefF4gtbShHJFV7a0/Uwx2+V8UapR1vCzS/6KyS0zJcECsZ0A1MCEsa9LwJIk7P5E7KqdOvwVlB7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811171; c=relaxed/simple;
	bh=r90VB4kVBN2xFkL5AxvLxiyYXhfIfvCQV5FTD6ekEMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AODGMAylvGbIR+I1knFpxd3AOu4AAxqXG20lmpS3Tbe3jT9NRS2IvyNcNEZaFYME1lpjaZVi1vvtbWoG3pMBPQxzvTTfZRa+hoCi/p4QDwpSeYUu5e/K8SDtJhVnPfIxgJwEpQnzWNdT5uP8z37WY30iQGpXCkIoZvIyUyJK+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtrVACOT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f1bc40b35so41522805ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768811169; x=1769415969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4A5fkthP3KXEpRu6BAtoU0UoZrqtT9TFK5zNXIFO6I=;
        b=TtrVACOTquiPmnd3bq+zMDfbACTlbD/5sqrlQMHm12O6jGKkMhbK4W2hVu5G0f38aY
         pVTouLUGEIQ0yTh/MJWIHYXy/3s0gc7+Rvn4RljzqQTAY5sSvKnJYH1T8vkxEQVvMuDs
         fgeEeH//JpOuatZzSfSy6BEk6ieYJGFVBioO5jLb4PaKUf2j3UEwbageGvixQSX0NKA5
         79/BQZ47AnFCOcpN965SY07ZzdpM2lVa7sbbiK8qVS7BFNimp+z6w7aqTVxiYnyWuTno
         OS7PfATwo1hD9oecIAc8ZW3mx8appZjQcDECsjBosDLZ9hugxpFbcl0CEd/J/5zac+bu
         gFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811169; x=1769415969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4A5fkthP3KXEpRu6BAtoU0UoZrqtT9TFK5zNXIFO6I=;
        b=C8gZG7ReJ3z+PSTanHElRzF/4iVZJMcpV1sszpRbgOh7JTKipzQkyUb75jCAKMgjMo
         gSa+YOoDY/VGA2RHorDpRjchaNL/eztkGXbm7rujpWD6lnr4WXeH+qhV+mNECMuto3YW
         CM7/jN0wRjl0HUfE3pEtifgirUedl5v6/u+4iqGAe1j+3niV/Uq+8/3pdUHFYGUZS+Lg
         z9ns7IS8exnr2O58dDx3BqqW9qCHvimFyWaC8R2cyFwlhxM7CeWWjM4HIY3dUwkbl+5f
         5FfOSUXtuZK5JcSEWUIdla1P7rxZLh5bvGvZdF30V0MSomsYWkRMOW2vzqdBLlGundK+
         VGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkPCIFlrv4tPe/jN/udQETVDBO2KI+qGsElt47E6AYmuMaPtCtRC3PFYLa6wU8R014mrEWq4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPylCvWdsEaxtbmVyDDi/rYxLJ6HDn2ubSP7YBNCYqK8FxMC9h
	Fdg6uWTGezvuIeahoAeLohAv3kG0Kxnd0afdkev1XSNxbhR7SKI6p+Zx
X-Gm-Gg: AZuq6aIv6k7A+kfOLSHA/nKRFB/uYiRAhtY4X4KIDs9fScVpTjiJ2LXDJbGNvsdIJ9S
	0dK34pHgaXsaHIFm85ZzMWPaaJvSZySBTyMPJ1dtfF9ulzgzaoSc4fYajRTPTRUy2A0uu7ls1dv
	ZxQonszQNXUZpftId7gO4Z/n9+qPzHHfBQEQv6qMJfZrN5eApkSo+aURApMwhhXDOr0qE5uugFm
	GkEPXqAksR1jH7h7nBreLlYqz+GWNOd5ETLFeDkE1+EPepsWe8u2Y36uOGqf3WNl4Ubtn+B3J8C
	qaSYpUPURq+XWPGiDjk5il1KZ88Z29YnGJJS3+z0yKfUCHqCA/j1eCgryQ5zKoBk3G3h/D7Z49s
	eG5SgCP3CWOowonaSAqM4p/Y7SF8EPGPFEs9ygGp0dIdsgHjk73tNACoa+hSjolrLTW+eSmpx5V
	0h2Th5art27m1nKD1Yyx6gOrEynw7K6+rQ4ydHvQ==
X-Received: by 2002:a17:903:124f:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a7177e2b6fmr92683575ad.52.1768811169196;
        Mon, 19 Jan 2026 00:26:09 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm85699645ad.27.2026.01.19.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:26:08 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 2/3 RESEND] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Mon, 19 Jan 2026 17:25:52 +0900
Message-Id: <20260119082553.195181-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119082553.195181-1-aha310510@gmail.com>
References: <20260119082553.195181-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 1fe297d512e7..601406b640c7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -251,13 +251,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
--

