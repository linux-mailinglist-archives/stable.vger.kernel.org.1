Return-Path: <stable+bounces-38867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C808A10C3
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A822E1C23B37
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56214A4CA;
	Thu, 11 Apr 2024 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AShO64pn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EE149E10;
	Thu, 11 Apr 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831827; cv=none; b=hD/xxibrHHJFbzsqstpyt3JuWP/IAvA7oLfB8ipgTmZmkOeqpRRwFAOU8tmOfavKqoBaGEJIzCyirC8EUa1TflF7TuqRJqXEruB9rZifO8vIE7cvJt1Ct2F3UP1bBOVR6nBYBAaLnlnjnmeGbckSOziCiWOhcB8yQhMrqLVsQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831827; c=relaxed/simple;
	bh=V76FmQUbYNTtENnNJb7sBI5WmwmODwv0Ahd0YPwlxuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER+sdqd0kU1LnD1MuUrZNDkjeAvIKXnaCFRZWfWdwi63Ekqb5k9MK44B6LVKmwd7/GFJ1KV2xmcAshbY5i4AzoZ3H0FgniGqzlpojOAQVQDV/jG1CyDfWF8QtTQiehrAzTjEd0QVnKGFJ8T+5Ua5QiT2DX7qaQgj38m+T3bkb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AShO64pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1EBC433C7;
	Thu, 11 Apr 2024 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831826;
	bh=V76FmQUbYNTtENnNJb7sBI5WmwmODwv0Ahd0YPwlxuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AShO64pnfZuT9sxtI/7mHMmyNJZ0hnprodnF/TBMtEQnpvUg+tO4pAxv9+Gh1AIl0
	 9wmzk1V6x/+DxNYNKneCNzG7TjjuRcQpWD0JtTiltb3ElUgW1h7I9hJJnG+eKJ/kDz
	 alG3OrBR/H5PL3xCWI4brBA3ExwKHlNfHEuRqbA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 5.10 138/294] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
Date: Thu, 11 Apr 2024 11:55:01 +0200
Message-ID: <20240411095439.810313369@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

commit f87bc8dc7a7c438c70f97b4e51c76a183313272e upstream.

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,12 +6,14 @@
 # define __ASM_FORM(x)	x
 # define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 
 # define __ASM_FORM(x)	" " __stringify(x) " "
 # define __ASM_FORM_RAW(x)     __stringify(x)
 # define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #ifndef __x86_64__
@@ -48,6 +50,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 



