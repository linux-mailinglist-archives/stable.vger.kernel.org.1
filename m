Return-Path: <stable+bounces-83054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D5995360
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D302A1C25436
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E01E0495;
	Tue,  8 Oct 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DERZYsxa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD71DEFCF;
	Tue,  8 Oct 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401225; cv=none; b=QjHkV0wj06h7NFNdKbOubxWmNMxr+/fd7u+tmjQsPjCp3eRKQ0c23GgjkW19RZ8/JVQlbW12ByCtbjNwkBxAX/tHqroqwm8rpDeiT7X9NE+pqb1i8VVROpcBJkwe95hYr45PCeDckrLIy9ExB2S5jTrPN6GHLxfDOn36+SvxAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401225; c=relaxed/simple;
	bh=7zIVHXrGUFUQeGA3JsB1jGUISzgxJSyZ2/hsJJ6T0s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU4I9Icra/W6DVcarb1MoZBaJhqi1cDy9RvIjKL2BaL0Q4aWY2Jgfyc9B3+WymlgR2Evj0LT72lVAQlCzLVVJ+ukLqrBclfVQvz3zNPX6M7OstPlhF0Kx5ubgEWharMuYqxJAowz/A3xqG03gkpxUlqjCjgHtLb+zPOCs10SNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DERZYsxa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba8340beso41209355e9.1;
        Tue, 08 Oct 2024 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728401222; x=1729006022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx33b0Vst6rr/13H3aLmQkWWcQZszdz1hSN+fgduKMQ=;
        b=DERZYsxaW7q043EacaAvsi8pHjaNoMN9B747DYFpa2SznIf3Ut06AdoguXfaNhmVG1
         TpnL2TAEkf5tQ0i5t1XLFgVqjI1mcRSRKoRFr+YecfW48LVAqeb8D/jNohBHODQOurjH
         dud2eQdr4VIVRwfpWmUzyglgnN4ddLcKrksZZs7w1rvIfLwqFZmiqa84mps9chAfeAHx
         VnhoYG/XFOJE9GlONK1j47efbrFUhV3cHEEUDtTj4WtTShihZ3Bllhr/jxTtblX6fZLh
         Sgi02SOVtTuAJqZhMyPey0XdRmBo045kYuDyKXoYnn5BiRsGVKherfvk1nwFfh/s74nt
         Fbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728401222; x=1729006022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx33b0Vst6rr/13H3aLmQkWWcQZszdz1hSN+fgduKMQ=;
        b=HpvmlgAQ110OjGUjnDq1J1XyQpjdhh6loWcQ6UCG69p/Ebenljgryd2AvzxcObj9wk
         YeTIwFF2HCkLw21ho3y7TUj2mt4+baE/ZWuSOxVLL72XptiQLRJ+ceIFSMB6Lz7mlF1n
         qvvP/cd8kbt8uVGNfYMKHWCAqusjZkDE+eIvWAh2QzxknoqCEb/oOC5mGIOtqUAoB+bM
         e0tOCjpYe0JyRfgJkENwDYw5V3Fp3nTVt5O/CDHxb7grarCqVICvkvvU90/TarOs6/cx
         sDSgNMn9C8bxOiDRkjwtSHTbxgAVxknbiiEIk+JgJi/K8t9OEiR+nQPTe93NPFooxXfo
         bPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXeN1wxDfRseM5DPcFVMrDL5vBnzEv7PG2zgwm5CDF0wJYX3999GNigWp+mY0xdPgb+NRWRukeVHse79AE=@vger.kernel.org, AJvYcCXme/mbcN6HGNO36zrqeb6jVVRe3Kb15eZrh0MgSXGap7OvsqOOvdndHriSEAHz+G6DuGQJjyBs@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoj2xVuyAaXPBYCRjJDtdquW8QvcCAjC/dQK00Wm4sR4F+0Rg
	4r1p4BL+4p5WXbaoeieM2otU/i4Swcsafda4TKdlVF7GptXTCEA=
X-Google-Smtp-Source: AGHT+IH7j0waETH9wpacj2LEJiLemxRMnh5ZTXtQiF8a7MTObAsoTJwfxQhdiBU/g+FLlm0ThCd//Q==
X-Received: by 2002:a5d:4150:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-37d29350cdemr2497525f8f.24.1728401221524;
        Tue, 08 Oct 2024 08:27:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4723.dip0.t-ipconnect.de. [91.43.71.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e8aasm8338609f8f.78.2024.10.08.08.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:27:00 -0700 (PDT)
Message-ID: <7f46f38d-c1e4-4a07-8694-cc7a2ff0f992@googlemail.com>
Date: Tue, 8 Oct 2024 17:26:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.10.2024 um 14:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
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

