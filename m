Return-Path: <stable+bounces-119416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D9A42D75
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 21:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D817A6971
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6423A98E;
	Mon, 24 Feb 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JFatn8i3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124361D95B3;
	Mon, 24 Feb 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427907; cv=none; b=BeduY8SzZ5P5IQ48Gm+5JAntX3Pbz/Hmumh/xRV5sbQSjn3+596oUQsxlHTOttteisKrspJqo0yfK9l51F1D/VrKwvWpy8xOAk3Afk9bG3KxkFkJX6wvix5jEjptC2SniiITXT3sSqdLryrpO6ZWrK7ZVManEPdM9gWmoq6hlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427907; c=relaxed/simple;
	bh=6pjgEv5jtnNy5Tr5N+52m2Y75Q2sQRHkBtqg7KUsQ/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2ij2JN5/d4IylCpitWifdwmPHKW9/Meh1WtoqHtHRNjNYn5yapz6efC6h77kosIvt7/gSIvIfvahPFYLl4JfRRVL51o5x9aEUpRWLFEJ0a6IggAdq2AWPBjml13XjgniFwPfVZcEydU60oOZ3B1o5EwIfBpMIWlw1gWPAwVO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JFatn8i3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f406e9f80so4481832f8f.2;
        Mon, 24 Feb 2025 12:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740427904; x=1741032704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3FMH/6OT6haPXkk0Coaw8uEZuFy4LmsF2gw0IKEy6A=;
        b=JFatn8i3PVHMQqEUaO3kwAtTlMCg6pV2zh4YsUIA8mjTBE9uvvzq+lK2nbjonLHRdd
         +WgO90EUJD8RIDNqf8QMEyMMjysSwrU4FfEdsMgV4AH4UIwCb34qMfU95fawHHpUSxAs
         rDkXrX0M8uEs2InFABiYts4PEK3mRhxbXV5lnkK18IuEcDerNFJHK1uxFO6+5eqoRajF
         2RiAJxpGSB6ZE2/aWuSdpLU7lTX5LB9bs0sQe4boQZOKhkah9PdZOLY8u/zMOIsOthlp
         DnSSK0J6BqjQlZ6pGHpb68wYYsKs0XC4sK7XLgeMHX5vVll0gGZsj5mSeUTBONl0zKcv
         NRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427904; x=1741032704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3FMH/6OT6haPXkk0Coaw8uEZuFy4LmsF2gw0IKEy6A=;
        b=nYTD0cs2B8kXueuzLoeFpPhbObgpTCkwv43ewIU27ycbN25bVIDTFSm4dcmn+Ea/cU
         ZNGqy5uv1M3XEw8i681BdS7AuKfpo434aTIrpmFeX+obHlR7/J9PcKtjDeyrLZ3304oY
         IQ6rlZDwEPWVhqR5sAAZWIEUA7QzbI0tGa7Q0Y612t8h5HUv0060GjGZ+Yfjyd0j6+Wx
         SRe9m5XirXp8G5Stpjfv3YBD+EwpcEVQ3MyJTEhNKZnLWfrkMaEuow8rzhAkCBKkjW2+
         3Rvsr8ed49X8hUEOF8B1+5/JtVlq+yBN5azK6D2Grzqvr+aaWb0QkLZsQHJnQxrnXo+D
         wywQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaRJjqkazoohqeon/MjfC2hmsYScl6TuAIoVp4t6kDbXJkcOQIUQJsBxt7RMS2G+6LP0KVgKZkZqmQ9Sw=@vger.kernel.org, AJvYcCVxEi64eeDiznMBd2NT0sX6sciYo65x/xPG66l/MN+0jXUrIDKUawfrvyLEgIrreE7QNC75DUVT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/leEx75YhWmaznqWsCbeulRfI/NajlyuB3+TgNdG/5s4qpO6
	DCWnHs1fksKXYMTVWRVCS9v8Cdvq0YZ0T+8v5Te7J6zWj5BQ7XXu8BkBgIA=
X-Gm-Gg: ASbGncv6TTQRFAzNJ9V/HGC3Vu91S3mvNLpaAuHct25XE/Wcftn7HHRGsimemgB2WpG
	MtDLZxehgYImB6YH8GT9srMtG8PbFvVtB8hIPnuRaexHgHQFlA3A/gazLcUTLpDyDuP1pJh1A00
	qTDuA6CUZhBoIySUmfH5WIxEPoadQjFebTD2nXdV1ytO3jN0uUmRnaDLx4pIqNP9hZYjIeucG2H
	3aZ+i4VDenVJ6HBDVIgllgLDYeMsMNAdH46naZe6ecAJUpIqH0HFiuEAu0gmkdHc9pd8iTWtRnc
	QC1D0jjyvmk7eZwsOEQZim4ACf+WqFCQ5YFhgc7TkTtjcoddmN6Vt9e+sFIQaN7XYXR29ws6Im9
	81/A=
X-Google-Smtp-Source: AGHT+IHe8KpE28HGQKeYbj27ThBdPxfw/s6E0w3UGQhbS7t5bxK9YxgsSAbelbkmQWV5CiXmPKw8iA==
X-Received: by 2002:a5d:6daa:0:b0:38f:5481:1160 with SMTP id ffacd0b85a97d-38f6e95c313mr11347706f8f.15.1740427904212;
        Mon, 24 Feb 2025 12:11:44 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4180.dip0.t-ipconnect.de. [91.43.65.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882602sm14859f8f.41.2025.02.24.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 12:11:43 -0800 (PST)
Message-ID: <dec6835f-c708-4286-8746-594916362156@googlemail.com>
Date: Mon, 24 Feb 2025 21:11:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/154] 6.12.17-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142607.058226288@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.02.2025 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 154 patches in this series, all will be posted as a response
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

