Return-Path: <stable+bounces-33748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39C892337
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8021C21668
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D313777B;
	Fri, 29 Mar 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShjR5ZGT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE318AF8
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736315; cv=none; b=bYU2CWoEVRVecHqMfr9CDgffyjDSeK51Vq33wqlA1IJp+49kAxz5G0oH6wrg2cULfMadCBf9Wfvt9mKNT7n8KW3BWAL79hbhPseM2F93+Iw6GEtk2pI1BoRF3Rsk75lijWfwWh3DMnyJhf6esqnh3Wbs0U2Se0zgllmn3eOMQrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736315; c=relaxed/simple;
	bh=Sd+j2e2MUQnNDPjauV3+ytZJosiW6++YaM7Leds7YB4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bg7zs636g5t32lFKldxdFsvJcsEXCVjK6YN0S5/9oLR7Cf5ly0puA8P59jTLiPuviTyvZAFeu47W+s4Au/wAntTUjvJM5NUnXDY5iHYiKttUyAm2sCcs7cYvkzJf+gAMZ4kbNYJOz8gVAKw7P6OquSa+AGMaLthU6/vKbKNGsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShjR5ZGT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so3822605276.2
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711736310; x=1712341110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0En8cmWxc1OqE14MHkV6P7ff7KOpwDGD7OecJqbQzE=;
        b=ShjR5ZGTbLq9kmzTk0zJyAyJyNHZLX3OcdB/syceF3reZaXjMMUsRBIXA4/lXG4s5J
         AxD9iVF2T0fl3IjOPb49XtSRcJmbDX5aRducNJnaYKAERU/T27XojLlFu0eEAFzEWr9O
         xCYphYI7DqJ9arWSgiMqGCR4cCTZ06/7MGyhna8vpuKVhh0NdWeREpO/DZ/z0lZglEF7
         offmPAJCJds3VXR8Y8BgXJjl6hmJki6hzgqv34wtAlXXMO8aSXu8TpY4lcelSTDiYReN
         QRsUbVXAu2pFtPfA33pmT2TH13u6PGWfrMGKMV4S7FHu+Uwo8kM1lbQcDHmJqit1O80G
         j3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736310; x=1712341110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0En8cmWxc1OqE14MHkV6P7ff7KOpwDGD7OecJqbQzE=;
        b=BKdnFYL4B7jDkeE+sLB77PK5MwiOBkG0CLFJ0s5y3i8TFX2c5ul0nObjkbVd5jYRf3
         jPiatyosHPDcyK/uHGeKFOeYIpVmTaPHbk0u28aIcz0YqEBZUEY5EXTpjS6XjJPVzUEL
         XS1qpnkYdV2GtY/kO1usWXsHz5CLUPCcrFZzYCoi6XpLq6chExBBz0H57ToKFCWCKCTf
         CTEWOSq4dfm956oruwm2GI8nC3nt9NSMABvE6TALg3Oh7Gz+5GCDrwH5jV3By824/xNX
         wTe9QvxQx06qLiBZvwwB6tvP4iLOJTIWxEj5i/JxY9zM+rEOjVZ741SHhaVOnGY8nFFD
         DuDg==
X-Gm-Message-State: AOJu0YwDxQoWSbQjr3isM8q3hIvj1/irew08jaNtRsik0HO+9SVu0T46
	/qLMmxLQcmTG3quCFRycMMv+bcqX/s1JClXKwp/B+tBqKXmaTQykO1nnrg2d5L4CZVT5jWIxp0q
	Hx5g3XAUNg/DL6rnq/H7RAu0maAaygCvw3i//A3ysncPi/e0wHP+P2jw8dqdSJvPtyF4PpFCcvb
	U5e7WYfqebxzd/mJ9UD8ohJg==
X-Google-Smtp-Source: AGHT+IHo7E98IAaOLMnLzKG9EVcbAJgtlLiNkwNTxJGZvE6s4aoqRIvcDXV21kr/yB5iHM5d0dcPEZtM
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1601:b0:dca:33b8:38d7 with SMTP id
 bw1-20020a056902160100b00dca33b838d7mr882088ybb.11.1711736310468; Fri, 29 Mar
 2024 11:18:30 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:18:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=ardb@kernel.org;
 h=from:subject; bh=NGqxdq3MUi9EZ2cVsqWiHkXwzthwdrYIpYQ4JK4gj2Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2d9aaoYIPHhNgpTxe8nv+jRbRgdu67uYV9Lntk2ENi0
 /iumfh1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImIz2JkmJD0XyTk3uzdqY0p
 pj86S75ckys5mq1u1B32b/alL8+DXzAyvFkT7cGQ5N6n7MauZnGkvcc+6Ir3rqvbAjdevW3mG7y QFwA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329181800.619169-5-ardb+git@google.com>
Subject: [PATCH -stable-6.1 resend 1/4] x86/coco: Export cc_vendor
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Commit 3d91c537296794d5d0773f61abbe7b63f2f132d8 upstream ]

It will be used in different checks in future changes. Export it directly
and provide accessor functions and stubs so this can be used in general
code when CONFIG_ARCH_HAS_CC_PLATFORM is not set.

No functional changes.

[ tglx: Add accessor functions ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/core.c        | 13 ++++-------
 arch/x86/include/asm/coco.h | 23 +++++++++++++++++---
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..684f0a910475 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -83,7 +83,7 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
@@ -105,7 +105,7 @@ u64 cc_mkenc(u64 val)
 	 * - for AMD, bit *set* means the page is encrypted
 	 * - for Intel *clear* means encrypted.
 	 */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
 	case CC_VENDOR_INTEL:
@@ -118,7 +118,7 @@ u64 cc_mkenc(u64 val)
 u64 cc_mkdec(u64 val)
 {
 	/* See comment in cc_mkenc() */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
 	case CC_VENDOR_INTEL:
@@ -129,11 +129,6 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
 
-__init void cc_set_vendor(enum cc_vendor v)
-{
-	vendor = v;
-}
-
 __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..91b9448ffe76 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,13 +11,30 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_set_vendor(enum cc_vendor v);
-void cc_set_mask(u64 mask);
-
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern enum cc_vendor cc_vendor;
+
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return cc_vendor;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor)
+{
+	cc_vendor = vendor;
+}
+
+void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return CC_VENDOR_NONE;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor) { }
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
-- 
2.44.0.478.gd926399ef9-goog


