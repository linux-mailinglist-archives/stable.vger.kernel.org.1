Return-Path: <stable+bounces-56124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2B91CDBC
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C774B214C0
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682C82869;
	Sat, 29 Jun 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kocOI9Cd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2880043
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673966; cv=none; b=tKWBpOcpT/Db1ICf/ouYIvVa/Dy9gwDqagdY0VNG7M+EEWMW4ElsmodDlT7BiiwX9+lWqkZassTbljnfLhAuwC/F8shsGTnHBm7JobCkC5t8yiug1//cSwz18auEJWlvzsEKgL2XMFbJDqPZw+87SbHA/kwZZppgUaeFoOO8oE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673966; c=relaxed/simple;
	bh=iibWLjnmExBMCCryDGBHNknBM+agW+bmQBrOQElK1n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O9Yx4ixhajGuecm/KGHbHl4g/zoCIvlhrKq3L69rQNm25jY0eK06ghRA0UNAdhIH5YCt0Wqc9CTuB68bXy8tznvHLU0tkk5XD0ZovZDFTFELCL1P0jHwuyaSafsSHTqpc9k9ULMurhmZZDOfS8bXFUtKBmFK+/NulLJGVta3fTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kocOI9Cd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64ad9545c5cso27943847b3.1
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719673964; x=1720278764; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bn4ZRLPgX8bnVcNwCjnMW6QCMerMe+Z66kZekW6xIM=;
        b=kocOI9CdUWW9TlWHpNUX9ZF53nzUaWFyeJ3jVfjZIvdFVvLX98dOJDdFcuI08chsPm
         ALQwQOg4Gy+f/aNTgHiKQXUXci71w9ohcgKXtkBfjJ8NwCSavJmxJgMtaxTcMpLM/c6d
         N1U6sMMTi9ExWOpXg3cZzFVSU2PuR0vu/8ItytIZ4qR5Tgy4zUmpnIFa84d8GuzE0xur
         DHZSfQxMh6e2pswucms2Z/P1uNqdaOVzrnFe4ADbuGmGt8dn8EVTXLW49yeRCd8sXXNg
         OmAKydcyOxqXzpWXoWWEHW0HjDamspCJO/G5JglnWyAfKl3b+Xh/YpB1RANwkfd067T6
         oTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719673964; x=1720278764;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bn4ZRLPgX8bnVcNwCjnMW6QCMerMe+Z66kZekW6xIM=;
        b=S1N2xscKDifskJQezD/iHEQDvY/XPM7C3Q4T4g8UN7yMjT8tcdB59vRVJ4fNYmGw7p
         zyBqU4zuyTzgZYbLQYD8qDU1BeqITy9+1Gju6MAa4OUfgJZD8BgpJElLYQzv9+deil9r
         zcA6uXsg0yY+vO2/pxZPDgq6eplyWyElA6ySkbL1l7Oq3jMtLRrXHuNiwmFdrZrkPbhg
         GQqoamK7XnJkOKEV7FDWo/Pk9y1Z5ADdHbBuUz1k5eUp8xX5NVySBE9tUzZ5UPPgi75f
         Sg1a2/Uv2BpHlmkmeu4uCXH4u6T5b4sznTOv5b7ZtrQwf+A+xz9WH543DcKyOm5QEU3t
         jkdA==
X-Gm-Message-State: AOJu0YzTRc69PjOr3xZni4HRjbmiqVE+bbceRlC3fL0+NotGKviWdQPI
	/ORABqorfXNn6wQRg2IlzQtE1qEYeYsdDXxZTMpgbp5FRMWAqyhWgAYqsA6r8YHM/n8TRjue9lp
	LDpNatZ1uiMm7PtMoVQtV1zKn0oYgIUeBkbcsh21Q6WpluJafVRrz6eYg2lmYprROkRPpJyhTX1
	IjlpFUwqqz/7M+XTciVC3Ung==
X-Google-Smtp-Source: AGHT+IH3W/bNHh4Up0A5y2wzHTOnEy+B6fmr5JpMS9E2TvLJOYjy9si2/W1VIPX/aXKQ06zHjPyTyuA1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:83d1:0:b0:648:afcb:a7ce with SMTP id
 00721157ae682-64c75218c82mr410517b3.3.1719673964046; Sat, 29 Jun 2024
 08:12:44 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:12:33 +0200
In-Reply-To: <20240629151231.864706-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062448-overspend-lucid-de35@gregkh> <20240629151231.864706-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=ardb@kernel.org;
 h=from:subject; bh=gtgh8fl0ha1pKygh+toNuQ79nBA71W8+tfNWQYCnCuY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BJakk6HHz6fk3p7vu//Yi9MmkqmCRb+v47f9nBbK3s
 1gVpJt3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcMmBkeG48Sz5n/YRXK7Y4
 ea7s0plcPznM09CiWHbxjhMc6n0B7xgZGruE5C+qPOJ01jgguD5XZo94fNJ1wds5PJI/Zaf2ffn PDwA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151231.864706-7-ardb+git@google.com>
Subject: [PATCH 5.15.y 2/5] efi: Correct comment on efi_memmap_alloc
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


