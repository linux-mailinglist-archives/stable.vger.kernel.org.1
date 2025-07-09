Return-Path: <stable+bounces-161501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74CCAFF4B4
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CC35884A3
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D249156237;
	Wed,  9 Jul 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDpx9rWv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290A1CAA85
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100226; cv=none; b=R7RFJG6ROaYRDGpPvS9ew4+oW6Pf3+WDRAnXJ4RMdDV68jOG1oGTccxev7TyhtWoR2v3BB2Km+toDEu+3OTYKe8XUQmRsHLY8SwuJADTf1toZqSBNrzbFc32IHVUSII49pXuYFLTRSP9CzCfFxpQzQNEx5mKmVkYDC4EWFKwffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100226; c=relaxed/simple;
	bh=aF6G9tcF+Fa4cdy8Ks736TFpC2f8/b5Mmv1ONlQmOLE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fObqF0eOVpxD1MmfwoXpVY92kS/GggEuk1Nqngn6Mva0cDOebi5ebnQMhRxtmVfBZ4MtCbLB82QjUmVFXLG6Pgvs2cUjhJCyGeHJlwC0uPqIQn79beAyJjijh1yquY5uL2pL1QxGbR3s7yqCgo9chqbGDdpTxIy1A8J+cag6VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDpx9rWv; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73cddf31c47so256962a34.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100224; x=1752705024; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWhp40Wpv88SghmfVuASW0XdDtJo+/gOASyVSSNL1kc=;
        b=jDpx9rWvZLsqk19kwCxskcbVId2IBC/OJZn2JDKYEjcwbAU9faKvJslGm1QS7kOzlc
         2rLtoRRm+mHmKYHniuEh44v+OC2IC/Cd8VtEa174EQsFuBuKcTRENWBuh/FaWSvsIU/G
         tIqfUA4uRUvJgIxKEf0WMp4mBtfqc+MknfUFdIIQ9leujMLNQnjwTh7tnUZ7T+UjaSht
         IGhwwIJyMUAnrVOVXHaVGMlQI5CbvRCRXF8p/NWvJIKKTILgNS3r4iVwkxj3u9un5Q5l
         Rq3AOJxZG9fylv5Zl33OCU8CY56fiUmR1m7Fzm1nHz8rSRWu0PvxGj7hiKPcopCoD7HM
         +9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100224; x=1752705024;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWhp40Wpv88SghmfVuASW0XdDtJo+/gOASyVSSNL1kc=;
        b=a9agd4zSLv6ZqWllLKZtlCMzIJZHQNa+9Vjp3n42kCvQfvMn34f1/fxrQToUKAE3mC
         dYSpxNLJko+Ser7oqKAAjeTqezMgvkCmscOqwIVueHuqjCl9zbM2KNCqBmnxwNdI5+dZ
         XsiXFEJw9/ruUmNWZAI5E7n3v1w51XUYijJDNFu/wF/0uKbGMvtjLsX3Dnanjki4BfL2
         DNKWxSqN+9BHSdWXS3l5e9ZTvCylt4J2yUKyIx7gkEKrrPx1ZbjMCMG5FOTqNKo1pcaS
         BXi8FXQoMb4ROrAmDX4+QM2S0NgJR1BC1c/U6Bq/cmbkhTtNghtDJuWggiZ7VSyrUDWb
         8pvA==
X-Forwarded-Encrypted: i=1; AJvYcCUUvxrhcomuezL6erhNYaTNkLa7aYgu/XvfB28JShdud6vNUR/Wgpd7JFQCkJU03ZcwH0hSc1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUk6eQWX3PT9cloDD6Fv1xkX6jWbIeAzGYGHSg7D/7Ef/5DLcc
	0yohAbarwF6na3SjXPI+CGkarc95soXsHET3Ox68avp4aN0VJ3jOvxmU0t2TiI0=
X-Gm-Gg: ASbGncuPlPkmXPYh2ChXf/LQVnv1aCeXXZWItyZj6ZtOcCqwm78UUYbFKxUDyY2uBzg
	oHxUMMcvC666n2YU1jz8dwFawt9DF/90ScvnVuH+iyYZnQpFD/YauUisIqIX5x8ABUF6wqGysao
	yAUbYhagGDJMfaw8IFwE87a0e8lknMqRBghmCAJjYQR2+WpAU7CiQWpDsU1atxvpzt5a/HnABN3
	/znpsgQB+XP0Wr7uo6yqhUaexFrwJzqex4sGan3gn0XMs/FCG+ZBnLLSxGzsW12D/yEAzhxQROG
	JhNQW8mdogarSbi92oVd8kL5N+aySFLQfr0hhmg9us/66inq4WR/WGYnrY/w3roZZ5LhqfECXkf
	q7jBuPpo1mo3osQDofecaruiIVa/E
X-Google-Smtp-Source: AGHT+IEP7e6rebwVU9kFKVc/2nFC2m1ybjfuVPujaF/xQvCzc8T5aJRMsy5VTVejd764hTtcEb375w==
X-Received: by 2002:a05:6830:8104:b0:73b:2617:87f1 with SMTP id 46e09a7af769-73cf06c1987mr236078a34.28.1752100224413;
        Wed, 09 Jul 2025 15:30:24 -0700 (PDT)
Received: from ?IPV6:2600:8804:8c40:ef:e529:73bf:275e:58f6? ([2600:8804:8c40:ef:e529:73bf:275e:58f6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf1275280sm19241a34.31.2025.07.09.15.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:30:24 -0700 (PDT)
Message-ID: <10c5e84f-c2af-4398-b44d-0459760d1b09@gmail.com>
Date: Wed, 9 Jul 2025 17:30:22 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless <linux-wireless@vger.kernel.org> Felix Fietkau"
 <nbd@nbd.name>, stable@vger.kernel.org
From: Nick Morrow <morrownr@gmail.com>
Subject: [PATCH wireless-next] wifi: mt76: mt7925u: Add VID/PID for Netgear
 A9000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From 17bf632a10e843af7a5f80d9e1449c5c26bb8486 Mon Sep 17 00:00:00 2001
From: Nick Morrow <morrownr@gmail.com>
Date: Tue, 8 Jul 2025 16:40:42 -0500
Subject: [PATCH wireless-next] wifi: mt76: mt7925u: Add VID/PID for Netgear A9000

Add VID/PID 0846/9072 for recently released Netgear A9000.

Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 4dfbc1b6cfdd..bf040f34e4b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A9000 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ },
 };
 
-- 
2.48.1

