Return-Path: <stable+bounces-111076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30724A2183A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE21886185
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B8198A36;
	Wed, 29 Jan 2025 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="X8aNVg3N"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75F19580F
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136137; cv=none; b=grJPq/wl8B05xRMV4+nIRZFssJYILvBui0fV7Bcd22H8TIuQa9wG8IA2vAqp9qnEVQDN7nQ5lom2uLZmKB1KnbS4QovXQebkcUjMJYVrGsBlz5Fv9gF68Uwv/WX2j8iqVyUXBsBQ75rdkEGNCSgmGQai0TaoZTGzJIrTQ3C9zxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136137; c=relaxed/simple;
	bh=/PrXWxohQ205RW/ae0fQlLa42s0+6zVNBySmFktGVTw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tmfBrKAa9rwRNz0SNUcfXgE7/xpof/uMBQYCU7PJf/wE/VMBbT9zQDpE4MzHbkqVnAS7P3nQwBDjwBToQlCutvtGonKf/LfssIq2VgliNwVlu/Q4wzI9cbsGl8fphu/cYcJwXpikDKzLE4LVv+Y6rv38Wz/GEJs80GNijoXpGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=X8aNVg3N; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 50T7ZUNv007607-50T7ZUNx007607
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 29 Jan 2025 10:35:30 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 10:35:29 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 29 Jan 2025 10:35:29 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] power: supply: da9150-fg: fix potential overflow
Thread-Topic: [PATCH] power: supply: da9150-fg: fix potential overflow
Thread-Index: AQHbciBeVfngnClpf0+wmCQJvzHG8w==
Date: Wed, 29 Jan 2025 07:35:29 +0000
Message-ID: <20250129073524.23360-1-a.vatoropin@crpt.ru>
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
 bh=o54c9MrkUFXn90FGbRmy5zFWqtUULMfirflS/ppsvvI=;
 b=X8aNVg3NjNHDR01NJhMk9Lk3d0kOt/4bmCH9WECkChNIJZ5WW9dfpOreGS4NU/a/mmL/FYFY+tJA
	r9les7Cndvn/sCnpQ6QG5Q1vHb/vScq0yJr8mZuRUxmS0z3aJ8jmaOLLQMhgR+GacaTPgd9XhP85
	kLRNSvXm0JmzfyOeOwAdJwum9V8/aeoCKrmm1ma4Wixaz+DX2vWqMNnrYflaZwbBoFzkEeWmoQrW
	H8c3mYiMmtzjpWykKCY2wU0cdOYWIhyKD4iLXXSj5nfV1CWZmdmuueknP7MRSRA6ns16sadNZVAQ
	n8ktJSCJaCYfk6XvrPcS0Uj0ynPVmTDsxJ0QQA==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Size of variable sd_gain equals four bytes - DA9150_QIF_SD_GAIN_SIZE.
Size of variable shunt_val equals two bytes - DA9150_QIF_SHUNT_VAL_SIZE.

The expression sd_gain * shunt_val is currently being evaluated using
32-bit arithmetic. So during the multiplication an overflow may occur.

As the value of type 'u64' is used as storage for the eventual result, put
ULL variable at the first position of each expression in order to give the
compiler complete information about the proper arithmetic to use. According
to C99 the guaranteed width for a variable of type 'unsigned long long' >=
=3D
64 bits.

Remove the explicit cast to u64 as it is meaningless.

Just for the sake of consistency, perform the similar trick with another
expression concerning 'iavg'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a419b4fd9138 ("power: Add support for DA9150 Fuel-Gauge")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>=20
---
 drivers/power/supply/da9150-fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150=
-fg.c
index 652c1f213af1..63bec706167c 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -247,7 +247,7 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
=20
-	div =3D (u64) (sd_gain * shunt_val * 65536ULL);
+	div =3D 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res =3D (u64) (iavg * 1000000ULL);
+	res =3D 1000000ULL * iavg;
 	do_div(res, div);
--=20
2.43.0

