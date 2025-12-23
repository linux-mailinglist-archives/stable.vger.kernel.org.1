Return-Path: <stable+bounces-203270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCACCD8423
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBF630173B8
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A172FFDCB;
	Tue, 23 Dec 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="lA39fu/B"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714882C11C4;
	Tue, 23 Dec 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471520; cv=none; b=mmKgB1lPDuU6BgdFRVEdouVgpPxVpSpNqmi+aLGZc41HmCl4UFoGNuDUBZEttOVIG4/6ypO4YA3XfEXW5mZWdf8jPcUSE4OkQUzcPdx26nWFXNI9o8WzJsy9maHdHCYKgklHYgFQx88oh8skz2/lhhCL/gr3dIKtr08WhtruRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471520; c=relaxed/simple;
	bh=uIyoHWdWNu6d1ClWbNYZx1UJseEfMekq0zayGia+/zg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tzQ/xDhIoUx7ZhyVa6PipiK0pD3qeZEnkTOabhNvTdTBdR1jSqFAP+1p1DtBY0SL37sWU8KJVTjYz8t/6n1tv89u2OIWneDt9QIs52fFmUwTEsyTy35ax7Iv2UJEuIAeAXgwxCniTsjsmHWasg80eNQXwcLrdmx95fysVAhGXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=lA39fu/B; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 5BN6V7ol026179-5BN6V7on026179
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 23 Dec 2025 09:31:07 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 23 Dec
 2025 09:31:06 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 23 Dec 2025 09:31:06 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Samasth Norway Ananda
	<samasth.norway.ananda@oracle.com>, Zsolt Kajtar <soci@c64.rulez.org>, "Lucas
 De Marchi" <lucas.demarchi@intel.com>, "Antonino A. Daplas"
	<adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 5.10] fbcon: Add check for return value
Thread-Topic: [PATCH 5.10] fbcon: Add check for return value
Thread-Index: AQHcc9W32zQUeRD9Y0S9vQt0S50zYg==
Date: Tue, 23 Dec 2025 06:31:06 +0000
Message-ID: <20251223063055.77545-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 12/22/2025 10:06:00 PM
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaXEgKRhIHBAYBDRoDAQ0oGwkFGx0GD0YLBwVIWEhaSFlaSFlRWkZZXlBGXlhGXEhQSFhIWEhZWUhYSFhIWEhZX0gJDAkYBAkbKA8FCQEERgsHBUhYSFpdSAkDGAUoBAEGHRBFDgcdBgwJHAEHBkYHGg9IWEhaXEgKRhIHBAYBDRoDAQ0oGwkFGx0GD0YLBwVIWEhbWUgMGgFFDA0eDQQoBAEbHBtGDhoNDQwNGwMcBxhGBxoPSFhIWl5IDxoNDwMAKAQBBh0QDgcdBgwJHAEHBkYHGg9IWEhaX0gEAQYdEEUOCgwNHigeDw0aRgMNGgYNBEYHGg9IWEhaXEgEHQsJG0YMDQUJGgsAASgBBhwNBEYLBwVIWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIW1pIGwkFCRscAEYGBxofCRFGCQYJBgwJKAcaCQsEDUYLBwVIWEhZUEgbBwsBKAteXEYaHQQNEkYHGg9IWEhZUUgcEgEFBQ0aBQkGBigbHRsNRgwNSFg=
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=NmXWo8cqnFNX78iJ5OKHOK6zwMhrZ7kh7/MERegNA/g=;
 b=lA39fu/BqQS/xZVIKnQL+bzgWvxLLD+qKKh8hSbRK62x1rAjm+mP3xZRoEjD3futJ2e2dADCuQKt
	wlUoYWm1b8opOQ5SiAaPRv57OfJt4wpgCDuaKC5IvFffkb5cDzZS0t8ryXjMvl9YyYx8o7Iiyo2g
	D9pku7j8FM7HbfLeGAlwzUKJxAgSvgnvqSxLIOWIy1SOdyNEK+/lXJKPK6//xNT7z4tKTwECs7fg
	V5zRKCs8PP4VCIbvRddkLF+J7uoWeq6Qy2gCat8CnBFRKGTv2DZKC8OLTr5pZiOr2z3pSvduTJGK
	xyhbLWatUT1YzZ+pMc+nc/VCVXc208yF3/jxQg==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

If fbcon_open() fails when called from con2fb_acquire_newinfo() then
info->fbcon_par pointer remains NULL which is later dereferenced.

Add check for return value of the function con2fb_acquire_newinfo() to
avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1baa4ffa677 ("fbcon: set_con2fb_map fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/video/fbdev/core/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index 3dd03e02bf97..d9b2b54f00db 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1057,7 +1057,8 @@ static void fbcon_init(struct vc_data *vc, int init)
 		return;
=20
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
+		if (con2fb_acquire_newinfo(vc, info, vc->vc_num, -1))
+			return;
=20
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
--=20
2.43.0

