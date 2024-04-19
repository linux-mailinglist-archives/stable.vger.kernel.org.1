Return-Path: <stable+bounces-40244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E18AA9D2
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352301F210A6
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A14EB4A;
	Fri, 19 Apr 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBDUAMFy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4004E1DC
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514306; cv=none; b=qvMDc6bAxgMRi02w1WGtnxcDUeT40/p55tPsFq/V04FuURUffLZD/4jt6vGfcV9/0tw4cLNTtWhj4kN5dIt0a1agkxsKYIFbg0aRmEkxyY6n6AUBUU22tWixTuzHpbuOo6S9ivIisBakp2oY0LQFZKh0SdmolPIkmyrxMtIHIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514306; c=relaxed/simple;
	bh=cHXiK3FpUluGnD8iQ/Kgff21XMWj7A135Qj73nH2Pq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NlU7G3NJwgFD1YzaTa5ItdJoraR0PRHMrDICpVvzFwswodlfZvEO3nX5Fp/xyPi8mHlUwvk5HSm0oL678D4Ah8QzaLoUG4m7OgYglrJcyHTToz8DnYcJuJobDEtyxR1xEnssFjHRQxhcCk6CnyTvA9zA/cURm7GEyi02swY3Ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBDUAMFy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de462f1cf3dso3567480276.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514304; x=1714119104; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAP1AmX11apFdztIP+PCe/19t30ppP2fSeer7RkTric=;
        b=DBDUAMFyFSYf3gelVKMZ4ORLDSBVRSAg4xENki8Pi3xKRJPq4sL7FCiHt7E/eAiA+y
         pQA+ZSh8KXNxXwFuU0qeekS/WkA3L8Au6ZjD2sDywb4uqXsWQjIiGC+PrtlTlh028nbb
         dlG6YCStVxfimmSPkY0IWnmAeTz62ngS6Yn09M3Df03uFelmOw8TKm+wC9AZlcvx8HYz
         1iJ1Y/0tc11lPy9v1hsO1dGpGEVozOf9yF1Q9BxtCL9HPSkc0bdop5pxk+ssPNMLblLG
         Ct9T3pcmkkVzDYyfzCAkGMrP3bTKIAQJzw1UjL5jST8gOzfvqOesldZWmOExPpFoEyXH
         Y81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514304; x=1714119104;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAP1AmX11apFdztIP+PCe/19t30ppP2fSeer7RkTric=;
        b=Z2eA7+SRfEjvr5V7MelasPtV9a9eHEmThBWHDDoQuOU1qgh1oRMedUxVD7megiyTTk
         NvBGM56kZO18FXRVwOa3sTzxREG4uhM8mlaBSVge99zdqlqgnXwM1ddKqjV/is0m1Cxz
         +NZnZK/EU21O2adLI2d3ZzC06OvN8gs0D8tkKW0ffJWGTw1PT7d7YBSJQlI36qBgueFW
         tc6vgdWM+v5FVf/pqo7CtSkQrWPqpwYJESzn+1Pfco2+vtwDHent+YtzwYlKjmTBdTnq
         O90j7UQH78wPzhyIMrdXEqDKhZ7xJRpcdoRTCdi6lUVIzpa5QmFBh0PR889yvmNdqoE4
         jrlA==
X-Gm-Message-State: AOJu0YzLw2xpYOXiPUsg4IwZXTWCC7UhUVssGO3SL3HC7fIDyiythyMa
	9VrMOITlOMk9vjT/wJkJyF8oA/Zkz3WqVWm0KXg4SrsxiyYBKJ+yoyPBfOUyZCIJU3D5xUyw7xk
	tsQXHDQJo0xbB+NXV/sUH9tJ6Rju/4gn8eumX+rUbwT4enRw5FSfdpLRisKD1JftSLbzTYawZeo
	k9cN5AY4weBWBzIompuIjDDA==
X-Google-Smtp-Source: AGHT+IFdiuKBR9S0l4hC6bLJMT711LnF8cJZWqDt9S0X+Uk5jLARGqwmbScqMJPJC7kYJTOvvQ4YEQcX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:989:b0:dc9:c54e:c5eb with SMTP id
 bv9-20020a056902098900b00dc9c54ec5ebmr340831ybb.7.1713514304138; Fri, 19 Apr
 2024 01:11:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:14 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=ardb@kernel.org;
 h=from:subject; bh=8eS1grYMIEEhqp7MivM27n6IaGC/r5IHt0LLIUKwacg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXcHu4rL/gt+53NgfuSitmfP2c4n2sv+zy42ilCo3F
 1WsPRfTUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbylZ+RoXHzo0jP60/s42SE
 lWZNnxx+I7WSP0ZKukdpxdk0eZVEL4Z/6nuKvqbXOZ8RiZqQE3bp4zmbpQsNo5w/nj/7uCnNvPI OMwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-33-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 08/23] x86/boot: Drop references to startup_64
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit b618d31f112bea3d2daea19190d63e567f32a4db upstream ]

The x86 boot image generation tool assign a default value to startup_64
and subsequently parses the actual value from zoffset.h but it never
actually uses the value anywhere. So remove this code.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-25-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      | 2 +-
 arch/x86/boot/tools/build.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffaadb5d..10ea28469788 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index efa4e9c7d713..10b0207a6b18 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -60,7 +60,6 @@ static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long kernel_info;
-static unsigned long startup_64;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -264,7 +263,6 @@ static void efi_stub_defaults(void)
 	efi_pe_entry = 0x10;
 #else
 	efi_pe_entry = 0x210;
-	startup_64 = 0x200;
 #endif
 }
 
@@ -340,7 +338,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
-		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
-- 
2.44.0.769.g3c40516874-goog


