Return-Path: <stable+bounces-181979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8EBAA539
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 20:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C8B3ABE4C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EB23BF9F;
	Mon, 29 Sep 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="spFQ+H8M"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555119F13F;
	Mon, 29 Sep 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170892; cv=none; b=DL4g2rsdOt5LlYKJVGt4uUba1+tWZHceC2hw5qIVe0IzNtdcbEH4k8zhKkoS1Rrxf5aiuYM5k3Xm8hfijZURUWByj5UlSM8wBJiB55PNFW/kRRgswmNiQmiUu32WVLIYf2Xkb3g3AeMt+TNZGVX31LUa0bLeFCkEX+NOw7YRzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170892; c=relaxed/simple;
	bh=nlvxYaLaWRNdcmYPv9KL9mUJqKtD+ww79dSJfh94FPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWwzsIEhKvSQhYFNNc+R1m5e5LJCiUIVRyT2SS3L1rE+CjzeGWGJ4NrHDBkCLuT3I/5QrDg8WEOsGSYcmBls4VUFWLU4K7UvNp85V04rBe/iSgrrNCnB44InGIugAZb/M9ip5IszBxgQyfupnMhayFj2IDGbY4/u9Erh6plil9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=spFQ+H8M; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759170890; x=1790706890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgKTaT7jj0zRx6jbQ7DJOMsaZramokk9q66dhz8aLl4=;
  b=spFQ+H8MV2pLUf3OVrD2vjFmC/LZLv3vuC+mUiesndN7MxB7e6/KY3dg
   6yTjDwu5HnFlneYxKKz6rEYSAlMKWDdDewLNRl7INzRK3Y1xsXbD0y7Ff
   Lg7KaJvMeKh63AEvk//MfRalMGFslGvbYJA7Cxu3B1w5yfWwm5DtP4MDw
   Vlnj16FmJGbrU8/d/pDHyc8UH+NnpQFVbaA5fRhZBepAww9SHTVDkrETH
   tT+RpUkdVaiH/w0ijdVezuOI1936HNf74BGR9pn+NbltmJ1cRmhNzkJZ7
   Rh9FeegtumI7guNV9J16M4sbTeiBnZJ4GdSqpTrquj/bs0Y9oT4eBUzPp
   Q==;
X-CSE-ConnectionGUID: oH59tiyhRbuNX2Bqws6aLg==
X-CSE-MsgGUID: kGJppDcGQZ6xA8DIhzRm5g==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2844789"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:34:45 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:28413]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.147:2525] with esmtp (Farcaster)
 id 872860a2-efde-412c-9e1d-133674d4e8ca; Mon, 29 Sep 2025 18:34:44 +0000 (UTC)
X-Farcaster-Flow-ID: 872860a2-efde-412c-9e1d-133674d4e8ca
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 18:34:44 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 29 Sep 2025
 18:34:41 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <David.Laight@ACULAB.COM>,
	<arnd@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<farbere@amazon.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, David Laight
	<David.Laight@aculab.com>
Subject: [PATCH v2 06/13 6.1.y] minmax: fix up min3() and max3() too
Date: Mon, 29 Sep 2025 18:33:51 +0000
Message-ID: <20250929183358.18982-7-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250929183358.18982-1-farbere@amazon.com>
References: <20250929183358.18982-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 21b136cc63d2a9ddd60d4699552b69c214b32964 ]

David Laight pointed out that we should deal with the min3() and max3()
mess too, which still does excessive expansion.

And our current macros are actually rather broken.

In particular, the macros did this:

  #define min3(x, y, z) min((typeof(x))min(x, y), z)
  #define max3(x, y, z) max((typeof(x))max(x, y), z)

and that not only is a nested expansion of possibly very complex
arguments with all that involves, the typing with that "typeof()" cast
is completely wrong.

For example, imagine what happens in max3() if 'x' happens to be a
'unsigned char', but 'y' and 'z' are 'unsigned long'.  The types are
compatible, and there's no warning - but the result is just random
garbage.

No, I don't think we've ever hit that issue in practice, but since we
now have sane infrastructure for doing this right, let's just use it.
It fixes any excessive expansion, and also avoids these kinds of broken
type issues.

Requested-by: David Laight <David.Laight@aculab.com>
Acked-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 41da6f85a407..98008dd92153 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -152,13 +152,20 @@
 #define umax(x, y)	\
 	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
+#define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
+	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
+	BUILD_BUG_ON_MSG(!__types_ok3(x,y,z,ux,uy,uz),			\
+		#op"3("#x", "#y", "#z") signedness error");		\
+	__cmp(op, ux, __cmp(op, uy, uz)); })
+
 /**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
  * @z: third value
  */
-#define min3(x, y, z) min((typeof(x))min(x, y), z)
+#define min3(x, y, z) \
+	__careful_op3(min, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_ID(z_))
 
 /**
  * max3 - return maximum of three values
@@ -166,7 +173,8 @@
  * @y: second value
  * @z: third value
  */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
+#define max3(x, y, z) \
+	__careful_op3(max, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_ID(z_))
 
 /**
  * min_not_zero - return the minimum that is _not_ zero, unless both are zero
-- 
2.47.3


