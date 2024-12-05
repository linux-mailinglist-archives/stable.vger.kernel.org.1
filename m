Return-Path: <stable+bounces-98794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF19E5514
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C15281C03
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC73217F37;
	Thu,  5 Dec 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OPtka1xb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14682217710
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400650; cv=none; b=JfCj/v1L4/WBva9Ekl8XnTKXT3wdjDpcHQzIDcXbPXjPkhJHqrLSZszroeEqRBTZ+UFQHkhMWpEUHAAyKeUtIy/Nk67g95j23EkCJwHOVYBT6ahjaRN0lyOkcFt/8BmxbPR63QJD39yWMKpa64qBLw6UzniJLgSUyUKavj3cmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400650; c=relaxed/simple;
	bh=2EZLrM0ZLYYdbPxLmXbwElTcSDaUUFW0yoyYRrkj0Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOBKn1/evq8vJ1d0KGu5rXlQ6eAerK3nZ032NNlHmtaxRoY/MJL3Ut5ygiUmkNVWxinIc+MvP6pTP7GGfgAhjRQySVJcRyhg1a5703wwsfcJw4jUYJvgTUDbmqQs8Htv+3ZBhqDBn+tSuUPkRQBI/kQRoJuqpPN/T5HCvDDu9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OPtka1xb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so8864065e9.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400647; x=1734005447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=OPtka1xbNSnLHImw/SXzmr+vThp69HlpLao6h8MAYbHaOsNc6dq0iCM+OMrR138uow
         HzqgCk8UDWKG/7KMWHtKMRJ1S8HiPD6x6uoC1Rmvy/PUrHCVRs0fINP0P0XPL4T0X9zq
         sDqPl2wN8D8rbTjt2txODLTHVW+k4IH6LjpBzCO3LdAdLdqYYCV5JW7AQ1knwZlG5WOu
         dBn+vF4/HHQHrAv05x1saKN9LvoMx2qAxI+wpacl/cqBstKNwf1+1vociSfl4oynozH6
         vD65XvWtgXMjVyR48tMMWawjtM5vsYkjZp3g+3hcrRgYwJZwHYGb5g0n/vYIavyAWYRQ
         8wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400647; x=1734005447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=ML6Ci7YIWN3iDWjl1P597XOH/peBFSF9bzmu88zIpey93OlajsyAosxN6XhwXkd5JX
         26PchdsnIOobCe5D2dMIddgDWmwRVxuCKgk2idWAsSH/BR1HohMPYYIY51wFs84vI4Rr
         FeWKpZcI1yrm4e7peT9kksZDqe8N5LEh47TKLv5p39gBnwFUTlhIRSgxGGK+CBlm4tSK
         11jn7+T4NPOkyUTC0lb2v9TIQV/QcSOiSaILDLSOVCC8PzFuAnHoDL07ios3SHqX+BVV
         2aRRO4aSIbJzCRjQkcbYASbYkisZ6O3x7iqJMd67L30lICosW8darx7fTOqEfQ/jceJu
         48+g==
X-Forwarded-Encrypted: i=1; AJvYcCUbLDliFI+95GO6uH1XRcmq/fH77tipMHDwvs+N5yBioZKq55WgjhKoqx0jlpSWEVOVGnTs5WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyh1StD+XAXUwyCcdCGuNQupeivVDRl2J5c1EiOgEjKtqe/wmo
	xwWOEhE8Z4QDR/AdFKgpULZxfzpduwVZZtjjAutuCaVtiAGlSYesH2So6TJI5uc=
X-Gm-Gg: ASbGncuWGsGQsaLS/S/CSB6V2g4eJvybxlMT0bxWWlComaZCs2cdtyIF3rb/4T32DeF
	+8pOf2uxoMPp7owoMKliwOSjI4aW6xYr+xPm0KruOhLjrMYuZ/8ajRMg7DjBxbr0tL1ofao62fU
	Gfn2SfG9OfuPKUdFbN/gmf8BPiV/H3M9f/1KWjBkf4OQNQvFhFmk6kS+8d1uDIusEvHAcPxUr3J
	dd2AEVN9jeDaKC0l1+W/CUHxBCIhS/ncS45LVC0atbENVc9
X-Google-Smtp-Source: AGHT+IFfZ50+YagInJgFWXUcpmHfKY6JBPuy+JFDnVOzAD63Uh2CX35OZkA94Lrmw5g1ER5Pu8VJOQ==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id 5b1f17b1804b1-434d09b5fbdmr91829905e9.14.1733400647235;
        Thu, 05 Dec 2024 04:10:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0980ddsm22089655e9.0.2024.12.05.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:10:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Wentong Wu <wentong.wu@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
Date: Thu,  5 Dec 2024 13:10:45 +0100
Message-ID: <173340064220.41307.8479220444337077350.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203141451.342316-1-lihaoyu499@gmail.com>
References: <20241203141451.342316-1-lihaoyu499@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 03 Dec 2024 22:14:51 +0800, Haoyu Li wrote:
> With the new __counted_by annocation in ljca_gpio_packet, the "num"
> struct member must be set before accessing the "item" array. Failing to
> do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
> 
> Fixes: 1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
> 
> [...]

Applied, thanks!

[1/1] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
      commit: 963deccd17d4e538a8bafb1617803746efe910ef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

