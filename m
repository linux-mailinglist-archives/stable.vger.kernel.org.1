Return-Path: <stable+bounces-206137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A50CFD8D0
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 782763024274
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEC2E6CDF;
	Wed,  7 Jan 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="27VssIgp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BF28CF5F
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787611; cv=none; b=QHVQD4m2bJJXF6gKlmYgO8QWSOy7W2IPJFZWQbDOVEoetP/HFxtaJ8oYYWqvpB1GLnWtxp/cJ5VKcH6aGXdAiju7rLfKEYAqWsiyvfMpBNJpTzliv/mMuaUBeA3urjd6au1TgDfS80JdI9waiSuaJ70umIcnrflvuhvV0hyC3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787611; c=relaxed/simple;
	bh=Hd89bWb+jjM+oE+CjvJUy21nuwEQVkLJKh/KDVKNEEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lonWm19/MP3mZ6wjB8InY2LIUB+xDukLQk/GE0O4WXnFGhrS1HPQ+bxhJVHwBQ7SlUn+ISTIpDCvspiSXt1Ui12M6bwnV/W2pW+rmxT+C1P5ba/nQ6aJpjbZLCAKN3lP0hG6COU33LjToBDS2Fljmjv2azuc2rGzOLhKAprYxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=27VssIgp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7cee045187so139958966b.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 04:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1767787607; x=1768392407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UnvZVvYnzo8W+10RWJ1y7Egy5BvmNWtkYjbI4As+8M=;
        b=27VssIgpW+R4hEXqeHU190bMa4IRgBWtTDujrunzBZ/bmBmQUTAGXx6OX6szIS20Xz
         5ZsYP5HilAgYdNZ4DaIpXmfT/r5+osA9/SkknYsr5nuhZkXAmyjlAaQWDIZjpucB3WDy
         LZWLsiSgJXtzDgS5mivUbwnCtvxi1I+lZGqUdcXdh+HiJ2LzRkc5Ibg6ohDkkG1+MI2E
         CYR0jp2poT/7EzAJSt1djBYX1M+hUK3xs9yElnbcltbeiCtSSDi+OJ0xEow7TrGmpwfl
         hhBJnAEgrI5pfDO8hAe5sant9BHh2N1dZYuOT/j5+nj5zdDxTZ7n60C7KfrsEFG0c7K9
         Mg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787607; x=1768392407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UnvZVvYnzo8W+10RWJ1y7Egy5BvmNWtkYjbI4As+8M=;
        b=VHvMrc4/JxejDxtyml0nGTGxotJ3yUacKdyf2mBh2oJuvPxzFSKbTsvdBVj/5YIdQp
         R4kbfS41N/o0yd6iLNIFGMhzugOvcTmdFvYqYynACSUSVzGpTBgHqJ+mQFjLexp8ssiC
         M6N1I5dYCZmUpdJ5bEL0bSaQ/GA1wezv1RFKI+WVcSKqseISocUd+LqfGW90z65PRWr+
         HqS0JCjtJhUDeQPmq9Pmkef0uk4D07zKnenR3byi8RUbrutNKopCWARGjU7stYZSt05T
         UUZB8XUr96CX6SrpcOR6CqOqL99uPngXpMlNxeiHtxqV2OKOHh+6XPX3ACjYSgYGyNSJ
         93jQ==
X-Gm-Message-State: AOJu0Yw3bcLb0VSLp29zgozCpAaIXCOvpRMlWVWEE1McS/xEG/k9iacV
	kK+9iI0/LP/bsiiiRkJIqUb2lua0VAIG3g24dJ2SPbftXwMOvGyr3Q+RHAWoR3M5m9GlUOQaGcv
	zSBUtYrpwgAMZK53uHchI8HHs3flMstKRGmDY/YHJTw==
X-Gm-Gg: AY/fxX7p8/Hs4WBryDR0wdaMNJW5HhdcHWGIz41dyfa5yjWdNyMQ7hdAl73ikPgfXzy
	av/5pY2zRy9usRMloHv1ZA1D7sC68jBzb5EuZcON5CRAU2OqsYomQ8aLdA6CpTxE0KdWk2sTL/2
	Fx6jlDYEM7ZcCVvaAIkd7z2yqWbb2B4CWuVJyaD30EWbpvPwx164j1+dAZUYK1gxt0YQJmydEVx
	hyiPYi8e/eQ8lCWXuTuFRiJfxiRLmE2T8TwMg1ap+80+nYC/KKmtyQrI/l/XIMr05CLt+tb
X-Google-Smtp-Source: AGHT+IGiNPwS91IqhJ7loX5P6SA0DDVvmKocVd5OKv0zCp1ptz33w7p6z4AP5CbtqxxlpklFx+ngNMmQ1ya+nPqy9XA=
X-Received: by 2002:a17:906:4fd1:b0:b80:40ea:1d65 with SMTP id
 a640c23a62f3a-b8444fd5896mr287633466b.31.1767787607025; Wed, 07 Jan 2026
 04:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170547.832845344@linuxfoundation.org>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 7 Jan 2026 17:36:10 +0530
X-Gm-Features: AQt7F2qAKFEdLvUVibydeeDv2ylwdVc8DpGkkpMzFgzL_tgc2FatH9qX5peM0B0
Message-ID: <CAG=yYwn4iTqCyqGucNqMxLyZ_QLjA_TOdj4Lr4+dQP50BOWMig@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello

Compiled and booted  6.18.4-rc1+

No  typical new regressions   from dmesg.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

