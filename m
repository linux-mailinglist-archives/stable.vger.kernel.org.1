Return-Path: <stable+bounces-119526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA4A443A0
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7913A170783
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6221ABD3;
	Tue, 25 Feb 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgk+0JNy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F621ABBE
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495236; cv=none; b=oLsbbUqT8Py7DWfGqW/4BWsdnI2hwNk0LFzUDPMWDQ5e0GsW30mMqULkQPRdHBg0nzdJTdh7d5OVRb6DH9qwK1BTEK5uNscNWPvibuGLJ2903jhuCm2cClB34iFKZYDhsUS7pyp5tVTc/em2FJVvTGWdoVk+GpJIorlu0b9v/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495236; c=relaxed/simple;
	bh=/rkbwb7BWbpl6EvsZedD5EKq6cXDtvyu4pczaAeBfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF5hDrbZmNYu+uCQ5WW31lV8GGjpRtFcNhDLJgQQjFOZ2h0+H9p83ZiGPehaNrk02qI/aQqKZORuEkCM1Y+1a79ZSgtw70vYN0J2OkEX9TzqOScQrtblRRxORJndKaUHXuNgGyTfCwqbQDtKSgBI9EGSbWfxe/8BFNS0gFXicHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgk+0JNy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so7752443a12.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740495233; x=1741100033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5C3026m8vJqLHregU/ELib4I5AMuVrmyvjpEMDfDPJI=;
        b=cgk+0JNyTeGz+vhG7I4PeJGQ095xAHkbapdPaaMPLShqivabNWxsskW37uRy1r9ON8
         fS4leKKkq6o8uPYLFbIdVr0e3Kx0q0hX3mGSfnqap4adwK8L5+q3lTL6vhW0v/NNFezF
         /WE1356lCVUNag0McCAIlM+SRFwK+0EM0kyLCY5O7MbhKutuNhcFjS1YfezH32scI0Sb
         qIw4Z13zYOYDON+xGux7CaSIMs98oxoOpadi4w1eH5TpeHsl/T/E4VayB6KfOddvmIDl
         O2k7vvGCRCKg3CtnuGyfPW/++Fttn/+ySZu+HmOEsi0T7rzCT4u4rv+tTD5BPIgJ+wbz
         6IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495233; x=1741100033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C3026m8vJqLHregU/ELib4I5AMuVrmyvjpEMDfDPJI=;
        b=tN70GZNT7KdN4qk9KYwPTvOWwqhu8NdronVNxoC8sstqQnGcBQtW0cMm1hfuczg28t
         gZPxPeBwkZas10KOufsk14fujK4o189P5mUYPd79i5u0ZCmHvX53uYzAbf4jOa/UJ7GU
         Vz4N32GbNFywaDh2+Zk9jBCy054I4kxkQRgUXtlKoSCANOJYPjTs1FcMGmbrqAJoqrIA
         PYSdVxWaTFCR++gOtPi/ZG+zsquT1nmFgCxYDnQ1JEg+bYdusrj0g2ZgFX8BSiQtOpwx
         8tt2a3aQ6Eq0KO3NU0LHrFbz/cECLA28XdyDVyRfovXkefn+FvubhYk+CFpZt/aiGS1J
         hU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZM9oIiOU9Sz7LZB0SQwNFjnkWgyVlXBRaQyiyXFh3V+iB867tpnutPkGjHYFfaqN0AHO+0dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXudjxKDT4//xThLMRyZTgBFHw6luqYQRo/h0a3DaEuOxH7H3
	wZ04t93n5h0mMUS/+Ii1TttdtKtMNpSmQbxqh6lU6RCzDxMn71gS3n89/n3Rb1Q=
X-Gm-Gg: ASbGncukejCJcCRCHpFThPYfAQIUqMQrpwciwrZWXJ8m8uxugH9qi7jbDXR3egWA8Ez
	OZT5JRu5VCXlz7c2Zgz/SAsE2im9igIShCRGzZ0M3moVkWvN0Si/N+aNPu51tX7DY9WXMBRkiUz
	1HHWEuTTdjMjp8DxX1lyES3Woz7d3Kg5vnlONvEPiHsn9PXEGBuXlFzjOvxUy7XOBM1W04T5mxQ
	nyedGwUW05Kq7JJEECKsl9I5Pb6in/xEqogw0nYeyGoBZaZlvQlfjKsqKuaD58FHEjeY4haWIh6
	NZhizn4rMNISPL5RcxXBaODuv+3elO4=
X-Google-Smtp-Source: AGHT+IF9Qg7g9R+HcAoXsNncQZZXosXuBSyKZekQD9yLdDMX6VPLdQatIx5tZiUiQOgii6TA9Dw+0Q==
X-Received: by 2002:a05:6402:50c7:b0:5dc:a44d:36bd with SMTP id 4fb4d7f45d1cf-5e0b70d5790mr15883093a12.8.1740495233068;
        Tue, 25 Feb 2025 06:53:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e461f3e7f8sm1338944a12.69.2025.02.25.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:53:52 -0800 (PST)
Date: Tue, 25 Feb 2025 17:53:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, paskripkin@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [BUG] r8188eu: Potential deadlocks in rtw_wx_set_wap/essid
 functions
Message-ID: <40085616-3b80-4e4d-b610-605dba69aede@stanley.mountain>
References: <CAOPYjvaOBke7QVqAwbxOGyuVVb2hQGi3t-yiN7P=4sK-Mt-+Dg@mail.gmail.com>
 <Z73MMWEI7o59qzDL@equinox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73MMWEI7o59qzDL@equinox>

On Tue, Feb 25, 2025 at 01:57:05PM +0000, Phillip Potter wrote:
> > This issue exists in longterm kernels containing the r8188eu driver:
> > 
> > 5.4.y (until 5.4.290)
> > 5.10.y (until 5.10.234)
> > 5.15.y (until 5.15.178)
> > 6.1.y (until 6.1.129)

This work is interesting, but we're not going to patch old kernels to
fix static checker bugs.  If the driver were still present in current
kernels or if it were a privilege escalation bug that would be a
different story.

regards,
dan carpenter

