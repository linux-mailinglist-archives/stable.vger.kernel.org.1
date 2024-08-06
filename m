Return-Path: <stable+bounces-65485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2543948EE1
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF5728C59D
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485281C4617;
	Tue,  6 Aug 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R2XSasi1"
X-Original-To: stable@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E511C0DE7;
	Tue,  6 Aug 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946357; cv=none; b=cGapSfcmXZg26pp+62MkUc8BYFhzXIhqrvama7wwVRTT9NcGYGbLstKR+sHgG9DJuoMhxU0iOLifl4IYLtHP4zntzcckWCIMJoWTvRdKwaaiivw9VaguE1F6rfk6NTePEK4KFxCVDGqIfznzcOQJAIdaUjuCglJcQUOdm2j1iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946357; c=relaxed/simple;
	bh=4Jlvs3s8D6Puqz4utkMELxCxHzvLhaMPn3o/pdA9IeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS0Jm0T2Z6AxLurFEy5wmBXGVZwXFVKx/bxnsM5b6dnf3YHiega4AZAklIxI8Qckyakn86VDJLYE4MiG0hEjimX/HCpoFNVP9sD+HqMo/eeAMnvjR7Z1TiA0DpcimOBqNr7lEPQG+p3rtNiPJSLA5eSwgVy3kr7f4BKrXOurglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R2XSasi1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476CCCaf024746;
	Tue, 6 Aug 2024 07:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722946332;
	bh=g5gDMigbTHL+jxXCwUmh5fa9wrLaoK43+KxVX/dTfvM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R2XSasi1RETGNZJLKD+HlKf2YrLQ9lVUdZw30x0ETjPuLH8ZB+8tQsaQuzUGXXeVd
	 UIX5DyA9XMLSx7eRRj7tWI/+bq1ggXBJaFha7q2wHMf4nrZia9RabqUen0Y/15Af4C
	 X4P9gV6Rjjag9ZBvf17l5ykFhTBRv8R7MGG72F/E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476CCCL7055008
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 07:12:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 07:12:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 07:12:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476CCCbA081755;
	Tue, 6 Aug 2024 07:12:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regulator on
Date: Tue, 6 Aug 2024 07:12:10 -0500
Message-ID: <172294632012.366302.5768922280079626594.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731054804.6061-1-francesco@dolcini.it>
References: <20240731054804.6061-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco Dolcini,

On Wed, 31 Jul 2024 07:48:04 +0200, Francesco Dolcini wrote:
> This reverts commit 3935fbc87ddebea5439f3ab6a78b1e83e976bf88.
> 
> CTRL_SLEEP_MOCI# is a signal that is defined for all the SoM
> implementing the Verdin family specification, this signal is supposed to
> control the power enable in the carrier board when the system is in deep
> sleep mode. However this is not possible with Texas Instruments AM62
> SoC, IOs output buffer is disabled in deep sleep and IOs are in
> tri-state mode.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regulator on
      commit: 9438f970296f9c3a6dd340ae0ad01d2f056c88e6

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


