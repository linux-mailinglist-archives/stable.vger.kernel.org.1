Return-Path: <stable+bounces-180492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9ABB83557
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E978482F11
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A882E7186;
	Thu, 18 Sep 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy5pqVOJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5A2E41E
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180972; cv=none; b=YD3+UDUj69IqdiBJl12lkX4PhfVRmMNgMSiLQXteFqf0bjm9cplt9OKqnDq2ppP7FLF5sSeyklcn9v7UNxgwLeFXHjICrvk/D9V/T00sP0VynlOfRClbDbj4QgCtxyuYgjsB+Yn/DGAmuwkXwDVxeGEL8gRcb39a6xB+ruPCiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180972; c=relaxed/simple;
	bh=8palloZvosHrIgHRGThUtWJIYbk78Nd31FUAB6PjsBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVjxHdpmFeZIOBWU94ytrkau/SFnpKM/hbTaZ4zaUTndsEj/xTRpQlI0p82fWMzAKFh/sOs7FvMGkUQ4BvD1M9s5Cw5b6q2GzhIPGXp/TDTkq4mKCQteyVTn6QdSmq0f8v5inVXZatYucJN/7YS3Opi2eKb/ZNbyDw4bQkCwJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy5pqVOJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26060bcc5c8so6054115ad.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758180970; x=1758785770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=Jy5pqVOJZDhdKSUHxJ6Db4OnRNpPMDSYy0+y2BDnMZ7J3uHeIHYYKt48OpZsYTdkDZ
         SoI1OxeC646vW38WvQwZ8w5XyIQM4LOgsXSJDELTYjcLLY0VfLR8jxkygqqivKtP/G61
         avUEV8zUwohNKxcwb0fYkCFXSB8YEhKQ6VIJ8X67LKxwl0aSOFp9qpd8+pQWUT7QNz0w
         B+j4YuRxCLilQ6njDt/fwLxblB4JEEu9d/HEQHZPofT6Ar8nfrqETkHyqtq6R0ZGs9J+
         59t9G/tvy3mdo+4SNRuh0Af+S8mLEYo+adG1v1/7Efr/3RLqA8FoTmdh2Tyv9bRWC/0z
         rKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180970; x=1758785770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=X6Mv7AL7krukzc2MAwj9KvPkJAQKSva6sCJUJs292ruM06ERmKAU/jZs2QAzMXWNHc
         SbIG3wmzpq9th51ltAxaDcC/bTzmaevuM8VzKwuTmWRXWp73X+wma/Xm4pvw8UFL3/lD
         PolC3UoNaAg62h8jpTb4BM0nf1HeD1oijBhc4Bvzz8fS2htJSIYPKGEaI2AB5W0l2nxT
         j/T6wb5mFGVlnhh7OqHbQJMlZcV301poA3WRZj0mkAZ4n+g5soKsjK3J3PIa8u3Bpc6/
         nC7iuWy/aEIsVYeyHBfmbZ6AlCrAMJpzWLfm+Uh+eAf77t94KmA6clPnuGTr7t2klTAO
         1WbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNDKI70Tytpn1EKXucnO75ykz8ACAHKSf267MAWzG8nGJFccdd/5kTAJ8bmGhq5evra7fY4t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W7RkZFHcOWe9pK7APPg2ZjBftQKD2lESMxaOdzMn+2yNbtIl
	bj/pVr4I5eVM0hrolHW+xRLZXhSoiA6VU0ZaZSqnqiXa2l/p+DhQ+AXopxQdiPtQJhA=
X-Gm-Gg: ASbGncvAUcDOiAS0Ly5MrkVe6uj5ASTxmMpKW2ckd4MItASd9O9NUQ19/AVVTAvrHQt
	gzgkOChzZi8M893/2k5l2eyHw/vfKNcIdbjIQ3z9JEUJoVsLpXEwGdK9WHjL8jGQ39iC9fAkxbf
	CbYIVvmhxs0ddT6zRbYbdMJ2VqzvL5V5bS6fXmQaRO+O2L97hg28SEnQTyQP+mhQ3HZOjb6YBRU
	yM+bDb92szJ7bC2+TzemvEO+rDBsKSL9iNbwWlyosBun1tg5D5bI/WibM0llDBHbrcUj+GP2lJR
	ZVPdMv31p+qRsA2mJ8MiV8topITM8u9sL1p4L00UobreySWmwd4/WJz3RyOrE+ujDD0JzTcfq2I
	4nnSnT4IiTRXqISjq6NiqVPR/RgeQ2bSFzfG1j4Vunw==
X-Google-Smtp-Source: AGHT+IHf15pm5mUhA/3udDwM9qDRHAE+xLKBTWm7gcm+EPYPeb2jty/DLUjmSPz+Oc4ISpuvyFBaUQ==
X-Received: by 2002:a17:903:1ace:b0:268:500:5ec7 with SMTP id d9443c01a7336-268118b4286mr69354675ad.2.1758180969677;
        Thu, 18 Sep 2025 00:36:09 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:f714:24d4:c9c5:fb88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35afa1sm1516337a12.7.2025.09.18.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:36:09 -0700 (PDT)
From: lgs201920130244@gmail.com
To: Huacai Chen <chenhuacai@kernel.org>
Cc: 2312863846@qq.com,
	Guangshuo Li <202321181@mail.sdu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: vDSO: check kcalloc() result in init_vdso
Date: Thu, 18 Sep 2025 15:35:39 +0800
Message-ID: <20250918073539.3382107-1-lgs201920130244@gmail.com>
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


