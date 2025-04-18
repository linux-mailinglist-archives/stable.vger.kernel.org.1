Return-Path: <stable+bounces-134648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50184A93E06
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760A8463644
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667E22CBD0;
	Fri, 18 Apr 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I3gauu/2"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CF45009;
	Fri, 18 Apr 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745002661; cv=none; b=FcVzRHvuUfxRwbYgVWo1W2u69QkGUME6j3ht0yz3SaJvbhNo+qmrVkt/oFobVaJMfpPcbpxfE8a+SxxYqULhBewpGV+Crr+uqi8dTy8qGbBJLbDH+/OhWUowmYVda/7U/NEAWyeFKOZTveQGW37Elr4caQK351OUdIv/t5My9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745002661; c=relaxed/simple;
	bh=5UwVwEq/xGg26R8B+TCG4GcCZiIXe3NZW+oFppPqgFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iby4BMXVAvR6Ik7dibwlnCUX/7gLC7BhKo7sPI0vs88H7A3anqaCvQDrwjsSicExrnWPS+uno909qercLs0WPxocM+TFqLu8GWScAJkVua0oSZoEK7ChQppr21JxRy2db0mL9Tml0rc4XTVt2WgbZrUFAd/K/NSLRBlAmiermU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I3gauu/2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IIvVX6353562
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 13:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745002651;
	bh=EY57HjKf2prRMxdJWIJuXK+RjDgqW+nncR0DJTXH0ME=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I3gauu/2lgX+RMNOrEdOHWm6jaCARPHMQ8mox2DBtpX4UN3amqJMhSn9plasuAztl
	 remyBmKuOkWl3uBGBWbaQF8ezzCSuyn//K9sRDd5rL/ueLR2sI2Z2SEahcRZvCSfbe
	 7K9g6PXUZGVmJb3WvmBm9uSRKDRdV/f3FWZTiq30=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IIvVQn108853
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Apr 2025 13:57:31 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 13:57:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 13:57:30 -0500
Received: from localhost ([10.249.36.23])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IIvV6N117424;
	Fri, 18 Apr 2025 13:57:31 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <u-kumar1@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <stable@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3 0/4] J722S: Disable WIZ0 and WIZ1 in SoC file
Date: Fri, 18 Apr 2025 13:57:29 -0500
Message-ID: <174500262306.95371.2904108787224104131.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250417123246.2733923-1-s-vadapalli@ti.com>
References: <20250417123246.2733923-1-s-vadapalli@ti.com>
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

On Thu, 17 Apr 2025 18:02:42 +0530, Siddharth Vadapalli wrote:
> This series disables the "serdes_wiz0" and "serdes_wiz1" device-tree
> nodes in the J722S SoC file and enables them in the board files where
> they are required along with "serdes0" and "serdes1". There are two
> reasons behind this change:
> 1. To follow the existing convention of disabling nodes in the SoC file
>    and enabling them in the board file as required.
> 2. To address situations where a board file hasn't explicitly disabled
>    "serdes_wiz0" and "serdes_wiz1" (example: am67a-beagley-ai.dts)
>    as a result of which booting the board displays the following errors:
>      wiz bus@f0000:phy@f000000: probe with driver wiz failed with error -12
>      ...
>      wiz bus@f0000:phy@f010000: probe with driver wiz failed with error -12
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0" and "serdes_wiz1"
      commit: 9d76be5828be44ed7a104cc21b4f875be4a63322
[2/4] arm64: dts: ti: k3-j722s-main: Disable "serdes_wiz0" and "serdes_wiz1"
      commit: 320d8a84f6f045dc876d4c2983f9024c7ac9d6df
[3/4] arm64: dts: ti: k3-j722s-main: don't disable serdes0 and serdes1
      commit: 3f7523bf8c35f96e0309d420d9f89e300c97fc20
[4/4] arm64: dts: ti: k3-j722s-evm: drop redundant status within serdes0/serdes1
      commit: 2a36e8656836f5897508e61d46d22fe344af6426

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


