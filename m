Return-Path: <stable+bounces-58823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362492C070
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948961C2244E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2451C9EB6;
	Tue,  9 Jul 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkM/hj0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D821C9EA7;
	Tue,  9 Jul 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542192; cv=none; b=DMolgmSLHO6xA1eRReV3nDkLtcBB1MU8v5X04lD8wLr8EQ4P+i29c6GobGtVx2JhQ3fLXX1CKkgPlKzBRcnuVeftj/8EELUp1L6I61IF75oVA1fWjQ/lTF17pHE9/8S6QY3X0EuKhqZgEWOFmXw5dpmg1NFdeZvQBUWgBvtzi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542192; c=relaxed/simple;
	bh=dOzyPdvPbxOst7gUQklgQkrXZpmlbbqCdWR1tTUqjY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1m02R7SJ3HtcGAesvLrVixUkc/eydPlnftdRSI2HD/+gj13al3lR3WZcjDSGL5UTdq9Gf9DzlCgHDXyx4OhOIwqBjRhU91GiBeX0Z3xHuwIFxMsdDwYfmdrdHrDIMG8FCLnIRbXp+V5CvMrbGGJgf+pbkDlR65DwodZmLAQ+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkM/hj0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5600C32786;
	Tue,  9 Jul 2024 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542192;
	bh=dOzyPdvPbxOst7gUQklgQkrXZpmlbbqCdWR1tTUqjY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkM/hj0EkFEAQ+Pnp0yMdbXdvayMsoTGLsKMvQGueh8hD/3pi0y5NaSLTPd9rT4IC
	 TK2UAAIanXRmf0tvy60Cj6DLwRSH2J/WvqE9xo63KGd5/EF7obDcHxFpiajDOHZncr
	 KuI6dwjItD9TVr6/njAhDbBt4B5VNm2CxwNdV12P2ftt87g54zdGPSyC4Uc3YVROWh
	 7Mis3ELPpC4KINRGGHw71omt/OjrKaxJ3L1BwZ30ufWEHW/IbqviRZNW/iDZicCc6C
	 Y07OS4FUFJwS8YRB1qh4h3S+TCLjIH3a0S/FZpCGyg59y+eT69/QNvPx8m6lseugbi
	 JEF+y7ouufZMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	vadimp@nvidia.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/33] platform/mellanox: nvsw-sn2201: Add check for platform_device_add_resources
Date: Tue,  9 Jul 2024 12:21:47 -0400
Message-ID: <20240709162224.31148-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit d56fbfbaf592a115b2e11c1044829afba34069d2 ]

Add check for the return value of platform_device_add_resources() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://lore.kernel.org/r/20240605032745.2916183-1-nichen@iscas.ac.cn
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 75b699676ca6d..1a7c45aa41bbf 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1198,6 +1198,7 @@ static int nvsw_sn2201_config_pre_init(struct nvsw_sn2201 *nvsw_sn2201)
 static int nvsw_sn2201_probe(struct platform_device *pdev)
 {
 	struct nvsw_sn2201 *nvsw_sn2201;
+	int ret;
 
 	nvsw_sn2201 = devm_kzalloc(&pdev->dev, sizeof(*nvsw_sn2201), GFP_KERNEL);
 	if (!nvsw_sn2201)
@@ -1205,8 +1206,10 @@ static int nvsw_sn2201_probe(struct platform_device *pdev)
 
 	nvsw_sn2201->dev = &pdev->dev;
 	platform_set_drvdata(pdev, nvsw_sn2201);
-	platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
+	ret = platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
 				      ARRAY_SIZE(nvsw_sn2201_lpc_io_resources));
+	if (ret)
+		return ret;
 
 	nvsw_sn2201->main_mux_deferred_nr = NVSW_SN2201_MAIN_MUX_DEFER_NR;
 	nvsw_sn2201->main_mux_devs = nvsw_sn2201_main_mux_brdinfo;
-- 
2.43.0


