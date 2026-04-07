Return-Path: <stable+bounces-233500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC+EGHKk1GmkwAcAu9opvQ
	(envelope-from <stable+bounces-233500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:30:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00A73AA492
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27FFE300832B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE937E2E0;
	Tue,  7 Apr 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="YA0hoaHD"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F427386C19
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543406; cv=none; b=Ar4PMZmzil0XRiW/LIK419eFibPVLz0zGm6Mi/QJ1XHmsqkCn8/bd39Jg8qlT33Af3s0u89BXsBxKnYoghX7PMG4/ZJ5OHkTic4W8qysovffkMA9ZZeZ0JpG/ZkUr1RkZMef0EjC79k4joEQSoe1aqXbERpJPJVf/ke5HBSSs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543406; c=relaxed/simple;
	bh=MX9vmaM1vsHQf1dVwps+VV1p8+tNw7VrLp36WgpOUic=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GYixEQgB8lHFZ5BLE63SUF5ZuXIQxh9ewnfrtCtnLaaXj1LT7cqmiYfwFuO8d1rane1EPlIJe7IVCNo2EUAWxXgHLMP2oxJhdApYZLDvAQ5G8VYatGFW331WbQDl6t0bBcg1/s2a5hTxwb/cY+DzkQ+B17PaQfZE9tb3OSXlxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=YA0hoaHD; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] scsi: target: Add a check to prevent the use of a NULL
 pointer
Thread-Topic: [PATCH] scsi: target: Add a check to prevent the use of a NULL
 pointer
Thread-Index: AQHcxlXTYrgrTlkH5UuZ399PSNuFqg==
Date: Tue, 7 Apr 2026 06:14:44 +0000
Message-ID: <20260407061358.10274-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 4/6/2026 10:37:00 PM
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=dqTvHvdpCcYQcBQ5wNDU9UKjodEysP7VET1PsAnDFyI=;
 b=YA0hoaHD8hKoDCy9EFTWDBWjUpkXtH1IfPRbc/KKdJOWjaKTS1HZBlF+wvj0YRBaKuZ7T6YCSPZ4
	WaAgfhjUr7Ul5nEghbu3vN4cdfHMEnfTm5NDlwfuzPe5OJIFL7EEgdC9U+3JI4SC//hRzz/hEf+l
	DLDv5JyMiC6+LWbhHL3stZjLYOeZMObNx/RhO335wdwHev91939ii5GIJQadZjBCpHDjFqKA3CNC
	kou4Ww0UHEwAY1HjbZ/2UjJx5Rd1Yvkshj5BxgZiX3BhQWtc1pH1GP57BOO6jsGtLIkUv8HSwfZJ
	uehJMR1G9wuTjCB2iBXkv0eknENmCBtR7fgpAw==
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[crpt.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[crpt.ru:s=crpt.ru];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233500-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.vatoropin@crpt.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[crpt.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: D00A73AA492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Some functions accept a string input parameter, which is then passed to
strscpy(). If strscpy() returns zero the (len > 0) branch is not taken and
`stripped` remains NULL. The subsequent check (len < 0 || len >
INQUIRY_VENDOR_LEN) does not catch this case, allowing a NULL `stripped`
pointer to be passed to target_check_inquiry_data().

Therefore, the existing checks are insufficient to prevent the use of a
NULL pointer when an empty string is passed.

Add exclusion of zero-length strings to avoid dereferencing a NULL
`stripped` pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Fixes: 54a6f3f6a43c ("scsi: target: add device vendor_id configfs attribute=
")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/target/target_core_configfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_=
core_configfs.c
index a1c91d4515bc..3aaa2b931009 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1455,6 +1455,10 @@ static ssize_t target_wwn_vendor_id_store(struct con=
fig_item *item,
 			"\n");
 		return -EOVERFLOW;
 	}
+	if (len =3D=3D 0) {
+		pr_err("Emulated T10 Vendor Identification equals zero.\n");
+		return -EINVAL;
+	}
=20
 	ret =3D target_check_inquiry_data(stripped);
=20
@@ -1511,6 +1515,10 @@ static ssize_t target_wwn_product_id_store(struct co=
nfig_item *item,
 			"\n");
 		return -EOVERFLOW;
 	}
+	if (len =3D=3D 0) {
+		pr_err("Emulated T10 Vendor equals zero.\n");
+		return -EINVAL;
+	}
=20
 	ret =3D target_check_inquiry_data(stripped);
=20
@@ -1567,6 +1575,10 @@ static ssize_t target_wwn_revision_store(struct conf=
ig_item *item,
 			"\n");
 		return -EOVERFLOW;
 	}
+	if (len =3D=3D 0) {
+		pr_err("Emulated T10 Revision equals zero.\n");
+		return -EINVAL;
+	}
=20
 	ret =3D target_check_inquiry_data(stripped);
=20
--=20
2.43.0

