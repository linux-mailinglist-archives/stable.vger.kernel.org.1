Return-Path: <stable+bounces-126809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A55A726D6
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F29F3ACEDD
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109801DDC1E;
	Wed, 26 Mar 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aYbkrPBV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DD19644B;
	Wed, 26 Mar 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030290; cv=none; b=ocNhLyaOGyLyvCp4ZnvswN3lSzjWODBiLk2woPmKKwkfStV+oyQ3K+uTfidQt56j9J9h2LOpMiSr9zyRs6VT/o16fx0AzIzFFgoSrYnBhm4GjCdRymOstDxq8gUcn255EsDttD5nNa2eXrsKEY747V1SUQt4489/9sxztvXjgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030290; c=relaxed/simple;
	bh=lu0985pnAiWIeLqiiXNJyyeE3/4K9/7b88UOr7N8zC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeY9c5tX6pVzgs9lLMxMuZKXKN9mlc7cJA06nErRlCx4S6tzTb9felFqiIzXzh0tCkQcHZi9z3L6jfQ3jFbgLqVYKgmjTkgOLpU4SWteezoZR2YS/QOcSukq1NzlGmTBPz2OJb32v2V8854tJNtRARvfx0FgGOn3q4WnQc89hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aYbkrPBV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso987852f8f.1;
        Wed, 26 Mar 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743030287; x=1743635087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1Db4+giVOhxRRsgeVFOY4J55f6l7WCs95jCreUUDT4=;
        b=aYbkrPBVn/XMIAFeb2dfpqq8KLWfH0dnDpQ0qgHiWTix4h0gyoPTy+Pa4LCPAd1ojJ
         401VBsHHt7r101DuKjbboYoGmYHvtvwKxhnS2eaBntLCyPYvAmeJPECk9UAUEJLRPSZG
         aXtwNW5kPOq1StwpoHgAiByZMOQMZA34FPlWRTBIBqC5AgP4du5BQ6YfVma96/opSX/8
         bvwIF4SHnUIyYtVtsAeFVpWjfVMig2ouKQmOiMDKP5E54YS1vVX8YtzpzszbFbr3j0Ii
         Ym4UbmOIdCA6N4Mz82NZd286rWKevb7HrCYco5r/YKJsczhI/QpZSCIBfP7vMgDjFkUr
         1VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743030287; x=1743635087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Db4+giVOhxRRsgeVFOY4J55f6l7WCs95jCreUUDT4=;
        b=n/MwUfV0PAcivbASyRi98aNd5D0uu+JxpNY6NdMwS5Lc1ORYNiWNPVpL3nbd99kk92
         TWBYDaxQDIHLTCqx7uckEWxLlJwFzlTQTUi1JRSLVJmx0LwwlvxX9N9LohjljmDYi9cy
         jXSqbVGfCIkFDDHLcbYnLuNl7ut/5kS0en1aKb7Q06/hQMEkPUHoxAh9XX43x48HZdlT
         VZIEupQutlDCPxloWPmwnLZjsA8XhE65vTEbHTpSw86TzF7WUZozl8gXkBKiybQ9CWzW
         hDF1hC2bYh9xsisI5uQE6zk0VMMumKaMZeD0co3K3HgiyfwEx8CRy0udepy3zXNYO6rJ
         Fv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa7lk1pz/fPwhGs5JIPWcjrri2CTrAzZK+ZGYJ8uNeRkbFV6wv3MOppTvL31V/n8McMS8gszFI@vger.kernel.org, AJvYcCWe+lBGtldHJP8cSPjQ6Sl6ujrUcTMUnfxICx3+5v1yWv/tUth7Ahsk4s7N+GLUntgIVznTLbDop/pSlsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wog5iEysEwilqPR91p6S/zdn5SymjjyR/e/yoAXU29RAej7q
	lLbA7aELIwW8m/Lu0vjEou5U2oj016EPiiAksivoKcHlZ5FLqMM=
X-Gm-Gg: ASbGncs9dIlqy2STCfzlpCkmQxYs1msdgAK4r+IbSCe1MYc/yY9dTlkoRW/38hXppfU
	VwTSMHcPs1PPoig/BLQhWGK+4k7xZyKmDoyNtk/Aw4X7H8fx6FWOMvY3tusLAAQZTFJdOQeAcVg
	Th6OYve/tugTEBHWX8ccycVOv15irm9LczfB7T9Sosk0caxyIQ10AkVLqSWt+ccqm94z04aPcLJ
	PtCnd/KJWGpxOesRKXvC0umPcRSELxt9y0CBWmhb9qBgv3p7Kp35bWH/T1eBCeHpSzkAp8EoJDj
	Q9Do3vPrQzz/QbZG6Ve6bZkGtYn80wi/Tl+LIZgJFCuliyvaoHsCCEeUQSOfwtb/W5NIYOxFQyj
	J59iceIhClKeg7MpbbfQG
X-Google-Smtp-Source: AGHT+IEYCg6JrwvA9ri9z4o/+GNt/2rRyXIUH7v3Awan8sMK7hJCRKxqpK5ZlWFLSeEigUNOVXrQJg==
X-Received: by 2002:a5d:6d01:0:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-39ad14f7f07mr1284508f8f.13.1743030287279;
        Wed, 26 Mar 2025 16:04:47 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a21.dip0.t-ipconnect.de. [91.5.122.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ad0c6bae8sm1940263f8f.68.2025.03.26.16.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 16:04:44 -0700 (PDT)
Message-ID: <d3ca01f7-08a1-4725-9007-b6d127de0b1d@googlemail.com>
Date: Thu, 27 Mar 2025 00:04:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250325122149.058346343@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.03.2025 um 13:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

