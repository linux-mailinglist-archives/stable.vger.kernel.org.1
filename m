Return-Path: <stable+bounces-144590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11871AB9986
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 11:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87DF3AB3F3
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACD233727;
	Fri, 16 May 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwZopY+f"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C823183F;
	Fri, 16 May 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389398; cv=none; b=oYveUmTfISsYcPaIckPCdIFrUtbyGB3/mnFJ0ihzP23AtZwoacqJeZfCVDwhpFlsBCIzZo8m/zuBHSERkd/FXZvWJc7yEd8hc/KavoNB11UuUPxwPgLXw3EH0TbvTpVunOyAfg4hUsq/E8CLY1hCUEPs5UAfKm7yNFn/okmyLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389398; c=relaxed/simple;
	bh=bSJnfG7+L2euepoA/1Qi9DoxHhmEZq4LnuNDo5SQoOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd8cOSG7i6mL3OO0ZWIVQbC/c60xFxhy8oYuTHuvjk8PipL4dqzfB6Sg774vFFyc7tVPX7FgoKvGyOnhvE7wEJdeMzl7eGM9kj3wK2oE9zxd3bTgJoij91wvqer38Cd29nhZrlPg/Q9fovu+JXVN9aafjcy7/vcDVTxZHdu8wtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwZopY+f; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54998f865b8so2012759e87.3;
        Fri, 16 May 2025 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747389393; x=1747994193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpmIJMNWGqY/l+ruFQDU7SiRdQqxGro8a5Ny2wZNgEQ=;
        b=GwZopY+flII2Rvy4DfTt7SK28ZSkBUHkymb3Nr7evRjSEhuEixXKf1eiNZyOxAutkR
         GB+cLnd58Uv+w4Bztpp2HuPmc1x2TFqORe2hi1ZGC+o0LEK01MdGghyjmgnJZbr1eCoy
         XRdu9nlejtRySflj7+ghuB5bp0jT+zChEYYCaO82RKIZzTaWlO/QwzByMUldnuCEl6Tu
         dSpQGlNVWNzlQPthDFYyNnLVlZZC80JcQ43785lgKdPHl17/mXnhVGE6d5DbM0nekrjr
         dm5YeWrBAN0qY72aJTXh/WILu9BLplYEOqjmJ6QTvDZSdTAe3szbIJyzF+Fdm1Vo4rmf
         z2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747389393; x=1747994193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpmIJMNWGqY/l+ruFQDU7SiRdQqxGro8a5Ny2wZNgEQ=;
        b=jToEICgLP22/2KkBrvrr8S99lA5dnIHRY6swZOg4rvZ6Sic8m1qgOcb1YpVxjRoo81
         EHeq+0dD7R1hdItrW0DRWQdFP1zROSBKajg06DqNa9FoMzstxAwFm5ZiO2AtetuPLvWs
         b7aD3LK8vHwd9HeCpwvt/Kpvq5E23aDQ6L+hchjN+r2RrJfxrV5kQhw4Yh1Le59mFNe0
         zsTSUXCIMQYGWERVVfkuqPRYm/1Nu+zhKtOB8q0fae39tphYUg0aTrGcjViqHEuFwGod
         fN6b+kNrLjtRfnD2vCShXzAiJ8ZyO30EObgPG6Jg/Km8wZjs7ssR7EfGp7A/ZUnEwbEc
         4DLg==
X-Forwarded-Encrypted: i=1; AJvYcCVEzGHLwHoVciFhKsyQGbLiSYSIlG0hlp3M/kl1zk7GI3KELGk6QVJ0JIadcBpiEJToC86N7i8N@vger.kernel.org, AJvYcCXDNPBYuaYYg+6ABdz1OwJnYMnB7EKoiyw0LYwilFStEwlVAA1rMFZCm6ONboDRyL1NlwHNM1KMnVNY@vger.kernel.org, AJvYcCXpNuNvYXYbwBYiWymKVqJ325Hi42R8IWPePtZ2fSeh9irl+tFJN19hXYn7gE85fdvU6t3aEmyXZRECJmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrGdCja7E4/h1BjR+f173moHpzRskegLDWNGW8wQOsr+0+Yaj
	il1hKrdEcFivKmRwYj/EK9NHDkzzxIVdXKWg7nenQWBmoUpJMzA+nmso
X-Gm-Gg: ASbGncv/TUwT7Gr+sKCMShNL2lyPCVUyYe+L7yrKFutL+Cce4g/RqQtIvGflSlJKfDl
	Mf/aFFSKJo2MGYqwk/br82dyatMig53527abGiGzIPRWFqqnP6Jav6/gaOYwAQOsYkN/i1oeTFr
	iNWyo37hVoifECyTsUamPstrNkLyw0baQlSTnsNljwCVnk4gAzCKHdMvbR+skhza1NXWFOBoFEk
	FIdhbVXZGsqTMM7Vd9jf4EUL7KxSGZGiFYW7/NR913AoWVNRPhAdleohcO8dBzHZviwcR3TvIT1
	/glNVzUi3gshajDwy+G+WfvUoii6Z6gkq+Sce1V1RvF8q0WiqF88x0wp/v/1bq8k1FEQ
X-Google-Smtp-Source: AGHT+IH9yer7SwNXsFDAt2nUJRKt97iEJnL7X/6yFuf9K7ua5zElrzLxcG4WsX/aOKAL8BkQiglRPQ==
X-Received: by 2002:a05:6512:4488:b0:54f:c10b:253d with SMTP id 2adb3069b0e04-550e7245258mr671687e87.40.1747389392940;
        Fri, 16 May 2025 02:56:32 -0700 (PDT)
Received: from foxbook (adqk186.neoplus.adsl.tpnet.pl. [79.185.144.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f30db4sm356925e87.76.2025.05.16.02.56.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 May 2025 02:56:32 -0700 (PDT)
Date: Fri, 16 May 2025 11:56:27 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
 "make_ruc2021@163.com" <make_ruc2021@163.com>, "peter.chen@nxp.com"
 <peter.chen@nxp.com>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pawel Eichler <peichler@cadence.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: hub: lack of clearing xHC resources
Message-ID: <20250516115627.5e79831f@foxbook>
In-Reply-To: <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250228074307.728010-1-pawell@cadence.com>
	<PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 07:50:25 +0000, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in
> correct order after resuming in case when while suspend device was
> reconnected.
> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force host to suspend
> - reconnect hub attached to root port
> - wake host
> 
> For this scenario during enumeration of USB LS/FS device the Cadence
> xHC reports completion error code for xHC commands because the xHC
> resources used for devices has not been properly released.
> XHCI specification doesn't mention that device can be reset in any
> order so, we should not treat this issue as Cadence xHC controller
> bug. Similar as during disconnecting in this case the device
> resources should be cleared starting form the last usb device in tree
> toward the root hub. To fix this issue usbcore driver should call
> hcd->driver->reset_device for all USB devices connected to hub which
> was reconnected while suspending.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Taking discussion about this patch out of bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=220069#c42

As Mathias pointed out, this whole idea is an explicit spec violation,
because it puts multiple Device Slots into the Default state.

(Which has nothing to do with actually resetting the devices, by the
way. USB core will still do it from the root towards the leaves. It
only means the xHC believes that they are reset when they are not.)


A reset-resume of a whole tree looks like a tricky case, because on one
hand a hub must resume (here: be reset) before its children in order to
reset them, but this apparently causes problems when some xHCs consider
the hub "in use" by the children (or its TT in use by their endpoints,
I suspect that's the case here and the reason why this patch helps).

I have done some experimentation with reset-resuming from autosuspend,
either by causing Transaction Errors while resuming (full speed only)
or simulating usb_get_std_status() error in finish_port_resume().

Either way, I noticed that the whole device tree ends up logically
disconnected and reconnected during reset-resume, so perhaps it would
be acceptable to disable all xHC Device Slots (leaf to root) before
resetting everything and re-enable Slots (root to leaf) one by one?


By the way, it's highly unclear if bug 220069 is caused by this spec
violation (I think it's not), but this is still very sloppy code.

Regards,
Michal

