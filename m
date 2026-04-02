Return-Path: <stable+bounces-232939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ3nCdgrzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:42:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376838635A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB9DC30FB487
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417E3A544B;
	Thu,  2 Apr 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz6Hna+2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82B246782
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119051; cv=none; b=TLqNUfZQ10wcJ7Gm8CLiQlrReMSE6WJFZYWoYNMpNvGbCXDXDTF78T6uz2/EF+g04hXhlv4/tZZL7nTGpTWPzD3RGrxrI8mvmdM1hQ34xI7KtFD6eaDgN2zLbeNruyTf6v1UWWIeSf2QUQDbEF4CukdRWLPWsElO5gR/7JBcMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119051; c=relaxed/simple;
	bh=sjNHI0SqRG1xFTfbqXbfYmiraZhzljPHPeE0rBZzwcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrrRHNU03ZvMO3d0MtrecwNha0fPXLMVloaHaGmf66MdZmMGDsbNidGfNRUgXAxrB/Js46d/os/Vt4v1fPT2Je1PNC2mJNwAzLjMDWDEcn9iBwBMdWZIp8TOKb88fIxwAnN35ITwd16f9Jq0n/r1cIcLmU35gZjQFtZjpzVEniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nz6Hna+2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso4348945e9.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775119049; x=1775723849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OS1+Hv6V68sWUSaQ2t5yVzr46ljjcx27+0z8+uJDDlM=;
        b=nz6Hna+2NkBlljTkewYWtQBU3IhbVmLZ3QUNwz4FDkjFtGiZU4ghU0+uCFyEAhWMQf
         fjAP/P0DiICtcnLWya9G3D2QOT/r0hLs/F3Ds8OgbVpiIDD97pwY79fD+UYq+uR6bJCo
         eyTeJSRO/ul1oLOvkpqh8NB+yMjhVWUcuuEAegB6jii6FvWYWfN8JJYr0ScAt5YOtrGL
         996yfAetkLQ8UjOzo5TpmM+u7pbXM0VbJ+uh7OkIa+OYlpDFouGv/aCGyhMzdrRqaV13
         rzqQMuKOXAPYm0pnEI99VslcfVnIQXXYPnr41KGUu9xzk008rBYMxua2oGydvTmf/VlR
         uoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119049; x=1775723849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS1+Hv6V68sWUSaQ2t5yVzr46ljjcx27+0z8+uJDDlM=;
        b=PC2qgP7M9b0+o13H2eAunkWTbp0yRkGKDnw/zYrHpd682LlopIUZozzb3nlRtRPbeG
         0f5gXy9C1THeKZ15FRVvISGIUeJVvEOJ10dlkqNl/mbGoGn6XM7PfflGbtMpw8GACyUd
         g5Hqxk9ShwqZntwiN6l+4zul8gHTzOw9PdkfV6SJjyVDZYS+PAOYREzjru4P1x8AoAPI
         WQd1Z9aRQEkZFAbjvu/yEZK5PFoSrHPwVcfM8qn/zYJHkpfEUl67xvtTmtAFe15O2nht
         tODnt7b6HU1qV0YFpJGPOJtBw8wSj1JK0pfPkMHApI18PkKYgHSRtV/zBwKBPuCrzY+B
         yK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW33oqnWHYgw/MtDwB6WNyw5m/9bmuJudWM65JAL70dDCwQILkBpugIq7JQ0EZSFvvC8kxXf98=@vger.kernel.org
X-Gm-Message-State: AOJu0YySv2ljwHRQsTWJ9JLXwJpJf6UGA8tEC/itjpCq1vnSCarG47z8
	Uu7o+zqGDEdUjZHGgz/rejeiOAcI8Mi71uU2i6arYuNj86+q1A39BmV9wa4XO61W
X-Gm-Gg: ATEYQzxppzTpgrqYkgiM9MSC6AamEYy6z0USqqLPja84eG7BHWicdnDuHZleTD+C4lg
	RR/AhuK/lfGWmpvOKnBF9MuGGounWV623/2d54lZKp+cghRAOgLDQe0lyNYSpl0RA8BiTYGwO2m
	ZlitWDhnAxOhdXPJSQhpXsFPagq96GYHjeywPuE8a2P3VnXWdf0gNfsvU0XQwUZsv1FQSBz6ZcF
	iwEAfShkV+QcHPNm8qiWU1hM7AbBvkqtmFs0eUmURg0uMxI5WkGO9k/Plam497pwqodaF8gZ5z/
	kfXe/uKAEmxXwVWTcRlQnXFQRMAboR7XkPPw9mrg6TfkpKpF4hM+QHVIHOrvOn89acrmE5ZLlv4
	uBwhfxtKefh4ZZaMU1XrzFF946h8wL5fJNCNpheSw+Xz4qA/awH5TbWT/ZuLBISqQPk6nLhQTOe
	CWAzXS9vwzZyl4hezDldUYBoibZgKgES6v+Q1sB6VDZttGugmLCwTfcUVynL77xutUiDi7m4WpC
	Jjvf0PwpLKFS9H712uBp2SiNdWBN5Kd04G7Gq0XGA==
X-Received: by 2002:a05:600c:4a18:b0:488:90fc:82cf with SMTP id 5b1f17b1804b1-48890fc877bmr10691015e9.22.1775119048772;
        Thu, 02 Apr 2026 01:37:28 -0700 (PDT)
Received: from labdl-itc-sw01.tmt.telital.com ([2a01:7d0:4800:7:a04:488a:882a:de93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c3a01sm5883101f8f.12.2026.04.02.01.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:37:28 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: serial: option: add Telit Cinterion FN990A MBIM composition
Date: Thu,  2 Apr 2026 10:37:22 +0200
Message-ID: <20260402083722.100973-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232939-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabioporcedda@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9376838635A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the following Telit Cinterion FN990A MBIM composition:

0x1074: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (diag) +
        DPL (Data Packet Logging) + adb

T:  Bus=01 Lev=01 Prnt=04 Port=06 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1074 Rev=05.04
S:  Manufacturer=Telit Wireless Solutions
S:  Product=FN990
S:  SerialNumber=70628d0c
C:  #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=8f(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
v2:
- Added "Cc: stable@vger.kernel.org"
- Link to v1: https://lore.kernel.org/linux-usb/20260402082747.98441-1-fabio.porcedda@gmail.com

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 313612114db9..c71461893d20 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1383,6 +1383,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1074, 0xff),	/* Telit FN990A (MBIM) */
+	  .driver_info = NCTRL(5) | RSVD(6) | RSVD(7) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
-- 
2.53.0


