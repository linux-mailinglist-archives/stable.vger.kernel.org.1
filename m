Return-Path: <stable+bounces-144367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A048AAB6B4F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4214A6EF7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355927603F;
	Wed, 14 May 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="bBB1baW5";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="KtcrOFi7"
X-Original-To: stable@vger.kernel.org
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58427510A;
	Wed, 14 May 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225243; cv=none; b=YmADbBDwNI9XSswzgzITLU+gWLVTZj/fljNQLEoRwFn08M+Eqtfjr/ul8Tpwij098cGOyqyOMelS6YVh3q02mqzTHU/BU1IgXPqyfZpFmFbXUwjDsKeNyRqzJp6tb+k337BbLPIudMUhyHpUafoF9+xBYW/6+PLbcJuhz6uLA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225243; c=relaxed/simple;
	bh=bCMtLnVD2dgxi8EjKGcWIGCO8ra6AUHVklgwLHB8IbQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nuqwrMy+fEDw2zqS9goVPjUx71FSYivnhLoKrDO4cRD8TXKJNM0VSZTlbhEBfSBbaoBvoR9lzMqX5EOTMxuDKBTba42Ipv8Oq4dGgSgRX8U3w4r76xu4Ng9f5oq5LbcgICxFf+z6sqD9DzSi3Hh6WhKnbADkS1KGlHFT8UvFnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=bBB1baW5; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=KtcrOFi7; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202502; t=1747224786;
	bh=pAjLW2i6DlqO1kn+FO+4QKQ88dteWB/N9XRN4Z86JAo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=bBB1baW5Ev8WKm3e59WK+xdR5CNo2/JVqpkdYxLLm2KjiU6CRjCd3Y+rJaMxwxmw7
	 LPvIKXJHXuJeI/p1+1nY11GiWx8pWabQGPRlb+k3vnOkYTPlG/4ooVqnno7bcrI/5J
	 xrviDOcyvcYwUxWPcRZ07+2GlDT3qmKseMH0WWVcDDacgvUw4V0RY3P47imS5Nc1Ss
	 wd4X7KO17llqX91Tsr/13bHnDsoy4Oo9KEjj4SMr0qNrPjUlhMk10u83xgEWKlxdnH
	 puoZjgQfLD1akbfX0EXnG74Oe3JCg5aXBSZismY63KUK4al2zaGuqZ1SOJZ+ZQDfJ3
	 N+gtvs5Cl/uAA==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 2D6D7E8F244;
	Wed, 14 May 2025 15:13:06 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id 03BC9E8F231;
	Wed, 14 May 2025 15:13:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202502; t=1747224776;
	bh=pAjLW2i6DlqO1kn+FO+4QKQ88dteWB/N9XRN4Z86JAo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=KtcrOFi7sYoiVBDNR4Znc/i/kYXErdIJGU8ic98y9kHQ5/xXIbeufS6FBaa26lWmp
	 coIrO2YxLe5drhpOXnQDEBisNnkZ/Z2l40Te3ntqSlrgMDGjjQ+jBrREFCIaBWx664
	 pWZMt2aIJ+IGg+J9wH+KEwS2ZwY+lMFPJB1VRVKOlJYVYTFzbLcQA/Fbs29nlyq9K6
	 hIpNs7Kjut6kNf+INdGneqyjaLcV9X8iFsbNNo6/72C/sHoESOGyNzXlce2lAA2kNd
	 z1717Uu1JnhkZv1QCFXwOiZGDbaczwQie6vA8JxEEL6BslOSj62mwS3KFOf51fXnD0
	 bLHMXvnP6aDTw==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id DC7813E501B;
	Wed, 14 May 2025 15:12:56 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 1C3AB3E5671;
	Wed, 14 May 2025 15:12:56 +0300 (MSK)
Received: from HQMAILSRV1.avp.ru (10.64.57.51) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 14 May
 2025 15:12:55 +0300
Received: from HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408]) by
 HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408%2]) with mapi id
 15.02.1748.010; Wed, 14 May 2025 15:12:55 +0300
From: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>
CC: Hans de Goede <hdegoede@redhat.com>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Mario Limonciello
	<mario.limonciello@dell.com>, Divya Bharathi <divya.bharathi@dell.com>,
	"Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] platform/x86: dell-wmi-sysman: Avoid buffer overflow in
 current_password_store()
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: Avoid buffer overflow in
 current_password_store()
Thread-Index: AdvEyRwGGRgYB7/5RZGEC7fXF7io4Q==
Date: Wed, 14 May 2025 12:12:55 +0000
Message-ID: <39973642a4f24295b4a8fad9109c5b08@kaspersky.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-kse-serverinfo: HQMAILSRV2.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 5/14/2025 10:47:00 AM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/05/14 05:39:00 #27979694
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

If the 'buf' array received from the user contains an empty string, the
'length' variable will be zero. Accessing the 'buf' array element with
index 'length - 1' will result in a buffer overflow.

Add a check for an empty string.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Managemen=
t Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c=
 b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index 230e6ee96636..d8f1bf5e58a0 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -45,7 +45,7 @@ static ssize_t current_password_store(struct kobject *kob=
j,
 	int length;
=20
 	length =3D strlen(buf);
-	if (buf[length-1] =3D=3D '\n')
+	if (length && buf[length - 1] =3D=3D '\n')
 		length--;
=20
 	/* firmware does verifiation of min/max password length,
--=20
2.25.1


