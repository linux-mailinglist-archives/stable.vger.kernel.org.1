Return-Path: <stable+bounces-76572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD9997AE9C
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A5B1F234E8
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717B1684BE;
	Tue, 17 Sep 2024 10:18:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122313E41D;
	Tue, 17 Sep 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568315; cv=none; b=RtrTqwmo9d4UQ3pJlYTS9ufFglBXwDaxT2/3fj6KW9NLOK4rIchr1TzrAxvpDYfQlk02BkKdYO97SyjLroq85BXw/RWg4b1sT+NbSIdxKiONaanOg0pLSV4J56yQiezKx2nAqcxxUHJh6XEnUV0Ntjaoue7WEeQg018MoKwMa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568315; c=relaxed/simple;
	bh=T2HlKWKOFHe+AjBsWvXEFtdaYNxiWWSa/XFLmo1uKoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IH2kbDggj0H5mI8hbHcB+92yUP0CvCUEFpKej+PGAmCGsi+9oKglYREW2sU7gzydhhHgowKqzho7KzzMhc+XCO1qvnzFLEHkSxQXqtMARo+4k0sUKLc7gwEXV6P21ERnlSsmuA7cFoa/xKW8wVM+pfNpnR0potldyf2eytRl/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 13:18:22 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
CC: Roman Smirnov <r.smirnov@omp.ru>, Mark Brown <broonie@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>, Karina
 Yankevich <k.yankevich@omp.ru>, Sergey Yudin <s.yudin@omp.ru>,
	<lvc-project@linuxtesting.org>, Schspa Shi <schspa@gmail.com>
Subject: [PATCH 5.10] regmap: cache: Add extra parameter check in regcache_init
Date: Tue, 17 Sep 2024 13:17:57 +0300
Message-ID: <20240917101757.83398-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/17/2024 10:02:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 187794 [Sep 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst083.omp.ru:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/17/2024 10:05:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/17/2024 9:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Schspa Shi <schspa@gmail.com>

commit a5201d42e2f8a8e8062103170027840ee372742f upstream.

When num_reg_defaults > 0 but reg_defaults is NULL, there will be a
NULL pointer exception.

Current code has no such usage, but as additional hardening, also
check this to prevent any chance of crashing.

Signed-off-by: Schspa Shi <schspa@gmail.com>
Link: https://lore.kernel.org/r/20220629130951.63040-1-schspa@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7fdd702e564a..5ff79ba665ad 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -133,6 +133,12 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 		return -EINVAL;
 	}
 
+	if (config->num_reg_defaults && !config->reg_defaults) {
+		dev_err(map->dev,
+			"Register defaults number are set without the reg!\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < config->num_reg_defaults; i++)
 		if (config->reg_defaults[i].reg % map->reg_stride)
 			return -EINVAL;
-- 
2.34.1


