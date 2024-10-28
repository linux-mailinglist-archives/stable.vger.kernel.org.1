Return-Path: <stable+bounces-89113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72B9B393D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8D1F226FC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1E1DF99D;
	Mon, 28 Oct 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="laRCOOV7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7D1DF975;
	Mon, 28 Oct 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140532; cv=none; b=KHWaRCjbAZjOmh32k4kxHdFHzS/BcxDqd2c8meXk5ccxGv7+vUflSljfjOIWyEHYT4tKfTcEqaNpqOtF+t1VsDOKUs7BGQxJovLwmXvBior0yiP0fzcZfXaDXOY4gOuWT7Xs9fa2Xr/BVZ6xGVUqGx1Rn9+kzTbMhxmXmjAadhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140532; c=relaxed/simple;
	bh=jnb+plD7goaSH8wIGYb1CGDhYn4Q9ZI3UyivcI/bHVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYnsZlUQWrZtH3ry/hC4lr5XtXt7GYReEuf6JuxF0yHbtU744XFtQbzN8XPIL2RT9qJOuiyYKYwbkGxHC5uWubMOnlBQiZ6O+GjYA3EHrLwASeWFX3pi+FLzeqHaUori0W2shV2oiMkumVa9B9K7452pVhvfdvtQFFc6YmLE1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=laRCOOV7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so44994245e9.1;
        Mon, 28 Oct 2024 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730140529; x=1730745329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wF7rFSZwpkrhJ/3IUc5qJkA4CHR7vXwnPrWxE1l4Tbo=;
        b=laRCOOV7Jzy8BKYkNHOnZ1tyJDvIOuGcbk7xLqfbeKgMvoTTBrOaYlHRLN03il2SRd
         x980Y3Dd75cOBKkYO9DkUsBMJvwPTd99JIP3e1eX9W2ecGZdXbCpWBzoebBWAUfqC05H
         STAzkgDRvCfHb5all/Wxfl6bhuoTxwuB4kXEZU45PWDOpDa1FsJPTuQpy+l/TBHSte1d
         MguDvWQgsdx8130I7FELutnFJRolMsUp2GNORRmoAiutyjfPsuDXaE3FaKjyTtswKFEs
         fFgOtEuL4pYTOiTa7c1SwpPa2jHNeUrfS8S98Y9AZhrc6eqfe4Uxha89DBJvW9Y95C8Y
         qzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140529; x=1730745329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF7rFSZwpkrhJ/3IUc5qJkA4CHR7vXwnPrWxE1l4Tbo=;
        b=vNIQLGM9hAvsWBTdp9iatXVuJKIjpnS8PENTgMIpAtzu5vU1fpVhYoZkKvZ9izf3eD
         fLfV7XLmEbiZay3oTj5Evi5yMRNQ9vPesqTeH8IdzX8nuPcwRFcBcpoZwu5ZfnCPV1BW
         8yhFRXmmGqHcWfLB4nNgjg+soMzkXn3P44+nmu8R4Gkhn/CFbH0jLwkVB+24UJx6xKJq
         //9soTRPWGe9ufl9uWIEI38tiOO9368aF4lgcsSn8xfIPhbfl3iihI+LBhqPe/8UztxZ
         znyP+xORzzhkjVdR4slu63iCTnGlb3iOz+liJYe2cnvKmG2pGsIQHpVDuQoIENOKH4ml
         0qQg==
X-Forwarded-Encrypted: i=1; AJvYcCUq+DerntRkSWu9jKAzIzBQVJmMcCiUDcIFg3zamUHXXhVFwyI5RYdIkw/YiIyd5DcaDRRPbLHgzCnV8z0=@vger.kernel.org, AJvYcCVTnIvd94C6CfZ0Nk7xoEZgsRnUC9Is2IJ3hCp4aCZEwZlr/dTxv1GtAHtfHyvrO9lz9llc/PKk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEW7DSws6+ZfRZb+gfCSMqWiRIx3P1YSno3CsbO9kEE5fmLopa
	oxlMyPODWor+WU9NDxQg6hM76/hKLSRt1DL65FzN44i2h/d+7Xg=
X-Google-Smtp-Source: AGHT+IFrF8O/vgnRf0qXwQYhmQQg+RuS042PM83nWHPdpH4prvOhTJm8gB5BidzVpegSXMZX+Y7NPA==
X-Received: by 2002:a05:600c:314a:b0:42f:8287:c24d with SMTP id 5b1f17b1804b1-4319acadbbemr85321105e9.21.1730140529141;
        Mon, 28 Oct 2024 11:35:29 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace6d.dip0.t-ipconnect.de. [91.42.206.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56eda3sm148736815e9.31.2024.10.28.11.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:35:28 -0700 (PDT)
Message-ID: <d5a2e80f-0482-43d0-b5a6-db3a69673060@googlemail.com>
Date: Mon, 28 Oct 2024 19:35:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/137] 6.1.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062258.708872330@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2024 um 07:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.115 release.
> There are 137 patches in this series, all will be posted as a response
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

