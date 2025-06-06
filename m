Return-Path: <stable+bounces-151596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD26ACFE33
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 10:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64543B1033
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E934283FE0;
	Fri,  6 Jun 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JV5yUvE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYcoL7LD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B77189F43;
	Fri,  6 Jun 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198262; cv=none; b=peQ1y/1phxuyVP9J232jO/kvDCr4zu2WLfrDLut8GQ9DH0mXg+jxmYSFcnxEnGlrp5Nc2qpCyNN3RREjHM8ZqLiZrqDz2gtoCh47s+wGZnTRAZyIM5YxdnSqMos4wxJ4smG1TTiORymoSyli+76qZnyV+x7H+N4DfW8tqRajunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198262; c=relaxed/simple;
	bh=LXXtQqxnaVnzTr/KeK0hnqR9RwZ7uk+DhzX918qKrDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NloP6hN0LvkXv0HTifJvJZkDt/nygOq+vAdRq2zob6sGDUXx5OAL/44pi63D0pe9GysS9sqpyoHrXG1CM42Ce85blVPowUvB3wndD6VpWTKrQDWA03SO+AsOAnQD21ISnAMqxS4AMDdj3VfPObNcU89WWcN7y1syZIASNislHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JV5yUvE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYcoL7LD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749198258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wqR60cXBz22LWPCJXS/Pq30I2q7GeCkOEBk1DVj2mQ=;
	b=JV5yUvE/luYb5J5qdhM+sVvf9WRrum0LwyZJaWOzUOuH4KkmR+TGiiHdhVM2p0qj4SmGQU
	rzGeHIlOaxEwkzgomi2LLziy6E7NziDWLYgvw0qBE6lKiTvYWZ1Rwol0drJJS6wiJ6+Lkk
	wBdTWIdVQDDCF9xZ0OfAMxAvK3KZbEgbUjRFiQVgYg1MPpjILJ0sNn1GwuwB/+Y/mVy8Ti
	L2E231bNCTgXZwbx23emBO2GukdnaGlXKDx2V6aZo+b7SBV9nqnj0gTn0FfNAaRPKww6Jw
	x7puHPCAf6n6Oey1QWLStDtpLPbZn+l9y1Q/ApvASTtrAPGrhvu4WAfGtDC8Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749198258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wqR60cXBz22LWPCJXS/Pq30I2q7GeCkOEBk1DVj2mQ=;
	b=CYcoL7LDzgqBm8Z9MRrqkGWpHVXvMumKO3MNYm8yycR6B70iyEKp6tJsN3Rv6hX17AKEEh
	9sp8PSyfGSDtuLAA==
Date: Fri, 06 Jun 2025 10:23:57 +0200
Subject: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJylQmgC/x3MQQqAIBBG4avErBNMaKKuEi3E/myILJQiCO+et
 PwW772UEAWJhuqliFuSHKGgqStyqw0eSuZiMtq0mjWry56iPMJu06agO+ZuBvdwVJIzYpHn341
 Tzh/naebgXgAAAA==
X-Change-ID: 20250606-uapi-genmask-e07667de69ec
To: Yury Norov <yury.norov@gmail.com>, 
 I Hsin Cheng <richard120310@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749198256; l=1773;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LXXtQqxnaVnzTr/KeK0hnqR9RwZ7uk+DhzX918qKrDA=;
 b=7h6a883lKxDrZnBb3StjpyCMgsYfj4+C5c7bXY5pYpF1Kppv7pfamYxpp1Zq3b5yZSy6T+sRT
 GZ9RWKIFVe+DXJilQH+T8jFBwy4Bx5er+e5wz3gpBovA7wFcYOyoRal
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Commit 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
did not take in account that the usage of BITS_PER_LONG in __GENMASK() was
changed to __BITS_PER_LONG for UAPI-safety in
commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
BITS_PER_LONG can not be used in UAPI headers as it derives from the kernel
configuration and not from the current compiler invocation.
When building compat userspace code or a compat vDSO its value will be
incorrect.

Switch back to __BITS_PER_LONG.

Fixes: 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/bits.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 682b406e10679dc8baa188830ab0811e7e3e13e3..a04afef9efca42f062e142fcb33f5d267512b1e5 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -4,9 +4,9 @@
 #ifndef _UAPI_LINUX_BITS_H
 #define _UAPI_LINUX_BITS_H
 
-#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
 
-#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
 	((_BIT128((h)) << 1) - (_BIT128(l)))

---
base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
change-id: 20250606-uapi-genmask-e07667de69ec

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


