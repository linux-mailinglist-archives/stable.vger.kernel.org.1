Return-Path: <stable+bounces-179392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18BB5569A
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC4567C9B
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44133A01D;
	Fri, 12 Sep 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="V99w5nmo"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE033471C;
	Fri, 12 Sep 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703351; cv=none; b=OnsWIz81QT/w0UKkN/p3oYRPPHYGmBMf+gCgJIBhgthcT1UuhPUwPKdsWGpGel0mhWZMGB04OLToXNcFH/wExeIag25SKSsxD8xqi+jAhYMB6FbpWiFcz2YnkYKIFj7d/GZyL/Kyf6NnOpAXBHnXPjwhTXwGE78huWF/B2HdPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703351; c=relaxed/simple;
	bh=4J4nVzSnRDQl6Hi05144Vtqwbow4HJsgS5XQf7jSKTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgWNGmX/Gwhh0RuNref/K265DPyCKV7MoTomxdXSzLOkB2ATo9CBLFNx3HXW+ZQvG/IOW0fDelyvwZ/57oIvEvujIpnJG9dXntDup4/rrGFSbSxnnOlDDeUa5gfNiIK7MRGwxsXUdkHB6o/eDoJZVrIHf+JLBwnt4PcxXlc+uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=V99w5nmo; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757703349; x=1789239349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+E0SdUe2btJke4ZdaxwfLgznsTubVaVloEsW/aNSzW0=;
  b=V99w5nmokYQaTY+OqgMf3vujA1xvntHkPEMJokmwl2eE3fywHzbeARse
   DzjRTfSep1ZaGSswR1e6VGmYVphowmDFL4yzbJ7lxZC/MC+SLPKbTrOpi
   tVxEJ1zxlBM5zvlhmxV/xSqKlsvYHfdIsaW/9SlNtXGly95kKQUiA5fxn
   1by9g5zEr3rxSxlUjMY0YYbxKpgXnRExlv+ohkK9CofQQHyVYGllJp4T9
   D8/FAiv4v17RrW7YUv4MjW3P3zk4NbGn9EK/yxesPwU9BfVKvzacfssrH
   a+N8g7tl3GQlVnmRiyr8+IwxfBmcIN2C02SIHJwoTeoR4Ev9L8C7BQ+5/
   Q==;
X-CSE-ConnectionGUID: QNbQIGb3QYK5qURAxOcSyw==
X-CSE-MsgGUID: MUJ4iccQTvWZJY/GQLcDHg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2039083"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 18:55:38 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:1578]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.95:2525] with esmtp (Farcaster)
 id 20a6b850-51c5-43a1-88cd-70e7bf45333a; Fri, 12 Sep 2025 18:55:37 +0000 (UTC)
X-Farcaster-Flow-ID: 20a6b850-51c5-43a1-88cd-70e7bf45333a
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 18:55:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 18:55:31 +0000
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
Subject: [PATCH v3 1/4 5.10.y] overflow: Correct check_shl_overflow() comment
Date: Fri, 12 Sep 2025 18:55:13 +0000
Message-ID: <20250912185518.39980-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912185518.39980-1-farbere@amazon.com>
References: <20250912185518.39980-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
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


