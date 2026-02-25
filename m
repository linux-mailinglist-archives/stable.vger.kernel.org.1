Return-Path: <stable+bounces-219670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOfJFzApn2nmZAQAu9opvQ
	(envelope-from <stable+bounces-219670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:54:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8019B020
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B8F301083F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE9392C26;
	Wed, 25 Feb 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="b/1gPYPs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC33D6463
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038440; cv=pass; b=RNnND/bu4mVwd379KutsoFDOx1xIs632LV4aW+xxz28JB6MtjiE2gtulmaOGIq15+4W9FwO9S9eNG2UnphkJ9U/vhRkniSSxG7JAJAJYRHkGoGg/WeQQoJIkatnerh+EEf7cJBvWDQmDXI9qSreXlFIjGSs3h+Xa0jyDr/uQ70c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038440; c=relaxed/simple;
	bh=+jwwOMlDpF2XCSZ9kzfJ4KmiB+RpQRwJoSNMGbCFXMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvo559jjDK1hO9wwar+YYBhpOa7lGPTKWLl+u7ukftt9Tj6BakWSISUJizkTQl7Fwyi+jzliClPpLvFixgUUubDk7uVrWo4lScOYf3ByeVBXIOe/BoQEOqB8QclRROCn4wVZyg41NTiBH6lHt+tYGqAcaZr5RtGBsQNBtPwF6is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=b/1gPYPs; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65bf302471dso7373202a12.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 08:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772038438; cv=none;
        d=google.com; s=arc-20240605;
        b=ScTakAfe7FPP//8E09PIc4STkddJwDG9JKu+saSsYVHAAQ/DAOtqdOEcuyL32raOdf
         aCSzd0d63f3sfau/j28DlcKA0y2Yxiqc6x7j3kjv9sF3LwIRePrEmJL1BjJe0j+Si3Qp
         GrbUXq12CizV2QcEMAuCCmrYFEbwvvldsEJRzgATkod1GNYhqQesQtujzIN2t8vsxFk+
         3hRPXbp/rXSC83pxF0RJO1Ps6VS9yqfwsvesKz/caaCvyal6YFrBzi69GtcTwwNotash
         Xr2DTod+RSUHCCYCaJXXcw8s0RSv75UavfuZ7miCc4eOn8bfbFUymestKbslrj6fQyCT
         f4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wi7RhDvs4J0GLmNN245z19usKf/YAkhKYx5CMJsLMlY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ZhPs25D7NK5pbyGjXke7JTAx4q560emm92FBKQ7a3r4D3sDp69nYL6y9anvFHwoTM3
         B5Imh9EIKC4l0mJKqaTK/SMKSX+hXuh8jOnKLm79THUWIylRLy1s8LVhPJs0Cl3VLUMT
         qoeWcVK7Iind80XxoNyUwhFqMk/UQiLu3/L8Gs8fVgnqgj7npBiDgyxGAdyWMv9o5A6P
         H6ofQW6mIWUGZ4E6XI/faRLKBToPcwnKZaCrZ9nKZkukz7luzDKZrxAfMq+r7KivpnpT
         zxvmiIKoplkfVADFXPhcCLrW+cgp6UFTLtZCU3uYgkZ3kGzGkJlWr61TYrsQt4AvjszU
         4J9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1772038438; x=1772643238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wi7RhDvs4J0GLmNN245z19usKf/YAkhKYx5CMJsLMlY=;
        b=b/1gPYPscheecx3rMfzLRu4mqKi1oBPMOCFfVOND/r2DGwnNvhvZu+ZvoVsrmadtYY
         cLLybjvFyD3jGNBQ7qEg01I6f7TMvX11q1BOomjxgA9SOFPq+GvTbjnq8HCCodrzVxdc
         49Pr3X7IMzlnaWsYwRPocwIc2l/jkbu8gstZRDhySkTUpkZp27FHFcwEaqMZLzi7uZqL
         azDmOZM6chrfSHJ4n1hVH3ivrj/IjdvEcBZ3tFgIfmA9Bac4BZeFWnJoeslSgZ2ZGheQ
         vJ3Nrxit4ymU1ZM8omhqE3KKfuxPOfleW2r4Lvf8xZO2n2Q0j/s3BWMk/4erOn+KtdBP
         Rvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772038438; x=1772643238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi7RhDvs4J0GLmNN245z19usKf/YAkhKYx5CMJsLMlY=;
        b=Wuinm9Gn1iPNXyFaK/6bvCP/CGJ3IFc0zY2cWVYnJHNtxtYFAkbaXuzSzSrVxQHOLN
         zovAKnqg7TZjHqSjDNCZM2RYPflTnOTJDGPr6BdkO+0YTm+9APwnKDB7ZFbpDAui6Ny0
         2xd5KWGamKspg+M6GPdTtKKxrqkkJAglTKnGqqdc5kuS78rxwf/4bnZ7p+8zeYDdWizf
         fItUrWA1pWqIINZVGxCM1TL2vPhu+JxETx3uGudaGWYscphqiltMCn2GSwN+KPnDxDp5
         oLMFdc+EpiiSuKySlorlOXAO8Vq2Mma7QJVE32IefLJ68S0PAbf/S4KbQ5ax+kpZvEpn
         1+EA==
X-Gm-Message-State: AOJu0YwEKu4kz78wl7IIaGq/i7whP9SAFEMa5HP9Vu8GvstqQL9d0xTE
	Lr/9D9h0I3ZWT7iDDdQ+vdITic1nwat8Ncviu+gCp0tjyBrsBNVBF5dd91jtazNbcxwHLzvriNm
	0LPFd+R1pL4tFfJem3IwrI1FpHLnAUi1Hs9G86ILSlA==
X-Gm-Gg: ATEYQzzPFEJEeC1iOUu8hvzkj0YCXh9neGmNMKq8OUAutifRF8ciZ9B8jkEe0uwh095
	ANAF6+aY8sA8k9iilCSOFCG/GsYSrq3NVYihi7mNpqmz/JefUDfTFIXb89SS5dvGjYSFQYmwLxq
	W30qApvZztXO1M0yhoU28msfFSZo5QCAioJDshEi1IeaHdHSg4iQnsBeicoblFAlXUkf4bd+Ja1
	BN0ArjM0EFEPXiDOPgy89m2Ai6Cn4/jT47bAKvoo4pGnirQ9Odfv40g6Ie8DkzsXJHbjuYUgNo1
	DKkFMxGRU0/+cV2k8SeFb+1n1l+m6h8w2IBNA4jQCP9osgZrGZyofEEkdqIn8kWyZRD1B4k=
X-Received: by 2002:a17:907:e105:b0:b8e:d04e:e510 with SMTP id
 a640c23a62f3a-b9081bd4308mr699613166b.55.1772038438016; Wed, 25 Feb 2026
 08:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 25 Feb 2026 22:23:21 +0530
X-Gm-Features: AaiRm50fFSBD47MI4HSjYIoWyJItk78BC39d7dR3JswEC-QWEai9UVWC3plMWyM
Message-ID: <CAG=yYw=0DgvXdfhEzeBYguw72gHy5R0ZiTeLZ61iy6uixKe++A@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219670-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BB8019B020
X-Rspamd-Action: no action

 hello,

Compiled and booted  6.18.14-rc2+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

