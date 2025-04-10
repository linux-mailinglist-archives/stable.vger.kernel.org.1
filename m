Return-Path: <stable+bounces-132083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1795A841C2
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD86F7A83D2
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146162836BE;
	Thu, 10 Apr 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CJJl3MsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EF283691
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284589; cv=none; b=PFCSGxoU2NIBoBS6MJqBMfUdASG6tJrR40IPqK4QEVeGCTCCEV9P/QpbY8C/LwJ+BPXtLV+3EuFdzbFcUSGgVhT8W61TZh8bmpRejXuURdh1+KW8bGKiQ0/o5coudva6wtHoHetB5PnkM8ollt1jPPnoWT02jHp6s2YIYRaorvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284589; c=relaxed/simple;
	bh=7EF92uy0HqAr0vHv++Xpljd9wbqIP32aaDhXDf2csFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ethNKu0+NrnFuLJEPXRHAYTZVMyOL/QtxSWwCqLW9bljq33nnPs0rCp4RPZhvKfjkCqpLmu8ShGtjczCoy53Twa8FKWS7yeE7NT497zzKFunBsMRPk+gzvzeACRTIVFJaqmBKgpe51FehwP2CyZKJnEA5wjzTOuVhABrTjavYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CJJl3MsG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3316385e9.3
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744284586; x=1744889386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inreEjGkP2FB86SvKqikRoCXcnYDIYzGtWDBTQYF/sA=;
        b=CJJl3MsGLDMR6MEGfXjAewU7fLufwgbRvt9V3FK52IxvnTq3RD6OKYcfcT02+khAbA
         8RPf8STtBAYkhASw41OKs/2zC8/0rmjLahSqYGX+eZZUg711+DqyuOuIzqrHRVsASkxc
         7FUSqgBktoaUSFFCj285QZFah1sgSdPx8hrSJWhY8ZOiyRlonpYCRDTSbiuI2XodgEYu
         palOUjUQ9Ug1l7YTcF7nf4hNVrg/cOZemHqJ9G8u8b51u9c2YOMkczDCgr7ur+gq+E7U
         hxIPln6blfTqm0sSZU50mZwYWdBQUj2tpt42S1bBssx+E2qRRFkrCt+Dx9uTcJw8Y0a9
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284586; x=1744889386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inreEjGkP2FB86SvKqikRoCXcnYDIYzGtWDBTQYF/sA=;
        b=TZGdv0NgBhQWsEreGRFvFbjIEEAAjbEMlLJZNtb17eFepyhCNXSovANxk0dsRswQls
         4qRydiDzLGgz4EPsrZGZXX6uHKEpra2vwW12F1R9ViPDFmHeR6JKGZ02BdYeWSGnYqMD
         gj1VPyfSF4qKI1p4Cw2KMbtkTWaI28G5CRiMP/YukCglWXfqgvVYxInV9H3K+4+qvg6o
         TFu4pG9Om8jWu19CU39kVFfh5UT/U4OL3TgkjxDQvFBuKCn3XCx4akOEd/9EQhC69FLh
         NPgt/HJIK+3Az8+qnU8MiK5XLojwsIGWrMbWDv3BaQ9X13IpfSQ2AFcmWF3W75gt/urz
         Qhug==
X-Forwarded-Encrypted: i=1; AJvYcCUCi/zKOM99lPaP0oJD6SliEt05rIPnT7VrmSfQXWW0Q9OkDAy1jSITe+VI8gnL7drL/x3t2Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2L5sNDvAlGZIM19rnhb9sBHc5jQtKXB2KFE62hhHbmYO5iLn
	XNQkJlfrAxxrYJfviC68ycF1UHRX/Vr701qzGjTmYWu09uLb25MuMuMhC2vu840=
X-Gm-Gg: ASbGnct6SdK01aORpy/cQl9g/Qyfzcyiavzuv/e0fXPu8OZDWTd3Gq7EqtdmbPmN2f6
	CJOU4zW0sv7AJs8PxxIIjd6x9jDHVsX11iQrF2EFO613CueZ9ylZyGaoxE6wh7LrfGDxXH5BC/E
	qIDgPe+SuTZJmY9htmxr74hpN9CyobWjzufIxqebjeil/LdgqsuEdGKQuOtFbgefoEj5ZtPAOBx
	SvVhG6XjmZSCGVDEWWGU6vLEH9qkrqDiXQsZYt6meKWtHA6fWZz+yz2eiWD5DMXBw9IXhJ14v7r
	I6hX4BRmAL8vmn0xIg1V7xTsiROLW61tj1sOsgrkzqU=
X-Google-Smtp-Source: AGHT+IGiu0OWEfT2fJWCoTEv1DArNTgNn8X+CE9Dq1sIudD9zQeKyE4/MK4CcE//ivPh7Bmvd/5jzw==
X-Received: by 2002:a05:6000:1863:b0:39c:30d8:f104 with SMTP id ffacd0b85a97d-39d8f36c5femr2027739f8f.6.1744284585872;
        Thu, 10 Apr 2025 04:29:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b09sm4616409f8f.63.2025.04.10.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:29:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 13:29:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <Z_erp2nLRKzLXuwF@pathway.suse.cz>
References: <20250405145354.492947-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145354.492947-1-ryotkkr98@gmail.com>

On Sat 2025-04-05 23:53:54, Ryo Takakura wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
> 
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
> 
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
> 
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Cc: stable@vger.kernel.org

I do not have the hardware around so I could not test it.
But the change make sense. It fixes a real race.
And the code looks reasonable:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

