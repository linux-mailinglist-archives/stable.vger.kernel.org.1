Return-Path: <stable+bounces-25088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A528697BA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42131B2D37F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B413B7AB;
	Tue, 27 Feb 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OotpYqS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE013B2B4;
	Tue, 27 Feb 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043827; cv=none; b=nMUmj/6lv9btuIVxn0IExiM4g+u9xQ2Jqbq4WU8/so/asmIL512GtdyvVm9IMFb4tal7AJbYPeC+Fj/pqpH8vd3s25GeGtceG1L+xgIP+YpyF+ZUvx5YttnBZP77AHAnjd/9c85xS6ytJXYzDgoPYFkMZXMCklpGuiMUdQcBW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043827; c=relaxed/simple;
	bh=jbm+2lDwEPz7nFB+gR0DRhXJtBjs6UiypVelHpwKYEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXLyhay/oKuVvoPVpF0WSG0ppM6uX/Tl6nDepOgRp/ZbRlfAQmrGfdFp3WmemsETnulaiPowAkxY0PnuhAFzULc5/cvoYDDM01cIwMelJtUftpHKW+DDZDuPbYwHzCHKdkefL62f9H0N6FJWouSjgtIvBLvG+crQOCPSPihnWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OotpYqS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDFDC433F1;
	Tue, 27 Feb 2024 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043826;
	bh=jbm+2lDwEPz7nFB+gR0DRhXJtBjs6UiypVelHpwKYEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OotpYqS9TZCOdUKkY8I/5r9ANFKP5asYGF/AWlObmnv+UsvcpoadRkRBpQMLFhpul
	 qgzNJfqsk1Pk2gwYhWkHM3ZWdNmhxw3i/hcCBJMsdv4S5IuflqqUBNOkHcziTzLpoU
	 aWyoSoEMSsq5swxaXmnkoiQp2tvhokB0mSzop+Us=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 51/84] PCI: tegra: Fix reporting GPIO error value
Date: Tue, 27 Feb 2024 14:27:18 +0100
Message-ID: <20240227131554.531403938@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 63605f1cfcc56bcb25c48bbee75a679d85ba7675 ]

Error code is stored in rp->reset_gpio and not in err variable.

Link: https://lore.kernel.org/r/20200414102512.27506-1-pali@kernel.org
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Stable-dep-of: eff21f5da308 ("PCI: tegra: Fix OF node reference leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 99d505a85067b..64921c63874fa 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2289,8 +2289,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
 				rp->reset_gpio = NULL;
 			} else {
-				dev_err(dev, "failed to get reset GPIO: %d\n",
-					err);
+				dev_err(dev, "failed to get reset GPIO: %ld\n",
+					PTR_ERR(rp->reset_gpio));
 				return PTR_ERR(rp->reset_gpio);
 			}
 		}
-- 
2.43.0




