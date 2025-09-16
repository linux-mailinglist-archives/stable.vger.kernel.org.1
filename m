Return-Path: <stable+bounces-179758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C826EB5A403
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884A7485C60
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1B27AC3E;
	Tue, 16 Sep 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="M/gP6cZ0"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A531BCA4;
	Tue, 16 Sep 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058326; cv=none; b=jnQiXjRuTTnXybaO3nrxgRsBiafXs1xjlbbRaVAcabX0EbJ6gNShjdpAQIMYSKXSFOClVq461NMfQbGad4RdFhUWEegYq4BrGwlsjJjlrwZCABTQUL2QzTaJUXFzFMpWWNqorfyDQHnNw7cqG+K+WWldh9fiN2vl0gOWPdOE+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058326; c=relaxed/simple;
	bh=xAyJyvI3Chdm0LibZ0qZvePCJKD//koP1PX+zfGnUyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hy+IfXRdVZ9VTqVDJpGmSuNEzj2sclXWo+c5M6bsaG1ww0BZ9Xo0hb0fpB8Pb3Of/RvXjua0XCIxO2wyVAdbOkjtEjkczpwAAZAIutEPSjjBsOUpTvvUZ1IZgT3+0Av3l/Pa4UO3k09W9Bn1Bo/lBgIjWhPUabtfKXS7RQxz11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=M/gP6cZ0; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758058324; x=1789594324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4aJJPYONPd+kj3l3iGncjKsidkoAi36aQ8s7TgvVC6s=;
  b=M/gP6cZ0FRPve94MA9ZJNQ/9EDB2vzh5djIiZJ0U1YA3ulD18g1cWN3S
   3zonJifRAVJ79KcEmVvyVP+y24v2ieudcLcnR1XBnifCVGlzH9ZjAhkz6
   NUWi2uomSj9x5xdfdM/6lAa2thTUS2CFA5NAflWv9diuCl6hOn8XBcLu9
   z2YQF36A205bBZ/dYFsaK+olBrAqu2WEtwSOzhg1NhDI2nhF1CdB7z8E3
   Al83/gEtXQsjhdJVzEgoFsMXbseeqiSJ68MEQDulrJG+eMF2wj2PURODx
   KvoWd9ivT/H7eCSz5+Iv4pbXoMCWFW+W/YNtnsa6qly/lYma8iUv6mvAi
   g==;
X-CSE-ConnectionGUID: 2iyve+uIQ5GAUjP7fEzvWw==
X-CSE-MsgGUID: DisTkKPqQp+NRl2B8PauVA==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2107650"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:32:01 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:10913]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.68:2525] with esmtp (Farcaster)
 id e5138796-ffee-4094-98a2-1235ad90a042; Tue, 16 Sep 2025 21:32:00 +0000 (UTC)
X-Farcaster-Flow-ID: e5138796-ffee-4094-98a2-1235ad90a042
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:32:00 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:31:55 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>, <sj@kernel.org>,
	<David.Laight@ACULAB.COM>, <Jason@zx2c4.com>,
	<andriy.shevchenko@linux.intel.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-sparse@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, <stable@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>
Subject: [PATCH 6/7 5.10.y] minmax: allow comparisons of 'int' against 'unsigned char/short'
Date: Tue, 16 Sep 2025 21:31:49 +0000
Message-ID: <20250916213149.9637-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

commit 4ead534fba42fc4fd41163297528d2aa731cd121 upstream.

Since 'unsigned char/short' get promoted to 'signed int' it is safe to
compare them against an 'int' value.

Link: https://lkml.kernel.org/r/8732ef5f809c47c28a7be47c938b28d4@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4ead534fba42fc4fd41163297528d2aa731cd121)
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 501fab582d68..f76b7145fc11 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -25,8 +25,9 @@
 	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
 		is_signed_type(typeof(x)), 0)
 
-#define __types_ok(x, y) \
-	(__is_signed(x) == __is_signed(y))
+#define __types_ok(x, y) 			\
+	(__is_signed(x) == __is_signed(y) ||	\
+		__is_signed((x) + 0) == __is_signed((y) + 0))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
-- 
2.47.3


