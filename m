Return-Path: <stable+bounces-19682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07485281A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 06:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A541F2452E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35FB11711;
	Tue, 13 Feb 2024 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xdjjI/uG"
X-Original-To: stable@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7D256A;
	Tue, 13 Feb 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800722; cv=none; b=YREzsEIvTBECr0ZmHlsP4oDg+DjX6ZMEyDT34Cq7jLY/Js9gGtu1/+QicjdRG8m9nqR6UK7LEfl25umhSlabALKUlRRsL0TqnWXi0nzWWH/XYh0A/zm7NmPV3S+3kopxQM1HJivOSLnXYVj2UQ2b7W/+Z41VieAf+mOpNuRcp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800722; c=relaxed/simple;
	bh=WSKMr6gkDr1yf6ORzy09m9ta4RLYmTrh742X0+WP1LY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XamtYqAq/Jtr8yRgLxlyM6gT8GPWDrfeGyQDXJL8RTsC8P1+UFl+eO7UE6X24TxmUQ0E7yM6Aom1LS6gHAkMvD1FUmSGlQbmzfAOl+/+d1s6AxD2AyiUiusBU8ezXQaPxowdGJEmwfTAYywgPn+GGOrIAnBcP/1Y4Je/N1V7LtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xdjjI/uG; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 248045C00D5;
	Tue, 13 Feb 2024 00:05:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 13 Feb 2024 00:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707800718; x=1707887118; bh=Rocq4MWumvMfC9CyxYv4ihUWxIMl
	w/77e/N5Du0lMQc=; b=xdjjI/uGXdt7OIXCZrX8j28ZTCn++0Lx1WEuVWn7Oxab
	Mb5LLyl1kI1PHe0zaoq0TG7U/ka/tJ7K5sKQ2wc7YWHwTILEue56nt06LxCfKgec
	Yv2D7BT5xB7BJVgbFNXJwBQeDoswOe+SWKUpc5NKx/lcr8t1c+B5bFnutya/c6nk
	V+1jpO3qjae/4+dwSpPplp3Qyu7Z9PmszxXRHD9fS1HcrB+pxREsEpN38WRXFJmj
	UMLyuwAhrzK8Lmu+MfKie6omTOEoL9tgn4XvsaAJ8tSN7UivKZ3qkgKAZFWVSlpb
	slRyocSnKSzcl4B8TV/l7vuX0klGS7LXG3BPI11IpQ==
X-ME-Sender: <xms:jfjKZfadPvel9h4Le3UmYdVErNmOb9Ydb2Dy_li4FCyPrMaZCMFDtg>
    <xme:jfjKZeZhUsJtMonr_KkAdXn7QJXZyFE8G7K6AMtEbxGUzfu62p1KRs4nYwEWB2F7_
    yaSnEOtHnxjQQHYjJc>
X-ME-Received: <xmr:jfjKZR-rcGxIMoJ7NJqifnQ9nNYdDXaG0WnvfAWrYlSGW8wA2XFcDv-Kfvw_JOPAtFdIjkb4mKLKW0dUTCV4e-R3Eqmw6-Ej4R8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:jfjKZVoiLk1QPYRNKclOLt2EWgb7kRqQ3bZ0jQMimdtz2_IDtDALVw>
    <xmx:jfjKZapAvUIdAS5x8xYtmM-U2pe1EMXtOx0n2bwDQ9uk5A__KTmBrw>
    <xmx:jfjKZbTgS_zOcxyUOkDpwdljxJKmwlNJOmLi7EKJ3Yuu7gFx5pfwPg>
    <xmx:jvjKZTlgZFtTygnCkeKIPM5yjVQ73b_4O_1lfrKg91uEqDL6s2yR6Q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 00:05:14 -0500 (EST)
Date: Tue, 13 Feb 2024 16:05:40 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Ulrich Hecht <uli@fpond.eu>
cc: Al Viro <viro@zeniv.linux.org.uk>, Michael Schmitz <schmitzmic@gmail.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/8] m68k: Handle arrivals of multiple signals
 correctly
In-Reply-To: <522961735.202648.1707732123771@webmail.strato.com>
Message-ID: <f3022b02-9859-1af1-1913-4215a12c1da8@linux-m68k.org>
References: <20240205023236.9325-1-schmitzmic@gmail.com> <20240205023236.9325-5-schmitzmic@gmail.com> <CAMuHMdUMwQSEwDQ3tsmChutY3P0VQUA0A8jg63NxfyrmxfKWXQ@mail.gmail.com> <401b6911-e6ed-3e9f-9dcc-d4f951c6beef@gmail.com> <1501038841.1120470.1707393238298@webmail.strato.com>
 <34d37f57-3146-8aa0-7828-2df2d1679ee4@linux-m68k.org> <522961735.202648.1707732123771@webmail.strato.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[Cc: stable]

On Mon, 12 Feb 2024, Ulrich Hecht wrote:

> 
> > On 02/08/2024 11:51 PM CET Finn Thain <fthain@linux-m68k.org> wrote:
> > Ulrich, I imagine that you would normally receive fixes via the 
> > corresponding -stable trees. If Michael's series went into 
> > stable/linux-4.19.y you could cherry-pick from there for your v4.4.y tree 
> > and maybe avoid some merge conflicts that way.
> 
> That would work for me.
> 

OK. Here's the relevant commit. It fixes bd6f56a75bb2 which first appeared 
in v2.6.38-rc1. I believe this can be cherry-picked without any conflicts.

50e43a573344 m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal

