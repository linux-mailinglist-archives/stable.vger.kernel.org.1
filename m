Return-Path: <stable+bounces-111082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA6A218AD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8527A134F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFC194096;
	Wed, 29 Jan 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="Y/rqoEob"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66012F29
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138280; cv=none; b=u7wNwYP5fs8Uc6XrxPUpHrKZMPeLZO3J57udrzMvTGRLiDoUedzNsN2yg0SlFieXgA3zVe/YVkOt/VrDPM1iQapIyaiGYtLPXA2tMRy87DCbzEzObX0mVOr308gkPi8y3L4LtQjJwuorYJPKa5CtVbeEgzvzpehbb6vqWzlnlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138280; c=relaxed/simple;
	bh=h2r953js5KMe/res5ngDhGH2T4wfjVJi31+pTjx2Bs8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b6q556i10qvAFmw7/KYCDkEmzdhCPaHERkZwYkN66kJjJXCjbbQSJCWqNF0LIMznsfRJNmrppwvUqv1+5T9FUx8gMMV3HqI8UXyI9Q0mQdRrJbu0VPyD+EpfVepg1iFUcp8EdhxNcukGmrr63vPD0yzeOnCpeosnqwHV5yMlGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Y/rqoEob; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50T8BDe1004712-50T8BDe3004712
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 29 Jan 2025 11:11:13 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:11:12 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 29 Jan 2025 11:11:12 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] hwmon: Use 64-bit arithmetic instead of 32-bit
Thread-Topic: [PATCH] hwmon: Use 64-bit arithmetic instead of 32-bit
Thread-Index: AQHbciVcdn0QuV8dnkKbJfGDJgSg+A==
Date: Wed, 29 Jan 2025 08:11:12 +0000
Message-ID: <20250129081107.30617-1-a.vatoropin@crpt.ru>
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
 bh=nH+fCocC71NvxcKmnj5F8xJxc2NZj7A/PmZ+0JCxCps=;
 b=Y/rqoEob8jyxCghVUGvDBZZ6PVrZ2sU2wpyDS/4da22/bcX684iv2jDVSO8knnztwRc2PBw2w/D7
	dAwhEYqY0eJTG+xmRLhv3+A8t30j7oYyUIhAwwEySwi0wB2sInApSqlAvHoslgTsPx2qGCFG0ovs
	S71KU4rUSEcnenEua91VgjFeJbo67TB53NIbhGC5i3cZeYcIIt3CxSprRfPDsqFBAEJlv+OrS60U
	k0J1VvzGOF+rdoYuHouJdLWHU0zbDdDidMfoI5ni7ks0YKlrZ8r77kJahPZSL1sCEmP/pKMcR/7S
	PxHtAEVTHZM6xKtoDQsF5GZssg0mUXR7w1nKeg==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

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

