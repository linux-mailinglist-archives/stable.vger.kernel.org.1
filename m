Return-Path: <stable+bounces-171927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FC4B2E873
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DF47B45BB
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF42BE7B4;
	Wed, 20 Aug 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kcs+/mmo"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3836CE0E;
	Wed, 20 Aug 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731217; cv=none; b=VGIJhFzuoMEUOB6VxQuiSDut/UeG5/GJ6BrbFWYGNZhmwBUe6lgMk2YkSjkobj97Nkr8YuJ9hvbYYkikNGX8gY94bubW/6Jm7gIoWGUONJoxiq3DC1OaR8AHiCMyFNRWVTcxYy0y53Ul7PtDBAZ7I/7gSVXc2BqJN6lg2Qd+XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731217; c=relaxed/simple;
	bh=+JBTVbGTqgF4dAXzSmod1Nk3K+YD/cNO0QCU8Uftajg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qk/bO6mHXWFIbXW7bOUGn9Yw5fk5M6ubYu663ustqTHjrJEelH8UvQjIYmbw5tqoIJYrgxnDBSa++GkftwxIL9/Sa86Nlg9Bcgo9LNyfrzmY79ImEDNaTHvLs6jQJDCQtj/z92eCZy4TUjdknJeDTbbiMRDUBaovkCAN66oyJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kcs+/mmo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 6BE70211337D; Wed, 20 Aug 2025 16:06:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BE70211337D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755731215;
	bh=ZciZznTaJBSrjGj2kJ/dCWmBsvc5aTUmPNfCRwpcKtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcs+/mmomryGE0ptkW1yyItGkU7qhbG02+gTdM2oFvSRYAcnmYV5koO/2ZamXr3rT
	 6qMkTyRnNztCvMEm2+f3vqL1y+H3RIXCpSEj+ZweSTdaRpj7hsvAAMa5MaGdC9RPp0
	 G5dk8xNNF9PU0KZCsUq6QwUAUPF27VY4TJv1peg4=
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: sashal@kernel.org
Cc: alexandre.belloni@bootlin.com,
	meaganlloyd@linux.microsoft.com,
	stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.4.y] rtc: ds1307: handle oscillator stop flag (OSF) for ds1341
Date: Wed, 20 Aug 2025 16:06:04 -0700
Message-Id: <1755731164-17255-1-git-send-email-meaganlloyd@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <aKPbXqJ-ddx4Thqj@laps>
References: <aKPbXqJ-ddx4Thqj@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

[ Upstream commit 523923cfd5d622b8f4ba893fdaf29fa6adeb8c3e ]

In using CONFIG_RTC_HCTOSYS, rtc_hctosys() will sync the RTC time to the
kernel time as long as rtc_read_time() succeeds. In some power loss
situations, our supercapacitor-backed DS1342 RTC comes up with either an
unpredictable future time or the default 01/01/00 from the datasheet.
The oscillator stop flag (OSF) is set in these scenarios due to the
power loss and can be used to determine the validity of the RTC data.

This change expands the oscillator stop flag (OSF) handling that has
already been implemented for some chips to the ds1341 chip (DS1341 and
DS1342 share a datasheet). This handling manages the validity of the RTC
data in .read_time and .set_time based on the OSF.

Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Reviewed-by: Tyler Hicks <code@tyhicks.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://lore.kernel.org/r/1749665656-30108-3-git-send-email-meaganlloyd@linux.microsoft.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Git was trying to insert the code above the ds_1388 case statement block (in
each respective function) which don't exist in the v5.4.296 rtc-ds1307 driver,
thus a manual fixup was required. ]
Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
---
Here's the backport of patch 2/2 of the series for v5.4.
---
 drivers/rtc/rtc-ds1307.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index bb65767996d7..0afc2b14f059 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -252,6 +252,13 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 		if (tmp & DS1340_BIT_OSF)
 			return -EINVAL;
 		break;
+	case ds_1341:
+		ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &tmp);
+		if (ret)
+			return ret;
+		if (tmp & DS1337_BIT_OSF)
+			return -EINVAL;
+		break;
 	case mcp794xx:
 		if (!(tmp & MCP794XX_BIT_ST))
 			return -EINVAL;
@@ -343,6 +350,10 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
 				   DS1340_BIT_OSF, 0);
 		break;
+	case ds_1341:
+		regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
+				   DS1337_BIT_OSF, 0);
+		break;
 	case mcp794xx:
 		/*
 		 * these bits were cleared when preparing the date/time
-- 
2.49.0


