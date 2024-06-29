Return-Path: <stable+bounces-56129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15991CDC4
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306B31F21DF8
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C68286B;
	Sat, 29 Jun 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqPu2EZ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6955B05E
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674051; cv=none; b=kFPPK/VI4HWIZznLw7PfUENxpCSpVkeYodrEss/423Ms+wDJemZIE/tfoSN2JJ1AGCtngOMwoB81khoHNGEzwpf4J1aeC7O5bXzuhzB+gflZYkLtepR8XLrvmAEaJX/IPCT/NizcouO4EzeS9u2tMpdsJVkE0q68NSLTirMdSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674051; c=relaxed/simple;
	bh=iibWLjnmExBMCCryDGBHNknBM+agW+bmQBrOQElK1n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cP0ipuQ0JnAh3fGvhlcwV4JjEvTg2cMrR93YAfZyjwCFu69A7m6et70nj0IG67czJm/wWVKpCKZSjl8LgjT3bjrY/uexnWPDgfVWBXaKwaRwtKgWhpdxQzWvYdJ+kV+um0B4tPyHaznOCZ3y7RJ/deRTrqUO0ozC1jrx3vq6pFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqPu2EZ+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so16464737b3.0
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719674049; x=1720278849; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bn4ZRLPgX8bnVcNwCjnMW6QCMerMe+Z66kZekW6xIM=;
        b=QqPu2EZ+elKYheTpEEMPNL5y96zdo7NK+1lY2ozkGa1MD88H2pk8NBIrioCrQhhqd4
         xebhwpmit8+vHXbiyUvc26SzLY1ClIkemwoDziWxcyf5NgVtof61ga/KGOPocvPtq0Go
         KotaZ7ipV5+M7WsEOxtmDrDYFw3cUKV8N4WBuosyEva/WTvnKh+tdJm/PiWJQW2VDyiw
         8TRK1tWSsQaaQdcwn/XJ4nsYtCk04i5PvSQ7Nh9pnmw2iSMFi58sUR/aKqXk+uRu4fcG
         LvV3/eRsW564l3hWJmhYoa4ilvCxzrTNjYeEj4yRWzeYrraR5WmMA9pAO3YYh7KbcLom
         dHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719674049; x=1720278849;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bn4ZRLPgX8bnVcNwCjnMW6QCMerMe+Z66kZekW6xIM=;
        b=AJ4i83VkYS/nQNKAG9Kr15AjcgA8yrAttyaZrUvacRO+ejn+eAYLYl43f70CiQthR+
         r3htYaufJOv8Xv29hX+k5s3D9RnbV4Y2oF3Bz9Amsjm6wlBHymvMw3L5/RRmTnjjxf3b
         T/B246+mixpaJ9UMco/5nGM/RBzbLB1XR9eoeeg5dYxhsyFm0Sa+H6oEwDIoPKIQzbd5
         qPZ19BLOwX4zlligHePI7lB8p4dXl2JQVaixqXP5IWg9aOs4b2QQM573P0YxjdLNDhev
         t5gWv2FmF/zsmsl8bnsA1s8Gaq0/XxuW/HNwGGnNJnTiW+1UlqH5GPHQ/HZ3pafejsNo
         y6kg==
X-Gm-Message-State: AOJu0YziE9z26a5i7PUYCim5piNaKmD/lOmKS3Bn3WYLoYhS3pvjCbTo
	NDkzEvzMfGSCuTnXAc2Q5YS5zKa2r/WAtJSLhs9o8j2s/4SGYou4h3eR6DuvzCJE3UD0OtQffj4
	M6hrQceWeQFBFe35tHG3NLP4CT/dp4a9C7cXTwPiFY/VdDm6DGY6nm7l+YGyXX7QKMziNRz+sWz
	ms6rmtGg1Oht9WTbPv+a/aQQ==
X-Google-Smtp-Source: AGHT+IHKEd26oz/gtX7DVpyM/hn2wurmljRMnChNzl7qzMFiHYMjXKaPWa+duLfVhlbPJBXJ7ouoISbe
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:4c90:b0:63c:7fa:86a7 with SMTP id
 00721157ae682-64af534245amr213717b3.3.1719674048913; Sat, 29 Jun 2024
 08:14:08 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:13:59 +0200
In-Reply-To: <20240629151357.866803-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062455-glazing-flask-cf0c@gregkh> <20240629151357.866803-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=ardb@kernel.org;
 h=from:subject; bh=gtgh8fl0ha1pKygh+toNuQ79nBA71W8+tfNWQYCnCuY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BZXtJ0OPm0/NvTnfd/+1F6JNJVcEi39bx2//PCmRvZ
 7EqSDfvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5e5Hhf9Se5IuRljsrPQKy
 zEvDtq5ZdGn/t7IHjxILuCLfTP+tn8/IsGfzy+LmXUztS29m+qz30/hj/mLvncmCcxm6Vsz8fzf zOiMA
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151357.866803-7-ardb+git@google.com>
Subject: [PATCH 5.10.y 2/5] efi: Correct comment on efi_memmap_alloc
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Liu Zixian <liuzixian4@huawei.com>

[ Commit db01ea882bf601252dad57242655da17fd9ad2f5 upstream ]

Returning zero means success now.

Signed-off-by: Liu Zixian <liuzixian4@huawei.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/memmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index b4070b5e4c45..3aaf717aad05 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -59,8 +59,7 @@ static void __init efi_memmap_free(void)
  * Depending on whether mm_init() has already been invoked or not,
  * either memblock or "normal" page allocation is used.
  *
- * Returns the physical address of the allocated memory map on
- * success, zero on failure.
+ * Returns zero on success, a negative error code on failure.
  */
 int __init efi_memmap_alloc(unsigned int num_entries,
 		struct efi_memory_map_data *data)
-- 
2.45.2.803.g4e1b14247a-goog


