Return-Path: <stable+bounces-121271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA3A54FEB
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA4B7A456E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3221171D;
	Thu,  6 Mar 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHBvHhi6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77072116F6
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276807; cv=none; b=CDlSMXaWkky762tnMturx0sksR6QvAZmtgDInlpgnswcM8j51f/H6X9CT/e2ogEwNfFFFifzJcKhfrNkEhUS/zgPXnqF8gYWgwh5dpyaTZqfqDR6HW5ToIeIkUf2XV63E70gc0oIezlbb6k2ti6GkQkuNgAe+rkjFqolYnLGYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276807; c=relaxed/simple;
	bh=8S+kn9eoLFcIV6s94q7ylj8ShiwoJrydVhkVyJ5u72Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R7YIJjcAeVPp+QkrLv3bQnvq8UU+MZKXLxjHKozq7kbaogGfo3ru+xciA/Li5ht027//y4hS6W54yS3mAEc+lgyzD6Z88+iIj5JC6tk2E5+6Fa05COCyCK8mspRjTI5Xa/rD1FZp0QKYcF+Lied8rPwm6iIHtdI7Wvtul5h03WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHBvHhi6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bcde3f887so5528695e9.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741276802; x=1741881602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tAB6/suJHRre/mBnY4z2mAVnfCiXWv+PUSg8dX32QjI=;
        b=RHBvHhi6uFOmR3J5yDpTtjiHlMCbynqcb9QyI3HCUoREaGHYBGl8/ZyHNQqunhL/GM
         TQcke2MVSQ9aBH1d0ZYIGHZBFu1e5rAJf+KWCRQoX3RnfNh+TPFqL61Mx+mdHFj3oDDV
         uTytlBo3BQnPtdZQEQN+iJis46dtuiMF9VlgC/XhaU5jfRkpqqf1+gwGfi986P7lZL1r
         Gu6BU4476I2jgzMfExV0UsLPN1Kjm8aMoJ+cSVQH39tiEvr1wceq/2JJnPrE2hASdlvr
         5xsTAli/mbscULtR4nn04dc3t1Tjvluo6uuO6dHZRmbgswao41MhqNoQDmLatWkPu88M
         x2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276802; x=1741881602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAB6/suJHRre/mBnY4z2mAVnfCiXWv+PUSg8dX32QjI=;
        b=XMEyAkvHGCnXXTdQJ3YxVH1rm0cobKv4AG38ZzWPy9HaPKqWrBrliXqglLs2DhshmM
         y/usaj7JPgMFaLi+z1YCAPCkaJyI+LdFZ+fioWKmtGoOKo+HYgNJTIabIqY9jgYF/+0J
         kG3F/0d8wArPYw3wAyo9skPWo75lsxvH9wbYuaXXvxOou527QNjvg7bIMnnKMeIuOgB+
         9QiAbaJcjDiopHaiCUsNr5qR2gDO2zNSfSp4ctjaGOqeIbxZG47uVKPBp1Z6Sg5i/qB5
         ahEOMPA1A7wPvoWDmB9srMTduE6VnmWWVRdzvTEr0rZWR9GogzVX5m9XUkeiE6bRpdu6
         V2fg==
X-Forwarded-Encrypted: i=1; AJvYcCXCB1TM4HIj1PMfgdCdAa7DGSc64mtu9e8BMaO4XE6ewU3NQ6BLBXylVl9WV8HxgWK57JGJ3oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJqdlKbEUKl9LIgBQAOEBpAtXisQd7Rz2xMc+AgXvapVJPdFc
	roPh+vaABH2yoFdAwFCi4Aq4uGSRidUdELQvfF6RGohm+fYws6Hn0ZABydQf6YATxga/AQ==
X-Google-Smtp-Source: AGHT+IGsDyZVuVoMjePfqPudE5bSuQ6vDQ2BfMvhJ2lchzVjnxqNAPjMSZLAKW5xDNxWxhEBguihiDLX
X-Received: from wmbay39.prod.google.com ([2002:a05:600c:1e27:b0:43b:d42e:35b6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5116:b0:439:689b:99eb
 with SMTP id 5b1f17b1804b1-43c5a5f9569mr241385e9.7.1741276802113; Thu, 06 Mar
 2025 08:00:02 -0800 (PST)
Date: Thu,  6 Mar 2025 16:59:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=ardb@kernel.org;
 h=from:subject; bh=yr5e1p3Qi6PlIBF5j5H9Cs2Lch54/XspKfU9Gt9v1No=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3ksZDeBi+tF4KHeBqSLmw9f+WdwccLqlM9jB+JmO+rE
 VX2vHGgo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkTIHhf47hKrYwTYvjfnPf
 aNYv0BcsO1GSaR9k+XejoXJnSOHqNQx/5aqLDt47aznj50qGm433dmg+lO5rsuwNOupu0qKdmJn JDgA=
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306155915.342465-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Sanitize boot params before parsing command line
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The 5-level paging code parses the command line to look for the 'no5lvl'
string, and does so very early, before sanitize_boot_params() has been
called and has been given the opportunity to wipe bogus data from the
fields in boot_params that are not covered by struct setup_header, and
are therefore supposed to be initialized to zero by the bootloader.

This triggers an early boot crash when using syslinux-efi to boot a
recent kernel built with CONFIG_X86_5LEVEL=y and CONFIG_EFI_STUB=n, as
the 0xff padding that now fills the unused PE/COFF header is copied into
boot_params by the bootloader, and interpreted as the top half of the
command line pointer.

Fix this by sanitizing the boot_params before use. Note that there is no
harm in calling this more than once; subsequent invocations are able to
spot that the boot_params have already been cleaned up.

Cc: <stable@vger.kernel.org> # v6.1+
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Closes: https://lore.kernel.org/all/202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af0..d8c5de40669d 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 #include <asm/bootparam.h>
+#include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
@@ -107,6 +108,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*
-- 
2.48.1.711.g2feabab25a-goog


