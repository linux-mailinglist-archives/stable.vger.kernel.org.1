Return-Path: <stable+bounces-199967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03BCA2BF1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD63301BE9E
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22EE3314D4;
	Thu,  4 Dec 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LdG+gEZd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAB2FE06B
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835595; cv=none; b=SFbMFDKJxoKjk16GYg6ZiIjG+4k+ZgZdp2+WQewJfjaovbD4jE7AHAfsTPaGvQ+L0DirfiledGdhNQLFBrzVaKv2SG6YToJ3ooWQNSfCoIXuLVKuEtEQyelXayTj50+9L0FMTED+Vwlc0DxuD1oI4Qd98PUL29kaVsi5vKAsnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835595; c=relaxed/simple;
	bh=BCDCsDkJ9uvwPU+50knBmJuzkgf2RKoR8C33QmBxmiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LX5xQYp+OEAOgDh/pjJLNvCHqXFVJq6JPiVlnWw8bIPUGQnG5ATp9QRrc68VdiJcvDz59Vbz2zVMCBNJyjWASCeCuz3jCkhZM8X6l0sisz8/53+I/BOw7Pq/ZPvDduNjcmqdNQF+fTnjLHifbjscLITh0AWtJSuklU55vzssGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LdG+gEZd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2e5da5fcso444138f8f.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 00:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764835589; x=1765440389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyTXMymmlZ0xsdNx2PUkEUwj8fF2q9ljQWHpIlfvcwo=;
        b=LdG+gEZdcZedN43Ove6T9OB8JYW29G6ZPhHvwFBgq54brHkRtFN+A/xKuUrJdxOjXu
         aqV7f3yeunK0ygQV9FKkFSUumt5nkv+T/Xbj30BuIiwWjO5IcQoGFjJEjxZLSSzShacv
         +K5zOZa10p2xeOvCb1tG6lnmOk8uZBTMmdp9imVQjF8NxqQtXyFo7N7dHI8eiugY+Fr6
         Ta64qM0gZBdfRmxY5e4fO7TbKtqTSEZEM+IqYLYqRZ3/C5a4uIs2AHk0HZVbJB1YC+p6
         RISFFLsCVp5Hbye2tOZmBin2lyQNzILJz3qje9QhL5tEQIX3XainW3ZjFrTA1LJu9cio
         P7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764835589; x=1765440389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyTXMymmlZ0xsdNx2PUkEUwj8fF2q9ljQWHpIlfvcwo=;
        b=O50YCgSPZcazf/W1T/XN1JPH7p0FU/ILaK+kiEJ9WSTLDwj4EWy0+PJR/fgIkAQb8S
         b+t38EutRpA56Atee6figpSWVx+ojUi/MyGVUaPEFc129b5bjhUbXbIR3+vMYcqyRsc3
         NWxb5SS9n5gJ8GLpq7bOqCYjEQlIACqHwEpSJk/pn97SiTnJly+fmjCNyn8/zIrZPa0x
         mD8eEmQoo/hj6HPEQaRuYzGXLEpj2nSVOHUSS7yfbhimsOrj0F34UJr3BAomgVpLou05
         e69pJzZSiFkGpYn2U+4O04ZNQhapIAoIWwmjCriqBRapDg5vX7ZeAcCfNqLo1WT5IJ1m
         8+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4VaJiCWP+sKBfuDjOiKXMKk1ivBMfGnh7HWNuYRy96UygKcmDfWSP3DmkKYy6C5pUgiGE3fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OwDIvSjXJBjDwny3LecwoM11q4MnhV1W4HqBtJh8bN6jxsz4
	iaB/VOygWN2Ct8x6PDOfbzueJtDZ6kTupeRwK/uaWK13rnqs+74U3YM=
X-Gm-Gg: ASbGncu+5+JpK5Lty8u4EsdzYWCjRrIsr8hqk3BGNMdSQXF2WndX1dvxMvHH/D0keFM
	+fjbXc46ayYqnAWyKkCDjJtGxnxaTdHDU1jyZFrSxPqrcjV91w0daAoshPhOchFIuK+crihLDFR
	5WgidhYQgnUmV1ptjrlfrxpL+KgkY2QkBU0NPtnf/WnK6zJaN6wHMoQmfv0/eEMR17cqtr6E7kb
	l/bYumk2I5RC2MGDrLr1eGBXez5WAwh2/v5UKjOnc3Oi4HqGYc+UEsa0l3HFbaYt3z8uzntK0Wj
	DbqCtTat6WWiymLLqKozO988RN+32k8XR+KuVnxB/+d3SMSBjMGKkHnoCAmi7qHqnF5rv4aCOqF
	qVfd4c1zf2DTNdO8NJvsgMhzF9DoWGx64mvreGZFiqqI4H3eTaLVUQXCBQ1EXESdTO/HT7wmw2g
	0ercICyunWlCcHG7ItN/TjJBqOe/E83smQfglOreQwte8wh/LhZrCKYHn1bzndlkTM
X-Google-Smtp-Source: AGHT+IGQvVhWveWSnN6NOmdJGhz2pF+4jr+Q5VX5lQ1i1ZA7n9cS7VXap9mZvJI8RBnBrTI+dC6fZw==
X-Received: by 2002:a05:6000:4006:b0:42b:2f59:6044 with SMTP id ffacd0b85a97d-42f79800eb7mr1690529f8f.17.1764835588885;
        Thu, 04 Dec 2025 00:06:28 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac6aa.dip0.t-ipconnect.de. [91.42.198.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331e62sm1770305f8f.35.2025.12.04.00.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:06:28 -0800 (PST)
Message-ID: <cff94b35-5861-4128-b3d0-c828a5c818b4@googlemail.com>
Date: Thu, 4 Dec 2025 09:06:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152343.285859633@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2025 um 16:27 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
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

