Return-Path: <stable+bounces-45264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B216B8C745D
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173A4B2555E
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94900143882;
	Thu, 16 May 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="Ytb/weWl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1A143754
	for <stable@vger.kernel.org>; Thu, 16 May 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853890; cv=none; b=rVb42u38WUo8vQH71yCAkJytesraiL763e5GprltlLmlcHcrAbWGNGzBw+UDTD7EpyhuCnCORWp+8Ijn9sz1NbMhsVPkl22vKgHq4++jcfSOuudYIgjia0HmszS0keeXYiKUNFQh3fwd/gj5kaypvgxrEpOlc2ACwnY+ozK7bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853890; c=relaxed/simple;
	bh=xK0v8AIiDlldUb7cHlwbOClImWx39ygN3bmMQvR/yHU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rB+tJBkGxfSzF90dJ5m70bQ4k34r5LPLLz6RH+54uE8jan8cf/P/4lFHnCqtfVECyql1RMGHaQlwjVyFifilTJC/UhHMKaIBkC+RHj/KOVSOQodnFhjnwhSra5feAyT2bmwRhZTlNzjF8nTuXjQpSecLmn0aFtntbUElrsbjm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=Ytb/weWl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42011507a4eso34616705e9.0
        for <stable@vger.kernel.org>; Thu, 16 May 2024 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715853884; x=1716458684; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+32cQaRlNd3o+CUtnhjXlS4PILQqk/uAUAGJBO3Exg=;
        b=Ytb/weWlyRKPFWsTjVq+u8/z4krnD07gO1tgWJshZh+tAxMTtTlEd6W4/VBgvPRFp7
         wNkj3XXUcpmHR17vWm0ZI7BnA2AWRFD9vIWbOMpePlxm0nNdz5DXBX1eIfa/Nn2n4hvx
         npCOSUQV1yyL3UBcURtn1lRqZmmG8Bb8G0yLVVxDXuEZpPJaz8q3CXM0W1d5OLPKU6D+
         UaWTmKuOOx6KdBhnwMAYNTfwO/Y4Q9e4iPKBnNJYlmb8MzKygJz6UziX1GZT4GHOvYCV
         z3NXTAuqQO+atIDQdAPr9hlTH8ZUwNcirev9/E88cvsC7cTEKfeYpkWHwiIxolkRwheI
         ixjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853884; x=1716458684;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+32cQaRlNd3o+CUtnhjXlS4PILQqk/uAUAGJBO3Exg=;
        b=NwU6hMVJkt52hEPdUztZnTWtKSP9lMW50zuQYMwWMCmQ6CazreHsckwnHdDR3gcGDT
         dzNgHdaHCK2gxkONq7c5FVjkUGO1P1bFd7FTxWDt9PM116fV3DFlDqHBwpTyCiHeKYhO
         FDV82x8o2WAL3TyPYm+ppEPMuPk2BWu4K1W2qpQkMdLs6F1uWBVDnIdx3KfSARX7q1iN
         Zh8DD+p63kktSHXm6FuiPdiLPX8bg9NXMGf0+rmKfcs16VMb/7+N3XI7+7TTv9mIqMSw
         5AbFQpixIYyxj2QKRWsGs8Yp5s8oVzrw2IWpLVQjIoeFhB+U88ZFRL5qIYWxQot8rGPK
         Gchg==
X-Gm-Message-State: AOJu0YwO+Ti0XkHkDsFTsN0T1K/sfFnu8ZWb4QKF1neLaucdYqR9Phab
	ky7U/15bXztjnOyQZ9UpGZ+/RXNFwXvVJt/cXydw8qx26gxIalpjxQ4CuJ6YnXwPctFM1qLA4BI
	pvnk=
X-Google-Smtp-Source: AGHT+IE502hCnYVxuHl3Lx02R7PRspz/3QxSmyTM59pQlB2gXWrH58mSiGsz0+72HhuUYaqVCus3bQ==
X-Received: by 2002:a05:600c:4513:b0:41f:df08:5ef7 with SMTP id 5b1f17b1804b1-41feac5a4a7mr131902395e9.28.1715853884106;
        Thu, 16 May 2024 03:04:44 -0700 (PDT)
Received: from [10.1.10.3] (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201916e7c6sm124787215e9.12.2024.05.16.03.04.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 03:04:43 -0700 (PDT)
Message-ID: <12c88a9d-0357-48b8-8f85-6f74a9d83a7b@smile.fr>
Date: Thu, 16 May 2024 12:04:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Yoann Congal <yoann.congal@smile.fr>
Subject: Pickup commit "mfd: stpmic1: Fix swapped mask/unmask in irq chip" for
 stable kernel?
Organization: Smile ECS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Please pickup commit c79e387389d5add7cb967d2f7622c3bf5550927b ("mfd: stpmic1: Fix swapped mask/unmask in irq chip")
for inclusion in stable kernel 6.1.y.

This fixes this warning at boot:
  stpmic1 [...]: mask_base and unmask_base are inverted, please fix it

It also avoid to invert masks later in IRQ framework so regression risks should be minimal.

Thanks!
-- 
Yoann Congal
Smile ECS - Tech Expert

