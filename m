Return-Path: <stable+bounces-76845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF597DBA1
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 06:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0421C20EFD
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617018489;
	Sat, 21 Sep 2024 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MkFXIxcJ"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015C2CA2
	for <stable@vger.kernel.org>; Sat, 21 Sep 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726892713; cv=none; b=sXd9IIhAhE70+LY1A7t5rji0uZTvqWVR6tFZamAa15+tih5oXQtO6nArNfkxMuIzzMbQ+HqnppfSB7+GYbB1FSRGlJqG1THtSjqghDTAZ8nAYiMP6BvrI4sssFdecbFOAf/kBvDZNwH0+fAx+YZhysxDjJgBNupbaf54DyTVimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726892713; c=relaxed/simple;
	bh=V1PefNuNUX1W8DPxztiGedYQq/5eL0sx159cg3dDBL8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=st1mEJDpjyfRQWfsRFqq+7ftv8IH2QUkW27ZfyIy+DAs1loHVqYtg/ispr7yMDhGB0cD4TXFQIEgTDwcprqk6ePEcrXfZzvQmh9U3HZgpexEbefE5Zam0qcW9O4Bd85jTN+Ltj4IGAgJTB/4iWVEtLM7Pxm+PkPrSXI2ZYosBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MkFXIxcJ; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726892400;
	bh=8k7t2Ri5sXxQ/RAsFjcnWOjPnF0X/aiQc9N7U48LDno=;
	h=From:To:Cc:Subject:Date;
	b=MkFXIxcJRhqZ9pj4eSc3FduybI3l6ubF+4FUO4ij6TZUucWAANPuNXCwiHMoQ4wL4
	 UcN3dT7j2Img1+TePXAEwIyKy9KLuGEkDd04uez6bJwXsRkwZsNGb4Is0G9WbP1EsN
	 v13nRczNRdl/FZM5n5juNz75oxLDRVOCygPhe6fs=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 4F90487B; Sat, 21 Sep 2024 12:19:57 +0800
X-QQ-mid: xmsmtpt1726892397tuimln7vm
Message-ID: <tencent_24E2A9BE4AABB32749444F024DF30F0A2F08@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8tVgdWSpMpXtfIXTBe7Mb+d7bPUz54ayPScihTs5dMkwvNjWb8S
	 0+pU62J79DwaKbLa6198he3QSc5gpZfQWFAKuUTiG5BBjE+VbEuY/RA4ZldKWuMBAZJ/CtfdbVZk
	 Lem/zHtiu+TtwmBIZrZrnEn8zsCJBJglutTphyt8LHnZ/9A1OW6NHEedt43EzLSY0Xi0RwS7HXSI
	 +mc7Re9Ql1899wqFnZyGzeYS+V1k6xqBS4aYKOXfqByzgkYizXEID+Dhp/Blw5z7OudASyHIfy5G
	 JDqjvKVSvRWIcYbhP9P57w91tSKYKKzEqIYhqc3PWz3XfCO1Le9r4CEw5BT8dWYHGMPc9iyn0eSG
	 MppewjZHlEq54qXDPQlauCdDQ+M0nKajM1EiNZwHzEHOU6D6ZJeym12n+PISLhfb/qhF8MpvYgVI
	 VJYRC/RTxq7VUtQNQG4zq32Cq0DY35lP7twm532Bcdq9vddP5mp5B+4KRL7cv0JwDpdOnbv/p5Q7
	 OEABkcaIlFNIl1tlPrUgMi0JYZXTJatTO4G7YFoYtGt97nzKttOnlpbr7BrsM+pQHvYc1YqMvbf1
	 8Ouhab2XZoxk/IJr2LjtcYeJkncc88ssfz8UBXvC3mL48DhODoLKA7IoCC9D1yo0nti/X7wIvb35
	 q9bRUAgh8rPzb5rxj3F0/RJtYDu1CVOY4kEgHW8tjVAEOMNiSnuqT+nI39Sf+y1XWG4QtgrsIcOj
	 PV3bBaRVAwFfE8EtAP/s+saP/quQwQgQwubRV+09zk4AMnaU9QsWhj0qOD3JTRuERD5xgYL0PhRn
	 dYhaI7Y7+RsjqVStL2fAF3fOO0LYIVq8Uw7tfqkeliq3zyG5NaN3KB3mxqB2CPVvApm/EfnWugcm
	 8pn3mMqKGX0a0tKyTwel5CB1eIGvsxK2QxzWG81ailnB+qd0FHK3NVyvgX0nW5dt+NaBKngd2H6c
	 4WEEs3Yso5UsK9NIvlpHYIrVtxAv10zF5N0sl+qlSG6h9ybuiqKTSCO0Xe0c6qAlwm6aXZE4H+nu
	 vEbt0acY8FV882T4Zj
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: yejiawei@bit.edu.cn
Cc: stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Sat, 21 Sep 2024 04:19:56 +0000
X-OQ-MSGID: <20240921041956.3315644-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `mac802154_scan_worker` function, the `scan_req->type` field was
accessed after the RCU read-side critical section was unlocked. According
to RCU usage rules, this is illegal and can lead to unpredictable
behavior, such as accessing memory that has been updated or causing
use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the `scan_req->type` value is now stored in a local
variable `scan_req_type` while still within the RCU read-side critical
section. The `scan_req_type` is then used after the RCU lock is released,
ensuring that the type value is safely accessed without violating RCU
rules.

Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: stable@vger.kernel.org
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changelog:

v1->v2: -Repositioned the enum nl802154_scan_types scan_req_type
declaration between struct cfg802154_scan_request *scan_req and struct
ieee802154_sub_if_data *sdata to comply with the reverse Christmas tree
rule.
---
 net/mac802154/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 1c0eeaa76560..a6dab3cc3ad8 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -176,6 +176,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, scan_work.work);
 	struct cfg802154_scan_request *scan_req;
+	enum nl802154_scan_types scan_req_type;
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
@@ -209,6 +210,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	}
 
 	wpan_phy = scan_req->wpan_phy;
+	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
 
 	/* Look for the next valid chan */
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,
-- 
2.34.1


