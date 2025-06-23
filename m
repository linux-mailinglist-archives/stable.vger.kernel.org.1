Return-Path: <stable+bounces-156023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08637AE44B9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7393188CFDB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB592472AF;
	Mon, 23 Jun 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aIcQySTY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973A1E480;
	Mon, 23 Jun 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685948; cv=none; b=IYzjWuVKpdGVbF2HSGUCbkATWpQx/yKGA6Fnn4LJRytlagJzspMjpU65r17McFXY47dV3wpQ6niXfbpXJxDzN+oRNKP4gvgQpGffoGHkCRyrCyupUZkLbivcFefl4LwHKRPc4PBfSPwIxMoQaLrZJEytosuJpZiDyKpSY9U6B3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685948; c=relaxed/simple;
	bh=gqO7WV/lvU7LjWUlpBYItE9x6rk2tim4ekj8XXrtd0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaOAwji4ycKnbn5L6gnEJv21pWmJVPnX9BJcQ8ohordhzXS3/PiKwE448ZQCIEQDsx3bLPCnT6uvbEktiCiwDqYHixlp7lU9U+5YV/svatfnxoqgKpuFFEfCrqQd1IM7Fd3mOiL5d3Z/JB4c9HOUq5w9BJg/gEIk+2dvy3pTQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aIcQySTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46044C4CEEA;
	Mon, 23 Jun 2025 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685948;
	bh=gqO7WV/lvU7LjWUlpBYItE9x6rk2tim4ekj8XXrtd0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIcQySTYgcUFE8owr3G5xRl3RUgyi4qI7kmjpAygM/0oMp22D6p0WlLTlto05VgIc
	 v03iUS+XAd3eaVToOtFKF/T8Lhcd48fMdE/mPRMKQnpcgtI15DCu5eTH7V4EWpnO8l
	 +OaD4T/qVUdvzaxT7V0Lm/wznWGAFTeCDe977ZMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Khem Raj <raj.khem@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.4 129/222] mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS
Date: Mon, 23 Jun 2025 15:07:44 +0200
Message-ID: <20250623130615.976556132@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khem Raj <raj.khem@gmail.com>

commit 0f4ae7c6ecb89bfda026d210dcf8216fb67d2333 upstream.

GCC 15 changed the default C standard dialect from gnu17 to gnu23,
which should not have impacted the kernel because it explicitly requests
the gnu11 standard in the main Makefile. However, mips/vdso code uses
its own CFLAGS without a '-std=' value, which break with this dialect
change because of the kernel's own definitions of bool, false, and true
conflicting with the C23 reserved keywords.

  include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
     11 |         false   = 0,
        |         ^~~~~
  include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
  include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
     35 | typedef _Bool                   bool;
        |                                 ^~~~
  include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards

Add -std as specified in KBUILD_CFLAGS to the decompressor and purgatory
CFLAGS to eliminate these errors and make the C standard version of these
areas match the rest of the kernel.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/vdso/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -25,6 +25,7 @@ ccflags-vdso := \
 # offsets.
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
+	$(filter -std=%,$(KBUILD_CFLAGS)) \
 	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \



