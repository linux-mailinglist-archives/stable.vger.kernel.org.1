Return-Path: <stable+bounces-119515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F0A4418F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E11C173354
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D326A0A9;
	Tue, 25 Feb 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="M2+Zq5ql"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13726A09F
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491831; cv=none; b=nsKf6rUAnEGnAf7Me429ecy8p5QdeIXRfHb5U6PrTmtkTZMykMBKrJOG0XGmMDOhSn+VXiKR6ATIzhsLStDdxtsyHwNzpqD3hmExOlr/P2bt4qy7mT90vro4U+gBwJ4hbVKTmGgM03PEB2Co9EPKwBEp6QJvxkJRdKna9vTdIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491831; c=relaxed/simple;
	bh=jNkGx7KXDIGaHcJ2rYwzogZr3XWTs6dGfkVUk/mbr2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2BsOiepxX+MrRHCZG9uCggiH3p/Ns1WJNQUTPM+tPL2FIMRYLQXbRn+gKJn5boO5mlrqfZ8A8osfVW5ISb28Zxuib8KoUeBwqs/dBzTNltrAX1uOsbGDiwtOZ5KHYyKIKUMk0xc9g5ANs1vZlJEojT9tbSVFep0B0qg0l7XT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=M2+Zq5ql; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so53672225e9.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1740491828; x=1741096628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xCMWClilUVx4gbpg5+ELoexid4UMYXeO+KTrE/EAgvo=;
        b=M2+Zq5qlh0VubHbRGgBbNoghPP7JQFrlIgnayam9U+U6IONKGJyY5rU/ysItLiLAgZ
         ot4Hdy4vrO6F4XDNI//8qMfTQ2zTepsgDDnTszVlwcCvjOo6EgvGPWVaq90pDfuFl0Wv
         BiO/vskvzMbkxA3t54gcotOFPddeVWo5VqOuVOtkP3QrtTeSFsR2amNpy7oVzcI+iR7/
         vvlQn7a+vMxQhb3sHfhQMsIeHVOo03JXaZCqom3NZx5EQKMxFEksFPcMUL4vOR0W0cL1
         Kv+170T5GRA5E6vsneXGG6dFGKSjohvaopiUifl9xwv2KMBnTGNuv62jCEusPC2DQz9T
         2g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491828; x=1741096628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCMWClilUVx4gbpg5+ELoexid4UMYXeO+KTrE/EAgvo=;
        b=u8l04jGVJoWIEv4y6/5evD2M8eg7lI2Zh5jGgfLimkgJutqluknuj+/REAtqwwlntb
         IEmNLry/3RvEZOqk/yHZHtJ2qJtmSc0Mlf6lBE1xeFE28+vlckziUX6pM00uaflI/FN9
         I5SLg7g5fZU7D7c7vsCMBWiJihLudMd4MR3Jtc+bwr6y+ZkURqX/MPeqsmoKipmgZ0As
         bzwsWFiqqc64Zrq2oCqh9hgxrYykbNPiQ9gFtguEsRRBaKxV4tIIWURwRw8jTE7eYZUj
         VKmrtYo5IhlUMLpZvqirTzUcP8dbREOblQm1xYW6b/5jED9l6m9j9hTeupXYc/vbOTHi
         r3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qfINyhXwNoT5kIjXUFlTGGIT17tDKP9pD+W7pfcapwvB81Js77eIihJ2FcJqsYCZTemmkVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAFIBR4TP4mqTQtEb9HkwYTJgrMhWKTiKEiO9sXNWTvPiTjNY
	D8d/qqwWucaMnaIn34er3UeagtsLaq25wB4+aLmIgh//rKPZHd3oL48QCRNaBPg=
X-Gm-Gg: ASbGncsuM11S+1rOA4Z+VDnbtsIPg9ZKpes6tJZQVj60vEiUOHSsPXLxQMJE+Vnu1PH
	WLK9eCQWIkORCJ4DB58EJMqkQjNqEa48JNZT6613PJqkkZTvePfDOToTpQrQSnEQLn0OJOP2ZwE
	A5HkNo0VIUWVi5PDv0j0QepNg9d3yUHYNCMBbna94ruaLxSwztAUd3hyQ44uVOn6I7lRNnSnGzO
	kYczuBhU3GRYv49awEukdFqYEhldSmfOc/DZADsbzJN0DqrFbeBv7Ey0sVsmHuWMm1iara8/gmK
	f5FRKpQ1JX2q7AK52aeAoi/QPYr/ScZuVZRcSGqmkzb6rAGTYfDeiqxvWdB72tN2h0AVoXxwCOj
	VyAEeZbqg
X-Google-Smtp-Source: AGHT+IG3o40PfdZ5xWkkYDR1eeBLAbfrWGZbWWL7adAfr6rI6bN+lbIQp0cgoQxoVPTgCqdy1XoClg==
X-Received: by 2002:a05:600c:3149:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-439aebe6b9bmr154964415e9.31.1740491827635;
        Tue, 25 Feb 2025 05:57:07 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532d9dsm27945595e9.6.2025.02.25.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:57:06 -0800 (PST)
Date: Tue, 25 Feb 2025 13:57:05 +0000
From: Phillip Potter <phil@philpotter.co.uk>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: phil@philpotter.co.uk, paskripkin@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [BUG] r8188eu: Potential deadlocks in rtw_wx_set_wap/essid
 functions
Message-ID: <Z73MMWEI7o59qzDL@equinox>
References: <CAOPYjvaOBke7QVqAwbxOGyuVVb2hQGi3t-yiN7P=4sK-Mt-+Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPYjvaOBke7QVqAwbxOGyuVVb2hQGi3t-yiN7P=4sK-Mt-+Dg@mail.gmail.com>

On Tue, Feb 25, 2025 at 09:02:00PM +0800, Gui-Dong Han wrote:
> Hello maintainers,
> 
> I would like to report a potential lock ordering issue in the r8188eu
> driver. This may lead to deadlocks under certain conditions.
> 
> The functions rtw_wx_set_wap() and rtw_wx_set_essid() acquire locks in
> an order that contradicts the established locking hierarchy observed
> in other parts of the driver:
> 
> 1. They first take &pmlmepriv->scanned_queue.lock
> 2. Then call rtw_set_802_11_infrastructure_mode() which takes &pmlmepriv->lock
> 
> This is inverted compared to the common pattern seen in functions like
> rtw_joinbss_event_prehandle(), rtw_createbss_cmd_callback(), and
> others, which typically:
> 
> 1. Take &pmlmepriv->lock first
> 2. Then take &pmlmepriv->scanned_queue.lock
> 
> This lock inversion creates a potential deadlock scenario when these
> code paths execute concurrently.
> 
> Moreover, the call chain: rtw_wx_set_* ->
> rtw_set_802_11_infrastructure_mode() -> rtw_free_assoc_resources()
> could lead to recursive acquisition of &pmlmepriv->scanned_queue.lock,
> potentially causing self-deadlock even without concurrency.
> 
> This issue exists in longterm kernels containing the r8188eu driver:
> 
> 5.4.y (until 5.4.290)
> 5.10.y (until 5.10.234)
> 5.15.y (until 5.15.178)
> 6.1.y (until 6.1.129)
> 
> The r8188eu driver has been removed from upstream, but older
> maintained versions (5.4.x–6.1.x) still include this driver and are
> affected.
> 
> This issue was identified through static analysis. While I've verified
> the locking patterns through code review, I'm not sufficiently
> familiar with the driver's internals to propose a safe fix.
> 
> Thank you for your attention to this matter.
> 
> Best regards,
> Gui-Dong Han

Dear Gui-Dong,

Not sure what the responsibility is here with this driver, given it
never left staging. I've not looked at it myself for years, so genuine
question on my part as to who is responsible for patching it (if at
all). It doesn't have a maintainer anymore to my knowledge.

Also, apologies to be the bearer of bad news, but it upsets me to have
to report Larry Finger sadly passed on last year and is no longer with
us.

Regards,
Phil Potter

