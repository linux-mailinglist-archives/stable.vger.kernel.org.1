Return-Path: <stable+bounces-160587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210F6AFD0D0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E3A485E7C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD929B797;
	Tue,  8 Jul 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvGHBX3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120D2A1BA;
	Tue,  8 Jul 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992088; cv=none; b=l2UZhkgP9/F+LdiRfWnBxcWqwFpwlLcYGeBoHHbP1iTaI6Ol9ms9pynPtmioIhYSNaT3UUSUtbq6ZMoO4h72IFy/nqk/ss+PXmg5425S7L+YUulB+41ZZ2C22PPIpe383GKjyFLbd5IfkRsaSlImFgE9RyjP8YwneD0OxucQQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992088; c=relaxed/simple;
	bh=/Dx5D6pyh0Zctr5FGBOkAsQapWew4cbbPQ2LhIoBjP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKrCJjs5nMK1C3nnYN2PUZiTR7tOlPOauFgh+tUE/s2PExhnuOaTLkb1+NY12z0ldWGKlocVKdxHC3UClDgNhlKny11xztYlQi+V3J0Dr3qEzgK9BhQkWh0MHThvcQBedyfxilJSnVYnNdXHaH3z9KQHGq/redPTMBXuTKnNhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvGHBX3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B3C4CEED;
	Tue,  8 Jul 2025 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992088;
	bh=/Dx5D6pyh0Zctr5FGBOkAsQapWew4cbbPQ2LhIoBjP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvGHBX3AJZEEcAu22hVGbtQ5uZzjHY+SVLqn2zlXvzXxfkQU6ril8UpaD1Uddsm6l
	 LG1x+zmhWG0DkTG1WoiirPrd5KXliaLO/f44wD5IvGqsVnF+pLfSmVJvmzuR3GoFlF
	 khsGoKyv2G7ZNAUqR6qX8nJuXhtFrBFv3IoSIMC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 24/81] platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
Date: Tue,  8 Jul 2025 18:23:16 +0200
Message-ID: <20250708162225.701284342@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit d07143b507c51c04c091081627c5a130e9d3c517 ]

change error log to use correct bus number from main_mux_devs
instead of cpld_devs.

Fixes: 662f24826f95 ("platform/mellanox: Add support for new SN2201 system")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/20250622072921.4111552-2-alok.a.tiwari@oracle.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index f53baf7e78e74..03fbbbe1c8756 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1084,7 +1084,7 @@ static int nvsw_sn2201_i2c_completion_notify(void *handle, int id)
 	if (!nvsw_sn2201->main_mux_devs->adapter) {
 		err = -ENODEV;
 		dev_err(nvsw_sn2201->dev, "Failed to get adapter for bus %d\n",
-			nvsw_sn2201->cpld_devs->nr);
+			nvsw_sn2201->main_mux_devs->nr);
 		goto i2c_get_adapter_main_fail;
 	}
 
-- 
2.39.5




