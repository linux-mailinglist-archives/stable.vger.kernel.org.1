Return-Path: <stable+bounces-140148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5CEAAA576
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7871631B0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2723120B6;
	Mon,  5 May 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwTgAMAt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D228CF75;
	Mon,  5 May 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484234; cv=none; b=ibXsjKxXzrD2qakpWwjQPbb946M7rWZgrqb39mGLRavJt/n7ooAd3BaO2bfNDYiUAJ3mJ4Y4ipSr9BzZf9TPKBYZ3SKHrpif4Py1ojB3GnSEO/VTAMty74ibHe36+O+EZYPSxLqhweLzaMbCnzDDp0wm0682kfs2HZHeY7eTjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484234; c=relaxed/simple;
	bh=HWnCyAbvDdirI8uYLst5UGg1wOV07mxIIYJ4NUlDZug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssktUkPtW651hRtawItEmbm1ULhV7tFuZpOQbzhSvmsmTs/e4Jnmbeusd9Jk92mKlk6qX+2CoKeMrbFpXLJb6BQOatMOMFTVqASKaTJ5+DaF1D5UvJ3AXSKXFoeMITNjvCjG5OpmFIV6uj616okUGiJX8CLDhsjy3zxsNt2Nup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwTgAMAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0343C4CEF6;
	Mon,  5 May 2025 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484234;
	bh=HWnCyAbvDdirI8uYLst5UGg1wOV07mxIIYJ4NUlDZug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwTgAMAtNxYfjcSv0Kyxu0+MS1bqzRXZTUEkaPIPVIWsGlp5/x+m/PXEUdabbxK7O
	 viVI9z533YQtqrO1mNc+TeSrb9tkVfOByvwpJDlI9twBaGi0VGBqECRixoeJZ4r7jY
	 Na7FklbuQuvrtBjaxjrc2lXkrAtNgZKLg1Wp9pOaOch6LGKAS3xYC93geWEueNvOPZ
	 rUDdcxqL9Nri1xyKOb2g2o4ew2C6F7SFddmcpkIejLJCPK6E3GjMWKMy8JY3IeBZmf
	 gvXaynF3m/CN1edo0+q4sRlyRJBd1EccyYgFlOYEvfkwyoP/adCFlar3Z6UAOJv/zZ
	 ++Dw8ahk0f12g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	yazen.ghannam@amd.com,
	nikunj@amd.com,
	nicolas.schier@linux.dev,
	masahiroy@kernel.org,
	dvyukov@google.com
Subject: [PATCH AUTOSEL 6.14 401/642] x86/boot: Disable stack protector for early boot code
Date: Mon,  5 May 2025 18:10:17 -0400
Message-Id: <20250505221419.2672473-401-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Brian Gerst <brgerst@gmail.com>

[ Upstream commit a9a76b38aaf577887103e3ebb41d70e6aa5a4b19 ]

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before user-space is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eba..84cfa179802c3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.39.5


