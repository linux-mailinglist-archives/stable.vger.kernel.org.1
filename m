Return-Path: <stable+bounces-78220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E89895D0
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F30281C6B
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DC17BEC8;
	Sun, 29 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OpvqpeBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3ED1E87B
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618575; cv=none; b=e9O135rG8APa6/3XuzQnOCxwuu6vlB6JSC1oz1IKjmj0KuzyeKx9Y6FsvBPMAGtrwqGkHmOnGw2nKnpZ1f185Ew2/Im2WHre3+MAIKEq/t9uTat8Vh68+xAhnbT4bHjUH7ax6Xbt3QoFUGjXABt0cco+sLiOkaOrXVb1hyfUdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618575; c=relaxed/simple;
	bh=jQWuKneG6PSuozkSdhcxOcE5ilARFwHnwjN8VyXm0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glWLLTkQrdq8Vp+6b2WQmamJ7eMMCJxSroRF0dc5rmkl/DQCSyymvkk35aLi9C+IT4tYRbZw975szpXRAUaqaVUFXf6D/n1fNyUCXT2LLsj9d80F9KGqgR5mui48LPq3E8na8HCZ1FV4FyMOcPkId3AHWrSws3u+mYDruRN+1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OpvqpeBZ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03C4C3F5D0
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727618565;
	bh=rHKx8mIJ5uIzbptOZkjeP2ZJIjmWzd/aEM3nFAlxFXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=OpvqpeBZ5IJcA2uctIVI0qw9kRb7HPxxtN6ujjH28jRbvhdj82gzz1olcrwb6BOJG
	 tveW4nJRDkGYpeua3tj7D/0KfxYbUjWJNFE0dNsTjvy2FM0u2pYSl+ny4ZUWgLMXZZ
	 n/Nz5AlQlslueZZfqOMOzPb+EZQkBzl3cqlw9C9M3MpIAMbmznV9h1C44ZAwIrd6GD
	 4zJ812hAH+dS1XbZCumiHiuohcWrhWT3PoCZTktUR05gyKSHWaRGvvNlZ6DxGutJGW
	 gdMdhDSyf5vsKd57DKwtPnFYHJjWPymDaMWhMAOzH4S9gaJ8rglEfzI0QZ+d0FDoqG
	 o1TkWaSLyx5Zw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd282fb39so1477949f8f.2
        for <stable@vger.kernel.org>; Sun, 29 Sep 2024 07:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618563; x=1728223363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHKx8mIJ5uIzbptOZkjeP2ZJIjmWzd/aEM3nFAlxFXE=;
        b=jpCRfTed1b+jFYI72gEM2nbbZwsikF0m/csxsgpNLXCNKWAxdq3qFl30Xu8MEOb7jM
         Fq366E+84/x2k5ZhcuN4EVWT/QLqJHfK1u9Y1rbRersxmpAi/fHA9wc5QciDiKqi4r6l
         luj/KGA4dvVMm7Spn4/Fe2psO8eQrGAfziQqpbA/3aYhnHMq5n4ytg/Wl5t3qbl2KQr0
         KsoYLAg1xMTROeAth8yLkodrK9pVRJbpanGyguf+LqpNLwyarasEGl+3d1aI88WFQy6v
         5DxrMii5v6eXug7+boU1msMG7pC4nbnTyNXmDEFNSEuMB0aEFppuNVyIhw6aLanNSdP5
         vbrA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4gmBl1cXjEd8ji2VswKFg+Ah8qYOT9myM+WIz4S0xaiTaFzeB7wGm1bnKQWXQLuU/c3u+vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh2PVle3X7oB4NaphvadAldnZjEA1creKUBvLCHQj9nyUk2N7
	+AhrjxeZuyBG1QF2IQ9CrD22zzEpGDx9+AHdBRqbMiGMuZHVDztN1sWSN0xWIxcI8QIvm37E4UU
	oKLtOBo1U18B+kZ83GV9+xDH1doD/+eZTS38VZg1EiVjZZ/IOX/cdyyyV6IZYIXbqcztZ3Q==
X-Received: by 2002:a05:6000:46:b0:371:8750:419e with SMTP id ffacd0b85a97d-37cd5b1050dmr4364131f8f.47.1727618563438;
        Sun, 29 Sep 2024 07:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpRsGnT/O5Zh2PNndGTBGCRoPiKJuRnaYvFSR823DBh5TYMOIXkdUslOOcZ+Mk5FUrP/jCIA==
X-Received: by 2002:a05:6000:46:b0:371:8750:419e with SMTP id ffacd0b85a97d-37cd5b1050dmr4364109f8f.47.1727618562729;
        Sun, 29 Sep 2024 07:02:42 -0700 (PDT)
Received: from localhost.localdomain (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f23d5sm127805885e9.13.2024.09.29.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:02:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
Date: Sun, 29 Sep 2024 16:02:33 +0200
Message-ID: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
EFI binary does not rely on pages that are both executable and
writable.

The flag is used by some distro versions of GRUB to decide if the EFI
binary may be executed.

As the Linux kernel neither has RWX sections nor needs RWX pages for
relocation we should set the flag.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/efi-header.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 515b2dfbca75..c5f17c2710b5 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -64,7 +64,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
-- 
2.45.2


