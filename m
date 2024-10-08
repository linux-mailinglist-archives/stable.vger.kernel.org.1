Return-Path: <stable+bounces-81508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B4993E0A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF82F28170B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAC446B4;
	Tue,  8 Oct 2024 04:35:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F052B9BB
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 04:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728362123; cv=none; b=IMqHSsAJCTCD5DszJkLSUjdr0ZP7enepZOd+ZcESYZkZ1X/peGRWNOr+YrTe9Lg6gq28T8FIbLa+It4u5+6DxFdk4TLeMioJWbs/mzszlO20GUm0fzYj5uZekHSwMuMA925cEmrqrqKbKYyvVyp9IsFG23gk43sjqIgkM77LwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728362123; c=relaxed/simple;
	bh=9zXfW7sf7tF7D3V1ruzEbJtGiOrXMgE5pvFOG7+sDjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgKxJ/MK/TOYafircpz0z6i6I2t8GNd2i30R7PtaAbUURsYdhs2tLvOI4VjqnbI+BPofifW1VoBXleOVyycnaAmh5+QiGxB62fFYLCH8dM5gab9yng2lfIp9aPMQEvhGpFkLmn0E+0aYQ5PQSqIr/EXOiPeVjdrcM46rpUfVEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1457786a12.3
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 21:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728362121; x=1728966921;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cglZ23D4MmN5YFbZud7Ft5LNLo1mduZvjSV22voGLk=;
        b=hM1C/aBAD/JhmF4b8f5tgr4UPQ+rpVPn2INN+H/EuzrciZS3DRGrUKmzc9fNszkLzN
         PPGKZ+AuUK78tDNvKdlxNWBwO5GYoUVyz/vh7CmYhz1IQJzoKeimfsPzYTSPk4Mwi7r1
         xFDZ6pvWoY49jemO1m2ixfrDVITFiFjDDD3ZutyoU28gr+yHp9otODMDOEfK51tI2n9k
         SyDP4VMjslAo25J+s11VfGl9bY8JaVx3l/ajBreE1km55/A34U6StuY2MzeVdbzZfxFU
         g8RVqxR9kDhF/1rRKNJkEX3pjoSRqUYjfLizgU8wE1vWKaDFjdrZ6prTBUCFEkpbKSNj
         HskA==
X-Forwarded-Encrypted: i=1; AJvYcCWVjSDue+i+qgQRCcgVNsRIUQwYyy59a4pbdbbnQW6icKG6qv8UcdDN/36agZ/uT47ScUblF1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI6+ezTymgYu/e4/ux+XOQp4MYNvdCXATiM6AXqCg+o6LWAcc
	2wIXi+VavsBsOb05sALAFCKPB/QHXVc3Ebh204X6vxRemIviiWyT
X-Google-Smtp-Source: AGHT+IFdhDw+A96t87Z7XoyCt/EFn5FvvF3EhxypMDz5wRWKmyBbrExkja4Q0zPrvmEDKjsUp4gotQ==
X-Received: by 2002:a05:6402:13c2:b0:5c8:9f3c:ea01 with SMTP id 4fb4d7f45d1cf-5c8d2d01097mr13468727a12.2.1728362120379;
        Mon, 07 Oct 2024 21:35:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e049ee6asm3939881a12.0.2024.10.07.21.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:35:19 -0700 (PDT)
Message-ID: <d0232dfe-f20b-45b3-b523-e86febe4ad5a@kernel.org>
Date: Tue, 8 Oct 2024 06:35:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in 6.11.2
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: 'Roman Gilg' <romangg@manjaro.org>
References: <d75e0922-ec80-4ef1-880a-fba98a67ffe5@amd.com>
 <602fc890-8924-4ff4-904c-8bc561745b46@manjaro.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <602fc890-8924-4ff4-904c-8bc561745b46@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08. 10. 24, 3:35, Philip Müller wrote:
> On 8/10/24 03:33, Mario Limonciello wrote:
>> Hi,
>>
>> commit 872b8f14d772 ("drm/amd/display: Validate backlight caps are 
>> sane") was added to stable trees to fix a brightness problem on one 
>> laptop on a buggy firmware but with how aggressive it was it caused a 
>> problem on another.
>>
>> Fortunately the problem on the other was already fixed in 6.12 though!
>>
>> commit 87d749a6aab7 ("drm/amd/display: Allow backlight to go below 
>> `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`")
>>
>> Can that commit please be brought everywhere that 872b8f14d772 went?
>>
>> Thanks!
> 
> So far commit 872b8f14d772 got added to 6.11.2, 6.10.13 and 6.6.54.
> It is also queued up for upcoming 6.1.113 and 5.15.168.

This is confusing -- Mario used a wrong SHA.

The (correct) bad one is:
327e62f47eb5 drm/amd/display: Validate backlight caps are sane
and is present:
queue-5.15/drm-amd-display-validate-backlight-caps-are-sane.patch
queue-6.1/drm-amd-display-validate-backlight-caps-are-sane.patch
releases/6.10.13/drm-amd-display-validate-backlight-caps-are-sane.patch
releases/6.11.2/drm-amd-display-validate-backlight-caps-are-sane.patch
releases/6.6.54/drm-amd-display-validate-backlight-caps-are-sane.patch


The good one is:
87d749a6aab7 drm/amd/display: Allow backlight to go below 
`AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`

and is nowhere.

thanks,
-- 
js
suse labs


