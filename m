Return-Path: <stable+bounces-118243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36499A3BC2A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E4188E461
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26F1DED44;
	Wed, 19 Feb 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JY6YUIY4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5431DE4F6
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962568; cv=none; b=r4Je8izaH/qRU1GClaBa/1P73OGTzm3HpulwuHnItNkTRCXA7923Jkh+enT9vQBlokP+hm7L4EwiTrWmZFoFJVOugZiw3wUv0+WfD/c8bPubccK4WTuwpfiT5GrtwjqA8DNFysnu03lfjc/QYhQa9oR7mlrbqvpRZ1J3L2tfjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962568; c=relaxed/simple;
	bh=eaG/GbWLBDk4/YJIcaFIY6f9h1iZspXbx7Ba+G69v9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sh1dla6WA3nTZHAfsJyALsVAIH9D5i7ebLOaoV5YjDIDIoCz8lvbuTLyzup73Y7B2s4almKGEzRV8Z+zbt9tXon5Qj0kBd1GwW9Y00QS1yjejDwhoAhIE4rXDG6k9BoU7qR7sVR2CS3K5WurLeetQKpn+FIH9DX6k9i44NKxW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JY6YUIY4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so38133965e9.2
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739962565; x=1740567365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9qTS4Uc1tQ2R+88yELo0rnzGgf96mYUsGo/xuWB5/Y=;
        b=JY6YUIY4xxn5OBFi3bijk9+3ydD7I2oES18JMesVCCO9RzYvX6MErobQig6j5y2uvC
         ew6+yRb3MW82rUkrvBDn722JC26ateZbhJpDuW9JE9xxKDcpdZZiZtIu7iQ7/k5NvwsR
         z1Ga2Y67+rvxWbz909HfX/Ze9QTi+0iKQZhfoKD+b2L+571wlfZwwUBYAu86Awm2SYxK
         tZzR35u4FMuqp5K1/Dxi35rSGB44NvLsFged4j4NsrAfjH0qR4Yf+78+CgtxBptsNWby
         NLgNLeC35xrghsVOby6jZSU0RTuo1d95Fac/D3e/jji3xtlRYnS98VgIvT3j/WXYqCKD
         NwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962565; x=1740567365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9qTS4Uc1tQ2R+88yELo0rnzGgf96mYUsGo/xuWB5/Y=;
        b=XI1ZWjtpvJ642CShaQijuFcDPm34Y2sgnXqv17DTbib7Dhi7fPWxxV6ONx1dAtkdHT
         Frqf5mjxLv6Pjo5rUO+qpqwCvoTE34ZYe1HA6tBKiSbGrN+mCi+vuSx8/sSkfGiS7gOE
         uzYhCY//RuCithv9HaVVojJE8Uusd2WqQ4elrS9+RFAf+ooTajmOX+yeCfV2Qo9AdmD4
         TRTKUtSnLbZ1Lm1ORl9l6nXAJClgsaZOvjhjKgA3wei00BGOpwEYPP+flLIweLY4sIzH
         mH9AGUfyogSz1c/kOmgKI5/hy4oV6t6jY9CkudvcB6LSrmwNmZQZHhlkIziwycJR0MxT
         7R/w==
X-Forwarded-Encrypted: i=1; AJvYcCWonps5gnxg7pBxKXh70ZzBWEox17Hg0R7BLli65CBE18sTijqnrBBG+rCtEi0QHq+8oh+XafE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogXJX1roPrTOV2u6GyLaXtVlCF4EVcoYcoA/xLamF+NOwQBwq
	RG50WE3XU1zOuq/9/CUdAZ5Az2xg3/tWNDOu9ACRG7tmaO3I+lc2r1kcDhvYWkY38b15Yg==
X-Google-Smtp-Source: AGHT+IHoREA2ePDbR8mhOuh0W0YArGHABmjjWj+HtOC3f43DWme5eakY/sEFJdfRLZliHhEDJEk89fAn
X-Received: from wmbbi18.prod.google.com ([2002:a05:600c:3d92:b0:439:7d73:d8fc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1f0f:b0:439:8653:20bb
 with SMTP id 5b1f17b1804b1-439865322ddmr103214025e9.14.1739962565036; Wed, 19
 Feb 2025 02:56:05 -0800 (PST)
Date: Wed, 19 Feb 2025 11:55:44 +0100
In-Reply-To: <20250219105542.2418786-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219105542.2418786-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=ardb@kernel.org;
 h=from:subject; bh=HkjZ8co7JO5kD2Q6DjKKl8vHVJcbPC4E7rJMS59Tps8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX3rjg2sU0snRccvDPzP8KLlg0DiHoaknAi2kyuDbK0+H
 VkWVNXcUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyYwkjw6UELeZFsydvv/f/
 YJ7bEfvgrKCv/esDw+r/b9i4eINo8xqG/8FHvQuVzKWbNj9+fExZZruTyRbjx/Vc63tm935gXbN IgBMA
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219105542.2418786-5-ardb+git@google.com>
Subject: [PATCH v2 1/2] asm-generic/vmlinux.lds: Move .data.rel.ro input into
 .rodata segment
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When using -fPIE codegen, the compiler will emit const global objects
(which are useless unless statically initialized) into .data.rel.ro
rather than .rodata if the object contains fields that carry absolute
addresses of other code or data objects. This permits the linker to
annotate such regions as requiring read-write access only at load time,
but not at execution time (in user space).

This distinction does not matter for the kernel, but it does imply that
const data will end up in writable memory if the .data.rel.ro sections
are not treated in a special way.

So emit .data.rel.ro into the .rodata segment.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 02a4adb4a999..0d5b186abee8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
-- 
2.48.1.601.g30ceb7b040-goog


