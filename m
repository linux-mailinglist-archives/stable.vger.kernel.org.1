Return-Path: <stable+bounces-180920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D12B9004B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC68422FAF
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596372FF14F;
	Mon, 22 Sep 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="m8FSUyE/"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B72FF67F;
	Mon, 22 Sep 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537142; cv=none; b=vABUq7EmFfpgA8eGsSDDfO1m8eRqxtOKVKwYz6wY5Bk/0ZR+0jbgA2HF1HH9vWlYhnRnemN2krgEW+3x9sS6Wg3tjP7wzGuy57R8pZJ89j63MGJsXzrqzgsGIeVDvzeKI/cfKSFOooraOojaXjgxVVyixCVOHieIAKZhx7We1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537142; c=relaxed/simple;
	bh=M+DzBGorF0x2HwKxbRALu5Mz4okNvOwcKTlN8glrxuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAWcuUdBJ304Nc947QJes8WHEd9ZLVW/uZUIEed+3DRANh98hwdaxrv+3/mo0/8gW7DD4A0t8Uwyv9HhY9tSVxaT07zp5eQEqIAgm7nU6VN69S3zMm/oaursx04zzGdK+lwbx90gauSN7h+6rflUItDUz8L8ovVMC+R0jzgE89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=m8FSUyE/; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537140; x=1790073140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8djAgabF22BDsxfYcNFa72Q6mXnC3doUyHk+thXHzBc=;
  b=m8FSUyE/n4ZHYV0fTcK58iikQDGar5tNIdFtT2Qz6iNygxWNt2rP2F4g
   txp2TToiWRyvBHdxbZkjdSucCRYGbp7WR0TzbxFLXpJtXaORZRjPEv/6W
   zMU7LjvfEC8gwOQe1Bgnsz7XEariVFQo5NrBuhL3WuoghstFiasMLX0WM
   2tmiQG8u4Spd1xr8GhpojuSH7jvBPxvb3Oay7AaE+7ddiob7C6xCI3mem
   uQ2fK/Zgb8a7kPAjHo/A2CsGaRbo5R8xX3eN6FqXv5lG0F/eLGycIiLZ+
   Mx39+0iPZsR2lMidiZna789WMLTtrvrEh/OHaa9EnbERbaUpy1Fbt4Udq
   w==;
X-CSE-ConnectionGUID: yS4WVbWFR6yJ2dUwWAhBOQ==
X-CSE-MsgGUID: +S4Nh2FFTG+yjHzD2ltijQ==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="2475125"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:32:19 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:11130]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.238:2525] with esmtp (Farcaster)
 id 60e16807-4864-46b6-823a-89f1e0206c07; Mon, 22 Sep 2025 10:32:19 +0000 (UTC)
X-Farcaster-Flow-ID: 60e16807-4864-46b6-823a-89f1e0206c07
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:32:18 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 10:32:14 +0000
From: Eliav Farber <farbere@amazon.com>
To: <farbere@amazon.com>, <akpm@linux-foundation.org>,
	<David.Laight@ACULAB.COM>, <arnd@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig
	<hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 6/7 6.12.y] minmax.h: simplify the variants of clamp()
Date: Mon, 22 Sep 2025 10:31:22 +0000
Message-ID: <20250922103123.14538-7-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922103123.14538-1-farbere@amazon.com>
References: <20250922103123.14538-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 495bba17cdf95e9703af1b8ef773c55ef0dfe703 ]

Always pass a 'type' through to __clamp_once(), pass '__auto_type' from
clamp() itself.

The expansion of __types_ok3() is reasonable so it isn't worth the added
complexity of avoiding it when a fixed type is used for all three values.

Link: https://lkml.kernel.org/r/8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 75fb7a6ad4c6..2bbdd5b5e07e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -183,29 +183,29 @@
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
 
-#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({				\
-	__auto_type uval = (val);						\
-	__auto_type ulo = (lo);							\
-	__auto_type uhi = (hi);							\
+#define __clamp_once(type, val, lo, hi, uval, ulo, uhi) ({			\
+	type uval = (val);							\
+	type ulo = (lo);							\
+	type uhi = (hi);							\
 	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
 	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
 	__clamp(uval, ulo, uhi); })
 
-#define __careful_clamp(val, lo, hi) \
-	__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
+#define __careful_clamp(type, val, lo, hi) \
+	__clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
 
 /**
- * clamp - return a value clamped to a given range with strict typechecking
+ * clamp - return a value clamped to a given range with typechecking
  * @val: current value
  * @lo: lowest allowable value
  * @hi: highest allowable value
  *
- * This macro does strict typechecking of @lo/@hi to make sure they are of the
- * same type as @val.  See the unnecessary pointer comparisons.
+ * This macro checks @val/@lo/@hi to make sure they have compatible
+ * signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -217,7 +217,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
+#define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
@@ -230,7 +230,7 @@
  * type and @lo and @hi are literals that will otherwise be assigned a signed
  * integer type.
  */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+#define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
 
 /*
  * Do not check the array parameter using __must_be_array().
-- 
2.47.3


