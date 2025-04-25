Return-Path: <stable+bounces-136734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900AEA9D3F1
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C974E1934
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A9224AFE;
	Fri, 25 Apr 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DUtOiIFy"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF12248AC;
	Fri, 25 Apr 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615405; cv=none; b=gwpjdVyNj/M/v+u3OfavQvlZL1D736XNvBFN9EheYUAMGoxExhZEy/H3sfrtU35kxCgNvpk9yjjJWDatFUGBxfS3PYbvdXZoh151ixMZW16St4hNOym44Nl3YWZuBGdHyATvs5L46drT/D6I8E59fhY31AoNR9yBock1eCFSIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615405; c=relaxed/simple;
	bh=MOO/CzWZ0YIgmolaHheEdxVd28uNvBFXtKwYoeaf2Ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH34K1TRRsItY3vPc/eYp16RsXpWTOH1hfv/tgvmgswo6RgLqhKtMJQerw16aw5SJkv700BHlqhsXofmjdxBgB55eRxl9/qwqCOnqaUtA29y/KCafH+rE+1Z+pUWB1WzCNKdtvCLNhG6+VFBjLpAJsIlOA4pCdtE97ng0WVWKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DUtOiIFy; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PL9wjg3026995
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745615398;
	bh=MGjIDaoDelEvuWIMDJx6V82b37fg2WOb7gjvoptL2H8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DUtOiIFyvXc6ibkd4jJuM34QBlefujhLmFU7NW0JoehrfrBFdnG2Dzyw7gZ2yMUuK
	 DfLhgnTX4L8l0Gz97ctURjQO0kwEudFZanfburcc3n7rxMRdzC/5nixiW4kZffcdAy
	 WodjIyxfS6eaL8J7LjRhURVDgCY+7E3H/WA5ainw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PL9wUe078487
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 16:09:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 16:09:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 16:09:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PL9vdF093546;
	Fri, 25 Apr 2025 16:09:57 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <stable@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: fix length of serdes_ln_ctrl
Date: Fri, 25 Apr 2025 16:09:56 -0500
Message-ID: <174561535469.210207.12728695761860472816.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250423151612.48848-1-s-vadapalli@ti.com>
References: <20250423151612.48848-1-s-vadapalli@ti.com>
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

On Wed, 23 Apr 2025 20:46:12 +0530, Siddharth Vadapalli wrote:
> Commit under Fixes corrected the "mux-reg-masks" property but did not
> update the "length" field of the "reg" property to account for the newly
> added register offsets which extend the region. Fix this.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-j742s2-main-common: fix length of serdes_ln_ctrl
      commit: 3b62bd1fde50d54cc59015e14869e6cc3d6899e0

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


