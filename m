Return-Path: <stable+bounces-238280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ2SOs+n4GlZkgAAu9opvQ
	(envelope-from <stable+bounces-238280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:11:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57440C06E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 297483009382
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6C38F657;
	Thu, 16 Apr 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds/1jm87"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3137CD49
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330697; cv=pass; b=XqiyUkDoEocNN70nrB8djlDBKPb2tzlVSOFsg6T9CLFnbd9Yz/5/htnG+r80PafEw/iK/tkC8+82W3ynQ0qeUhgVzc3kcmFbjpSBPvkiGxvonou2IgyEWBFY+IYAOqeyi3F/N+eXp17i7+w8tLzTaXO+gLqdRrv7gFq2nuggEVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330697; c=relaxed/simple;
	bh=lPss4pXYIIOF8fADFf1z6o8wrqt6CC0/v8OIPeDBCN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaoNwQL8GSohEjXWrOM62Xx2S6HQH14Mp9GWAfIH0HH4QVKOPDrOe3F8mMBBnxA8hO4fdxQlrI10tykPI9t82YGcoU6DgWp1fxLfAdAcS4GzBNrKZRDnFF0EoNwSnSIqwhdTrf5yLyvuem3thc6vdUJbhG3hRrgltA0R43T0nbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds/1jm87; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501547d7edso7308564d50.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330695; cv=none;
        d=google.com; s=arc-20240605;
        b=LXiwpo7dzbnMAkax+0TRNROWOdEbYAYWcvf3zQGcfHFnUbEM9vlRkgrjE2Q67V5TX2
         uCTE90AeXgdbqfVFIcJ8zWzJmJ1+lfmYWG6Bd8XX4Z/QrQeDvvgFrEwPfSynbjph2B6D
         Xu3ro0gulp8Ggsjq0MjupYghvZEO4A3sl7Ok6dLw9XWQMWMk2p7mK4t2Ygm9+xMHQU8Q
         xPPpNPgEMZO5/ArtbjrnoDQpIsi689uuc/LjPItZ8IWNoBUsepjQ9bb53ku+PS6HoaGn
         lZV/7vg/VGIFdGv+xjPz/F+UFDwuAWBabWsltvaBm8uhC2avSIxZZWc+/5CRLLitsskX
         +wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lPss4pXYIIOF8fADFf1z6o8wrqt6CC0/v8OIPeDBCN4=;
        fh=dUhVcU1cQH38RcoUUhGUj18xREThjZQcePp296uxEMM=;
        b=kgyHuATOGM+a5IrhgYPjcn/9Bf8y/4ZIVxAPcdHmrdtkNZCCWIvBU69SD4S741AcKk
         zVyf5ZCfQQj+u77UqVAWO04gsz6h7UZZY/7nBR4h7ak+V5po3jO0HuBOEaKZ+LOsL9rc
         n4rQLy7d8XIqDPOV+a7Q0X0FUzadjhCJCOT/Lrb1qpA/m4tCzXVh2ZDC9SFZawuEt/+S
         BNElfD2AgbkKWohDSFAfeEjloUvnuKR8xr/JP7QrvfhcY8giGtojeN7PllDz+h1ocDhD
         Khti6D2ULHkC+PXtxIVlJAXJMarwSYUOZaZ9KLhceITDJt1Erdbt9euPSaP3WEiygf7Y
         p3XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776330695; x=1776935495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lPss4pXYIIOF8fADFf1z6o8wrqt6CC0/v8OIPeDBCN4=;
        b=Ds/1jm87aCAoVUXxiXQfY6v6ION4oPz/OWMSG3pGIMj7aQPmZg9jSuLpbp+CLdsOud
         YqSH6HlGtnygSheNT3doTBVISbW1CEZNfdltKD1urNJo73CQsvs6Vqx22GS5AUrh61Sz
         OG3yg/0c/pTuYDuqiP+vqxHFy7eVFugptZytoPLEBfQVSGuayPkupHf1dK7DBfK1sn16
         BF0/lgfzZk5RNZti/yYqWGKIGONWjMdWmVy9ABIkHeGRDHU2IQ08jJPD6OCR12Gga+1Y
         ym3j63lPJanmJLwJStxRW3Fofa/147Pl2dnYRI6ijF3f1FxjwGXYbxyfArYViSFEhLBc
         JmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330695; x=1776935495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPss4pXYIIOF8fADFf1z6o8wrqt6CC0/v8OIPeDBCN4=;
        b=sI1idIWQ4Pbp43SZg9xtRQ1W22SJba1ggchefY1+VrHbWvKqM+roREBFmPRjnCuFFP
         uty9X1E6DEf6wEW1D3v0eIwWJw3/VjdF+Sh7NzFBc7XNtJOFufQ/DYii63ozf4t36erf
         J251xhl14pTgARGcSWvEjspsXQ4W79YHu6drbMkhn2XxXWrMq3f25NCwao2YEZlQ1kni
         zICKHxHMEen8sWX2dZ3uk4yvPm6bEbfpysNWrWsVkeKgoKAoGo3QKNjZ1hzMOWwwqkh9
         V8kNzMg0X5vkR3c5Z+3J5eQPU5GLev/dA9sJtJuaWvtbxRTk7JwwaS5g9rFLSnblHOzb
         u9Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/vOi1Ycw76f70gEmWww1DaYYquiP7MmTqY6UV2jJ4IwmFHWCNTetTJTKOmZXRI4m7XPkM0dMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6+0e3XUIPMufx51Q2e2Bmj7sVTqdo26mBWNna/1i7axbOpk7
	c6BziLLR/BPiQohYf+00AJnlsJOs1bg97TG75XDyYsHt6qDBdWrF9uSJqZMRJtJFivyqqFojSd8
	4eIPhW/bFeZH3AVDuvUp7IHlBTdigpMc=
X-Gm-Gg: AeBDietKZuvS7acPiItsfx8Sv48XlQRJAwfPAxGIpmr+F+XHTSJ6MD0NXMOTHsGnBbe
	M6uGDF4JE5K05IgOmfBeg1pdTHltOcFXhrlUjkml3sw/csz9P97TyeJZc3l1ziSknXAouQ8sq39
	hS/kD3QYmNCQKBhi/7o6saTTYmUYuoJRCdfXGt804gYIZndA0kE1xq2gwBOcHAoqGzKxAroaFuf
	Xp+ATxehDt+b7+/awF3vlvn1IaW9ggolmDqRbL+bhDSehFUFtcFXDFDFW6MR3embX+z+SiTXPSp
	nl6vR0xyYWcXblBUau+u
X-Received: by 2002:a05:690e:4105:b0:651:c698:fc01 with SMTP id
 956f58d0204a3-651c698fe41mr15283368d50.24.1776330695403; Thu, 16 Apr 2026
 02:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415154537.3451732-1-lgs201920130244@gmail.com>
 <75275f6e-8314-4dd6-a54e-95320c2224e2@linuxfoundation.org>
 <CANUHTR9j8-wHB8rE1zGLaUw4ZyNh2Mq3njFerBoUcVPWAh7w6A@mail.gmail.com> <a189c5e7-9119-43ad-8a90-b96cc40fed06@linuxfoundation.org>
In-Reply-To: <a189c5e7-9119-43ad-8a90-b96cc40fed06@linuxfoundation.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 17:11:21 +0800
X-Gm-Features: AQROBzBkyYJEDY-3EzYz4JpmEC6TfTKUR_6PKczImyFVHt3Y9gPZvyypY_TFnV0
Message-ID: <CANUHTR8FYWid_W=Lcd_N0dZdaoTFdxVKJhE9G4QBrcp3rsCiyw@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: fix reference leak on failed device registration
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238280-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,patchew.org:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 2C57440C06E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shuah,

Thanks for reviewing.

On Thu, 16 Apr 2026 at 04:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/15/26 10:56, Guangshuo Li wrote:
> > Hi Shuah,
> >
> > Thanks for reviewing.
> >
> > On Thu, 16 Apr 2026 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >
> >>
> >> Can you share your manual review?
> >>
> >> Can other static analysis tools for example scripts/coccinelle support
> >> your findings?
> >>
>
> Did you try other static analysis tools in the kernel?
>
I have not used other static analysis tools for this case.

> There are several calls to platform_device_register() all over the kernel.
> Did your tool find all other cases or just this one?
>
> thanks,
> -- Shuah

My tool also identified other similar issues in the kernel, and I have
posted corresponding patches for them, for example:

[PATCH] eeprom: digsy_mtc: fix reference leak on failed device registration
https://patchew.org/linux/20260415165203.3584869-1-lgs201920130244@gmail.com/

[PATCH] arm_pmu: acpi: fix reference leak on failed device registration
https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Thanks,
Guangshuo

