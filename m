Return-Path: <stable+bounces-110860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43297A1D57A
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953C7166472
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE61FECC9;
	Mon, 27 Jan 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="mjMiJKk3"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F11FCFD6
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978044; cv=none; b=TFWgWUvIXKde/y3pfrPWeGEKZNMXTbz1Y/PxLE9o7E+GAyXUMYcYy+KRXhoe8bgrYf3fwL3C4B+vDENt0R4KHMfS2E1VX+/qSyX9WczoaS5XzZRnnxVokg+0rAQSOUgePolRRfT+lKpin9b9Xpu0/IkFH36TUkHRAJjLyYWqi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978044; c=relaxed/simple;
	bh=NIxISyiiC4iMHYJFxPidYQlOqRY29SF/EO7KwKqyz+o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p6CjBe62PZACNVt9MeCa88Ch+z+bYBpqSi7RSGL8kWGgi4hOlNPRdXV7UuQRrRWOheOWOLHQ13yZCG69Lhdqws2NOes0aVYU0XvEb9GDAhaPUYPUbbYV3ydHzaCRvMuG6EfWw109l2FUHT7epO6fTKoLt8qbLKASkOKLUZBCZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=mjMiJKk3; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50RBPRLE014435-50RBPRLG014435
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:25:27 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 14:25:26 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Mon, 27 Jan 2025 14:25:26 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] drm/gem: overflow in calculating DMA GEM size
Thread-Topic: [PATCH] drm/gem: overflow in calculating DMA GEM size
Thread-Index: AQHbcK4p0k+1I3hZoUy3Vnl1+b1O4Q==
Date: Mon, 27 Jan 2025 11:25:26 +0000
Message-ID: <20250127112515.88735-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/26/2025 11:12:00 PM
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
 bh=VjPDc6XIu+Pd+uZ/AwnKjmVj2zkk6k7QL5M85K7HYZs=;
 b=mjMiJKk3Y1QCJCKfCYK/JtJ8sqHkvG/W0j/hLHuTR0K8n3iiBiO+0byHzXYO4v36s+/ENpx3AgJ7
	00l23hVUFo+wxyIPDV6XKF+j+M01nI9o9qVBCCkFTNwFyqu0sh3JzJclKo2xwi18N+92JA+xXf8T
	EjOTcm58rafA5e3sU1Z1PLbcU24fIB+FtD76FrzLRRMjFYCKNzOVsRbLMeEXh4TNRcAQ180zwmx0
	+FbdycbJjukXH8Veg2Usi2tR3iEqmBCIKqSVEuOYGNF902q8OPKoz8tbN+SDv05kNupedVCEcnrW
	dxjEV9ZqHB290Jq4pVB/eV7Y3BGxAQLZLQ9NtQ==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Size of variable args->pitch equals four bytes.
Size of variable args->height equals four bytes.

The expression args->pitch * args->height is currently being evaluated
using 32-bit arithmetic. During multiplication, an overflow may occur.

Above the expression args->pitch * args->height there is a check for its
minimum value. However, if args->pitch has a value greater than this
minimum, that check is insufficient.

Since a value of type 'u64' is used to store the eventual result,
cast the first variable of each expression to 'u64' to provide the=20
compiler with complete information about the appropriate arithmetic to use.

This is similar to commit 0f8f8a643000 ("drm/i915/gem: Detect overflow
in calculating dumb buffer size").

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal()=
")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem=
_dma_helper.c
index 870b90b78bc4..a8862f6f702a 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -272,8 +272,8 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *f=
ile_priv,
 	if (args->pitch < min_pitch)
 		args->pitch =3D min_pitch;
=20
-	if (args->size < args->pitch * args->height)
-		args->size =3D args->pitch * args->height;
+	if (args->size < mul_u32_u32(args->pitch, args->height))
+		args->size =3D mul_u32_u32(args->pitch, args->height);
=20
 	dma_obj =3D drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
--=20
2.43.0

