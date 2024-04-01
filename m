Return-Path: <stable+bounces-33874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9914893877
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 08:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A0B20EA8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054CD8BF0;
	Mon,  1 Apr 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CmwUezKu"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218623BB
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953839; cv=none; b=DVeiniqvCElP3Jm6oDc7dYGEpb59F1a2M5lsfKZDL4Nva87yfmXbW55HbCGpzeQLOd3d5hx3QF24L47AGI68JzQIw7y8aNOsIZXhQ/gpdn4KlM9SlvnB7I7zUhlWRIVm5r6d2tILYALmMCG7e6iafQ2vjQmkaSOi9NVpIxEltSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953839; c=relaxed/simple;
	bh=2zPU//NQ2Mb5rmZzF1z8Dl3h+/pMzkxQehgy12BmhYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8KQUPUqvs0mfXl46cD2hZ3YpW8kw0SNFzKLlDS0mkywTAxBAMgFOPXvQP1FndbM8WQpthQZPBheiNGN0f0chUAJyuWN0HgOxBvFqhUtFta8/3Lmt7NkjKyLrZnMjhBmtjgkEsmqWdvyBqWofWXUBXjDB9WqScsEnaQ4JpiqG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CmwUezKu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <349de395-0797-478d-9e04-860ebf423f4d@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711953834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7OJf8fKApgyb9hZltYxm31CZ8p0l+usVnA6B81mmP4=;
	b=CmwUezKuxSATDrAXVBfJ0+dWssMgmgFoGDicYLgxCbD7XyIVQU8WFyMKuMrJOZJyRQ+8Xg
	HD7J5JsxW7IZB6GJoFRoJbNvyYPUGNFO51g3IA6r3F5KvohbOggVBTiFCNZk4YvdKgIUB/
	+jCqTfDyiYNWSsfAGyLDkeyb6bmg4biiNOOMTSpCkIfBFsu5fu4BEI9dzFWO3AFT6T85eJ
	pu1RK62WVOb4Lfdise4+gNtTRuTuFlY6Wdautat3MyRBLnmz1RfWzClEjXDnTMItWiDMrB
	0Eir+AGMKE6Wc+my6IYt8LkK4xwrq82pSB3TdNsb/pmF+ZdqfYnIJvxnt4o/sA==
Date: Mon, 1 Apr 2024 13:43:49 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
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
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <297c2412-5680-4a4f-bd43-b3431a0bb4bd@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 01/04/2024 13:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> TWIMC: Kenny Levinsen (now CCed) posted a patch to fix problems
> introduced by af93a167eda9:
> https://lore.kernel.org/all/20240331182440.14477-1-kl@kl.wtf/
> 
> Looks a bit (but I might be wrong there!) like he ran into similar
> problems as Philip, but was not aware of this thread.

Hi Thorsten,

thx for the pointer. I'm applying it right now and let you know if that 
changes the situation on my device. Might be the right direction.

-- 
Best, Philip


