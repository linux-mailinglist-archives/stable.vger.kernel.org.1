Return-Path: <stable+bounces-91837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079279C08DC
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C6DB230E5
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FF212D0A;
	Thu,  7 Nov 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SPzde+DZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE721218A;
	Thu,  7 Nov 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989601; cv=none; b=gOlWSOTqRL8Jk/6nrQGNizpN39V2Fk9c1fOy9WSh1doc5XI9G3rxzC0HBQVrLIjiQxRaUB06tKUY1B7XgSiMN+bhs2rw7nr5BeTgsHWlodB+B+HDFsZqkYroCQAlaEDfmOqqFIXsSjicWpdmV7sfz3Bxn8A9uwdzdIWFU3w7KPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989601; c=relaxed/simple;
	bh=IZ1L6Ihm8Joep60ZOkXArh7N57MsF6DTK72afzXGdrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSzERs734Z8pvDNHo+H/SNwnD7F6mNkzpEb4hLsZCtOQSXmoDCkQ52MWIesLCfmxrSA2C4in0g8LFhHM2T9lXBpwqH65OzQYaUtmY6YFYTtJMXNp6qEJhH4wgDZrFcRTqh8gvdWXDOVzk8ueLwXDjubVSjxma6PJU2lUgmUWmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SPzde+DZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso9347065e9.0;
        Thu, 07 Nov 2024 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730989598; x=1731594398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lWe+8OTr1x391V84LUEUDWwUDsOdkE6GAj381Q8PLc=;
        b=SPzde+DZwfOeHiCfvN3xxk2YQBzs7PaBTq/g3NFo3l6Yz5x+xg1E/HGyKUmmp/+yZG
         i1UgvKKy91rRBjzXriHsK/vxDVOGDYVgGwQYs34VbyUPipovURJehs+DvUZUNmmpR54T
         X7EdftOZ0ONPIB3S6EGp9km+cjL5FWBfQaouuQTxM7NI+LnK47fY6ZAp8AgpGCQv6/Sv
         x12S+QXltID08PxFeFIvZ8ItudfUeCHdjYV0mF7gWYf75t1C64Dr2zGOF2kgyGumkoXU
         hV8E2QnBjZAf+mfQ0OPvxJq1O1OOaBIKdPsGRv0RQ4E0zihhLvUmeoIghEfbg7E7zJod
         LwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989598; x=1731594398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWe+8OTr1x391V84LUEUDWwUDsOdkE6GAj381Q8PLc=;
        b=hRHsCci5d1GZ0kpYUN9lRgrIvVlNJmiJl4BZelH3ffOVgVVNy5AmsLML9V9AY7+o7h
         acag58hzvhLOrsgei38DccZXcP7W4n+Y0fCgL3ZOqEZ+DijljGIvbiHg43ZUdeBg3nZe
         EqscKsOY4RS7hcLsEg5gjTwPI9WCU7Jipb5ReZXMi6A2tq1tv6XQYyqhi7LYuef3ncUU
         cIm86N9bwzMuODyhfX5/+hPeKuHIy/AcNpkNmXX8bDBJi/nPHet0zVtOGtepp+XMUXDu
         G2eYDwzyAejhmx9PcIWJwjf7Nn9oy59HCt404Sy/ZkazbjUsJxpSdEv2uFCU4bQ85db5
         DTNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMEjglyCwz1kRVBFPkqBiXOFzEdWBCm44X+dfhdW0cRNG+3PYa42hRZpYQyl8lUE1ufW0sZMTCO7r5g7s=@vger.kernel.org, AJvYcCWi92+cNwLwcslqvKCWAvMORCeyov8LDiJijkbAkevNkpHtzXdhHoOo40Qf49pQWcZ6NxtOd3OH@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdN/nBcSOGI3yA1x8xPH7Ke/ygCTwEfd9igNbgnUV2xsfygMN
	I0XBjr1exeBc0yaA92ZuBePvVf1zKSUcAoKK3kFS1XgPBu+IseQ=
X-Google-Smtp-Source: AGHT+IHL0wi7WKTvPc5hxP5ofUXYUbtQb+bUpSZkX57u5JK3fnO3kXSjXOKKaPT73hDp1BFuoTcl6w==
X-Received: by 2002:a05:600c:1d09:b0:431:5f3b:6ae4 with SMTP id 5b1f17b1804b1-43283255a5bmr214848015e9.17.1730989597555;
        Thu, 07 Nov 2024 06:26:37 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac486.dip0.t-ipconnect.de. [91.42.196.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c2161sm26038635e9.31.2024.11.07.06.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 06:26:36 -0800 (PST)
Message-ID: <6f515d2c-80dd-4868-893f-194dd8e2963f@googlemail.com>
Date: Thu, 7 Nov 2024 15:26:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241107064547.006019150@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.11.2024 um 07:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
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

