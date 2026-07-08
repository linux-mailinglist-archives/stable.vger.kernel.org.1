Return-Path: <stable+bounces-272557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +tMSA4DhTWoz/gEAu9opvQ
	(envelope-from <stable+bounces-272557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ACF721DCD
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VW9ZfxdH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272557-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272557-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34D03301B00C
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB33C2B9C;
	Wed,  8 Jul 2026 05:34:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0273C0617
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 05:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488865; cv=none; b=RGNJeg5fBcW84ptOR6xqlxdYI8jvwx1RoxRq1rqr+xmF8rgeyEDHOVFlZWiyf2jOSq3zY66jQLzotww2eMwLsPix91a3jNgcXWhshd3uVN/iGrHPFNz4YrOhmZEXDN6Bc5aFDd7H0BaTOluLiRpQWF/lXZoCVOStpFrzPOQShw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488865; c=relaxed/simple;
	bh=iShz7l7ZusIwvENL/lDC2VhyBdjbPgnHRjbbDd86sDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2u1jhZ3k6YQTKnACrxSPUvp4VMSJns4JfsK4G4GDUchhe7m8QAuzEy/BjNos40BqsZyrcAfYO+tFRh8TA06TPRDLBDXH3TqhvhVkg3s+mLVfPd4qivWDZpPOyow/YoMxrcipTXWER2dUdA8+6bi4HUfmbWFdIOxRZggaPaH74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW9ZfxdH; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so15296055e9.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488862; x=1784093662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuiklN8ThbHWqpkE49ZV3AQdW0KurEfVot6WwYCuWx4=;
        b=VW9ZfxdH0GaKlMnNK+Um4x20KvajshRvsAmXAsUTqsu/FYJDiDJfmzhAFfJT/+HI4e
         YvJBHam6wP4TR1QpVxqPmJTB0DkjG0atB2izf7lcQwsUWSI9ElSsiehI2hsw+rCVoRmD
         lf/OhvfQM6ThYXiQcNSPBPQ5i2tEOTYNpjfE1cWJ+QpWCD/uvSSK59orbldR5kasZhFv
         RRHaRupdUMcbxESiDVIPUkr5dai3hlRH+UTl5pz6f3vJBCYwuar7m4O5W8unOvdS2WUK
         y/LOqRxSa+2SjG76fTlLAPXTN08Hm2vuiRs2Q2qlCynD5QSGJ9uijpDnM4RlWBK93Sw8
         OQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488862; x=1784093662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OuiklN8ThbHWqpkE49ZV3AQdW0KurEfVot6WwYCuWx4=;
        b=VG6/O7XghBhobiihBYe/JhAOKdFIY3QzyaZ/fcsnYVxWwItPIBkwnE9V6pI+NJy0b8
         dFXqcbSYX127rr4Zf35cRTgQLSTcog21Qj+L0sHojFKAoSwORPsLnhpBigQQE+dulTe+
         1lbJWHdPMHaDMGyotDP+ItKOhUekaY+aVid8v5qeTsIsRUatqDd1BT6VEvyXZqixZpX5
         6XSySHnH3664j4qUp1EOlGlxS9wOZ2nB8FUpOE2mE+T0PsGC7VelKCM2OTxR9hzlDY86
         Q3YBdOtmNB8/CUZlb7uNiChmsEHAf6NrdhMjn6BhESQPBn4IA/Bbn+1m8nn/EHgpILTl
         z8yg==
X-Forwarded-Encrypted: i=1; AHgh+RrdtY7U0ddcFBTSCv90IjvLedX4pmpY/Vo3e73aO/Dbb6/KVx4jqhOxmDjNnNqfQL3EIL49FEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJQWLadb34e7qVxO1qGo6PuiWI2vTjSIpJ+nlDgdpqr3H3I8V
	AdAaOxOpRwUABqml7w6Xs6bhva8TRn9CglkbGQ0kuwOOh5pLBPEGX4EZ
X-Gm-Gg: AfdE7cn5xeeAVESyFVPQFW89S1QzdXt9u8O1W4mmmfWX/Q+h6E9u2TvaErqP3yhcjia
	uqMTQybuMSFtq1acvadiClobfpMbsiuXTsHZurZ9KFIoCzPyxzj9tVn+han6HXiKdSOxHAzDh5C
	MxxO+UW7Fq4kUhEVzEB4PA+dMFH9mvhaDhFsGU4x6yPTrA/Vo8DDNJILidj85TJzOFkgGwmFTnj
	ZtD5CR1MQtthxLLNUbgjui2461LB1/4xKGLC2rF0urKB/U9U/ufl3potAZRI1yftQxmfeRpDuB8
	SiHrnMvI5tYU749OTcQ4s/JBLw4opdzuNvvSLmQQxH5W69bbDdSQXxvb4XflMtau9ZS5QoOYQek
	1y6LrkOoOxA+cShu6MJqSMLk0eRLFxqVzmbMUTA2kAyCcVlDnnjxfv7kBXX6jETg1V9Wg1I0ODo
	NM9MJ52eRAF8w2YptqLn4Gd0imIhyagFjQKQNqcOspVpLL5SykMQHSdpoibOkAzzi/LuDiDAAtC
	xbweBjxAosShXtm1k+jdGT7R+tUjfUHgxfRg5u4ReBdOp7BzC2Nn4FeyvkrgJKkMI+JsKDZbQKZ
	K/eZINMKXZwrwiEdZBLtjESqyBMkXe31m9Ewv4qNsHsTbAUkok8INw==
X-Received: by 2002:a05:600c:4692:b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493e6393963mr9601615e9.12.1783488862308;
        Tue, 07 Jul 2026 22:34:22 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm35528415e9.0.2026.07.07.22.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:21 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 08 Jul 2026 07:34:14 +0200
Subject: [PATCH 3/3] iio: adc: max14001: add missing 'select REGMAP' to
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-add-missing-regmap-v1-3-6d424322e3d4@gmail.com>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
In-Reply-To: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488858; l=790;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=iShz7l7ZusIwvENL/lDC2VhyBdjbPgnHRjbbDd86sDg=;
 b=Z26FGgIIQoNTPLIp4HMivVlYJq+tcpr2gP1WpKQhPaKGdXeyAQNRaW3fEv92YAfvsu6UZTZFC
 w5LvuwnV/kNBynEJmvCwpSeilnh5YFtqF/T1kHkZ9y/B474vfAaWaOZ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272557-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:stefan.popa@analog.com,m:jstephan@baylibre.com,m:fr0st61te@gmail.com,m:marcelo.schmitt1@gmail.com,m:marilene.agarcia@gmail.com,m:kimseer.paller@analog.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joshua.crofts1@gmail.com,m:stable@vger.kernel.org,m:marceloschmitt1@gmail.com,m:marileneagarcia@gmail.com,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7ACF721DCD

The Kconfig entry for the MAX14001 is missing a 'select REGMAP',
causing build failures.

Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 01e48d6701ee..91a39860c676 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1075,6 +1075,7 @@ config MAX1363
 config MAX14001
 	tristate "Analog Devices MAX14001/MAX14002 ADC driver"
 	depends on SPI
+	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices MAX14001/MAX14002
 	  Configurable, Isolated 10-bit ADCs for Multi-Range Binary Inputs.

-- 
2.54.0


