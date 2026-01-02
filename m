Return-Path: <stable+bounces-204436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE7CEE07B
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 313F030006D9
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B52D7395;
	Fri,  2 Jan 2026 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOrRUyha"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA5275114
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344406; cv=none; b=m2nm/B0RNhkmmVtIIKL99SJlBAe+DIb2yuHvcYT1hAHlA2TDmC4MQKCAtis9fQGl/0YChexNbUItKC/4YQyWPj6um09V63wYOtz4HQPx01fn8f1JsZIt/aZtD+Fc4jfCfPVwmR3Sd7kjQAxpYwGmFKra07x5weAg9qTZfdx0Ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344406; c=relaxed/simple;
	bh=jpX1sp0dOUe0Y9PDZWnl5fMODDLa7M96yRYKLj7AUJ0=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6zGP776tfBxlWU0rJfcqQqWlRBa+JF4i2Upncop2kEU8QH56qkGsynFw/pYHtsBHkVvWUuk42qPWSAQ6aiTuF0FWPMYXap08ww9oPqIzR2Z2B6T1Cg5tE5hVOIJMRpEtuLfs1+DExnaOBobc+Kk+zPqkJKa7cJS5/H3bpLM2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOrRUyha; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305914so7852204f8f.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767344403; x=1767949203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMvYo00UHPTgnAzKbA48lPT0mfLyfutmcEEcrwo8pvw=;
        b=TOrRUyhaDfdynO9QW6OH7eEERyrMpQbSdIBH4upEJgs+iGInpjoy7QZ33P/Qs3g26V
         NoglI3R1WobdHcVUMpnF3lENFcSYjmTclMwqxk2hh1MMTWmr7LFnsfhqsLTAjOeyh2uZ
         w72xDVwKxQicztdNEowTKqqbdGpeLRoIXe7p11dXLzqeqGNtTitXh9dBdBfELRUeKnd0
         pdQXNZtQNBYWJsAex5SNaqdLL6hRIT5ZJw6m8wr8PxyjPaGHyxSErvpYeYu3EZYTMD9g
         pkEk3Xtyv4kbfHOt91hRE5w0ANgHsSdxH8Pooto0905P2muoW8Th0AnvfpkXNS+ZxbRd
         degQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767344403; x=1767949203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMvYo00UHPTgnAzKbA48lPT0mfLyfutmcEEcrwo8pvw=;
        b=f+4xA465uZL6jXJRLnHzARVOS0jZScg0ITN7UGFa5zVpqwjT97DSY3OJGM/vfk+gSd
         3N6XXbZDMEWOfeBrz9EXO3eIfpzWYl0jIwY+93dP+LFPRH1GwAfrEYgMtLJGYPtYIbXx
         E73/TJNODulrimFWAh3/MxIP80cz+Y1DPiWTeG++JDsIlszGy7LSNSv3HdyhWpWHZL8P
         BrRg+YOjTfl1PRPzFKLZGcboIOe5GgIxue/C/qZHWudko8zikN73FQW0Q8Ons79L0Fx4
         fTI3rkVOi9zKwu5iKLeUxTx3bytiCv+AMHoXZtSArMSbYo+SjCFgbt65eboIj7Vvu99v
         lOEA==
X-Gm-Message-State: AOJu0YzFRsYAdQCsGEWyr4+FmWEHIIwO5UTZaxhsmlx4tFxcpF2B+itD
	EDUkwup9IDxIEDAgdFF0zpkcyNMAc/nb5objzEx+0FnJH1uaqjDSBVeO0Jr5Sh5s
X-Gm-Gg: AY/fxX4Zue0PJIEjisMYsxs7viic9lj+seigcwPxMNib4McLhVqn/WpCLd5U2MJEnTq
	uYthAAi4XnTij9hCyagKdhLtzhiDb9H5OH86AQbudFedX9l+sh8G9AGIcD62qF7UsNK3DwoRcrE
	wyzoh4+FnTnAZxNrAwvmY5YUGNVdiRiOUW6u0PH8EwvJZ3KyWL6EAjGZ+Hk329Ivq97XFwMzJKD
	97ryl3fHF8VRT8Ik5bIHspfUnH0zetiDDC7PRxYlW8BiEDfNCDsx126I1wxlnWPCFoMpjQiRkAr
	FUbpiQXLzHwfvbyRGvhwyl/HGQsY8+H+r8rPl1L6R8OAY/Td+O7RzXOvBjfKXfaHDQnjzfGdmoS
	/c2tRxLni0dN4NDscOVXr7KjvSvCsBFQjnJPDUlATwCDipNonzkfx/UQicgLxt7u5ea6seCwx4c
	NLdU+xvj0PCwy+T2xBKTDJ9hJ1BulIpY/jKc/gXEH/K1WXGyEtyKXCAriplV1aFM5nx8sJCQ==
X-Google-Smtp-Source: AGHT+IFTWPOIT/yjWti0PrTTT7JQpcKUR8XSKOIUnSkFqae1S2Q7ZJRE3ZPnrb4N3vFrIUnMwsnFpg==
X-Received: by 2002:a05:6000:608:b0:432:86dd:f449 with SMTP id ffacd0b85a97d-43286ddf5damr21312793f8f.0.1767344402931;
        Fri, 02 Jan 2026 01:00:02 -0800 (PST)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm74140714f8f.21.2026.01.02.01.00.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 01:00:02 -0800 (PST)
Message-ID: <dcbabdc0-be40-40f0-a128-7f7e10363d1c@gmail.com>
Date: Fri, 2 Jan 2026 10:00:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sd card race on resume with filesystem errors (possible data
 loss?)
Cc: stable@vger.kernel.org
References: <547b67dc-0b01-41f7-92a8-ab4371195f40@gmail.com>
 <2026010216-replay-polar-18b5@gregkh>
From: Sergio Callegari <sergio.callegari@gmail.com>
Content-Language: en-US, it-IT
In-Reply-To: <2026010216-replay-polar-18b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I misinterpreted the instructions, sorry for the noise, then!

Sergio

On 02/01/2026 07:52, Greg KH wrote:
> On Wed, Dec 31, 2025 at 06:21:32PM +0100, Sergio Callegari wrote:
>> Hi and happy new year!
>>
>> I would like to report a problem that I am encountering with the sdcard
>> storage.
> 
> Great, but I would recommend contacting the storage developers, they are
> not here on just the stable list.
> 
> thanks,
> 
> greg k-h


