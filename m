Return-Path: <stable+bounces-202938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F4CCAB66
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C3ED3022F83
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D02D3737;
	Thu, 18 Dec 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eNJPKxaC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E420FAB2
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043840; cv=none; b=LFDU2yr4hs/y7yn7aHMl/087uPlM3PEK+WCz1c71vodrktLRBEqvVugpWU+O5flTl7t1IMbiGitfO/dPK3fGYnsQmNTVhy8m91eVbFEAHmzZgjuONGZDy1UEjxbwyAyi+/pLEBpliINIYfX8i//Tj8Dks1v0QluucjklcrL2Lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043840; c=relaxed/simple;
	bh=p8l5eezb1CTtwAcj3l2Y3ml2pDSEw3r3dkZMwboKCCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+6j8LMWfqTmiR4dEf1/b2mHBKa2OC6MpJdtwNoPoDEJhi3ukUYsxzG5VlzTAs0Gn1l9ZGDtKmBLlAtySItnkfy6M4RPDTCQNa9J225kxuWgFRsAlo3i0Qzt9inECxHO/JtaWveZRYqpL7060u2S70NY45Zv2rfJly40oi5v4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eNJPKxaC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47118259fd8so2614005e9.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 23:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766043837; x=1766648637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9a6I9p8Qoy8PBC1R4N7ii/8mZi1V+XC1q27O7cdjZY=;
        b=eNJPKxaCftkX8kGoj2R19ypCreRa00PFBFqfiAQCpHwHlG8wnwlwnpLEMgofIH6Z0n
         ThM0YfpOAeAiE3jpIiYWpkS6b9UlAuNl0Gm0CJPTqvm5U8GqsaZzO/3UqsyAW8mCa7zJ
         qbAwcGVFHrb3gLqEWIzgwzZnfMyeNMP/Y1N5wueL8hUoUPogm9RftX8oP+xji+TyKU1a
         rtwQJv0in2fe27KXNXvhTm+zyd0gz96cmunnlizrICLWkxEhcwpTesBR31cd6xVr3Z4c
         VrbQtXxSPXpB1gwGvBMNGPQkazGNmF0AsU9QfRCJSqk3fuU3vhl5Cnxt14aONqOcw1zy
         sX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043837; x=1766648637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9a6I9p8Qoy8PBC1R4N7ii/8mZi1V+XC1q27O7cdjZY=;
        b=ILwHp1EvN1IwvchXS/B25PCTgF4YkyXkyJ+0BCtJTN/5JJYA8w0Eb5X74MgNRmWCmM
         gTrAvSsZ9DpuZWxSylElY+p6kjl6svo9gGZauVsWU+3XOt6dXJaic7eu1q9nsUPJ32Dz
         wMudFF3mS0P0WYyJGVMNn/0kBW58QlG2Z3vYR2RHN+3WWguAN/zhglvUKMgtmkINow4Z
         LarNejq8W+HwqAF5dcIwSAilxZUEw8wkfBbIOgOt4IoQC8faSwA6WRA/zA6IgDMYDnNS
         byvxui1aGsDMEFJqelGPPZEO7wgo4jB9W1kQGmjuPkIPW+JnvVZlXijFiR4sQ20QB+nW
         Zzag==
X-Forwarded-Encrypted: i=1; AJvYcCW1lcmlhHfoqvuf7Hwrz6KlGRop9jX//T9Zq3SJLM10k7iZrwK1vPT4sz6tAR/Aqzjl2mS/5eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5X1q88VB4rJdIVkaMZ7/27Sym9M2dKVp+8I4ao2+ODXNY81Z
	LpAhGQsChCAHSUzB1c2TUjcCoptPnlzU7R4Ro+dZK+SVYkvzIYI07FS6vAYYc+HvyRo=
X-Gm-Gg: AY/fxX6/oCAiM0SuNoli8wFMbBbgHTu6G1xVrCZPN60EkJjM09VWRrYQg6oo+tqp9if
	hWybTDna8K148GrWcsrhQUmkiCAQGD4nJuV3RahwbPq/fqYrsqOo+qvCNP+bvr5+xl6GJSUAx6P
	qCWMhe2anI4ZTZrqix1STgZcPq2vQJRgTcJH5mznonTKve/Iad6vi38k8xrPafivEW5jEPk9Zrn
	YkVBAT3w/TRS3kyue+gUOFO1Mzil27N/u6xOK6FM0fqpiLP+yeczGQHWjhfavARGAfrESN9vw4O
	2WzSADcwl4fJlhTJSGUDg+M5rKirVE4jhnnKMJcLUlXzrthFThntW5F2ZrTxcKuWRWKhmmt9Xs7
	VvFtGXYTA33kxlaUHsfgjyVt/K04IkWzBIhRL+DhOpQ+hGstWHJjKSlvanASpTxs2G7heQJaqty
	+ekah+a4DRV88xo0C2/w==
X-Google-Smtp-Source: AGHT+IHTaj354v56JVpbEnzZd73D1HkWzh99zzHoJxmOUQpA5NAIjnss1tvSVtvdSXeo4VkzhrFlQQ==
X-Received: by 2002:a05:600c:3e10:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47a8f8ab731mr210907645e9.5.1766043836794;
        Wed, 17 Dec 2025 23:43:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324498fbd2sm3531140f8f.27.2025.12.17.23.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 23:43:56 -0800 (PST)
Message-ID: <e2037b38-4c20-4f1e-b681-ae3def30823c@tuxon.dev>
Date: Thu, 18 Dec 2025 09:43:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 12/17/25 18:16, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 17 December 2025 13:52
>> To: vkoul@kernel.org; Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Biju Das
>> <biju.das.jz@bp.renesas.com>; geert+renesas@glider.be; Prabhakar Mahadev Lad <prabhakar.mahadev-
>> lad.rj@bp.renesas.com>
>> Cc: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; dmaengine@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>; stable@vger.kernel.org
>> Subject: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the CHCTRL registers. To avoid
>> concurrency issues when updating these registers, take the virtual channel lock. All other CHCTRL
>> updates were already protected by the same lock.
>>
>> Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before accessing CHCTRL registers
>> but this does not ensure race-free access.
> 
> Maybe I am missing some thing here about race-access:
> 
> 	local_irq_save(flags);
>    	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> 
> After local_irq_save there won't be any IRQ. So how there
> can be a race in IRQ handler.

My point was to address races that may happen b/w different cores trying 
to set CHCTRL. E.g.:

core0: take the IRQ and set CHCTRL
core1: call rz_dmac_issue_pending() -> rz_dmac_xfer_desc() -> 
rz_dmac_enable_hw() -> set CHCTRL

However, looking again though the HW manual, the CHCTRL returns zero 
when it is read, for each individual bit. Thus, there is no need for any 
kind of locking around this register. Also, read-modify-write approach 
when updating settings though it is not needed.

I'll adjust it in the next version.

Thank you,
Claudiu

