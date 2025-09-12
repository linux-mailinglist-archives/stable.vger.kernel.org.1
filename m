Return-Path: <stable+bounces-179358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8164B54EA1
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE44B630FC
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C42309DB5;
	Fri, 12 Sep 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bVhrkJOm"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B3305079;
	Fri, 12 Sep 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681800; cv=none; b=IMbFVElhGvHN6u4eo8Jolk7Cvou+qIsV6rb4EKOH/o7nDYq75m+rvJIOoV50KSEQA488T5LbMjhocSh2+Kc77StSE1SbTBVBv1V+dpgq3gyyMOKVb86SygEzaAL6MiR5pw25ydzVPjKZrGkTtdRrV8DRFSPwhOjHFblkWMouhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681800; c=relaxed/simple;
	bh=rNEuTJdGvb53iWCh3gQ4DB6yH3hHITEJ+g43y1RCJmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQ/G8mgr9DuZw5SEibC6nlSKVK2GCgYImp9eMrrfIVAgcWoGh22TjKze2zCIHdPJpscwX1t5bLPhNZcVqYhQtVTWV65d3t8xOwZlRQ8q3l2xI4stZUYD005/NLbsaCOe7PapPwEPAdHQ9gE8b2GQR2DwUGLvtKdr+h7Jh5XTM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bVhrkJOm; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757681798; x=1789217798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xp984FdbcHoEGhiR9gh4tur1oqr0Sh4+pzFALfMqSC4=;
  b=bVhrkJOmeSIiDbNxvxDlMilmCHi+W4gLWbUoKlx1UGA8RPmtpIzEdd84
   UGLzFjQlmyIp8p9+ysuSTRbu6CEXfc1UaO81N4OTy7ibsKeoThxaTJIEP
   XRQVgPHYtphJ5Vv76veHleM7rgUYSpqca2m2Yyx/Kf8H5F7pEL/FAclkY
   Hg6BIMIOQ7FIVSTfX+y4YL0mkorni5QTO+BHRB1b3Z6TlOmVtlACofPBz
   d3NOVgmCHKhTVT8bqp0MAmSirdsh8U5L4pp60AXRGqnEgAzVYFj4Vv5Be
   4t58sx4Py9S5jNX26aflKBMTPf2VY9GeEjstTX2+UtVmuCfP15EPguhnw
   A==;
X-CSE-ConnectionGUID: X10yDwi6TgiUpRmoGLpiQQ==
X-CSE-MsgGUID: 3QvjZYoGQiWJRIHL9Cdn0g==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2020371"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 12:56:27 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:23913]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.107:2525] with esmtp (Farcaster)
 id 138c3595-7e63-4a87-91bc-27777f485fde; Fri, 12 Sep 2025 12:56:27 +0000 (UTC)
X-Farcaster-Flow-ID: 138c3595-7e63-4a87-91bc-27777f485fde
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 12:56:25 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 12:56:19 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<natechancellor@gmail.com>, <ndesaulniers@google.com>,
	<keescook@chromium.org>, <sashal@kernel.org>, <akpm@linux-foundation.org>,
	<ojeda@kernel.org>, <elver@google.com>, <gregkh@linuxfoundation.org>,
	<kbusch@kernel.org>, <sj@kernel.org>, <bvanassche@acm.org>,
	<leon@kernel.org>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <clang-built-linux@googlegroups.com>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 1/4 5.10.y] overflow: Correct check_shl_overflow() comment
Date: Fri, 12 Sep 2025 12:56:02 +0000
Message-ID: <20250912125606.13262-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912125606.13262-1-farbere@amazon.com>
References: <20250912125606.13262-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4578be130a6470d85ff05b13b75a00e6224eeeeb ]

A 'false' return means the value was safely set, so the comment should
say 'true' for when it is not considered safe.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper")
Link: https://lore.kernel.org/r/20210401160629.1941787-1-kbusch@kernel.org
---
 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 35af574d006f..d1dd039fe1c3 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -235,7 +235,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * - 'a << s' sets the sign bit, if any, in '*d'.
  *
  * '*d' will hold the results of the attempted shift, but is not
- * considered "safe for use" if false is returned.
+ * considered "safe for use" if true is returned.
  */
 #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
-- 
2.47.3


