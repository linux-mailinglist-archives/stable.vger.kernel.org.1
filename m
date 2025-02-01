Return-Path: <stable+bounces-111915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BFA24C1C
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52591885445
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D581724;
	Sat,  1 Feb 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g4sfP0wM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6211547FF
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738451277; cv=none; b=DafwsKCCS71qCvmjOC7wsnxwCs2U4ig14Ay76/ig+Hjm7Sxr48EpagDhDjovvBlC/p/cXgdBcAcdqlgRLdonZl46iHGuq8WaL578HUZtFSlqLHETnqOva7hUXU2wRtYqgoqRQJ1oShBqCwnSLQfgYqsdUQ1WIJuixmfqCWjCeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738451277; c=relaxed/simple;
	bh=A1+Co6Ldzp6vCLEZJuunZ9IQjcvfQm+huHWbW7wV9kU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zp+76F2L+qYJ9MOInhWoePDSdjtbLpGneFNmQrWkcttCNoJ2G2YCiKxJajwVRBvhpFSbp0+0eFXfRXMVJB6odWxBDA6BD7P5IOW3RFb6i4XEv/x/D2yDVc0ctSwoEEMjufLixYGZGhR0PtlFruZjFDT2sWTL+kAkZvPjHwpdAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g4sfP0wM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso22038745e9.0
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738451274; x=1739056074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q3DleDzpgD7EzF7P1DuXDyZxKtwf0/HFl5nJAaVslM=;
        b=g4sfP0wMakiDIpguEy8FP52GwAEUGzOTO43zKsy15knzWliGYgnUtmxifOnnVsrtW0
         ACqS7/ES8AJ7mWxmnoa0waSAGZEAq0yU3JKVKeoHrqsWVnuCyAgfA/zuXNdJRrLdsQf1
         TT66BdgZV1vP/LNch+ZFOGc4Zy5Zhni5bxRp3bFu0jE7ylYQc8ex0nay7vTit57oGhe7
         /fJzfLdjoO7Nvsqc4EayRPiHyoNBesw2ULQbVSIWRp4h5oRyy9PiqGkeLM0bq1o7kTg/
         +O9I1lJiehAH7d6lGFmMOq2o9lOAvkdNev8JZmCtQwuIYkW+cSw/mJyMXnWKW0PQGazi
         YYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738451274; x=1739056074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5q3DleDzpgD7EzF7P1DuXDyZxKtwf0/HFl5nJAaVslM=;
        b=bf57wTJI7l2HaWK+MnzUxmW9IFfYcvuLxrYzRv6xmfrt4sMO4a8BE0317U2SLya8Tb
         cwcqG6OaSaXaV9EMK+hM9x7RhLsb1DzqcRkCVPSW7S+hNUgj32VBpsjyi00a4/sSa0Ly
         F8XM1MRNZDwip5GPeqJkADiCik64Wv0ykTnVdC5eQTIxb0ZVOtL1ia9NPxScQ0ySHodt
         oQ9l58OeThcPHhAdcwdlrcBqq6zgLgFtU4IW7K5EXW/ioSYzl1SGEgvdNiDMeCfmuy/D
         6yXD8DCQuBtpU2OxgUCGQ31v53+7apkECp5dYFToH+A0l9UiCFlYxJ/6S6xarpp015tx
         gEpw==
X-Forwarded-Encrypted: i=1; AJvYcCX7A6B5nDTx9rse+cGSBnSXS3uBMLUGihdTVzK1UGP6VXXl5I/mxwEFZ0auM5JTAGKRB4rwvMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGc204TZsruSWsi6X2Z/acFwCasn2uNESiXvlNW59CtSqjjs1
	akrWo9Z6UoC1AeOa9iKkmhe+Q7zNVbvLX54h72E5BkHS/sH5PGSF
X-Gm-Gg: ASbGncv+CMa1AvYP5lYRsGe0a/QLjKqG9rmzodB2P3pWhaBzjrbmMPpiGZggFzvnj1k
	3fwM0tWx6N3sLBbH3P1g9/jb06eQHoQC2M4qlMQAqCqgmt6aWXkSmTgN7AoxRXVrMY2iRpe8oz6
	neySkORPkIl15GepK6+Xt+UQ9JiegF1i71VK1SkI8YCWev8eGzKRQt3q/STrGdKQvADkhbIS5OA
	3kGTXdU3cjpXRxW42dydenJnMpy5rhGsN4SuwUcNXvxLvNlBQf27bFA5IUpvsFWG0gqRq34TWYA
	IRw3KCephAaTX4mvtcgH/S+wifaniA==
X-Google-Smtp-Source: AGHT+IF1ijrf5GV3LAgJuIitt8CuxdpOYO8Z/Kf+YMgYFonfsxo1H9DKWlH1CP79/A3UyOHx3knK5g==
X-Received: by 2002:a05:600c:a45:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-438dc40cf15mr130069765e9.23.1738451274253;
        Sat, 01 Feb 2025 15:07:54 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b5780sm8487849f8f.67.2025.02.01.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 15:07:53 -0800 (PST)
Message-ID: <7a543bef6e096babdb4e8a02d86e0b68f4c92697.camel@googlemail.com>
Subject: Re: rk3399 fails to boot since v6.12.7
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, 
	KeverYang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, stable <stable@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date: Sun, 02 Feb 2025 00:07:52 +0100
In-Reply-To: <865xluvmp0.wl-maz@kernel.org>
References: <b1266652fb64857246e8babdf268d0df8f0c36d9.camel@googlemail.com>
	 <86a5b8vd0d.wl-maz@kernel.org>
	 <fc0b65020f3376e5245a8f599a060fdca10ab61c.camel@googlemail.com>
	 <865xluvmp0.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Anyway, can you try the hack below? it works on my own rk3399, but I
> don't have anything on the secure side. Please also try it by passing
> "irqchip.gicv3_pseudo_nmi=3D1" on the command-line.

Done, works in both cases now for me. If you want you can add my
Tested-by and/or Reported-by.

Thanks
  -- Christoph


