Return-Path: <stable+bounces-158447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F841AE6ED3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1979F1BC4C1D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC2C238C3B;
	Tue, 24 Jun 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HH21uuRe"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D319DF4A;
	Tue, 24 Jun 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790749; cv=none; b=tPL/IjP+MXothwzWLRRF1fkiRmNcoJRJu1hAv2pkqdtHFjxqhGn/UFRg7T9zryqWUOWKaWioiIPRIH8NMxSjBNYMgAY0Mdh++9d4oqyBgliCwaSNSALrQxlwmO1NsO03HETpsRYdGfKBCxZYL6kdhlQvwiE7fJ8s47BX+E10PL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790749; c=relaxed/simple;
	bh=mpigxhq/5ZYuhiGJZPIBKkiwd+dsvZCPwQyOMPGbrh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5bZJmiShtc70GpKu809020fF0ZZL3vraXIR0BOxUEL/kKJf9e5om95I3LnSS0AI1P9/WRaWn5fhZeL5K6vT0wyZeiAZbX97WeKOwoSRxmrbkTuqOX/WqM3pBvo26VwVjjVcqawMSuCwV8Quf7nVtx3yjua0OKtpjhzuH6pVDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HH21uuRe; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55OIjadm1238609;
	Tue, 24 Jun 2025 13:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750790736;
	bh=jCehJ/03vgXo43v5fdkPlxCVgkwl4XEINgeHUUIjpIM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HH21uuRenlyBJrmpV8tV01ggfubYZdd8TpKLoLY4vv8nKQow7ioeLe/uR1A7OxrGW
	 BMwK7Vxb7qbdWjIW9/IOgMng+DZiWBd9y6KpFb73zyAg1uuKtCgImdTZ3sky1aaxHu
	 pCS33fARrH9UJeYIpbS+Dio8MKVy5f4JIc1HFnOI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55OIjatH264462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 24 Jun 2025 13:45:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 24
 Jun 2025 13:45:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 24 Jun 2025 13:45:35 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55OIjVbv1993190;
	Tue, 24 Jun 2025 13:45:32 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Emanuele Ghidoli <ghidoliemanuele@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses
Date: Wed, 25 Jun 2025 00:15:30 +0530
Message-ID: <175079060330.1874839.7299512877628097063.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528110741.262336-1-ghidoliemanuele@gmail.com>
References: <20250528110741.262336-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Emanuele Ghidoli,

On Wed, 28 May 2025 13:07:37 +0200, Emanuele Ghidoli wrote:
> Enable internal bias pull-ups on the SoC-side I2C buses that do not have
> external pull resistors populated on the SoM. This ensures proper
> default line levels.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses
      commit: bdf4252f736cc1d2a8e3e633c70fe6c728f0756e

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


