Return-Path: <stable+bounces-165577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51FB1654B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476A03A4878
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2E2D839C;
	Wed, 30 Jul 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Os4oyMcT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BD1E51FA
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895929; cv=none; b=QEOZ2f+S4VOuK+HkwndD5PYOO4oTjuL21kr41BBwOqtg0ELQIgp397opHEFTO2IG68suHLVlgovsWdN63OvwCnrWeNzFUkyG+E1aXbAR+GqAyZz06N2IlbCkG038nKXdUyr6s7VQeNPYAz68685mnX1LtzKdKEEPpGk7iruOQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895929; c=relaxed/simple;
	bh=VppY1RNaGM05qSVYWlq2x203DUScAe9oDHwUZvqRxOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PKgCrByA3eWr+UIOSjqQ5nE6ugwhpFJaV6WvFUTv7Bfe5oZxXilBwUvOkiefSJHNnNSeX0rlJ81U1BseG/ksNomTM5r4dhqf/Lh2eEIQQSHrNtFkuYCtyZ/HAZ2UKqsje2uQamTI9xVRWx0pxno9kCbBVdHyO+kMfzNejNqlNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=Os4oyMcT; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30008553e7eso60159fac.2
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753895927; x=1754500727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIgPfkke9L+gt3Y+xzk7up30nLE9ee9GkO3g0N8HBW4=;
        b=Os4oyMcTtVNphKiwdsY3q28Bguarm4NoHOsrFdJzeMGRl2+ZtGbxkVk5ykvHvz7rh5
         4/aToVAV503cfmcscPlYfIUcIqA0gd8Pc3zFFH1K3Kxx1aIGp7Et3nYxGKpkRIOpQGCn
         NkThY24B90uTd1pbXuppvqluRIR0ZCspQT7H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895927; x=1754500727;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIgPfkke9L+gt3Y+xzk7up30nLE9ee9GkO3g0N8HBW4=;
        b=vKsEBTC6kZRHLND2MZ3Q7+55cs+RMsGn4iCJX8qF9azcXeNg46hsS6lrCYoU4QOnv4
         AHNnMCnbHmYOmwMZJZF6V0Bj8ZZx4Yx8uz/BaCZO2jD/P64UQdYkjbh8yoZBFZ6BEghJ
         C4+/d6pzYEViZDkZ0PUVPQieM434c6BGIKL2VvbH+2ohP5yXKDkSv1TH4QF/SYFq7Z4R
         tv39DP8p+Kpu0Uuqn7sR/9D+Ia+gPuMOrBmObcgKpO7XuSKI1BEE6saqaN3lfAhGL7/M
         hOre+7CICeTiKRoC1jNVDZuU1n6aFYM/kZcKeWb/VTRop33sNEvwEs9BaU6i8nXXz5Uq
         Oasw==
X-Forwarded-Encrypted: i=1; AJvYcCXc6jx9Gu14ZsfL4Z7gkuREgJQN43LhRhk4iyxzbvFuNp83cjvd6nFyDLHm9ExAmhcxp0hWsT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovHqoy4nh+bAN4kgeM9IS1XZ2hH5u9FPhk4x1X9ErQHnbtVra
	i/pF9/kXrljjmtceuIsIf3SafKBD2WabywtqiHhAQoqUiRlPzc9mctea657MzbJyJ14=
X-Gm-Gg: ASbGncv4R/zAGqQrnUSwFDBd4IGCUbpeCqCbVGFV2vM4/FI/wnRw51xDvR5PQ8sR9bW
	7mD0NDaK0I8VbAEBezKqgdcd55tTVO4o5d9D/JHtqJZ2kLcsOd3hv8TZc3EM8dK/UtwsFNQ2noS
	AW3UGJBhAWpxmHUxmIGO7lHC4QUTjfm9NT1SeT/rCAl1wMLVucGTRxg8h15/v3R77mpDycJFgQW
	J0WAuKs5Vz3E8oocGjsi2FLXilV8mUXhTfw98QIsVJfR2s601Y95Xb7jQS3MU+PboUDYGJM1gfs
	I2U+82hohn0mfCJtZ7yIn0XSAGeN7PzktwhP4kX/TWlowjJgkyW7J0p+PC+rs+fEPzNpyaXC7Nj
	NTHGLPQEnJnxsfzkcRx6DN6vybcL5yIMwonkG1IPjKuuR0c0iNYyXXEw=
X-Google-Smtp-Source: AGHT+IHuTmWxI4i8r7ZHOjUOwORgqYc37RB7JdviVo2iiGM1xg2pazuUrfsKeAcOpVwoAltr7qSk0A==
X-Received: by 2002:a05:6870:b417:b0:301:5fc8:d0b1 with SMTP id 586e51a60fabf-307859d3a4emr2813245fac.6.1753895926645;
        Wed, 30 Jul 2025 10:18:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:18:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Klaus Goger <klaus.goger@cherry.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
References: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
Subject: Re: [PATCH 0/6] rockchip: puma-rk3399: anticipate breakage with
 v6.16 DT
Message-Id: <175389592490.3621398.12846810223384732149.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 30 Jul 2025 13:10:16 +0200, Quentin Schulz wrote:

> Due to updates to the Device Tree (migrating to onboard USB hub nodes
> instead of (badly) hacking things with a gpio regulator that doesn't
> actually work properly), we now need to enable the onboard USB hub
> driver in U-Boot.
> 
> This anticipates upcoming breakage when 6.16 DT will be merged into
> U-Boot's dts/upstream.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] configs: puma-rk3399: enable onboard USB hub support
      commit: 7810d079adfa7bc7b73085896d3a00d736b5cafb
[2/6] dt-bindings: usb: usb-device: relax compatible pattern to a contains
      commit: 7c0491ccc6a772a13b326b76a47cb6b3cc5e3f7f
[3/6] dt-bindings: usb: cypress,hx3: Add support for all variants
      commit: c419fd81349efaf4301c3b6e66ee12d500738105
[4/6] arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma
      commit: 6dd61725a2207c0ac3a01138ed34fd73af2e9dde
[5/6] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      commit: d0681cf0c8cde4dcf98d02912d5f0ef2ec786c9e
[6/6] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      commit: e12e9320a39cd26368aecd8961ec11c7526ff1c3
-- 
Tom



