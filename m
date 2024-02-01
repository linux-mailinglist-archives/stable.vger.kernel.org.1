Return-Path: <stable+bounces-17574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C184566A
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE35F1F28348
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0815CD74;
	Thu,  1 Feb 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g75KF9Xz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D715B99C
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787724; cv=none; b=rUTi/x18VwUjkE/pxVc8XZGQOEDy/D1ZdLOyra5BWBiyz+zlqIXorHs7tHzHRA/YxKWvDGgcMduau2QrSC2kU0WMScGeUJBX9rPzro+vzv6SBSj8op6FBh4MWvW5JZ7IUUhnsuGYCLan77whVuYWs717jOiBLeSmrCBrTNVsOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787724; c=relaxed/simple;
	bh=urHbrS1cllbFOsHLucuq+fokSSEAJOkVktHa/rCN26o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/qXP7Dyht1ZJ6FNfdvShQZD6vyjIhjCoRSX8iSZh5uTxAkYyKQcffgK/00MjSLLSMIXAgHbZrDRkiiHP8szqxUyVxUmVKlGNbHc0R9JRhQE462kmqfbJHfLtfKtIAKaGsFny7MJPix1bUBuDlOPT2ZLWeqf79nApcff6LOdle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g75KF9Xz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706787722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3GUNiFWMLKOvtORWj8ClGeTDULPNTU+aWgtkbxkUxo=;
	b=g75KF9XzohGtCD8mzrUKeU/g4RWFo0gxHeGjsI18lwp9WU7/S6qKuJY6vT7fD9GdJMpago
	z0q9A2lFTchm5YxvEybDR3bJU93Pu7Ej3BKnO0uvFKyDdORCgu6ZKchoWqkBVXeUm/u9cB
	TakQqjNgm+9WQJdtAdO96zRNhurmDeY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-VWuzo81MNFWViTxCzYVgeg-1; Thu, 01 Feb 2024 06:42:00 -0500
X-MC-Unique: VWuzo81MNFWViTxCzYVgeg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2cf57664fc2so7376121fa.0
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 03:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787719; x=1707392519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3GUNiFWMLKOvtORWj8ClGeTDULPNTU+aWgtkbxkUxo=;
        b=FLN85C0deof2J2k1sCPoJUjbGzDbDSWlvwgKt9v/YOgHDFyq58EX4gY9vFo5nRJ2Tj
         GSw9QeU62c7C3Q9Nr5+PvxfvNQHUhN8fv0kZM+HHCdYi2pSplaAR1xtldoZCOlE1tbUV
         7ZhULKAc6sTk6ddRortwIw0tmRCnDVsCX5HCt+cDjmy7vNpxsbms6sv3rIejxa3GsC35
         C8ffl2yERB7D1IVfPHFgYZe+jf5VEVW2jChVrSdu+VDE8uxmP30UwgRqskwFenHypLdV
         yPCOzy0GzQpHlz78PSPIS+Ltwyqor00guUo3xuJwhRP5SDFr0nD9bB3zPcZVeRVOmsEb
         Tb7g==
X-Gm-Message-State: AOJu0Yy4HxuyjZ5sI3q4Jl/ddD/JxCC65gljCsYgJoXjWtAcdbFITxHc
	5WDOMCwVlg5njT7nvcynSoNDG+PjPhEqcVCVTP3+ALx8tG6/doArWdrFbxTHjcsz2MyosB7z4ly
	dOE71bpbho2L4ygcnMsTnTJ+dQXAL/SBe065GjDo6hCjTpQvLPDsJiA==
X-Received: by 2002:a05:6512:2024:b0:511:20e3:e456 with SMTP id s4-20020a056512202400b0051120e3e456mr1628978lfs.49.1706787719227;
        Thu, 01 Feb 2024 03:41:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUM3ER/05K0P1SDSf9zUPrHLuhKoPYv86HIb2Qagavucs7NxIAB8te311dkA8fybttpWEZyw==
X-Received: by 2002:a05:6512:2024:b0:511:20e3:e456 with SMTP id s4-20020a056512202400b0051120e3e456mr1628968lfs.49.1706787718870;
        Thu, 01 Feb 2024 03:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUho0hfWGG9Q87RkUtWX3clrr2/kKc89RIbutx2CAwhhsLVNMpjzTA16a4UBEtoP8Yg56qPffnCU/MC4rDvillSXJDxVlACMmDh9a4q+7xOjCnx7tuJsJ8Kz7NRdK0hRbZSSBfnJL1th9BTl2Pz0VI+LtIajFby46LfHMeCCdk=
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id en26-20020a056402529a00b0055823c2ae17sm6604840edb.64.2024.02.01.03.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:41:58 -0800 (PST)
Message-ID: <99c7d1c7-4f0d-4a2e-9715-98425ce7c182@redhat.com>
Date: Thu, 1 Feb 2024 12:41:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH regression fix 0/2] Input: atkbd - Fix Dell XPS 13 line
 suspend/resume regression
Content-Language: en-US, nl
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20240126160724.13278-1-hdegoede@redhat.com>
 <dcb4cfe6-1a50-43cb-ad92-76905c05dde3@leemhuis.info>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <dcb4cfe6-1a50-43cb-ad92-76905c05dde3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/1/24 12:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 26.01.24 17:07, Hans de Goede wrote:
>> Hi Dmitry,
>>
>> There have been multiple reports that the keyboard on
>> Dell XPS 13 9350 / 9360 / 9370 models has stopped working after
>> a suspend/resume after the merging of commit 936e4d49ecbc ("Input:
>> atkbd - skip ATKBD_CMD_GETID in translated mode").
>>
>> See the 4 closes tags in the first patch for 4 reports of this.
>>
>> I have been working with the first reporter on resolving this
>> and testing on his Dell XPS 13 9360 confirms that these patches
>> fix things.
>>
>> Unfortunately the commit causing the issue has also been picked
>> up by multiple stable kernel series now. Can you please send
>> these fixes to Linus ASAP, so that they can also be backported
>> to the stable series ASAP ?
> 
> Dmitry,  Hans, what's the status here? I wonder if there is still a
> chance to get this into -rc3 so that Greg can fix the affected stable
> trees as well next week or so.

From my pov these are ready to go. I'm waiting for feedback
from Dmitry on these.

Regards,

Hans




