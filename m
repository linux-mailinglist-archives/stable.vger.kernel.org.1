Return-Path: <stable+bounces-191384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2FC12CCD
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9594E8C82
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B665278156;
	Tue, 28 Oct 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KxGpfoRm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5D27F754
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623132; cv=none; b=Q3N9WNcho5XocGSk2Qt7cpCkrnyJbaG+XN3o9POltG7C675D+luPgxVfCagOkfLhKSuJ2i4KOoEt602abZ1PA1cw1Behq0Tk+9a0n+nbTzRKIizJXBKywNwuA316nlIHNVxvI0HPl4xu58OMnew77F/CYuyB16x0HO5DzGjgskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623132; c=relaxed/simple;
	bh=KidjVKGLgarQNpGF00q4EvUkNmscuvzAOEAk0l1/r60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nmb4d9UpHBMyhdc7wgG/PapxpV1QlBMK5EDk26CLloFukX0co1YMLofnQ0G5yalFL8sc/UZeDgZG+aezO0wtwTZZ0laiCuvDEwYyxhH3c+rdlr2ay0aTisIcq+B0CpdtZzRpFRyiEmsKl5NwOVJJedgCLvRQ99j57sjG4N1WI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KxGpfoRm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so9702725a12.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761623129; x=1762227929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7GVt1v7G0WDNnH1zdoaYHuIyxA4YtNvwpKhFghPiGA=;
        b=KxGpfoRmNSQqiBOpeaLnJC/buXlD93KIbdqDC2GtbePPFGdKCU8miwgFdE8u2w0gFZ
         j7sTsJy7MNviCFHpzMfQ81CkoeLHRLD8XMRyBmN0ySEs1ks4uL2Q8SI+XjoTbqpRiM+b
         QcStL5fD0KTAZwX0dc2RNrOFw7m+uAtDtKFztK8m/pFRTc1g17bDXT5mMaH58w8QYlTc
         WDilPkFa2lnNqUhpVMCoxGLdE19DikrbLqPPb0i5+Fc+DQZvDhSMDsC+p4+gC6uz5QsB
         lXOeTmvJgSGx1NnjpRgw8AZU5CZLYQBcEcAQC2aBixnVC5K+iaJK5skt/6xSodJYwXWY
         FFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623129; x=1762227929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7GVt1v7G0WDNnH1zdoaYHuIyxA4YtNvwpKhFghPiGA=;
        b=Y39ZgXxCXEyY0uUIB8Tb8V/x2mD6eTsXiW6uGZHUudpOGGbPe55zvhSQq8EbTj3PeZ
         Eh/g7yFhe7WsgpU/8UBo7fa4nXoHL4Vsjnv7P+5iS8qNHnvia/ZBV/wIiupl9KR7ehgr
         s7dL6QeAcmljIpRsn5jyYG6VHW8yQpq4WxcaNP/IoJNnMCg9i2WanjFUkBAZInlajYXd
         n9MnBgzb7C13F9qix4edQrxDKoc9yHyQSp9hKHzlbwM6l7qwE9YMSTG7pk/+b60Z7uhL
         P9/YBnFi0dm/POd3GZVpNRl4dUrCJHQrXXwsxFo5HvDQoA5zQkZDgL69Hlau/ujg8L+r
         xG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXmm6g8ahcA8EFFtx32XM/YgBNxNQTC89Bcp+/ITxmPwyecA4IC3jw3+Ik6psPirKvdHFTUebs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszkDwEu/KbT2RBCpzpCq9jCLyggPCSkRTT/GOdz6j11K6qy0K
	1UnunS4U/XOHftCklKu6iqSZDb/y36cBU8OtzdKaNVLFRoK7WH8I1oA=
X-Gm-Gg: ASbGncsbMT/rszezFTMWWlzOKPpLz6zBkWA8GsgARbNNMLauJ+e0YOguD5f76k3lri2
	qLiWrOn2smx8VbtfZYPp4efwFBtb1mvvNYNrLi5EsXROKy/Hyht4bsyOQqdLf4J9ck6mcUDZ9mN
	MYvJR5Brq7b0zFMdSjVWBa099k9FdS28kVSBFmUWPypNB93HBtCoMLUslZQcS1zXeA7P3/kSQvm
	SMxCQk5eLxAcGJIncl+TKELU5lD0dQSAY9pDtTrKMUi7sbHnV6sRnvzd3/iDe+JwEiYH4v4yd5t
	22U/DlVoH2wGnbQuk5uOtQ4QzBfeh9G+x5jFpWLdL3pJFUJ9A/KuGDwFA3tCLPa4DLGf3GeQhKk
	a5aqyrDX5TAvCuUE5UmaCW/Nqnyb8u46DHak6YOFxomwI30WjXcn+uO6YQDSecN96ngnak3CgHM
	xSYQSto27a09q5/uU0wz3kbNQMvjMa3hjQ88MQtkHpBPyLHAqYbv3Cxth6uRjmKQ==
X-Google-Smtp-Source: AGHT+IEgy5yJL7k/IoRzMRfSxNY+mDkwZoZ4I8NMwRQxjmEkNkrb1HgCSFuIbsQrLU16vjMdJiSsag==
X-Received: by 2002:a05:6402:5cb:b0:639:720d:743 with SMTP id 4fb4d7f45d1cf-63ed8269cb7mr1758049a12.31.1761623128606;
        Mon, 27 Oct 2025 20:45:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e86c6d7d3sm7445083a12.27.2025.10.27.20.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:45:28 -0700 (PDT)
Message-ID: <cbc3e356-9d9b-4aab-9a2d-4e2b96d76987@googlemail.com>
Date: Tue, 28 Oct 2025 04:45:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183438.817309828@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

