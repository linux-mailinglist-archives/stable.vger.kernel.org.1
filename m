Return-Path: <stable+bounces-89222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F59B4E7D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B35B1C22304
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BA198A05;
	Tue, 29 Oct 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nSl9gSkq"
X-Original-To: stable@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CA195FE8;
	Tue, 29 Oct 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216932; cv=none; b=rLAsVbb5GWJlVQV6ujk52tRZD57grGesn1SfSPyCqmE5Vq4OagdrIp/WkgL7VHaLxTS4a04GWa4oP22NuwuqRalYSh3zoiZSp3KDqA1Tl1i6O1nxXna2MpczQLR3n89sHsl+kpuyNcj6FbBwEemN60SNd2adVzLevIbjn1UJdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216932; c=relaxed/simple;
	bh=kw2yodzahR4uHkOkyff2pWOUVqNC1JdECsR5WBbYPJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crCRIr2VQGi9Rogrqc+tXMQMqJKCcATk+FLBOZQOBcfa/3/hYM4sNYEl0CRHlFY7aIqcpC9mSyBUGRYOJTTrypYVuQ/MdbLUFOq8g4ZZsV6dGvZv1CqKRmJMe5Bg7az7x/C2x9beB4seSDWZeCDFvj3ySCqtnzYY2FvbP18PD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nSl9gSkq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFmdPF107514;
	Tue, 29 Oct 2024 10:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216919;
	bh=rK9KU0J4YBmBr2lXi0vOCehw2awpCqHpg0XfEgjmMBs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nSl9gSkqEODdPb8fmlrdbqEKb3w7zncAK33mCZ5x3mzyT9MS+NXXJF+CCtnyoBXQf
	 NfTas3Z2DQeSzVOUn25Ies0uOA6c1nVGlbluqAfUtYu4HFvBVa315rLVkmWotKsncE
	 Yjw6nsJHYSI0qwLPbIaTGD7/VkVeOuc/yWeRtfo0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFmdHR010720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:48:39 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:48:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:48:38 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFmYeL084360;
	Tue, 29 Oct 2024 10:48:35 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
Date: Tue, 29 Oct 2024 21:18:32 +0530
Message-ID: <173021674664.3859929.14957336677514636431.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024130628.49650-1-francesco@dolcini.it>
References: <20241024130628.49650-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco Dolcini,

On Thu, 24 Oct 2024 15:06:28 +0200, Francesco Dolcini wrote:
> The power switch used to power the SD card interface might have
> more than 2ms turn-on time, increase the startup delay to 20ms to
> prevent failures.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
      commit: 2213ca51998fef61d3df4ca156054cdcc37c42b8

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


