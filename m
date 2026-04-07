Return-Path: <stable+bounces-233675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LNMNGUn1WnB1gcAu9opvQ
	(envelope-from <stable+bounces-233675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56C3B149A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 123E5300601C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A03CEBA5;
	Tue,  7 Apr 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtAO8WGB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904F39A048
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576724; cv=none; b=gBeLoSIXqXr9/nlZKwzW6VausooSfR5lSqo0deqjjJYk3q3gwrYDU9w1EU+kmz3Rd/Ssdm2LIYlNKU1aplu5PjUw8qrugBVfDINFZWpYAzDatdnbIOf7fKZU5cLtSjN33zwPIY+4nJ6uUDPeFm10UfR6E2kVH6A7BGlb4Knvprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576724; c=relaxed/simple;
	bh=SuWl3tjZsAfYMRt8x4bSIskei8uiSlKXsRGVBV5mucM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5znmnEPklCZRVx/X1a4+AZnfMyHY0iiSHjr5cMAmQXe2hzmzN0iBms2sDO0z1yST+pbn8ufTvAApUjrWNwqZTSRA5Npv/YLIgWD6+8KbwY+jcq4wD2j6SKlYpZv5DHJyj9rZL71YxXYDYhI8uMDO+Evkt/XOS+zj6wlftuUCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtAO8WGB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a9296b3926so29606005ad.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775576713; x=1776181513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdgebIX8WCshNHCphbYwlC8WuuoYhJuJww2bMe0846A=;
        b=EtAO8WGBhbO3ojne4s/bzZHqGLtagdRvigW/KRxezzeTiY4kH1QooiE6FWBihqM47d
         38Y0gsI4GDccLTg3DfMMHLK5IYhlyy6YdJJXWdL3Q2rVZbRNYUjmYB4hu6JsGZ2yAdBP
         xa74z7J7oVGWr8/lwhjFNe8ectYrClA7S5IlGGV+aQKjYiBe/YXP3FOhfWpD4ZjU5/hk
         HmflQSfZvlyd5ikgqklwvwCyLD2M2N7AwydRIYCrcEw44aDNRbtlW4w5irSqXpA5Kb/B
         8k+pBtYekFxCu7cUfo87n0/2Z/gV39W6onfXQvSANKwAOBjgzktLIWTylIQeHgMmAlI8
         7bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576713; x=1776181513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdgebIX8WCshNHCphbYwlC8WuuoYhJuJww2bMe0846A=;
        b=R/VjLdaDhwh47dFCXogZp7JB7A9REGjPmo6TsVDlLz5tiP3HTM/Bb5PTC515Cactgs
         wpMJMvD+oIRUpTr0zckgJ8E4cDypXT08geA0DQjsst37dk8tJ6ycK5e88reyb5lz6q1V
         8hxKCY6Byf6lyWTNElb1odJnbWB+QfGbGAUf463PQDOYmksWggWa9SgkEwxrDgIF4PZI
         kEzjSF6Oibo4Tdtc1SoklYABZQt3W0LS2dK3jZHYNlalJOqQ+aLFv8kDijeGlQraSvYc
         d3WoSdwsW76YbnyDXQQEhlhsyyHv/bMnGSEGRf+tHfj4OcAxLJrXEFrqw+KDHLA00Lg/
         zr2w==
X-Forwarded-Encrypted: i=1; AJvYcCX3kwHPHPFAWkt9GOiHlllrb3KFLDDS/ezwkkZssV6iff1SguDnbkvzshxNHGGFh9i+BefMpoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+Y6ad2dxojNGfujtL0Bcxwioze4WoUaiNH6abcgT4qNFiO+u
	z/7Fyos78qzsvyzibTCiHMyYIkSkqsDsUhMZoCzf4e3mq7Fz9mb+SwG/
X-Gm-Gg: AeBDiesrBZ1zDs963EIdVZYAe+U3Nb52Fd3oHEJUgao92mlLSf3+BkmoxBrp1IO354r
	SOtkNbxXuQ6sUU3+wmLok6lFz8Tih3VkAtgFNJY+e00efFO+4qU0EHI9DBmAsjtvDvgMDI0tYLI
	iJFEOfnnylhzy0oLfD1Fa1aWY3CN+IzeVzg767jZa9BJTpGwdYDlxCaSvDYmdtLL4/w4974bV5y
	G7KK/e/SeZNxB5A3rzgG/JkoZo95GQGgxschmEkfqDQ92Fx6Z8RuMpmXnFWnMgOu5skP/rDy9+P
	rfCj7jfwr+9QYyyswQsqRogsOyeb+ijRFwEyi3jFNRx5FLJyiO+mNVG/QzV9cmXLFEy3NNmnfDy
	YWKiNcF9F9XiSJwsla9xOEjGI6aTdEOrHrYBL/GfErwbMcRCUPnv36abAZb8EJs2FqMXDCvpMDE
	kWFcVvxWyz0ybGkp/y/mCy0X4=
X-Received: by 2002:a17:903:1aa8:b0:2b2:42b1:ad9a with SMTP id d9443c01a7336-2b28182be11mr183382875ad.19.1775576712346;
        Tue, 07 Apr 2026 08:45:12 -0700 (PDT)
Received: from BM5220 ([49.215.226.71])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm230992905ad.11.2026.04.07.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:45:11 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH mt76] wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S
Date: Tue,  7 Apr 2026 23:44:30 +0800
Message-ID: <20260407154430.9184-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-233675-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-hardware.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bushowhige.blogspot.com:url]
X-Rspamd-Queue-Id: CF56C3B149A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ID 056e:400a to the table to support an additional MT7612U
adapter: ELECOM WDC-867SU3S.

Compile tested only.

Cc: stable@vger.kernel.org # 5.10.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
This ID was found from [1] and adding it to the device table should be 
enough to make it work. Hardware probes at [2] can prove its existence.

[1] https://bushowhige.blogspot.com/2019/08/ubuntu-1804-mediatek-usb-wi-fi.html
[2] https://linux-hardware.org/?id=usb:056e-400a
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 01cb3b283..459c4044f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -16,6 +16,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0e8d, 0x7612) },	/* Aukey USBAC1200 - Alfa AWUS036ACM */
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
+	{ USB_DEVICE(0x056e, 0x400a) },	/* ELECOM WDC-867SU3S */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
 	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
 	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
-- 
2.53.0


