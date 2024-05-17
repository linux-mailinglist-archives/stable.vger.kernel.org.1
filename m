Return-Path: <stable+bounces-45394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB48C860E
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C381C2344A
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429CA537ED;
	Fri, 17 May 2024 11:59:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7951C59;
	Fri, 17 May 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947149; cv=none; b=SIGPPsx1iE5/j/pgUAPn7u+9BWOR/rsavYwgmsW0x+SSJ1WlDSwFsG8QxlOI/zF64zXDXhhXf3B1YNZXW8ewpAX1aeGcxNwakc+pa8h9V4/mCpwrm7zex6IgnvKJ3aziJ7qzxUksg+bj9EyD9ZcCuNNiLGclNh1C4J7ifXgT5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947149; c=relaxed/simple;
	bh=fe43fJSj3i9NMSzNqNRStwhPd10HNnKc47sfeXR3k8E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DpVmuSfsUkMbxrcUT726hiMV7fAkX1cghOjOK+l/0Y7RCSY/eiLWyU8Xcm6XlJht8b58BxqVWZ1DkWFQHgLAo7t3i7e5OKYcf67LivfSE/2uQW9te3CUUuC/iZ+AceflJ6ot1B+xiwkPJk76tT4dt2lj3axEZhiTbb4S9oQgSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 May
 2024 13:43:52 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.039; Fri, 17 May 2024 13:43:52 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is
 selected
Thread-Topic: [PATCH] USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is
 selected
Thread-Index: AQHaqE99M70NH7RzN0K31Fykj7Mi3Q==
Date: Fri, 17 May 2024 11:43:52 +0000
Message-ID: <20240517114345.1190755-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
x-esetresult: clean, is OK
x-esetid: 37303A29059A2F57607765
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

If no other USB HCDs are selected when compiling a small pure virutal
machine, the Xen HCD driver cannot be built.

Fix it by traversing down host/ if CONFIG_USB_XEN_HCD is selected.

Fixes: 494ed3997d75 ("usb: Introduce Xen pvUSB frontend (xen hcd)")
Cc: stable@vger.kernel.org # v5.17+
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---
 drivers/usb/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 3a9a0dd4be70..949eca0adebe 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_USB_R8A66597_HCD)	+=3D host/
 obj-$(CONFIG_USB_FSL_USB2)	+=3D host/
 obj-$(CONFIG_USB_FOTG210_HCD)	+=3D host/
 obj-$(CONFIG_USB_MAX3421_HCD)	+=3D host/
+obj-$(CONFIG_USB_XEN_HCD)	+=3D host/
=20
 obj-$(CONFIG_USB_C67X00_HCD)	+=3D c67x00/
=20
--=20
2.45.0

