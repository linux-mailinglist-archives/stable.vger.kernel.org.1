Return-Path: <stable+bounces-204433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB0CEDEF8
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6069C3000E8A
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626B2C2343;
	Fri,  2 Jan 2026 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4DXSF9WW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bsy8va++"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA79231845;
	Fri,  2 Jan 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767338185; cv=none; b=Cy4/w4sYMxe/89hvOxghX14OBNAgcbNU5bTiSzeLbYYCGqQR5sfKt+WILt6g5f5N7bfGHeEb3F+PEvXtHCEJPUAw2evXHRDbCnvp7NvEWRncp/ajBx9zXkV45XJCIU3TbqVoJrArySX80EAihl3xeSGW4nizsXGAFST3hlS76NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767338185; c=relaxed/simple;
	bh=6IdQhWHRL8sxQR3hfcJIbaJ1RnY35D0jn+3c047cMJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u+xHo4vfV56cmAMZc/15FzUNjeoviPJZy9HCUHBU1Eqn1YhyrieHRebDG48+/fYjcheIKpKcEKcFF7WfnHv0KyneJrMROFDI45uUQiduX+1r0lF7OE+jg2Hqr6C0sIzEEomgBTzgSLoj1tAyxq/4yk5E7Iu70f/OCqAdiBVO3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4DXSF9WW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bsy8va++; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767338174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUVfCdYU+P2/tuhq3RExnWJpGzo44bddZzASzjEowLU=;
	b=4DXSF9WWuZcRtKVleaHmSt2nqwEqk0XeBwPTXfycL7khpkOtVy7PZL+IEkYJ+eNkamw8xo
	BV5LuE1BdaJ7cvM9EeqVqxaAMrLs+tUdalVb6Ye/l2hXP1fuuSyJI7ORq4cpUDlnZcMtNY
	SOb1L+UF0GHPdImIIuZdMCLrapGW8vCqsB44fIb9wHGckiZs2SvE4Sny3wFTVTklPLUnFu
	auEJMlqFFFORED4uZqzhD5kFFUFu5dJtrw61jvqCxARTKupo9+2wQD4gSrYB5OUxi3fcaK
	5Q5LaN6YFtjHirouZrUvTKh82vS6FyCbBDyAKBTrzawoNm9N2rfcO1J+LPEysw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767338174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUVfCdYU+P2/tuhq3RExnWJpGzo44bddZzASzjEowLU=;
	b=Bsy8va++cov7ou85DSjmBzb+UqL3kuYF9dI8cJdbQmk4SG9e5lad3zeJptjL41PzpTIpAv
	80az9HoiU0mXalAg==
Date: Fri, 02 Jan 2026 08:15:46 +0100
Subject: [PATCH] ARM: fix memset64() on big-endian
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKFwV2kC/x3MSwqAIBRG4a3EHSeoPai2Eg2sfusOtNCIINx70
 vAbnPNSRGBEGoqXAm6OfPgMVRa07MZvELxmk5a6UbqSwgSHWTi4iKuthVRWG3SV7WEpR2eA5ec
 fjlNKH9hYpU9gAAAA
X-Change-ID: 20251230-armeb-memset64-01f2ae83f9ef
To: Russell King <linux@armlinux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767338172; l=1275;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6IdQhWHRL8sxQR3hfcJIbaJ1RnY35D0jn+3c047cMJE=;
 b=vEVVWgHwwrx7iXQyo/+hyWo5gF0lLYQfBaL2JT9JVklqDQvWNqK5LsdnA7oyvXXXaS2ldaDjJ
 PEg1QMTO0LiBo5aDEQ3d1izbZj+4V/Dc/JYRHTdr+oRADmoZ+If3X+0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On big-endian systems the 32-bit low and high halves need to be swapped,
for the underlying assembly implemenation to work correctly.

Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Found by the string_test_memset64 KUnit test.
---
 arch/arm/include/asm/string.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index 6c607c68f3ad..c35250c4991b 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -42,7 +42,10 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
 extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
 static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
-	return __memset64(p, v, n * 8, v >> 32);
+	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+		return __memset64(p, v, n * 8, v >> 32);
+	else
+		return __memset64(p, v >> 32, n * 8, v);
 }
 
 /*

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251230-armeb-memset64-01f2ae83f9ef

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


