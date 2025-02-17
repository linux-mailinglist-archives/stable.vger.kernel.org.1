Return-Path: <stable+bounces-116562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38088A380B7
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02161168306
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CE217654;
	Mon, 17 Feb 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z01mC7QZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF815C0
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789502; cv=none; b=UCrPO61xG+QeF5PJ8x3H2SZPrjduIkYeYZjeUd4gXzVVBAYxfwZ4gPU43M+/+rO7f/puIxrzDUcbXqSLGcy47/SefSrzlOCTgEXkhzcXq6D5u8O8Hod+pXBx8EXksrShM53o6Q8XMnSm3I+0Xln4+SSHjekmib1f/4CzFGM4/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789502; c=relaxed/simple;
	bh=2a6DWia5aelo3+hT4preBpQwhiMBH04u1wwdvEZZTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIB7fWSKcfCHlVUl7fvoObgMHW8FFOQC6iXDyjKk5aM6eRiug/KTP20XNDH32b32yczNs1hWvP2KjkXk2zOGCtUh26y2E9/uvhPMu6hK+X8be+wf8anfaMNDlReW5nI6oSVue5LHJ/mR8Sc00TT/5owkA554Bl5Ba61ll5ahaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z01mC7QZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso2188816f8f.0
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739789499; x=1740394299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9rL7BFj/LGtJcja3SBY10iTH0HmL8V8oaNVVBtRsuM=;
        b=Z01mC7QZwOxL1/XXOMz8nWKJZ3L8MAjS0d3cK2A7by6uQfstUzM4Y14rz6xBv/zpPW
         64ynFLrOUDJCWhSemDJkL5Y1xc/m+vkZLc5PegYqS35Z8puUwKjAGUYd6KuudKb09Aoh
         2JQrdPAOnccxglYFxBTqdOi6GVooWchcKg6q9sj8JEW/+5KYRi4XpXT1TrFzWPoFzBQu
         y6gTdKZQE5/upc1psewJIGHEays7sgTxdVvh9q/SKja/ilAM02ZZrDatrSwiJlR3Df1i
         cNqYmIiZ+SykBt4rivydr/pwudfbhl5nsqjxJtzmXRZMUNR/eF3Sjk7V0KtqmaNHnOXP
         ScZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789499; x=1740394299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9rL7BFj/LGtJcja3SBY10iTH0HmL8V8oaNVVBtRsuM=;
        b=avnWyTe/s9VtGAMVnC8mFDv5kj8g8mVLOCM9Ifq84/3f7SKUePr+j2ci1zNFn/5GYd
         rE6iSWKDR0p1x/K56NYBmuD5g7GN5bCKl3TPyhV3i1nzqjCCgNS4G5PUUxDb6CowQToj
         GR3vL5zmH0C9N2X/X2xJH/FOBMTa2R82btPQlAxkOmW9v60Zuuu3cVuygok1+AUryE0p
         9v2TDU4bHexwbdMzC9ysTpyPczmv1BDI3br1PjdjnuOU8X2bAYPktb4G0cELKhBgOMs1
         Nea1CPZocgZMiVGyvo1ec2LNQfkq3QRgSVcTlV/zJhfushLihXkmcRxEHweaEAz/hU2t
         jsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXRdO/7Iq1Hlb3202k6Mqfmw6ftQw9qd3Sce1ZMHadHCICdrkkMt3LTca2xW45U6vRMSaBVWtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuK8euS1MVPRRzFjoHtR2X9wH6QaVJiuri1EKPRKZ3iouS7/LA
	yKYfwLH66yn+aNTi7MFDpy3beEzUVi8cRAH38/68/HGzp48RGeJA8PTIjJK4mp4=
X-Gm-Gg: ASbGncuA8ztpEy08c7g2t+ytlrNpLmod1cxkK6MAFN3o2TkxSgvqjLixrMymQgWEKRm
	6Ki776Acmqcz9yM2bhGTC8y/Y1ZQ+brG+UR/qYkcPcLbj6xDo/5Gjr6ko20QOKrZxp35cRvGds4
	drKLZXp16L9XxQVIJWuIXI549LpSDnpbkCByjan1IYVQoFf776xyxzOyVAuHc4TNDuaBvhPUqrb
	ozVhojkeoVpHqXgm0SWMwWYZhnrghSw0DEye6F0VxwaJlBTiPihYT4Xq05rwIR/imHTYz3keDe4
	zvd9E0iDbe5R
X-Google-Smtp-Source: AGHT+IEcFZLNABjtm5sf5QsAlzR9E7GKqtzQrNge8fNqrR3LiZfoVYgQ3/KTJrrfcZCS1hAQIBqFGw==
X-Received: by 2002:a05:6000:145:b0:38d:b325:471f with SMTP id ffacd0b85a97d-38f33f1f725mr7557321f8f.15.1739789499204;
        Mon, 17 Feb 2025 02:51:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm11717692f8f.85.2025.02.17.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:51:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/8] gpiolib: sanitize return values of callbacks
Date: Mon, 17 Feb 2025 11:51:37 +0100
Message-ID: <173978946845.153202.10192575435977387116.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 11:51:54 +0100, Bartosz Golaszewski wrote:
> We've had instances of drivers returning invalid values from gpio_chip
> calbacks. In several cases these return values would be propagated to
> user-space and confuse programs that only expect 0 or negative errnos
> from ioctl()s. Let's sanitize the return values of callbacks and make
> sure we don't allow anyone see invalid ones.
> 
> The first patch checks the return values of get_direction() in kernel
> where needed and is a backportable fix.
> 
> [...]

Queued this one for fixes. The rest will be picked up next week once this
is upstream.

[1/8] gpiolib: check the return value of gpio_chip::get_direction()
      commit: 9d846b1aebbe488f245f1aa463802ff9c34cc078

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

