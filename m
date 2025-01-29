Return-Path: <stable+bounces-111080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E5A218A3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B21E161B36
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575619A28D;
	Wed, 29 Jan 2025 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="nVVThU8d"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532A193084
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138130; cv=none; b=CkaSuWOPPDJTxfz4t/He5CPv6JewwprKlYtzL29+IQtuO5y90oaFIWjbcIxYzH2c/xSbFr+dfNbxO4J31d8sNqcLCAyf/Q2NkBVBRd/W/efJGf2SESGMEXlptNPtZ49020SR0toJyoMnNkmo1kNhcIBWVUspc+JCS9YvsYVroDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138130; c=relaxed/simple;
	bh=S032GrX1Rk0WozHVNrJoPwdgahdXbXlWdo4zYMKndVk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bRJO2kLTvJp0pvYzeS1CZAm318lM1tHRyURH/DcVnkZfomxwDPatHlGiwTu8In3p5HlE7cwbkIDziSmtNV92xWWtrExIpe/rWx1Mz8MnQSX29MixOEQ8amStKAXUdbMh90XqOZAoNqB/7xDZbOCWKOJrSroPqKr04UqQ+4yRPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=nVVThU8d; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 50T88gxv032602-50T88gxx032602
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 29 Jan 2025 11:08:42 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:08:41 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 29 Jan 2025 11:08:41 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] hwmon: Use 64-bit arithmetic instead of 32-bit
Thread-Topic: [PATCH] hwmon: Use 64-bit arithmetic instead of 32-bit
Thread-Index: AQHbciUCSFTlqbW5SU6WUUjKlCKaBA==
Date: Wed, 29 Jan 2025 08:08:41 +0000
Message-ID: <20250129080836.29986-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
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
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=/u8Z2B1i1G2MsGUxKsxzUUF8hmyhVxNkNeP0nG+kJsU=;
 b=nVVThU8d7+YgZe3sOS+BzO7uM0VqPte84E1zIUkvHHX9XeIa/fB4BatszeWt+yKrfVYIgoJJUzCq
	lPzhUqZstiKphy3DEiocLZA1qdC8KMj0dA8Cb7X75o1u0mT4z3/qEjXxh9yhlEZslPkm/dNbow+d
	j/1GPLNE03oJ2cDgz2Lyr6iyyzjMPthJ3XPQIpBax0h46xLEY3QgxIWBxUgaC2K6MTIAvB+UsubZ
	jv7S7mdwIv6XSbPXu9U46N5D1YTSCw0Jic/s9/6NrLfS6hwcuUWrtlngaynHDEKjdX/uyuTcfxia
	jWkDp3A+t6yuMkjO7anxUAG9GT7otzSKtle2Zw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Add suffix ULL to constant 500 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression PCC_NUM_RETRIES * cppc_ss->latency, which at
preprocessing time translates to cppc_ss->latency; is currently
being evaluated using 32-bit arithmetic.

This is similar to commit b52f45110502 ("ACPI / CPPC: Use 64-bit
arithmetic instead of 32-bit")

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

