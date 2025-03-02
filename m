Return-Path: <stable+bounces-120017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAFA4B1D8
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7F188B800
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CCE1E570A;
	Sun,  2 Mar 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KVQrDe3N"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E41EB3D;
	Sun,  2 Mar 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921570; cv=none; b=Ysg77lof1raciydcQzParkQ8NS4oyUb20Q4OZcKMUivIfyu0mO5FiMhUdr1zCqbXD2XwM/hmdFfBu0khg1AQeTgPhD4W+3jy7F2fOrhPkWj5ep772zC2SCSV4QsIrtjZxPO+/CLJiEih2O34sBT+YEkxzYK0nogymYtVN/Svhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921570; c=relaxed/simple;
	bh=fpsUf7qagNA43+t2AgJEz/2jXEI1D8GrzdCPihZ1iVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8JO4nSHgTqO2xZBPaKCNfHxMvKq8Uisln63buoSa1tkyGcv+BQgo/WwsW00vnV2mmExeBGAHNQ5YunpsdvZtFHx8spDTPtebnP0y9wL59CHHilyfNLkOTJL3n2oE7Cx9KhhZm+uzMj7b1bxSW4q9nFoqxrsdBtfVJEX/guGLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KVQrDe3N; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJFpX2461592
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:19:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921555;
	bh=fY/MmG+5flypk7XKV4+Mu6hbOrp0aC0XssiUPIU93SA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KVQrDe3N7LSSebcTlE6EAlmSYGskSe3DXaAIQw5Z4FR0LYHOO+44Uo3KFYJ4haqRC
	 TNRyTt4icftIpYFQsVezVPxI+P1vCpI9JuJY6oriLmUoCpLNfW4HBe4CMZRmt0uXl6
	 sYunb9DYv4Wnj7nRZjOmFlSTlSHrQHB+4AYfJDk8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJFu2010697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:19:15 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:19:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:19:15 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DJBWT116974;
	Sun, 2 Mar 2025 07:19:12 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <robh+dt@kernel.org>, <nm@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzk+dt@kernel.org>, Keerthy <j-keerthy@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size
Date: Sun, 2 Mar 2025 18:49:08 +0530
Message-ID: <174092143355.3272913.10095422286018964990.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218052248.4734-1-j-keerthy@ti.com>
References: <20250218052248.4734-1-j-keerthy@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Keerthy,

On Tue, 18 Feb 2025 10:52:48 +0530, Keerthy wrote:
> Currently we get the warning:
> 
> "GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
> overlapping address"
> 
> As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size
      commit: 398898f9cca1a19a83184430c675562680e57c7b

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


