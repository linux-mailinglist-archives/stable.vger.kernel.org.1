Return-Path: <stable+bounces-178009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01483B4776C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F487AD054
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A928725B;
	Sat,  6 Sep 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdfmrQy5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A7315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193935; cv=none; b=kCmEQ0dtuwPqA0GTs0j1fsjm4ymOn74pYEnsAl8tMTgZ9XhotvOopMKCicMISwhWMSnZOcoFbjBi7RxvDP2vuzgh02ITaZmeoZ1ww4lnros4vgt2s/0oP9LE0jThRyR6crBH6UONznSXhwoThZvDSoJTXxpUyd5HL2ECT5+mCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193935; c=relaxed/simple;
	bh=N4iyWQEc3jtK01rT2CcmXDUdS61n01OLfjLbiGVh1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVx7YvR4eH7KmG8k7khJly7IPd0A8GVeugrRCmie/kWLbk/h3hkUNbtyHQqOwfio9QSGKousUPRcr2giN8R6QCHALZ8TZYcGeGbLlFycV5m2Rcuu8zarN8VZxqeAhMwXBMr+PCZIwsvrwCOqZ5jxyhIO18AZR8eSttFgj5m548A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdfmrQy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B746AC4CEF5;
	Sat,  6 Sep 2025 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193935;
	bh=N4iyWQEc3jtK01rT2CcmXDUdS61n01OLfjLbiGVh1UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdfmrQy52dapnyp6r+uQ7hga3Y+gxzRT89IbJBV7GAt+0XIRqtGj29gUou93QnAxV
	 HJEtxv6mxWdMf4oe7i+uRiHBK8N8YdvpWkHnSEl1t1+amUr9KKwpAqN+KrL0iHBhZ/
	 +y94IN+3MsNNcvfDBtOWnxtatp6wcaw+7Id3u37gV/Yd5gUThz3cP3at1L26uyYJlh
	 OACfL6ovhzGYfjZdRxC/Hcd//L9vgQ4MSLGeNdfXBL8O5HL/QIrja3zfpY+SeozD0n
	 0GV1P/NspHegZdOWWGLl4DINQRyjVSMfkkW0rrBL7UoENwjOL5QvQt2290K37oL89p
	 Fm7QkD5dAr+6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mm, slab: cleanup slab_bug() parameters
Date: Sat,  6 Sep 2025 17:25:29 -0400
Message-ID: <20250906212530.302670-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906212530.302670-1-sashal@kernel.org>
References: <2025090618-patient-manlike-340f@gregkh>
 <20250906212530.302670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 4b183dd9359d5772446cb634b12a383bed98c4fc ]

slab_err() has variadic printf arguments but instead of passing them to
slab_bug() it does vsnprintf() to a buffer and passes %s, buf.

To allow passing them directly, turn slab_bug() to __slab_bug() with a
va_list parameter, and slab_bug() a wrapper with fmt, ... parameters.
Then slab_err() can call __slab_bug() without the intermediate buffer.

Also constify fmt everywhere, which also simplifies object_err()'s
call to slab_bug().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Stable-dep-of: b4efccec8d06 ("mm/slub: avoid accessing metadata when pointer is invalid in object_err()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f6323fac6a026..39fb2b930fdf7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1027,12 +1027,12 @@ void skip_orig_size_check(struct kmem_cache *s, const void *object)
 	set_orig_size(s, (void *)object, s->object_size);
 }
 
-static void slab_bug(struct kmem_cache *s, char *fmt, ...)
+static void __slab_bug(struct kmem_cache *s, const char *fmt, va_list argsp)
 {
 	struct va_format vaf;
 	va_list args;
 
-	va_start(args, fmt);
+	va_copy(args, argsp);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_err("=============================================================================\n");
@@ -1041,8 +1041,17 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 	va_end(args);
 }
 
+static void slab_bug(struct kmem_cache *s, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	__slab_bug(s, fmt, args);
+	va_end(args);
+}
+
 __printf(2, 3)
-static void slab_fix(struct kmem_cache *s, char *fmt, ...)
+static void slab_fix(struct kmem_cache *s, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -1098,12 +1107,12 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 }
 
 static void object_err(struct kmem_cache *s, struct slab *slab,
-			u8 *object, char *reason)
+			u8 *object, const char *reason)
 {
 	if (slab_add_kunit_errors())
 		return;
 
-	slab_bug(s, "%s", reason);
+	slab_bug(s, reason);
 	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
@@ -1139,15 +1148,14 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
 	va_list args;
-	char buf[100];
 
 	if (slab_add_kunit_errors())
 		return;
 
 	va_start(args, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, args);
+	__slab_bug(s, fmt, args);
 	va_end(args);
-	slab_bug(s, "%s", buf);
+
 	__slab_err(slab);
 }
 
@@ -1185,7 +1193,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 					  s->inuse - poison_size);
 }
 
-static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
+static void restore_bytes(struct kmem_cache *s, const char *message, u8 data,
 						void *from, void *to)
 {
 	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
@@ -1200,7 +1208,7 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what, u8 *start, unsigned int value,
+		       u8 *object, const char *what, u8 *start, unsigned int value,
 		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
-- 
2.51.0


