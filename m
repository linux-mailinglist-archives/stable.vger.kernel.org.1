Return-Path: <stable+bounces-161633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F7B01279
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 07:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE34E7A6B3E
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 05:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32231ADFFE;
	Fri, 11 Jul 2025 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rU+dHQTL"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB32A59;
	Fri, 11 Jul 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210218; cv=none; b=n798i9klO8Mz9GLPEs6XhKMgaSBLIZyab6TBdsTTbww4jqLordcTpNgw/f0CC+maPp1HNcdoDFOBJX2Ej729+fkMjSkRey8Xe0mypMnsZKh5mnZbIfMWL7WJoJzPBrRzPkKfMeLs0USgSMIEjdvGeNdoSZZ6nqZ9glyBDLag0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210218; c=relaxed/simple;
	bh=hMviNszBFzONEB+pdZ2P/mSfVb/44rNj78t76l8agUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfSWVCUIFwtwEt21My8Ts9bWhGMtO0Zptgcdpz4ToqYJjji8LO9L7NRMYjkpEo11mf5YPDCuV1VXVJBMeihnDmZHxlpwAxOGWm7Hy5QaLpFFXhwdqz/3+j1pV6W9qXT1ptz83oKBCDGGLZcE+W/o2TLmXi6BUg+oafJQ0JE1IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rU+dHQTL; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B53UUW1963572;
	Fri, 11 Jul 2025 00:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752210210;
	bh=afDXnXc6wPd7UCJYFn9Xue4JEjVIxkwuEGrES44MIP0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rU+dHQTLkKY7DDdxF5lzfAxravsh7JtOGT0DJgAZHAWzx3p6e6cmmgzjohm7Gq/5n
	 gclBgheBo6xH+3E+tTVni7WfYtpxPCBpOcxMQWEVQUpXfyhS2fwdwZ5hYWlZ0FfsK3
	 hYbe6CbqyDsUMhxl3YHwKZtfxmfMvHxQRZJxk2ow=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B53Ulu822551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 00:03:30 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:03:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:03:29 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B53PxW2576359;
	Fri, 11 Jul 2025 00:03:26 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hong Guan <hguan@ti.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1
Date: Fri, 11 Jul 2025 10:33:11 +0530
Message-ID: <175205725857.918402.13683830653184738148.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707-uart-fixes-v1-1-8164147218b0@ti.com>
References: <20250707-uart-fixes-v1-1-8164147218b0@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Bryan Brattlof,

On Mon, 07 Jul 2025 11:55:13 -0500, Bryan Brattlof wrote:
> The &main_uart1, which is reserved for TIFS firmware traces, is routed
> to the onboard FT4232 via a FET swich which is connected to pin A21 and

Reword this bit locally along with s/swich/switch.

>
> B21 of the SoC and not E17 and C17. Fix it.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1
      commit: 8e44ac61abaae56fc6eb537a04ed78b458c5b984

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


