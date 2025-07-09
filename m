Return-Path: <stable+bounces-161422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35400AFE655
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3514E0CB6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631242D46C9;
	Wed,  9 Jul 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mFyCH4Lg"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56693293C51;
	Wed,  9 Jul 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057829; cv=none; b=R1qHIlA/thsnkjZEDJ2FPX/YU2ydSkhTvEmp5LabuLQlpK32y5gN3X7ts14JvHyrFYKGN2Yb13mnkzimsYjP9K7T+jFZGsWnSX2TcDE64IAi7QDSbmrPY4BEQIP/RgK5fn77ACFqMk8OLmkmVQ9uUAd0r7AyMLEaXD1VuGW0OhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057829; c=relaxed/simple;
	bh=i2nojjY5M/5ZpTQO+XXUZfDZuEkWfq9veV2u9ga3fFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRfMfL7OhvJU8rOC6vOJBgDHjKqr6qo5GMDcBBrsJEmczd3jdstSkEXfhijzinbU/brgy7ajNjoWdIvd9Qm1PVhlWxL89qfyiOEq4+zR2uBMJvnchiDO4jCi0lc/oxk7U+bhwFAVQyZg0ag6vL6wvhzk+K+Rw6EGtR3LEgpQUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mFyCH4Lg; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569Ahfq81189600;
	Wed, 9 Jul 2025 05:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752057821;
	bh=jyD+T34QYJ2ioCdy+HTorp68S+Nwa6aYr4LKt9u3P4E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mFyCH4LgnAI4nxJDC3XkvBTR11SZSa5izNgrcW5X9b+Odg6go8vNxeK7ga7Tf/8QR
	 bjHKTi7i/8Z+MAY8mrKYtvB6OZvGhRt+g+5K/yg2sDGoFPeU7qB/ykJqRzDSt3zDUD
	 NAYowrFXcqTjTr6D7ECVKUETavG0SlESr9WgoLW8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569AhfDD3275493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:43:41 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:43:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:43:40 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569Aha4Z3797348;
	Wed, 9 Jul 2025 05:43:37 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <stable@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C
Date: Wed, 9 Jul 2025 16:13:22 +0530
Message-ID: <175205778774.925763.11396013784655604242.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623100657.4082031-1-s-vadapalli@ti.com>
References: <20250623100657.4082031-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth Vadapalli,

On Mon, 23 Jun 2025 15:36:57 +0530, Siddharth Vadapalli wrote:
> According to the "GPIO Expander Map / Table" section of the J722S EVM
> Schematic within the Evaluation Module Design Files package [0], the
> GPIO Pin P05 located on the GPIO Expander 1 (I2C0/0x23) has to be pulled
> down to select the Type-C interface. Since commit under Fixes claims to
> enable the Type-C interface, update the property within "p05-hog" from
> "output-high" to "output-low", thereby switching from the Type-A
> interface to the Type-C interface.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C
      commit: 65ba2a6e77e9e5c843a591055789050e77b5c65e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


