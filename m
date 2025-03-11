Return-Path: <stable+bounces-124100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365FBA5CFA6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42D13AC770
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E04264A74;
	Tue, 11 Mar 2025 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUfCh8LF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1807264A6E;
	Tue, 11 Mar 2025 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722240; cv=none; b=nUy+B7MG9GLA0LhL9JaZpNJmXbYrAjoRAo47PJ2NxUZbETxMMdBDylnlg9I/rx3X+dVXOHhFKBtDC23iNCYDQg3xj1rL3y61qx294yS8xv308udOjpz+MDi1bFyrWnxFNz3pxv02KWCs9pLbPoI6AKl/86GSZYT+8QUaV8n7Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722240; c=relaxed/simple;
	bh=cNLHeDWhNyuM27QisQzqNRVewktto9osrReTHyq97VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4lwlu0luxlymjVUzTGWdlexHyGJzZNt0FTlqXDX/WUyJCgyHKSJlBH6f3dnZJCLaxyW0YJtUvsYIwNk3RtZbqqKxDxFRPutqiYwX6HArmAwKImR8rd8a8JykN5f2gm9xUklxPAeYqEgk5Sfx5GEik6X67ZKVblSdAT9xVS+QM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUfCh8LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78599C4CEEB;
	Tue, 11 Mar 2025 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722240;
	bh=cNLHeDWhNyuM27QisQzqNRVewktto9osrReTHyq97VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RUfCh8LFZAR1jrtj67BqPaR1pjNlhFuBgUAd33xLzramO4/RhD8AEmQEBIdvMvjSo
	 xGD+pwSHL++SvRzjowVlHKaIoCJ0FUbTd0+euSY7qtAqYLeFIyqisGI4wrz+ejdRyZ
	 wQsjQIpzEoli4pCT/loUhei80hGmkepKSNxEGM09vV2acQPRz1wObKDYxhg4nu7AUP
	 rHzlNdp4blgcv6t5LfJkAVH+zIySMMQ49U7RSnPvjBP0v+mnqqBGG7UOvfEefwnA8n
	 2h3h37Cu6OpQ3vEuQpXJpufgYwUt+KgA8IjvrsYcdMLBOrhy0tM2h9qvF40YdXEuqy
	 Ho50mpnsy8Hng==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 11 Mar 2025 20:43:43 +0100
Subject: [PATCH 2/2] ARM: add KEEP() keyword to ARM_VECTORS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-arm-fix-vectors-with-linker-dce-v1-2-ec4c382e3bfd@kernel.org>
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Christian Eggers <ceggers@arri.de>, Arnd Bergmann <arnd@arndb.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Yuntao Liu <liuyuntao12@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=nathan@kernel.org;
 h=from:subject:message-id; bh=k6KErdk8UAE5TaS8j5kgByd6cy02OSxvuL6oLJYcWN8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkXJlWmLj/rWPU569kZZ8NOjq9mmuvOy6dP1zrzJzfJ2
 GJuhSpTRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIvMsM/wuTIu94La9+fE1B
 Zfob1eNpEQ5JKtozw4PKGxaVqZz5oM3IcKfYh0GqM1Kv4M7Fyr9fdVL9so0+LdlTYiT8eEv99Hp
 FNgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

From: Christian Eggers <ceggers@arri.de>

Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
is enabled.  At startup, the CPU (silently) hangs in the undefined
instruction exception as soon as the first timer interrupt arrives.

On my setup, the system also boots fine without the 2nd and 3rd KEEP()
statements, so I cannot tell whether these are actually required.

Cc: stable@vger.kernel.org
Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
Signed-off-by: Christian Eggers <ceggers@arri.de>
[nathan: Use OVERLAY_KEEP() to avoid breaking old ld.lld versions]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 0f8ef1ed725e..14811b4f48ec 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -131,13 +131,13 @@
 	__vectors_lma = .;						\
 	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
 		.vectors {						\
-			*(.vectors)					\
+			OVERLAY_KEEP(*(.vectors))			\
 		}							\
 		.vectors.bhb.loop8 {					\
-			*(.vectors.bhb.loop8)				\
+			OVERLAY_KEEP(*(.vectors.bhb.loop8))		\
 		}							\
 		.vectors.bhb.bpiall {					\
-			*(.vectors.bhb.bpiall)				\
+			OVERLAY_KEEP(*(.vectors.bhb.bpiall))		\
 		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\

-- 
2.48.1


