Return-Path: <stable+bounces-181985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A9BAA593
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D591F17A571
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033828642A;
	Mon, 29 Sep 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="onzkDrX1"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE2262808;
	Mon, 29 Sep 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170924; cv=none; b=HS79chnCA4w0ojlgY/hItis5uGOsAy+Y5+5jxeelcYZ8HIIkxgQ7oSWCkoTw9gPl2QUPoPDHxi44C2CyU+W9dfzzqm7AU6K6en+oLk5It9vQzfxiC/2hufWqCCyVZ0e+joJklxAMIs4oIuSryzIbJcE5VGR01cFpydsi+FkumjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170924; c=relaxed/simple;
	bh=bSiDtvnimcgo6Y3knq8+w917eJDspbmoX3a4FcQGX4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBK88IONvT1NbBDykuC+Apj2woj8JiGKvynUFT7Hxqut5wSlwa++WTlSqCXhhzhNkN7fwKq5wupnZMSW1WIfjToShBtDqQz+KtW5leV6q9KidqmLp8e39KAV51tKGVA8RhyVH28qz9vQB7shC8IXCUQSk8INNAx0L6AYsMzaZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=onzkDrX1; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759170923; x=1790706923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4cCFbpHvYq8yWCMIbT6T5sZXi6GGX+iNVIOVWCWFxY=;
  b=onzkDrX1tv/WEXCkNCPC97tqZ2irM4C9eebiuhJZOhmfITrcnmscGRXQ
   yLbPgk0qFJoMypZ02XFao+qMfFKvW76S1TpnxRc+s+I8YnJxl9OOrmRzD
   FdTEuz43bp3ZW8Ys9jApY3O0xvaDgmVyfhS/FVpnQMtmmVz4q0BxXwizO
   3OAtq0sADAc7butOKVSD6eDUWbf31UAflQ+fVClM1+Zi7RGMp5tC7+5A+
   u3vr+wN9ZWmhJ7SgwDDd/gy+30Tr3DAxcPNTrYK8dScaIymIYuZ/duBzh
   OEwv98ShPWikQ2NXBRXbwopD6diF3FgVepPI0RByiD5phOHgOVJXDnEvi
   A==;
X-CSE-ConnectionGUID: l8NOXzGfQ9OUhXXoTmBnOw==
X-CSE-MsgGUID: XCF7IKnGRcSswoF4RbMVIQ==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2841839"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:35:20 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:1890]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.16:2525] with esmtp (Farcaster)
 id 6c916bae-d1bb-413e-bc29-3b3e02d2ef2a; Mon, 29 Sep 2025 18:35:20 +0000 (UTC)
X-Farcaster-Flow-ID: 6c916bae-d1bb-413e-bc29-3b3e02d2ef2a
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 18:35:20 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 29 Sep 2025
 18:35:15 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <David.Laight@ACULAB.COM>,
	<arnd@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<farbere@amazon.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig
	<hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 10/13 6.1.y] minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
Date: Mon, 29 Sep 2025 18:33:55 +0000
Message-ID: <20250929183358.18982-11-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit a5743f32baec4728711bbc01d6ac2b33d4c67040 ]

Use BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...) for the sanity check
of the bounds in clamp().  Gives better error coverage and one less
expansion of the arguments.

Link: https://lkml.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com
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
 include/linux/minmax.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 6f7ea669d305..91aa1b90c1bb 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -106,8 +106,7 @@
 	__auto_type uval = (val);						\
 	__auto_type ulo = (lo);							\
 	__auto_type uhi = (hi);							\
-	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
-			(lo) <= (hi), true),					\
+	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
 	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
-- 
2.47.3


