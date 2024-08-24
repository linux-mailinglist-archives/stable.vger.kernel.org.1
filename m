Return-Path: <stable+bounces-70089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBA95DE0C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D461C21093
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467E1714DF;
	Sat, 24 Aug 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmJxSlKk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4C4A07;
	Sat, 24 Aug 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724505989; cv=none; b=hoJs70lxT4QH2oROiRuF+q8aCNDmd00XXbP1yU0EvLI0nGQ6IdxB9Ib7vz4oRX98Z9akKG0NEcRN4C2Ho9vg5f1RmkirrxGuoe2qC3mvna/W5LnYOsT1hwzBdeSIcctWnv6n8ZtkvgAwESVxpPFaJJCOUYZIfWW46wZisaSHIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724505989; c=relaxed/simple;
	bh=+jc/Vc038MHhpyQ8+IxcxqzIq5COI3FuiKc4IC9F6uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFiqJnMS0JjbjZcYfXSsg/MPy/Xs4SK+n+duyk+o0JRlPiY3kuTi/nr/gHuPrVkRXy5uq8YgCeP2ScgIgJjxiX8X3Nt7z7SUYfBZ0IWXpbZstQ/xxlinkDUu8qQJTYbAO4sa/pCl30XXicLMs/0tnMsIvVuWP4BVubRqwVIgdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmJxSlKk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso1428877f8f.0;
        Sat, 24 Aug 2024 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724505986; x=1725110786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=114707c9TBN2Gihi0FV0kqjlbdnW0JCr+A5nsEfjtVU=;
        b=QmJxSlKkihY7Uq7TySUEEU7wPxJPQMijSVW66hMP0WlWbvVNafZLSOPHicBg3G8cRF
         nK6dQVs4fErZzSmNX6Z8FySo4XSmfs3G1q+YKYhDR1CPHEKPSW0ogfsuCBBzJJHj4M9V
         E/0LNwQHnwQKdzerl3KOz9lYuc1COeChHxHD3y4LhngQNmf6YEGhQchjAyHwslvwz1C3
         aWf7m5Vfo1azP+el+tqClGZPpMEmgmGSRBeK2h/PIS5+vRu1D/Pyry7zzPtqeefsE+mZ
         Z20cK6Zfg6+1iDm/CgPk1B3L4we76h2VnLcgjLpIJt3LbogXfs8DmFJ2tgcJpvuGZof/
         6oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724505986; x=1725110786;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=114707c9TBN2Gihi0FV0kqjlbdnW0JCr+A5nsEfjtVU=;
        b=qTU1dgFwrRx8vdriAlBpKVfILLg9i6G/YSQ32mhcGM8TkAt41nIFx92wP9GOEWQ5tU
         oAaBeacWltxnacLKSHf9rs/8K1hY0pU47jKxDO0fCi+pGACWMy/jqeGJXWpX26L2vT9j
         UyI68FTJE2do8WIr8WBjKM2o9GjzkKdcyVBUUV0JDd60vAfEjfhJ1ZZIszDjycZgFBfV
         BJoMBFe1DDmYIY69wXx9TtTBX5rpOCG9L5NpzX75ei4JE+dJccIt7iQLXCN0d4l42LaV
         gm8NWb+m1tpHg3eK3e/gkojQ8hqoWsQS7zah2mNPsntvFoB3c2mVstHdLZH/qwLtIywQ
         s2/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIYFWejIMJfGrBE95CgZeOkJu817yuHv0+6bOKzZ/KwRg23ynMdOfIwTHf8S5hmlH0Tm0/10Sh9LyhIFfe@vger.kernel.org, AJvYcCUJbdlb8Gp2zv6tTgO64Z6lVzAXmB9HfZj8+0V5EYj6dROIgbOuvsZoVLgAB8bI8spgUuRDoSHz@vger.kernel.org, AJvYcCXi4F0CgLxScRj6pmFyVVk5Zyz884S99guHxlvx9oOwOgX1JTcGTjoGsz+7rUc/txjHRmoKoPjEtVOm@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnN3HO8zd5WVoQxBpuEJsdyzYIvmntzCOPwIMhjyAfmyf2wPe
	U0n5LhB6dNGW61GwB64vJoSUKDu4sEGE303W55x+xzkXG+v+Jodw
X-Google-Smtp-Source: AGHT+IE97apoWLf+5ctckXkuIwyLEMMq8DzL8/wLznw24XrTkTZaFOgnINabsJwGyILMQnQ7VupSOQ==
X-Received: by 2002:a5d:6905:0:b0:373:b44:675 with SMTP id ffacd0b85a97d-3731189b12amr3706013f8f.20.1724505985477;
        Sat, 24 Aug 2024 06:26:25 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm95104245e9.2.2024.08.24.06.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 06:26:24 -0700 (PDT)
Message-ID: <f11001d4-fac1-490d-988c-01c6b4b588db@gmail.com>
Date: Sat, 24 Aug 2024 16:26:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Disable DPI display
 interface
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Stephen Boyd <swboyd@chromium.org>, Pin-yen Lin <treapking@chromium.org>,
 stable@vger.kernel.org
References: <20240821042836.2631815-1-wenst@chromium.org>
 <00aaa8ff-1344-48dd-b0cb-5e8f4518ff6b@notapiano>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <00aaa8ff-1344-48dd-b0cb-5e8f4518ff6b@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-08-22 18:25 +03:00, Nícolas F. R. A. Prado wrote:
> On Wed, Aug 21, 2024 at 12:28:34PM +0800, Chen-Yu Tsai wrote:
>> The DPI display interface feeds the external display pipeline. However
>> the pipeline representation is currently incomplete. Efforts are still
>> under way to come up with a way to represent the "creative" repurposing
>> of the DP bridge chip's internal output mux, which is meant to support
>> USB type-C orientation changes, to output to one of two type-C ports.
>>
>> Until that is finalized, the external display can't be fully described,
>> and thus won't work. Even worse, the half complete graph potentially
>> confuses the OS, breaking the internal display as well.
>>
>> Disable the external display interface across the whole Corsola family
>> until the DP / USB Type-C muxing graph binding is ready.
>>
>> Reported-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Closes: https://lore.kernel.org/linux-mediatek/38a703a9-6efb-456a-a248-1dd3687e526d@gmail.com/
>> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Would be good to have Alper verify that with this change the internal display
> works again in their specific setup, although this change seems reasonable to me
> either way.

Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Fixes that linked issue I had with internal display on my magneton. And
apparently I don't even need a custom kernel for it, I managed to get
the display working on Debian's v6.11-rc4 build with this dts change
(and `softdep mediatek-drm pre: mtk-iommu mt6358-regulator` iirc).

Thanks!

