Return-Path: <stable+bounces-40218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CA8AA415
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAB282C0C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F216C69F;
	Thu, 18 Apr 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkmBmgbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D95427E
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472587; cv=none; b=EPo1Mk2wxP+3n5Vw1fXtHO51x9Cj9+Gzw17T0SGzhyWzTorxBcIqEBhoME+cysZPh9TNE6SVqb7T8aL173+X/G+mpGq9XU3AeMZWJ5VcCi4rVwDIurIT20OHfdRunn4Hixop858CWyXjup3FrsmgbkMD9YN175tvGcB5qJ2sA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472587; c=relaxed/simple;
	bh=k39FpRlPIcxrGOlELeiH2EM74K6VnTNJuFqml0sm94o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PUeiHhZ9rRrszz/iIJwqDvcQIbKo/imxixmVFQu9i0zMTgNvy5I/+dB8VSd0oT+wDjwlJy5340zVw0gAcFhDiwohuwBDyBudiBbXx41pOyZP92k1KgJP69sb4CkUZ4g1Ne5B4/JT8RZz2ka/DrRzxv3z2p5EzSPqoooY+XzbTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkmBmgbf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41550858cabso10227585e9.2
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472583; x=1714077383; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHWUVv0nX0qDuW2AQePgV40KfkeywUJ3WM2jnLVn2ck=;
        b=HkmBmgbfR7vU1Iuyimk1EL/pjl4sB4ZZZGNkCEk7kNsstt8zhn/kxZfiFP3VUHdXNp
         1fFNEtnmmVY8pa2CMkQYAKCN7PXyLaNC8oKq8hn+9o96q6q72+MbZZmvLOSx4baBBr6c
         JBoDtuEwH2/Y/0w0Uvn2NCNTP/lfLPaWEYv57l8vy+2/Fyeejkd6jvykq0RxLEhdIe07
         I9dBIEHEmUXQTjpRR2k1zk7VCSE/89mCEGzKVEyWiu0o2+Y+3hyihdBjc9UIuoJDv0zX
         ss4X3odB2oBbzQEnWSOisriQbqQTqx2Jk6WErlzuHW54lEmTfXh64ycDxz2dVzsYbjG1
         RdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472583; x=1714077383;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHWUVv0nX0qDuW2AQePgV40KfkeywUJ3WM2jnLVn2ck=;
        b=B1Vd3NVJWNzkakGu3IuI+twCU9nemWsNDz/y8tKu/pqVl1RFv/HDUnmNmz1d9OHk2Z
         DJ2xu8y+JO78exf/YAm6gwDlfvTHtYqU6NgpCeqLuzUA4+ipITM8DiSg9wuJY9hzHezx
         1meIH5JDHNtW0D08W3bcNQxWJApKRcLpXzwyfSCEZTwOBWBIv53VKe1cQfOQ7D/HmguB
         vAwyUi6QqJdSCFfeAP1a7rbay/u4szOFm8guxbxDY4CgrRNXxTCg7LRg6V9aJBn26z08
         0Kqbh4UYw3wQwhlBTSp8kSVkhHk3DTIdDmYYNLDzElk00KAVBGMwKJESkCWQT4ysGNks
         qZLQ==
X-Gm-Message-State: AOJu0YzuwFYzlpdjI5PW6OUSMhVctEl0Qf22vqeRtLunQ8rVRF7XwYyz
	aLNVtdvkNqKVY5pfHV77na9K4rwFN/6Hc9kvEC+QwbaEqUmXeCU8VyNRBQ==
X-Google-Smtp-Source: AGHT+IHtMuPQKLzjU7lRwAYaydYsP9w/N6QltzZKLDglya0jEKxhI4slyEHPS1BVi6e/1rgBMWlHrQ==
X-Received: by 2002:a05:600c:5008:b0:416:3db7:74b4 with SMTP id n8-20020a05600c500800b004163db774b4mr11708wmr.24.1713472582678;
        Thu, 18 Apr 2024 13:36:22 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a7c:3800:df8:a4c3:282a:f888? (dynamic-2a01-0c22-7a7c-3800-0df8-a4c3-282a-f888.c22.pool.telefonica.de. [2a01:c22:7a7c:3800:df8:a4c3:282a:f888])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm4589737wmq.0.2024.04.18.13.36.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:36:22 -0700 (PDT)
Message-ID: <8bfda5e5-083c-4555-a79b-155bb426ccc3@gmail.com>
Date: Thu, 18 Apr 2024 22:36:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] r8169: add missing conditional compiling for call to
 r8169_remove_leds
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Upstream commit 97e176fcbbf3c0f2bd410c9b241177c051f57176 ]

Add missing dependency on CONFIG_R8169_LEDS. As-is a link error occurs
if config option CONFIG_R8169_LEDS isn't enabled.

Fixes: 19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
Cc: <stable@vger.kernel.org> # 6.8.x
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This for v6.8 only.
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2cc1c36ab..32b73f398 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4932,7 +4932,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
-	r8169_remove_leds(tp->leds);
+	if (IS_ENABLED(CONFIG_R8169_LEDS))
+		r8169_remove_leds(tp->leds);
 
 	unregister_netdev(tp->dev);
 
-- 
2.44.0


