Return-Path: <stable+bounces-58237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7692A7BD
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7964F280DD6
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76F146D6D;
	Mon,  8 Jul 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVpzk9Ac"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945D1420DF;
	Mon,  8 Jul 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457965; cv=none; b=OQ8Wvmnx/aOjBARwpcTLA9lXdx9/lggTcJZ/0buKcIFmb5s8YcLIg1bp3YlBKh7SI+FywGmSoA3eW4lZF6XD2MKcxiBkuIv2MYdfJmLZR/rYX2m7U61lQZ/Qahdm9RfQHf3pZwNT93bzQb9nts6vCa0sCJ6JxygbsUXYzZImimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457965; c=relaxed/simple;
	bh=MC2jeh3K9/F14G0xAQUbdCPQaqJVCH7hNWiRGr+8a2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reneegsUhAw2I1T52hNDtAMPv6kGtrcu0VWYYEoGgnYZ3DbAsuo9xURg6e/MQuJboqF34RiQsmCSUE/XWk05P54PnPnDvpdJgqXQUAeW1URtBW9rb3znwuR8/VEAnjNJBe9nqNcm/yAAMBWZ9Q8+jmja/sth4OCITiBw258C+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVpzk9Ac; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso2344985b3a.0;
        Mon, 08 Jul 2024 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720457963; x=1721062763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GA2XpCO1J6d5gU0Ok1U2LXi29QvqLxLZP3osgsxdgHw=;
        b=DVpzk9AckBTAKGwijWNCZIUsglELTWgXcH/LBj4el+e363T2vMu1bLzVa3/ptAYdBK
         vuzoRzZ7OFnln5cuBCYoIXRJFfY9ZeQnH9AmSHO1bQzuQZ0zQXHZ3NeCOSz5WTMBKLVS
         pEYCrFeJmpcyUsYomwe3oNp4urMOuMRCIzrRNW84NvZIFUHfSL8L3ERzqH8t1qYTOzXa
         NWuf+1imLNiMp3FL8zG8MUXPtRl1DWG9Ra96eVpchja4lcyg6Oygb7SUrio8L/YUX2Gt
         YovlVmnKyiJLdPYdNdTKORmvN6gJ/wdLWSw0A/za4tf7OLmoMUk0lE41QcgfB/ymlu0y
         DY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457963; x=1721062763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA2XpCO1J6d5gU0Ok1U2LXi29QvqLxLZP3osgsxdgHw=;
        b=WiZJqn9PStlhrFzEh2rnhS3ukfxGxR1U8zOtgPTnHV/k/KGb8OSU5N1m+tT0KUcUCq
         j6UTZA+MZo4OhJhn6GhblkxLsDBfQDjYZrTjQ+ixaCksUSY9SZxE70TMXOgDGWDSBsmp
         GaLfRrFkoV/Ck+7cDHyC07AIuMtvPJNbGZ9+OR+D+YCXXc0fSmmFoYmR8YYmBDhC6taB
         oSRBI/DouHjR6eLBQRzAxCIVmVqU9V6C2YfWg/99dCTgIJgXAc2h4NQwplzvKbAQdYyt
         uYXnDP7pgXGV/FSBeWLcvJpC+ole+7t8l6wZp1OCVKXt0n4Nzw3BsnvaBCLEr3HFyaJi
         +g7g==
X-Gm-Message-State: AOJu0YwnTlADHkyuAqwOeQzhooKS+oS26AmGosGlTyh0J0vdixKmSUz9
	Mba5KY3esfZxzPEOMObTIvdJqiQsg7UihT19TNsfwy5GBLFUnYHNlA9JrA==
X-Google-Smtp-Source: AGHT+IFrE6plrfxZ7rb8A7BCluebHnzY1IN9Rk6CdNYktXBVecfXRWLFTtQm2HhIv8bbRBgQA8GLew==
X-Received: by 2002:a05:6a20:9184:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1c28a6934cbmr3720908637.12.1720457962789;
        Mon, 08 Jul 2024 09:59:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d2a4:59f0:2144:2c00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898de8sm97558b3a.27.2024.07.08.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:59:22 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:59:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Patch "gpiolib: of: add polarity quirk for TSC2005" has been
 added to the 5.15-stable tree
Message-ID: <Zowa59vf_WdtspFc@google.com>
References: <20240707145855.3697915-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707145855.3697915-1-sashal@kernel.org>

On Sun, Jul 07, 2024 at 10:58:55AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     gpiolib: of: add polarity quirk for TSC2005
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      gpiolib-of-add-polarity-quirk-for-tsc2005.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Sasha, you are picking up a fix for an issue that was there for 7
years (since 2017), that nobody reported, for a device that there
probably 1 or 2 users in the world attempt to boot on mainline kernel.
For this you are forklifting bunch of other changes as dependencies.

I questioned myself when I was sending this change to mainline if it was
even worth it, and I am very sure the risks far outweigh the benefits(?)
of having this in stable.

The same goes for other cherry-picks to other stable branches.

Thanks.

-- 
Dmitry

