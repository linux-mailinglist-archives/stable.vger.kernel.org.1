Return-Path: <stable+bounces-172340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21189B312A4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D561CE568E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E702EDD5C;
	Fri, 22 Aug 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLVflZt8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDD4D599;
	Fri, 22 Aug 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854010; cv=none; b=DsMMaGnUrmPLiswOWwcd+T/ksrsoxl8jOBszVGNjtWSCza4bF/rdEUGdA1WUBHrNyBkAQUjSJXnzM+8PmrxCvQCojMWDFYb6mGL1rjXtuNYieolss0i+++vTudshbFl8JdGBJRjPofGwKMYRT5rKsb2NScp6Y5sWREo+HBA7dEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854010; c=relaxed/simple;
	bh=lrfZJO/Uhq7ZjXnlBDXeBqnUhtneJCKZUGg3Yce/cUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6vv4WjUEtfRHNwhACCY29Z6/+zPed9f7YBKMvm4rZtDQATCANlQo0v5P3ebM4/DkmwDrGNHDccgy0Sbi4slf/5rNJQqU7iq3dxSkLE/Qk3860in7jbAsSlF9s2CArVhKnhA6xykN4URhfUREaNZ7qxxaHQybUCVG+V8R9ZWV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLVflZt8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so15377575e9.0;
        Fri, 22 Aug 2025 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755854007; x=1756458807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WVB6Ufn8LQN8CYkitGQqrmJbX//AJCWVJHRLiQ2uSA=;
        b=ZLVflZt8KolEJj2urXqrz8QTzfNCDvYHxDuOyK6sTDZaseFSqiulpKkjcj2aF4b2yf
         49YrBu2kTM3y5l2tHN1bRY2+t4WH3dOvRWxjpTBLe5T5aMhFn+wvAkLfe6rGzfIKQf19
         mXu29YTpqCJzEiA2BHGC1rpYQtlV+Tnn8ByHtEZQubw2aXrQkDgMHg/AgYTLGAPgAb9S
         tS56FhIZkOkcg6jH6k5UoQrB2XZOJwpiKhAyQrJhG3ukKo9+D4iJnf/8a7uGJnviwOlj
         U6OKzClqPYpCXMTtf2P1aUaZr/giuHeQLaENDMwompFi/FLroxolw4YoqBhyKPYRG8yH
         4Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854007; x=1756458807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WVB6Ufn8LQN8CYkitGQqrmJbX//AJCWVJHRLiQ2uSA=;
        b=H4lfy0HwbbiaUwI5F68sVnJZPrR8HPG/zA7vAgmAJsjN2CDvMk9q1bAHmj0xTAlZzU
         ILNr1BmNwJTYdt6tjqscoeVUPISaAypbHSiWNFoVLR1HiioNg8dBvoBPEM1HG2JXSydk
         t9VemEdFljtIOh4T0h5//nmrmi/vfpo6W6JfPmK43m225oSoM/fTTxbBIGHVpgkm0LV9
         0Q6B7wJn2xWNSPN1Y9K8XsiPYqd1kHFtdKWg5uC+yOTEany02m2y5Ica21cfgsmgBNrr
         yFFSh+cStt1pTw9bmPdrd2RfYxIYBydv9ALQ8ppBSlRrk4MXn5uCR1GBs5kNrPhYk8mG
         SGgA==
X-Forwarded-Encrypted: i=1; AJvYcCUH4vtDns6pFaSqC7DIeqMxg755gqTQmvb8hWv/stEg+sLt/7hF0l7iywT9wqpNqiWLVGVEzem4@vger.kernel.org, AJvYcCVweR8D8RDmc0uy7U8czlGwK7ueVS+d/31kv4P7S23w1i0U9AsS5PQhI89MIKYU5uCRXt3Bt8OZNYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qg1EFTiN2wbx7q2DuQJUg5GQQEcDjuujR2sMW0S64IgeDwTB
	1ctxiRL1WiBMUdJXVZCKeUNj19ge8IURbAJzlXlyK6RnfxdsAQZlVuwT
X-Gm-Gg: ASbGncuxSCDWB2Qwy5JqDw61TyrsJ+0YfpAJ515r08jZXdokzNgDzkdUSYJFwmLRtLO
	vu5OoV2HrpqqqwECOaUlv5J4SUNOx5JCesfYaXfedNrebIu+HLxRW1Un58QbylCeUQfFypdefyx
	Tvrz+sWsMBjccuQSSQ28c4dEEGAdzZCBLRRWyaxB59iN5o3BsU084enN8ayFHdHY5RqNvkUpjul
	6QidZUUDZHtsNiBxFhDtfyYGwqBPfCdwa/99DNh39XHfZL8vY0GxsXlPTuBqMyR+oH2ZiDFpXsT
	G6n51PDiBMB+Ngr4PcDgOi4mrvhbqpOfR3RjDEh4zZi71j/RnCIBwQc4jB5QoJOAvfdEjyMsdns
	tTlOgMQVhTqwskJSK3uKRK/pWvl1Ok8LIi9iAemNacpox5f9EYc13s6z+DZMRq0koBnVkXftNfW
	cAvWv6L3DwPA6l4K61m3IgsllgraahDIQOHDd7gxg=
X-Google-Smtp-Source: AGHT+IG3N5dVsjBj8GZEWqWjVgwu5w9EmG2QPXeLTSfWVw/oMqvB4o5x5tkd7aQFh6+jBLDbfCuQcA==
X-Received: by 2002:a05:600c:350c:b0:45b:47e1:f5ff with SMTP id 5b1f17b1804b1-45b517dbf8amr16806835e9.35.1755854006975;
        Fri, 22 Aug 2025 02:13:26 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc40b7sm31170055e9.2.2025.08.22.02.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:13:26 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
X-Google-Original-From: Fabio Porcedda <Fabio.Porcedda@telit.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions
Date: Fri, 22 Aug 2025 11:13:24 +0200
Message-ID: <20250822091324.39558-1-Fabio.Porcedda@telit.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Porcedda <fabio.porcedda@gmail.com>

Add the following Telit Cinterion LE910C4-WWX new compositions:

0x1034: tty (AT) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1034 Rev=00.00
S:  Manufacturer=Telit
S:  Product=LE910C4-WWX
S:  SerialNumber=93f617e7
C:  #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x1037: tty (diag) + tty (Telit custom) + tty (AT) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 15 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1037 Rev=00.00
S:  Manufacturer=Telit
S:  Product=LE910C4-WWX
S:  SerialNumber=93f617e7
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x1038: tty (Telit custom) + tty (AT) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  9 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1038 Rev=00.00
S:  Manufacturer=Telit
S:  Product=LE910C4-WWX
S:  SerialNumber=93f617e7
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e56901bb6ebc..11352d85475a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1355,6 +1355,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1038, 3)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x103a, 0)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
-- 
2.51.0


