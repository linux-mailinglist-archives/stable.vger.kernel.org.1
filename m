Return-Path: <stable+bounces-61777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D61693C771
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD4CB212A2
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6719D088;
	Thu, 25 Jul 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ICID+PBq"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599018786F;
	Thu, 25 Jul 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926478; cv=none; b=fNjcHjIpACxJh8/oZ4ffutQrXky+2xzthnb5vYs37O+pA2rwkKoxeHZj/xbXF+m+15ADY0BvHJwmprBMB1ie2bFQDlUSuDOhjQ+ZWQKcC/i3qQZhXVVgBZaqST/lae9MTkE8TUISzozVMDWA8Rxx9Be/BFWcl8AHRkNen8QYSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926478; c=relaxed/simple;
	bh=syONP8VjVdqL2xWWMPlf7RznwF4rCyxx+6JdVj5duMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uEZWHVMeFNAxlAlhF/UG7sEIFj3MJpcbTQ6X20s98Ipb9xhO6ONt1gfoZc2lj4bkLSyi7+glBA8QMwOw0GNH4XZUWwf+P9k6ZY0kcWxreuZhm23jT8dbRjeJiABsGze85/qpmVr2Suhy4yrV0G17OIXmjaa/Ko2p5TuJtJuIm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ICID+PBq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721926464;
	bh=syONP8VjVdqL2xWWMPlf7RznwF4rCyxx+6JdVj5duMw=;
	h=From:Date:Subject:To:Cc:From;
	b=ICID+PBqOoNxfgEe43uhkJTTtzc9gjA5qc6trmobw1xGl9U0UBsM2Uyn2xL5V+v/j
	 EN6Z6wrlZ/Mi2mC3hKEFnaM10Jm7JcVOeWiNoEz4c8FTuZuu+cWa1xOIPeo6MC5rSo
	 79uUIp+KU3qcoMYRS0x20Wf2ytV3OTfntdTHFiuU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 25 Jul 2024 18:54:18 +0200
Subject: [PATCH] tools/nolibc: include arch.h from string.h
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-arch-has-func-v1-1-5521ed354acd@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADmDomYC/x3MQQqAIBBA0avErBswy8KuEi1sGnM2FkoRRHdPW
 r7F/w9kTsIZxuqBxJdk2WNBU1dAwcWNUdZi0Ep3atAGXaKAwWX0ZyQ0dunJamLbGijNkdjL/f+
 m+X0/rCp+sl8AAAA=
To: Willy Tarreau <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>, 
 Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721926463; l=1160;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=syONP8VjVdqL2xWWMPlf7RznwF4rCyxx+6JdVj5duMw=;
 b=90tcfI/zcxy8Qi19+jtfQ5KHMrUKeQjZYJDHa1Q7Wil+sdrYhhgLITVc+i+BygeNjWO040rv0
 yyjKnJpgyI9DOU3V0HFc2i2/Q/9i074fYpER7UfZXXsa64X2NrdoXdy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

string.h tests for the macros NOLIBC_ARCH_HAS_$FUNC to use the
architecture-optimized function variants.
However if string.h is included before arch.h header than that check
does not work, leading to duplicate function definitions.

Fixes: 553845eebd60 ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
Fixes: 12108aa8c1a1 ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
If nobody complains I'll apply this after v6.11-rc1 is released.
---
 tools/include/nolibc/string.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f9ab28421e6d..9ec9c24f38c0 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -7,6 +7,7 @@
 #ifndef _NOLIBC_STRING_H
 #define _NOLIBC_STRING_H
 
+#include "arch.h"
 #include "std.h"
 
 static void *malloc(size_t len);

---
base-commit: 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b
change-id: 20240725-arch-has-func-59b6c92ce935

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


