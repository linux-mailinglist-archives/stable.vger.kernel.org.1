Return-Path: <stable+bounces-164395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71546B0EBFE
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476453A1689
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F487277C82;
	Wed, 23 Jul 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k7Y6gWc6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5B277803;
	Wed, 23 Jul 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255930; cv=none; b=Z8C/rEttQUiDg9eTaQkuAQeWCr2Vv8cg8Zp9zE7N6JDRIwEg2lA/gaBn5IAp7CFHyAObKG15xM2Dz7MMJ+yeMtq/mFQ2wyxR7ihEVL+9V78YKEcP65mq4yG5OAvz5ez0n3o6Gvy01KMMBlhYRUa6XfUZ8oJnwNJKHe52LjQ7WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255930; c=relaxed/simple;
	bh=53FRn1dg5nX7qRA6SkVZVVkyE6GAjP4N8MbpH3Gndlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc54QUQGqZ2LNTtxHBjYUxeA2aCNpdLZB5WFxsq4NAXOcvVDlMNx3OmwWTQRIC5L3PppmoOVlP6FX4iMn4jW9raXi9/FqvjBTj03LM3bIIRbnkfs6rNHEQafgIwbjZ9fxgNhfIztSy1oEFHr74QOEkVrL+IaioTxJN+gwBhp5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k7Y6gWc6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a528243636so3809741f8f.3;
        Wed, 23 Jul 2025 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753255927; x=1753860727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/P0pFS6WBNNgY7NAWkRahkU88sfun4LTwe81ga9tlc=;
        b=k7Y6gWc6VY3T6vb5KF60z47yL096nx9mMzIQmz2dHCL49bsGhcQyOJ4OTzJXlfMJyz
         E5LYJ5cnp+LfABSjv7dWZkcEiswOU7x22YLNKNTylf+cg786mD2cqi4qVHn+crmPpo3Z
         93w+IlHDYDFBTTNlDwS9G9ji8l6Xh2987DsZgS+BYSYQt8H28MGAhzboasvScHoHF2uu
         OZCTz+OYOypOguErH4cM5YNMjloUuJzyvYVn1H7GtN9a92Fy0MOBuCIcos7q6Bb3YH8j
         BeJzlD1VX00NUNoY3zgqAzbrp4bvNkXrFtUQtF3OtN/andMI44pVYmItgCxdrY/wke1w
         EY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255927; x=1753860727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/P0pFS6WBNNgY7NAWkRahkU88sfun4LTwe81ga9tlc=;
        b=PP3g/GJJqEKizbVR20Hyhf46terCu7G4ZNeDzZon01pjtWqlpHzDdxy4yXc5Oa+fSP
         eyTRfScj9U9N1Uh71xhYUoai7XBhU7Zngmu0si5SnIpMqvUoQ8hxHomITk1633wzMzms
         EQWNA6I5qUyjFZxmiGzDMiBrTqIMUf2TVSLB36eSELPoOpaIviYkRdW3aVuzgb7rY+aJ
         mQPIsRtVOB3/ts4+T7WOo6kA0Dq7xTt329Qig7gs2kzy4ufkyTY/dNvdENsyd1I+mIym
         ea9MK58rzePR1hl4i0H2Zy1drdGOGtegMhr95Xl3FQPEeVKNXaCr/cUxcEoeZ/afHcrF
         Lx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQLvWeF/anCDyJHwRwuLjIhYim3GENKNtKdyf+muysrUrmYryIPuueITxIkMqB2IKjjX/4v5lT@vger.kernel.org, AJvYcCWtyw8wwGVeQbtMzLJumnbcYa8OiPFndm3EwjAhTOBMRSWXJazncprHx2QRbejtFM2mefOfrq4zeTh+XmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNemUaWbSkTuEZ14nVMOSRtzk+hT+Ypg51f/aqATnVDwLSWmK
	fa5lHv4TASBak+jiJEJQrCjKZjqNLxGk+8xTMcPbXhMH+lRN1Qk5g/A=
X-Gm-Gg: ASbGnct9gaKrKI1jjTMuk/0v9lzvijp4+2Qd8fzrc+C5lP80W17LPDvuwjHylYrDfvG
	93Uw30QoGsn2dAksS+guDkbF8rqeEPxYxxhSvN8kFrmUi5GE5Dh82jkSCEIMZ9eaTnNSyq4Mtma
	ztMZP/lW6XKLnuH9bRNdfCVlshIE9godYLLGttd3/HZWvQ5gXqQ8XdK3FV71m+fVqSPz2+4l80x
	yW3Z9H2RVnizCHKfBaCTCFZxgzCB/U9C6vIHF5IZLrp0p1GqrdXGJfb0C916psKj2qYeCTi7Je4
	ef4VZXi8K8YTf2gkA1a8jhPH9UT8srVGBWvlRLhZ+1kT9hFePrT3kN4HcHYQ0SXrzWx8oSjCWZU
	urioqkJZ6sGHqfbj7YlAEAebrJsxNuJT7UTWEhsZOjdoambidw5maY/gq9PtBrm2QH7+tcZsqLQ
	HWlnBGf/h2P9o=
X-Google-Smtp-Source: AGHT+IFlJDf15up2Xv/cRTUYlYOXXf1nRIW3wifWm4bDqNWuGTxkTGB+WrYc1h56uOBrzbnlnF5L/g==
X-Received: by 2002:a05:6000:26cd:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3b768f2e446mr1325854f8f.59.1753255926559;
        Wed, 23 Jul 2025 00:32:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7d3.dip0.t-ipconnect.de. [91.42.199.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7efsm15569792f8f.67.2025.07.23.00.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:32:05 -0700 (PDT)
Message-ID: <7984be98-e376-42a3-83f1-e2d572757491@googlemail.com>
Date: Wed, 23 Jul 2025 09:32:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134340.596340262@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2025 um 15:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
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

