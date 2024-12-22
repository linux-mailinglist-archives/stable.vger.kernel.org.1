Return-Path: <stable+bounces-105551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B219FA490
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2D1665A2
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC401885A1;
	Sun, 22 Dec 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNpSCCjz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12971185B56;
	Sun, 22 Dec 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734853053; cv=none; b=c8w/MAUCCPqpvZjQKXhVR5Aoe+YHVKl1d+9tzohK6OXza4m7bVz/EJEhUqOoIZWpyZveABw8lGCVRSroxmtAJIdNDvfWCTo6bKhKzgqnTxqk6hzWIakLbUF96Mle3whpMaPagabgqjwP4OatOPtFqZhg8bMyBaINYIYUZ5LH/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734853053; c=relaxed/simple;
	bh=NAx7BuxW2v7682O6csvhRPUArYnTbC4ZgJ9DLa94yNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0b/S2SIGPjEc+7/ZYsuaQKexyfxg7MJ65mRjMrVZyV/Bn/K/JS7K31Nfs/TmKnME8hy/duX7D63JgY+iOYo+seGDXU2LXRYFia/cEhOIz3e3PVQsjwCUqk48el7dmCdvI/fpIKjOAoauAW6dlsL1Wf9V/11utVVlh6I6SYtMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNpSCCjz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso8831025e9.2;
        Sat, 21 Dec 2024 23:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734853050; x=1735457850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nPbiq3g+dxfCRMYLQbYZmL3rmBrcEtirj2UUfzdEIU=;
        b=fNpSCCjzupGviIzLcvEHamCqifKIQnFTIOoW97G5hLrTy7lxmoHPJCaXMAaJTnYDjU
         Mjyapm9ax+zoV4vueSVN/rCnGha5gYfxpmIPiHbC8aOdXxvBiADxzu01L5Kf+a9O6qD+
         G/7M0tqM5IX5vVbZ24BbtOMG4YB9uaJgGA0OPg0VpczdjzWHpFzCvUDRs5b36clmpFNx
         UTSiglliv1dwj4iRo8zpBpMbtA7B3q2yoK9muABm0CvmfyiALSqhipFAE91kb7Rja3wn
         ZRILF48Tph4navyk5yKZUpTI961Xyr7o1er86Ei39ntSjSRYw1w0YWZwVr9f/kjRVJx1
         N7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734853050; x=1735457850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nPbiq3g+dxfCRMYLQbYZmL3rmBrcEtirj2UUfzdEIU=;
        b=r+cADI2izOCdySF3zLGErJGQbd82UzY24tDX7PXqnCQhUzgy+eqUeYok0fyepyVQw1
         d3rcVPffnvvsNn5NjSiPziupHZrgK01QjifGJBStdU3zyuMejc/jEyvzM8NLqFYkeLQM
         MgpCBpcLn3EiZdXNEU9TaQ11MMrNiWcacNgpwFAnZAZvOOet0g5yhdxiTynjHj6OCSrY
         J6wrfPQld7fj7AKsuuD9HS10ZD+OGe7wcijSDtVra/645W6zqn9JmkNdTWgSdaTmuijC
         QO7xfUe+WS7GxnwB2rROcPQ/6SDWNh5qcLcypdtF8ZU3LrNbxDXNk3fJ8GWj21OL7rJZ
         KEBg==
X-Forwarded-Encrypted: i=1; AJvYcCUTaN06VUKhB1kpdhLH/fzg9rAlp1EOSidLPH2FnoQa4pKCGY983Apj9pxANLtSo/ofhFe3bwcm@vger.kernel.org, AJvYcCWOXO27X7Oa51/njXqXcYOFqh9eLS+f/WeIvtFuJuj2xs1mLqfH128OKiBkR08pKA5Fd8KOV7j4yepCsLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCfDEUExo05LvITwHqgu31PngTDeAvPw/CZdLP9mDCoi0sdb6
	p/78N3LTC04oocj29wpOrKrbsSIpmvtEjpUpkoyowxBh2YEigOV6DsHw9CK1
X-Gm-Gg: ASbGncteYa8hUU0mubQVxipRBrzdGY6dy6C6sYeYzVvZRKYv0jz6rdclTrpVbx7tLy8
	TZBlgp2i1YF/DlXSrnbW99I1nChrHXo7Z+MveWkzIUWTENdYNEO24iLtZdrmb+UrdhU5t0a3kN1
	zzsSI+Am9fkhHBdJnkN80n04bGcHeSGR8YuZyb9ad+wZE3g6EQZvJwHnoVqoURO30pWRMgdzcOc
	6/Vab5XQMt9iAaAcglm9CZwOsrXxUXpGL5wh0rBgprQsbFqkp8x9XSI/dIdVv5nL6h5Q3hgZ8oJ
	gLYZ1eW+XaeK/TykbpeFz+yL1b4qHEUGnsiyaA==
X-Google-Smtp-Source: AGHT+IFSGdhCog6uSXLpFm+pr0vXhNpzT4F4SrM1oT802P5T6FT4W7Nfz8TaBX8F+8odOeywNFNKxQ==
X-Received: by 2002:a05:600c:3b13:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-4366864409amr79132085e9.12.1734853049981;
        Sat, 21 Dec 2024 23:37:29 -0800 (PST)
Received: from ?IPV6:2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272? ([2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474a9sm8148343f8f.52.2024.12.21.23.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 23:37:28 -0800 (PST)
Message-ID: <57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
Date: Sun, 22 Dec 2024 09:37:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
 Kailang Yang <kailang@realtek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions Mailing List <regressions@lists.linux.dev>,
 Linux Stable Mailing List <stable@vger.kernel.org>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
 <8734ijwru5.wl-tiwai@suse.de>
Content-Language: en-US
From: Evgeny Kapun <abacabadabacaba@gmail.com>
In-Reply-To: <8734ijwru5.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 18:38, Takashi Iwai wrote:
> Could you give alsa-info.sh output with broken and working (reverted)
> states?  Run the script with --no-upload option and attach the
> outputs.

Hi,

I already posted alsa-info output in a previous message:

Broken, kernel version 6.12.5: 
https://lore.kernel.org/linux-sound/0625722b-5404-406a-b571-ff79693fe980@gmail.com/3-alsa-info-6.12.5.txt
Working, kernel version 6.7.11: 
https://lore.kernel.org/linux-sound/0625722b-5404-406a-b571-ff79693fe980@gmail.com/2-alsa-info-6.7.11.txt

Or do you need alsa-info with a new kernel, but with the offending 
commit reverted?

