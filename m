Return-Path: <stable+bounces-179836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F1B7D9B9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622F5168CDE
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E131A7FC;
	Wed, 17 Sep 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HkvugRbS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81A2FBE0C
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111928; cv=none; b=ZUcGGwSp4ERsUUEw3UVT5V3VKdiLa/i+MTaJ/ntTNnQKQgBPBdgUWtPGy/L7GAWahrzN/90c5gqZ5XmLbwsgH8LoWMbhNCA9ZxomwKDV10lF/r89edbUlJ/NqexFcGj74/4ec9FOU6eC75msxde8SO8UllyoSgxaP7hVMyLLiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111928; c=relaxed/simple;
	bh=hfGHEKj+Li5C+SsyBXQ5+0EUnOsVD4wRyx9sD6DmIzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/i269W103g8ADbYSSkIIh0BzCQWdSkbHRDDnqTtks7XknrKtUF3/HjtR3qY6k4WmeHdoGaDlu1co9CjDzDrnzGH/XYndeylwJBJkFyvLV5eTPhjfbt2a8LYSBBnrpyJbopLalO0QhPgcsRsim0+YDLxkVbUSgefuAKDUjZtp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HkvugRbS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso682391166b.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758111925; x=1758716725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=HkvugRbSmQmsWNuWVrAIphvTAX3krdROP5+PXI5WRJcjaLKIqKeq11+pC8XtbO+A6t
         V+1clxw0GB+epCvnHcel8Lc4rw2OJouRl/biHaZJ8D4WIlzbZbKvNiGNWU7Qmcz3UwOu
         dQh4lAmSfzYWwB40jY2LsMtGsfN+YME+lR4VuzjezFYN1VbQ5XUbPs4n+XCwDqPoNSJk
         BEl6bLpDtpaqOKpuYSUktVkk+PdUZZCQMRtAe4TZ7fddhBYwl6klQQD8GnRNii5LzmoC
         zK+w2rbylUl3m63IR4lNSV+g75AiwgsON8A+OJHv6VNFXeP4vkwMKAEipZePkgOmx7od
         dg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111925; x=1758716725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=w+roEs0NNtPNdRZdpg5UufxvXEcjOyUTE/zxPdU2ptw3eSFh9ilV8fUG0kfbNeLvAq
         Cwj4XCuUBjjDkvI/n1l9491tANKSyghjActd+3GTNjRsI5nA11r2AayYU1UZa7tt4Ba4
         cyOOp1bkdg3cUp/QpVhKnh4Epucbb/jYPcUcEr0dNuLwbE+st5p16+5oxRsTCfRkkqE6
         zLiGUWy/2BjBTJHpGTFlH2LGt6/g+9e11kHEZZ3yJ9txe3uyqPIuGuZBCrbhdHDeVkiS
         gM+w8/8RtkNe2m4rPK+obR6UL61fPXSA2WE94/8loPlVUoGXh3mz2OowqFwE4O3kHmnA
         Xsfw==
X-Forwarded-Encrypted: i=1; AJvYcCXWvu0EmZrMlkj1/OlxwxKPIcF9oWyPFnOdC8q4WxV7+pah8R+uX1HHpc1Lh+TjQHD9p1jK6Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzkGv2imjHg2Sf8IvpqYI+qydFIH/hPVRgO17+EFShhCQmsGu
	H8P1Xl9XhPtXPX5WaRUf/Gbr4CSuttxEjL4xVOgDCZWi3RR6Gn9fAi86d8LteGiHkN4=
X-Gm-Gg: ASbGncuc2/dOy5gooDV4O7Qe9c4XpErpeJ8T1JU3PaXauTU6WvcEhF54Ufg6/FrytE/
	RBsDsnKFbXJPVMTXU389cYDE+E/pgRjBDfkgCsFFPA/bEC2wm0bBwr0fqI1DBK1sqKttocH4eAB
	M2rhwmDQQuPmI8T2h0FKoQAxrzeMBaAM2y9h0or4Zf0sDwTQ58ktZrDw0JqVGU3NTLutofaQpAJ
	xBDJNCmQpZ0NsHqLZYRKh4PQfWSo/zljwLMaDHFA+eP8n5XRoJ0JGz2r7d0WGRUZOuMdBA5UEXg
	nOaLPch21Ko++y1p6VsnswSth04g6wJhZoI3jXUl4pdhq5Bc97oLaENw8CGVBcZn8DGIaZULK5F
	VFnEihSBlyBAYZPzUhlghzjSaY8VDdMkehs+VLaLxwXcH9n4sLl52JnOXO8HsQkw1
X-Google-Smtp-Source: AGHT+IEMHO2+mrGwehsjHQd9adkafh7FOklixGAh9piZ10AcM2OldRJUtx+VWHX506OwdEOot1gHeQ==
X-Received: by 2002:a17:907:3da0:b0:b07:b645:e5b8 with SMTP id a640c23a62f3a-b1bbfa2bb35mr217910766b.30.1758111924771;
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f1989123fsm8515308a12.37.2025.09.17.05.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Message-ID: <cae31224-95f2-4c62-bdb5-1e1e81f2b726@suse.com>
Date: Wed, 17 Sep 2025 14:25:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
 <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.09.25 13:52, Oleksij Rempel wrote:
> Hi Oliver,
> 
> On Wed, Sep 17, 2025 at 12:10:48PM +0200, Oliver Neukum wrote:
>> Hi,
>>
>> On 17.09.25 11:54, Oleksij Rempel wrote:
>>
>>> With autosuspend active, resume paths may require calling phylink/phylib
>>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM

This very strongly suggested that the conditional call is the issue.

>>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>>> and poor test coverage (autosuspend is usually disabled by default in
>>> distros), forbid runtime PM here to avoid these hazards.
>>
>> This reasoning depends on netif_running() returning false during system resume.
>> Is that guaranteed?
> 
> You’re right - there is no guarantee that netif_running() is false
> during system resume. This change does not rely on that. If my wording
> suggested otherwise, I’ll reword the commit message to make it explicit.
> 
> 1) Runtime PM (autosuspend/autoresume)
> 
> Typical chain when user does ip link set dev <if> up while autosuspended:
> rtnl_newlink (RTNL held)
>    -> __dev_open -> usbnet_open
>       -> usb_autopm_get_interface -> __pm_runtime_resume
>          -> usb_resume_interface -> asix_resume
> 
> Here resume happens synchronously under RTNL (and with USB PM locking). If the
> driver then calls phylink/phylib from resume (caller must hold RTNL; MDIO I/O),
> we can deadlock or hit PM-lock vs MDIO wake issues.
> 
> Patch effect:
> I forbid runtime PM per-interface in ax88772_bind(). This removes the
> synchronous autoresume path.
> 
> 2) System suspend/resume
> 
> Typical chain:
> ... dpm_run_callback (workqueue)
>   -> usb_resume_interface -> asix_resume
> 
> This is not under RTNL, and no pm_runtime locking is involved. The patch does
> not change this path and makes no assumption about netif_running() here.
> 
> If helpful, I can rework the commit message.

It would maybe good to include a wording like:

With runtime PM, the driver is forced to resume its device while
holding RTNL, if it happens to be suspended. The methods needed
to resume the device take RTNL themselves. Thus runtime PM will deadlock.


	Regards
		Oliver



