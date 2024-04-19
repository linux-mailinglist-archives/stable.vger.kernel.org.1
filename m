Return-Path: <stable+bounces-40256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950368AA9DF
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24736B22E5D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D14EB4A;
	Fri, 19 Apr 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QudyywV3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695E4EB54
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514333; cv=none; b=DVGl/v56ifWkJ7S9J8Y0m8TNiUMoALxYH5yCaHIAWI+KmHvYKP55pWzX4+kG2pCWG9VpzwgdZD5xrf0Q+lt7HBVgEdXm7Fjkg7G3v+1aFODYREcEzA5iCssPNhtI875FY7q9gj5ffxP5XuT6VmcNr3slZGVV6U4agMIe0GdpHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514333; c=relaxed/simple;
	bh=jJ4V7q5Fx3JnwLiqukdIX+GNgAFsNYczwWVjH5VCmH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LVFeyHtuR8jHaCHiIaf2FgaEa++XEUgdomNUkHk/yrfDqVnWoMwhxNb9N6k7mhgB7oz5NPdnx4nzYPgx59d4bV1b8jpNRP4HNtQnOVugF2RBt5sktGrIl0C8TwsNIl4fTcANwVZMyExVmlg8Xr+byq5aRp3Dx7NQQG7v5WWhi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QudyywV3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41552c04845so9928095e9.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514330; x=1714119130; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFnPaMX3k0R1SLcwf9Pcn6gfMtxTBALvroSlU+gZPuU=;
        b=QudyywV3UCvRT7w4zDaHrgQNXy6aDBTlMyFFTgDNpNH8mT0O4p6jo2UYti747Q2MQX
         zzCSLYpQJ/JJgR8g9o1weoNHSu/SnKmJouB8sX5CR3UPSggaE4GZv5+RrhbUKIUFmRAz
         f/HtD/LBIZ/TdqbJFMWczk2REeENRuVzK17259TWocVG/yXYXZO6nwl7Lkd002SvlJLB
         xiqRN11+EueS+SIP1kJFFUUaQwgLwfV3fmmYNQsmu1I7sxUkmsPall3/5O5YmujRr+81
         Z2baAzCAStKNAY7rPtBlmsgudkg0ZJr7KETPzUO4kJ2xsWURD+kLBJAhDJ7j7Mm3WHEf
         GG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514330; x=1714119130;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFnPaMX3k0R1SLcwf9Pcn6gfMtxTBALvroSlU+gZPuU=;
        b=POMqqnj8wQpwSlyqKWAvv6jtLpOuwWEdeGdEMiiUjxpWhoEiV+A80NN2YfonKUjYWx
         vk/ugA0/MuUO89CLe7LLbxnbACPyM2TNcv41C3OsfslbxCB9Dj9YOSSWHAtjsCuJjaPn
         ql8g9KLbT0Ifqz9TUhAPf5weg/w2OrRy9A44TYbAfFsyOFQEEmhhzzoGcyYPcQCGURCT
         4cO61W/wktBG/MwkPZQ88F7qo0DhnegM9GtmRsyQzgEdtwl2qWuW3Ifo5K7Adezps8oB
         x7pOv0ltI+xDdVW8QtuRkwbRG36sK4JWJJ7Hi+iaNOQhdo1jMtwE9PKwarfCU4ZwSTJT
         MpTg==
X-Gm-Message-State: AOJu0YxZPL76e7sL1a80Y4t+vyWLTkHbhmh2pP3hsIMd9nhkcWToCi1o
	d98+7Q9z379T0VukP5QOzoO09m8lvNGjD/RsqoBOb0W6n2bDy/E3GRI1Vmc+0eRtJtPRJwgE7vs
	vvlPxwbCfC9fy5xfSs8ShKEin2SrMb4wZp0bmZXbz/JLnL8qopzV6maVVhHfGi00EmvkcnrcSsO
	1nAg6P/2FMGfABTDcozAOp8Q==
X-Google-Smtp-Source: AGHT+IEGDzYfX+6vHX8ih373HrtPtFYcnkIt5nDAJZfh/SxI6tR2PkUvr5G+XmgCqdydgsEou7P77OLf
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d1d:b0:418:2981:c2cb with SMTP id
 l29-20020a05600c1d1d00b004182981c2cbmr13374wms.3.1713514330795; Fri, 19 Apr
 2024 01:12:10 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:26 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=ardb@kernel.org;
 h=from:subject; bh=lHrxkY2JkiIQmzJ5bZVMYYAcBWdyRpCl7XUgNND7EpY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXbPji3FdxG0tzcX8nyrXq7dt33b2vs8F2zXnwiXs6
 kSf+2h2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImkv2H4Z6z9207759vIOWn2
 Fa0eRmbrKup/PP56RsjH4FFWr6xbF8M/pd1yfHrzH4nKL5Zb0Scx1+1a/FpF9f3FsvLmq7rmTFr GCgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-45-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 20/23] x86/head/64: Move the __head definition
 to <asm/init.h>
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

[ Commit d2a285d65bfde3218fd0c3b88794d0135ced680b upstream ]

Move the __head section definition to a header to widen its use.

An upcoming patch will mark the code as __head in mem_encrypt_identity.c too.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/0583f57977be184689c373fe540cbd7d85ca2047.1697525407.git.houwenlong.hwl@antgroup.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/init.h | 2 ++
 arch/x86/kernel/head64.c    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5f1d3c421f68..cc9ccf61b6bd 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#define __head	__section(".head.text")
+
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 78f3f6756538..4fae511b2e2b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -41,6 +41,7 @@
 #include <asm/trapnr.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/init.h>
 
 /*
  * Manage page tables very early on.
@@ -84,8 +85,6 @@ static struct desc_ptr startup_gdt_descr = {
 	.address = 0,
 };
 
-#define __head	__section(".head.text")
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
-- 
2.44.0.769.g3c40516874-goog


