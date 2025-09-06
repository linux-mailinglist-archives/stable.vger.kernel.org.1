Return-Path: <stable+bounces-177911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E2B4679C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38911BC7F61
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48942187346;
	Sat,  6 Sep 2025 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFODH011"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730817A310
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119115; cv=none; b=vD7/SYxp4w+QUxJ2r1j3UDay3Fd8uFVZiB/POwx64Hmc+RvcFOL8gwWp2UJ0ktYnRTnFkR2VNlBJyWiJBeQLqfsD0/BkuNaocR/i2bidHFbzb3vA2j0p3uGwk2IT0HjpYIJbbcKl0GHobeSuYYVnyEOTYsWDa4ROcTTufp18L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119115; c=relaxed/simple;
	bh=a442/H+RUwypbcQmBye9rwlmgWMlD8KVc2zaAYyRG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSDO41RQMkgyUIlgiW3MxgboO8mTUxAsrA2Z1pZTPnogANVIsTwqJMf5RYZJchk2MZ3+UWy9VTrXgw94YmY7QRlAOgmjGrrM6CjZxwxElMDtOEWXNOX4tukxcDuhRnXt736TervqMNTCRu+cvI/Cck4pZCA4/l1sixRmE7Cx+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFODH011; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E03C4CEF5;
	Sat,  6 Sep 2025 00:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757119114;
	bh=a442/H+RUwypbcQmBye9rwlmgWMlD8KVc2zaAYyRG18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFODH011A/M7PidN2/vh9lxOu1NzAZ5Ielu6qPLboq7C7zwX1xR2BjY+pn83MF1Mw
	 P/ASZbQnu5GnQgMUQMQXdLsUwVughVelAZA+Eyk8fR/42iAITJ5S0bfw6FojSnco2/
	 y0dhHoQXr4nDAs8T+gyAfPURpX1MJDiifX3xtbsj6eVqOshr2/RLjHkHVgizAmou0v
	 VrueiJg4A388X5mN5AfYgSeummQS516lWcoY3XlOZjaM/a6qEEyKzPMHx5Qnk+bSng
	 hR5Yg3NPL96nIQeqPccuqwaD+5UKLZmUoAPZ0awQc3R76N58Ez0m7M4SsiPvQSY7dI
	 3aYMTdA738qsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i2c: designware: Fix an error handling path in i2c_dw_pci_probe()
Date: Fri,  5 Sep 2025 20:38:31 -0400
Message-ID: <20250906003831.3605274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051957-mumps-vista-1dce@gregkh>
References: <2025051957-mumps-vista-1dce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1cfe51ef07ca3286581d612debfb0430eeccbb65 ]

If navi_amd_register_client() fails, the previous i2c_dw_probe() call
should be undone by a corresponding i2c_del_adapter() call, as already done
in the remove function.

Fixes: 17631e8ca2d3 ("i2c: designware: Add driver support for AMD NAVI GPU")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v5.13+
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/fcd9651835a32979df8802b2db9504c523a8ebbb.1747158983.git.christophe.jaillet@wanadoo.fr
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 61d7a27aa0701..55f7ab3eddf3e 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -337,9 +337,11 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
 		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
-		if (IS_ERR(dev->slave))
+		if (IS_ERR(dev->slave)) {
+			i2c_del_adapter(&dev->adapter);
 			return dev_err_probe(dev->dev, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
+		}
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-- 
2.50.1


