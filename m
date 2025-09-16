Return-Path: <stable+bounces-179739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4EB59B17
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975162A49F3
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624B3375CF;
	Tue, 16 Sep 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2vdxwJm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE133EB03
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034657; cv=none; b=XOMPV0xdS8oJz1dnE2UW3cEynulg6lD0FgutlPbcu9wE+zAqvBI1tKxHqdzbyz18fN3ajmlRPSfvBBzoKomXKSU+E5YCeKZ8R01ctQ9dzrOkG/Vx9gGz7jaUngRE59A/D1Bl07Io+beM1PMXbVrfxaVFt1lgVcl0+Hnv/vDSbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034657; c=relaxed/simple;
	bh=8palloZvosHrIgHRGThUtWJIYbk78Nd31FUAB6PjsBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXAQrnWiwo8VVUsrZlA1qzzebLqpfJXeYpETHb1406R62kr7vHv0LHCYgH8FxFE3NwkSTQyLpl5HifLMjhQ8fnleMWxYAkS43jMEO1URYQ41fxZpNIEcCjzRHko1lY1CxSdNlApJnt29ckBNBPaEszrLWl9+sqESBSCSp18xIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2vdxwJm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-261682fdfceso28209955ad.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034655; x=1758639455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=I2vdxwJm+js/OvxkMDblnnUDptNtPRVY0dWKzio/LEPnMkNJ7nKsFiaC66ztEVJ6T0
         LtIWhWrg4QvMG3zXNgJP7eA9aSBSwGudlQtgwVkHFJg9Aq2pBPr5OHX1KQ0VWBNxTxA2
         gri2kPbQ3Om7llIw3mNqeTFNZHDe2dJFRBSE9AIP1uu/IxXpjEF77AZiFI3UF9t6sxcJ
         FqJ0J5w+XoSRGXkqdJjF4tuDsufV2BkJYyzVN5P226TCduRsnFkkZd1oYIBlaMAceL0e
         plxbIbOd/H3wG8s53I+5N6bT3CjQ83/woad15fwLGJ/0asC/w0XLszVA2Un48jXPtqHi
         wbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034655; x=1758639455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=CRiSRnDW7FHLV1WeoQrcO3NKfpxDYFrQ44PVtCld/e3wHZZSa8p1qCJaM5h+MbeOz2
         HnEemuHw4vqAHYjCowq4rLw06hkUHp3JwUpwsHC5konBxT/r8ntNQgZYbI4M37py+++6
         8I69q8S/qxt1wQ2dGxS3pd6rgjPOxnHMQ6as5Q44z5xtXouWeWNoXDnAykIw+zHMuqOj
         HA25qh9RY0upeLQ3XYGL2KNIzC0IAjWZvCCGKsJ4a1ncVAkmg0qqUDKkEZaUcrw7wZ2c
         oDEKAChVFvPxdPlHi1aKoWmb3246BGXxzQHPIafKh8+eS85jxdPqsUMquIu5uVE8z7zv
         i2jw==
X-Forwarded-Encrypted: i=1; AJvYcCXl2Vh59GIb3ohdZ3PDEMlXnytzPO2JTQOAL4xuOoyEpB42cfZz367f3KFsgluOwFTp4DSNSyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHm+MtxuRu1DGttVrH9V4+swYrofJ2jVQPA/BrnahqD9mC/vjH
	pgradSwryEmmMyxit/0aRddrZiyF/MZnwsHlSIqJ88xOMJJve9cb5pET
X-Gm-Gg: ASbGncvIQ8NUthOK+vG7DbSPhIxx14BtCd0R028DTUkRwMn0OIa2FwjFz2wyIWeXYTa
	YNHbmwdJmgATy83rv4Qv2hJzSWRb6vRZup9yIgEg1jNk5QSKUkzVY4PJajxHZPWxQqXRMp/+BLl
	q2E6IQZVzRlYlTM0mhBnRfbmEe+S/Da5VWHH9e75kQziz7RkJXNV0t9g87M5DYrN5OFWu4f3Ntv
	kXD13Dfcd1jKiMTJIJh/d/F1WKJyErhKoDhSm+XS1Zv+7Mc6b083UpK+QXu7ir2DuYS3m4VlA7P
	lkZInQZ6A/NGSNuuLOVKEbymWmNvPJmSvc+3eKGwN8uh4r6j8GJL4MWbEcRaXju75TSw5omF4yw
	VtkFbOIQRKrYlV5TO3Abtzvw=
X-Google-Smtp-Source: AGHT+IE70dT64itvjVNcN+FspZAaHywtKEf5DdHLD2RGP4yJ8tS/2lNgczMINmrv9xvEqDqg18WQaw==
X-Received: by 2002:a17:902:c945:b0:267:c172:971a with SMTP id d9443c01a7336-267d15d7bb4mr43532905ad.18.1758034655035;
        Tue, 16 Sep 2025 07:57:35 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:6d43:6fc3:26a2:6645])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267a5b097f6sm48728095ad.11.2025.09.16.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:57:34 -0700 (PDT)
From: lgs201920130244@gmail.com
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nam Cao <namcao@kernel.org>,
	Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guangshuo Li <202321181@mail.sdu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: vDSO: check kcalloc() result in init_vdso
Date: Tue, 16 Sep 2025 22:57:10 +0800
Message-ID: <20250916145710.2994663-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <202321181@mail.sdu.edu.cn>

Add a NULL-pointer check after the kcalloc() call in init_vdso(). If
allocation fails, return -ENOMEM to prevent a possible dereference of
vdso_info.code_mapping.pages when it is NULL.

Fixes: 2ed119aef60d ("LoongArch: Set correct size for vDSO code mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <202321181@mail.sdu.edu.cn>
---
 arch/loongarch/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 10cf1608c7b3..da7a7922fb24 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -53,7 +53,8 @@ static int __init init_vdso(void)
 	vdso_info.size = PAGE_ALIGN(vdso_end - vdso_start);
 	vdso_info.code_mapping.pages =
 		kcalloc(vdso_info.size / PAGE_SIZE, sizeof(struct page *), GFP_KERNEL);
-
+	if (!vdso_info.code_mapping.pages)
+		return -ENOMEM;
 	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
 	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
 		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
-- 
2.43.0


