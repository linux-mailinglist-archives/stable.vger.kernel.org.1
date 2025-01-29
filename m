Return-Path: <stable+bounces-111081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F12A218AA
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787B33A10EB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00A19CC22;
	Wed, 29 Jan 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="WO0Qnr8c"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD019D07C
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138172; cv=none; b=QuFtooxT74UPFoyPURLZRtJEyGF4O6aJX6jLXG3nrdIih984Ag0Gm8j8htQ4YWsnNllDLUOBL4/LxzYCQZGTkFZRR43tE6X+8i8nOTNCq7d9drGVqIb4AYqzruAC+z+n7uxGFDjmppdatoc+BEdU4Mg42vHApNwNgcS5HFZB6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138172; c=relaxed/simple;
	bh=F8UzenNvcxrU6PrgPRkJBbE3wiZY/7H8B8YovLYytaA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b6RqPZ9s+bCKesQHLB+zUsUaTd0P2jCsgmNNlz05cFGF6VxzsQqatTAdB5qPc+WZuO5RLTNAmx2OJToVo4w58oc7A8mOP73rwInw3kpxMqRO6wUUJWDX1MpOYzvxd7mGOVb80xDMNE40/Rim4IbGdkcMU1XAGUHeRzJCPfyNEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=WO0Qnr8c; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50T89QlJ001438-50T89QlL001438
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 29 Jan 2025 11:09:26 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:09:26 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 29 Jan 2025 11:09:26 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject:
Thread-Index: AQHbciUc8udurk4dw0KCuAc3ujXXRA==
Date: Wed, 29 Jan 2025 08:09:26 +0000
Message-ID: <20250129080918.30210-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/28/2025 10:00:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=SmcCa4w34qV7YF0am9bGRHiFe7EZIOnXDy605dggeTY=;
 b=WO0Qnr8cpJ9m/eOmsLITDFuPr+fiQjwgIP3kf8ttFiaOLs7iLM8kjWYilb77s0zmocqShlzFhrRF
	rX/mVz0rBGm1GO1JpdqPOeIUs7u07ESG3/KELADNwvf32dwjH94DZ2wYUhrRC+YEFlOXzG1QYVk/
	SR8lCwx0gKo+85IeGAHWg+CAIi8ceMse5LC4VMqxq1E4HA5B/4SluPAeficF1ZS10H2dlWcsITP2
	BpusdJj5BbwMKmTPGqnGvYnKeKMRcmoRy3vO5h/efh66/eFe2r+DQioMM/VCrp2awJFUj1nes46Q
	FvmvaIdJRAA2Y0DAw/Wec1RJ2tyG5M03T+KpUw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Subject: [PATCH] hwmon: Use 64-bit arithmetic instead of 32-bit

Add suffix ULL to constant 500 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression PCC_NUM_RETRIES * pcc_chan->latency, which at
preprocessing time translates to pcc_chan->latency; is currently
being evaluated using 32-bit arithmetic.

This is similar to commit b52f45110502=20
("ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit")

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/hwmon/xgene-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922..43a08ddb964b 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -61,7 +61,7 @@
  * Arbitrary retries in case the remote processor is slow to respond
  * to PCC commands
  */
-#define PCC_NUM_RETRIES			500
+#define PCC_NUM_RETRIES			500ULL
=20
 #define ASYNC_MSG_FIFO_SIZE		16
 #define MBOX_OP_TIMEOUTMS		1000
--=20
2.43.0

