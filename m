Return-Path: <stable+bounces-45157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598B8C63F6
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08D11F22375
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90F4F606;
	Wed, 15 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRAaCy/G"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703105914C
	for <stable@vger.kernel.org>; Wed, 15 May 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766231; cv=none; b=KHUHfhp3AV6YwgkcHhfa+WN1grOI0HwlZ8fB2ECLU1RhufEk6ECxhjXoRUOZuqSnP67HuChwf1M3pxV2/5i/UI6aEOCbzLzIo+jl2McaQwuXR0sMrvE2AC9Ta2ccY/X+7hCJqXLWww0c7oEP4m2ieoXWccr1njUHSvTfdnM1vqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766231; c=relaxed/simple;
	bh=DdJm9Bit6Wh+9eclgu5ZV0rmCnz3Qf4JVoyFuHUVyhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZK7rUeqOIUzpL66bPhosgV9hXDXqhT4Wdegm0ohNZjrVN4cp1AfnicpH/I4myrmGXturO5tWAP7kn9ZoFct5sjLyr3S6B3/869HhyZvoY63gV2DHAVkKKwI50VkNZ4OUOVxSOY6aNOTGM6lzgVuXHd9hm0O0L2pyUZlx0bqV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRAaCy/G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a7d28555bso172667266b.1
        for <stable@vger.kernel.org>; Wed, 15 May 2024 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715766228; x=1716371028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+MJzfm+E8r097Rlv3PlQkUBO0qXhOpW/sqPSTf6ReY=;
        b=aRAaCy/GKw7JdtlBaE3gD9s2dsMQH1ZBJoSl1eFRZgXvhXAQvFGfdqU7RgLuTH5YbD
         o5fSJ67MWGj0p6vmpcjckTewMnA/02ArlG5vafSsPK5vdVfVZs6FKgp32B7g9+i5Iaxl
         2zmutJHlgfsVzQpImShonwPR4bMRYyRE0j8bLo4k1dTmQIDquKmApAAU8kayRZYwgFpE
         jhXi8q+l9VoMxJ6BTnU0hVFw/+HyOX2ZFEJVqNG2ox0h/yiEFzEA6vwbcyq4WF/IzqSB
         2QH8VdfHwmgK8dyYUQ8bdjNxLpMG8a5VswLJivGd5x7dioXbnGpwT5+9d41p9aRTm920
         NcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766228; x=1716371028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+MJzfm+E8r097Rlv3PlQkUBO0qXhOpW/sqPSTf6ReY=;
        b=uoGEwvKowtiOGdijpjK86FUqBklt6jLj/W3ILgeWSQDrqi0SFyXk4Yzd6O3RAwoW9A
         ZaQWASMCYeNLkquqy13i1fPP8xP7q4EnWFeQvNfkSJfaiYn4pXvOG9zZm+ksLgHh/6Nt
         x8yqB51jUr6qfcxMVmi5uOSprvhoKUS9TfFCua6da0XmhTVzGXiXYDBcy93Z6SqJ05Kl
         pbyHAhFOh9n7+RQdOqTqWlSij/Nc+F1xPthffa0aQpabLZSFEfN2ROtfq4+lM+3ces6H
         WgvfPjid6o5BHDxE3i2goezD2qm0d3dauhXT5hOZKbH6eGp9Y7Xt8JInJvU3CfqeMpcf
         d/Yg==
X-Gm-Message-State: AOJu0YzuQ5sYYzvrpG2ySxguq8SZoQqE31bER7hy8k1GLVQRXlwkySzR
	4aEPm8Z5DcWIeETxa8qw6+h8xhlK2Po+8r7+Azs0kUfVtgt2Uooyg4/HkKLCE6s3iC+C1XYOqWm
	urV0uDK872ZOYm0EocJj5aVFIi6rxYA==
X-Google-Smtp-Source: AGHT+IFU6pwPrgmcuuL5DKala0I/F+8oidFX3atLIqmp4CAYuBIHcfPZpw7rRaJ0+nUT3U/W5JOTOseAZMRD8aDv97k=
X-Received: by 2002:a17:906:a24e:b0:a59:aae5:b0bc with SMTP id
 a640c23a62f3a-a5a2d5d494fmr931422566b.42.1715766227485; Wed, 15 May 2024
 02:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>
 <2024051531-praising-john-b941@gregkh>
In-Reply-To: <2024051531-praising-john-b941@gregkh>
From: James Dutton <james.dutton@gmail.com>
Date: Wed, 15 May 2024 10:43:09 +0100
Message-ID: <CAAMvbhFoTRtiPWnb1vnyAhfygXJW_39C2N9DCJyy9--gVxkOEA@mail.gmail.com>
Subject: Re: Regression fix e100e: change usleep_range to udelay in PHY mdic
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 10:12, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 15, 2024 at 09:36:02AM +0100, James Dutton wrote:
> > Hi,
> >
> > Please can you add this regression fix to kernel 6.9.1.
> > Feel free to add a:
> > Tested-by: James Courtier-Dutton <james.dutton@gmail.com>
> >
> > It has been tested by many others also, as listed in the commit, so
> > don't feel the need to add my name if it delays adding it to kernel 6.9.1.
> > Without this fix, the network card in my HP laptop does not work.
> >
> > Here is the summary with links:
> >   - [net] e1000e: change usleep_range to udelay in PHY mdic access
> >     https://git.kernel.org/netdev/net/c/387f295cb215
>
> This commit is already in the 6.9 release, how can we add it to 6.9.1?
>
> confused,
>
> greg k-h

Sorry, my mistake. You are correct, it is already there.  PBKAC

