Return-Path: <stable+bounces-37981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18789FB0C
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCECB30A96
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BCE16D30E;
	Wed, 10 Apr 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="S2KAQAy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAD15EFA0
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759827; cv=none; b=l53xmoeK4av/87fAqxQQBgb/coYLv80GcT8GRxu94IWDA/n/JlCs+AyPv8a14ugvOhwgmGw53PeSHIhVpJb4QYViAZcu9l3EsDN4UX2llXFJapBF2sULhLNcSt9EhyBS6XVurDCumZPED2YMJ2yWqtH5iQt8ZXZBIAfzVj82mZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759827; c=relaxed/simple;
	bh=6OX0SbCwsu8LIWphrnQnLPawTJzDR8G9knX00oqYF+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvnlYXM/PaMK7Jp+2HhhUGgCCtt4+8FdqbmUuOG8cC3IrQ9pAvzjW+tknMWI3oqXILQgYwssiE9g48ETtH6gn6rZ4LQu4ti9OJnDYtQCP9jXTZ7KcE3h603QPTkx9jE21P9czGN2i4AhU8XlDNzAJcYHBK0sIbF5bqwIFb/nLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=S2KAQAy4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-416422e2acbso22288455e9.1
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712759824; x=1713364624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0k3G+fCKFtAvuxTFmw21CseTXlCWIYCbwZlcENKBATk=;
        b=S2KAQAy4rDTcmhX4/W1EfJCd6u2Emxfq1OhXktYOA+Wjvrcb2jHG+ssHcTDReRI1Tw
         qicsHsaXanwG3ml9QB/+EBsaAb/pwosGP9nC7WJf58N2D0S6kHvEbR+sDurP2J7WxuhB
         CnTxX6lscfPwELN2NlDiyy28XmJXi/W7fnEtIxuT8S5762YlEF72z31qGBXMMD7PMJ0D
         Chaue1AKATVQjI4yOIYJiND3Izj3hcaUivzMZL1DHacfK67PVaXLAI3AHhDsIiQz7PAg
         csbIxcGlQkX3GUGl8Pdts+b7NAb3vAzTrTv5pCf2vzXDIdTwdeoAF90TxZPuYAinIIY0
         j//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759824; x=1713364624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0k3G+fCKFtAvuxTFmw21CseTXlCWIYCbwZlcENKBATk=;
        b=pjxPWKInwnk9tcuXR9SPsEaPRUVXcCZRrg4a4cumdKdHWGpbLtNG3pRT4Iuk2hC0gs
         tKpzNiAbvs5//taXYzFVX5gTm9k55CxFr3SFcs8BmEiXN4oJu1dRzXMXF4K/lsJSuFDM
         KVdVoYSNyNTnh0ITE+VUHWweRbH+rVQANdbUzP2PL5zcR5jf8FjUXwWKmMXnjFcQat3/
         3WytbK5XwUkj1TdjZ1YWKSGZWscxWQ+LgMOsM1r3bwXbB9v/ubgIdTi5IRDOELvuoFii
         XriIBC7+mjIW2NSWvI+N075urX4fX0DM4pN4pqh17VAs5Evx8xy0hAnzgKpCNYNNVhVw
         qtew==
X-Gm-Message-State: AOJu0Yx4nG1kqGn8Pj9kr3+uD0Sr4xqFsweaFvljtuH+gWVAfkrmwxRn
	sux86/zxugvi5CRVlNEzELU03O9tDY3ynVeIFaKpjacyc61qyaDb4QxMoX7OqpY=
X-Google-Smtp-Source: AGHT+IE/CFg7oWpEBQoBcQF4Crl7uPXpfOLatvhe35kZM381B9IbnefPddohUlOA5xHLQy0pbaT9rw==
X-Received: by 2002:a5d:5848:0:b0:33d:754c:8daf with SMTP id i8-20020a5d5848000000b0033d754c8dafmr3177799wrf.10.1712759824076;
        Wed, 10 Apr 2024 07:37:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d47cf000000b0034353b9c26bsm14188483wrc.9.2024.04.10.07.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:37:03 -0700 (PDT)
Message-ID: <a81512d9-2831-4dc3-a127-9255916cf8a7@tuxon.dev>
Date: Wed, 10 Apr 2024 17:37:02 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport commit ed4adc07207d ("net: ravb: Count packets instead
 of descriptors in GbEth RX path")
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <TYCPR01MB64780A9ED53818F6A9D062ED9F072@TYCPR01MB6478.jpnprd01.prod.outlook.com>
 <2024040959-freckles-bling-36b6@gregkh>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <2024040959-freckles-bling-36b6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09.04.2024 17:53, Greg KH wrote:
> On Tue, Apr 09, 2024 at 02:47:02PM +0000, Claudiu Beznea wrote:
>> Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.
>>
> 
> Now deleted.
> 
> 

Sorry for that. It was automatically added by the corporate email system. I
wasn't aware of it.

Thank you,
Claudiu Beznea

