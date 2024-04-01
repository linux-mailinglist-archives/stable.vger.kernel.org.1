Return-Path: <stable+bounces-33917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E168939FE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ECF281FC8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DC125C4;
	Mon,  1 Apr 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="H6nzgVvl"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A07FC17
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966161; cv=none; b=jy+vokp+y0C1gSfJcybG8fMMOHjiZvfbMVXed6O0dPy+zg1m/kfoRuay5WaxCK4B0g0AB5kWjQdCZNEmIZK8EofJ0p8bqKAUM8+FUEGmLbwPzxpVpxEWK2nvY16w/KZr5KxKlYXYDzcBboUEW2EyE9ktD5v4+HOu1mzPss00uVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966161; c=relaxed/simple;
	bh=owbAWJTh8qQ2S0tIMe55XWKr2wK/TJwI7lOHLRVnbuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhYfs621+TYbdoUd/GIZtSq6HA6h8sNzkYf5qIKGVvD1muHYixwlwRg+xIRQY+lKxvbstsen8pz2oOxlPWdJSNgnfOKfNjn6CUNyOwjADn1f01IQ9DAurqzpww41A6XZ/eWTlbI30Dvx1SQrspWTLGpRZ6yJKyicj2Qq/YodLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=H6nzgVvl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <53b09f02-1422-405f-852f-02776fde19d1@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711966157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkbQG0JgQBaS0/cgc7cfRcHgIDa0PJBYGC4RDf8vMgQ=;
	b=H6nzgVvlBcqzCFu/X5behYchee1uf2t7QT18H/99DkaSLbtUn9jlG4iD9IFbrs+/9XZnGW
	LXTXtoDpWveLgwVrIrZYpilJkAgkKZK+hI2eY6z4L98UNPCVnxfEk4tDEjPAJPIqwc3iBC
	CM0Uox98Nnsu8JglPevsaqPZ+/wq5a1emo/XqrwUbXYW9vrNhwJYo7TximkSQBvvZW/U3m
	WP/zr/xtfRYI0PfiE9y1qKz+ntMcToae6n5jgJf9gSx4XVhDMmWdHwvguKcAfirjn2mpmI
	bNGYNO1XBncqLToflVyIE5Rz+NRKUNcxohyBBloIRqvKP5IL+JRc0jYK80SWBw==
Date: Mon, 1 Apr 2024 17:09:11 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Kenny Levinsen <kl@kl.wtf>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
 <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
 <297c2412-5680-4a4f-bd43-b3431a0bb4bd@leemhuis.info>
 <349de395-0797-478d-9e04-860ebf423f4d@manjaro.org>
Content-Language: en-US
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <349de395-0797-478d-9e04-860ebf423f4d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 01/04/2024 13:43, Philip Müller wrote:
> On 01/04/2024 13:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>> TWIMC: Kenny Levinsen (now CCed) posted a patch to fix problems
>> introduced by af93a167eda9:
>> https://lore.kernel.org/all/20240331182440.14477-1-kl@kl.wtf/
>>
>> Looks a bit (but I might be wrong there!) like he ran into similar
>> problems as Philip, but was not aware of this thread.
> 
> Hi Thorsten,
> 
> thx for the pointer. I'm applying it right now and let you know if that 
> changes the situation on my device. Might be the right direction.
> 

Seems I can confirm that the patch fixes the regression for me. I did 
batch test with reloading the module and no -110 errors anymore. We 
should add this patch also to 6.8+ kernels and backport if patches from 
that series should go to lower LTS kernels.

-- 
Best, Philip


