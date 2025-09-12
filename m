Return-Path: <stable+bounces-179379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94570B553A3
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61435BA3885
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330531354D;
	Fri, 12 Sep 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="moN7IVQb"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C179312817;
	Fri, 12 Sep 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691083; cv=none; b=F5GmoTf5bZ9xBWXbh14Y5vp/wPjZdiKMQfHkdaP0j7As5hIy9Ah3bh7St5o9+7t2sGaygjV9JVJCKz6GsDPuGXnlDnchyrbVif2Zq0ii47iExMUz+8HS5jEXmmee6mG1rKWQIiK82tNpTAO4Yra0FhdMTBInCKtW2E+NWkL2s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691083; c=relaxed/simple;
	bh=4J4nVzSnRDQl6Hi05144Vtqwbow4HJsgS5XQf7jSKTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8Y7CR3QAGwffglBTg85vMtkyymVTEu7DwHXGw3qa2dyOYA+I2hFJKAUMolLqkcplA6d2VsBVBdG2fbx9umjNN1fCdqR4s9S5AVKXF1e5WnNuRm/3JeoGkEMvO0XWFVyvJsLj5PoucJxPvDEe38fbtym2rFAMbXwnPX1Pmt3FJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=moN7IVQb; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691081; x=1789227081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+E0SdUe2btJke4ZdaxwfLgznsTubVaVloEsW/aNSzW0=;
  b=moN7IVQbu6rbKhPpGncnafYAiv43qHm/56lI4emJ+K08yA9q7mZw3mER
   qY/GxYxJcf3qecDNsWNpRmDUYoTjD6V1Kecj+vycL5ecLNezev9ulPbDM
   SMegRPIrNDo57vfVyPEONzKXG+g4N8khJahyHQv8TgE2fEtNfsl1PwpPq
   4m+1nZQ93kwav+dT+I2o630TuEEsaLuZmy6PMP+k34xRlIHfqOHhjvYZL
   oZwaJigSBrY+obN8ltk3vgtDwQ3WOk2RZetTplf/KhuA4V/SW2thnqKgg
   p1mAqOFEF6pEbW7s11DmKilyoCzjU4EhAxjhfPy9ALs/w9Cc6GVUnNxhv
   w==;
X-CSE-ConnectionGUID: CnjIj+YCQ0e8vSol35abSA==
X-CSE-MsgGUID: bs2gU8rKRsWu9ERM/B6h1Q==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1926584"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:31:00 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:12620]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.26:2525] with esmtp (Farcaster)
 id adc671f3-5191-4921-8b24-21cc0a914c45; Fri, 12 Sep 2025 15:30:59 +0000 (UTC)
X-Farcaster-Flow-ID: adc671f3-5191-4921-8b24-21cc0a914c45
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:30:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 15:30:52 +0000
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
Subject: [PATCH v2 1/4 5.10.y] overflow: Correct check_shl_overflow() comment
Date: Fri, 12 Sep 2025 15:30:35 +0000
Message-ID: <20250912153040.26691-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912153040.26691-1-farbere@amazon.com>
References: <20250912153040.26691-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4578be130a6470d85ff05b13b75a00e6224eeeeb ]

A 'false' return means the value was safely set, so the comment should
say 'true' for when it is not considered safe.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
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


