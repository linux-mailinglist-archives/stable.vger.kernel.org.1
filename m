Return-Path: <stable+bounces-176994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C4B3FDB2
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C751D2C4E99
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811242F8BC6;
	Tue,  2 Sep 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULDhcxTT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83422F744C;
	Tue,  2 Sep 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812114; cv=none; b=uSCKrMgZkFLqvi035JIjmVsqDOfQQ6mjAG2AYNwQMiwRnfxCpDrab/ljYnyUb9sgHRGj4rrz1UN72WTftkAtJScI50i+SfX7UTZcUpGNwhiVEfIEd8of0L0PDY3wobgG4RYyaueCAcQLA5zIcAO00NBNdpr9mi1MEWXS47gmuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812114; c=relaxed/simple;
	bh=r90VB4kVBN2xFkL5AxvLxiyYXhfIfvCQV5FTD6ekEMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wgm1FaAOq7Vn9Vgg6dCvPn4WomfExg77MCoZDBIfqCu2ArzNYmAdoar4iPATgQ5wbHtvsD4CXCCnc05ga2WFF4exEUfg0bA/ASNZvP+spbVTenYbCZRgCg26AWFw4KQtVPYZQ5CoqLS3zv1/ImssJSM8dz6hsLbP8Qmf9a2HgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULDhcxTT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-327771edfbbso5293019a91.0;
        Tue, 02 Sep 2025 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756812111; x=1757416911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4A5fkthP3KXEpRu6BAtoU0UoZrqtT9TFK5zNXIFO6I=;
        b=ULDhcxTT1Y/I/r76X1yFwZtbMdklz/diwnudlatgqW2xPfOcaaj8tYuGca8AdI/U4U
         7T5aOKhmLCWjJ9YCWMDuzK33i22XxGq8o3H4VJBns2pVvdlAt0Rx9PPKM26vA+y3grOk
         +SN0GB5cZPZgW7uTLOzG2bWnCFJAfY46FD9E5L/vRi2J3d3ed9PyoofwuVO76EcqkBp8
         XzkNPS2hQhaITQ+glZ+VJYQeRhSniD5A4IZfJfkRZ6kXKP95UdbIU+jWoU0cIoprDoLA
         VtsphQmWFzBP/2M6Z+NBx808kWo+b8rMabmYyX3opypED22m5UOEpSuiTXxxkdTGKBg2
         urcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812111; x=1757416911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4A5fkthP3KXEpRu6BAtoU0UoZrqtT9TFK5zNXIFO6I=;
        b=dFOYpCMlXqbRaYPqYAv0ati4ddjwZwP9gQbHYPLz40CsO38umK2a+GO36dRMLR8Qxw
         CreHvts6sjiQO0yA7Ioc7WIlD06QutMu8tTlBPN9IgvNi1tnxudMusx6lhWFSwBQpo/p
         HDNnh+kJwsxQf3PsUlHypUOozId26/0J9aveIds/JUQmeVDydNlkAVVvJ8bpYmFf4/+N
         zBr2BSFvTgz93tNfDZPkPuV3oROKywQHQtCXUssu8MJuaMleW213+irr9voDXa6zuOsp
         N2xTMgfKVRpXc3yMPUUDmcqZDi7FIMGlaS22t36IQAn6Ji7BKGv7ENKI+Qaky0HRDAA3
         iqow==
X-Forwarded-Encrypted: i=1; AJvYcCW6K61AGhmKCKEnTOW74Ws3rxQIJarvIY/WmGx2G13px179bGAJV69NBZVP3GRC2+keOSynw26yKnGDBYp18cD5NgU=@vger.kernel.org, AJvYcCWuJMAiLz8q30PWx8hgPbY2fyEhuiqNsx91En8onahk9Ib/7w/qS4655Oug3Zg1QyjrIeKpuICOFAplXs0=@vger.kernel.org, AJvYcCXCjqbOD+ZqO6ekPmAlWDNQ/Vh8O7VrZk/UTq4dFI8yccBQjsGTH4rmGnPGYh9LmS0ysDIAbZGE@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRssX2nkso8YoIObd144jKv0eSuqIosYTVmVlbLz2Fg5jgTie
	ILJM/LtTT2tzsOu5hNMGv9OWlkgoepdsYCCdvSevMm3jMPogUeKyfvCN
X-Gm-Gg: ASbGncv8TlpnSSb5pGKNhIqvvWTit9e3VphpIDSDqMGWTwDsbymR8RSQdZUWzaz7eZK
	hA75YpbfKPhUT2P9VGYOHppC9J2Zjk44ZN9SC5DfRt7YQJEvFQauCIFHttPrW9QZzZ8AeNBeVcr
	LjuuYrnMf5FZkmQcZqlGkjcqx54L34sMoUp+abAioEaRfSNhnwAipTrbPr+F+QEGcDnG2jBKXDM
	i/oTFl+Y1a8TMTJVpTAauZa7QQk8hyFlQhoVbvOlybQkisqGtZG+Ds4SQEB4YLwhbqLNzbt2PW8
	oMGWI5NG43ewWUFLXdcoI+CAyvyBnEXdi/9eWQaiVMGMokXianoEQGlXeQkCOsj8XeKra1LWFxo
	06pPsQvqDI/rFaTNVNhJBYM6FfBIf48sWkjY5c5YhCKdEM28LIGoPNgNi6EeH
X-Google-Smtp-Source: AGHT+IH1KF6DJ5OOOOe1l7ldEAlzXJxUIBb9mE6VlKXMsVGCI5lGE0+ieIjUzywYE4Fa9tCwx8K4LQ==
X-Received: by 2002:a17:90b:5587:b0:32b:4c71:f40a with SMTP id 98e67ed59e1d1-32b4c71f85amr241852a91.24.1756812110843;
        Tue, 02 Sep 2025 04:21:50 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm13140645b3a.81.2025.09.02.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:21:50 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: krzk@kernel.org,
	alim.akhtar@samsung.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	aha310510@gmail.com
Subject: [PATCH 2/3] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Tue,  2 Sep 2025 20:20:42 +0900
Message-Id: <20250902112043.3525123-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902112043.3525123-1-aha310510@gmail.com>
References: <20250902112043.3525123-1-aha310510@gmail.com>
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

