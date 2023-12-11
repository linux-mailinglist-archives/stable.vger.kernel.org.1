Return-Path: <stable+bounces-5676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217E80D5EB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A307C1C214E5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09E5102F;
	Mon, 11 Dec 2023 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ExqXg2rH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25C5101A;
	Mon, 11 Dec 2023 18:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B76C433C8;
	Mon, 11 Dec 2023 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319367;
	bh=pnluyD9lIne6ws2KVrCC9xBSidLIUf9AwpZ+sSoMThQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExqXg2rHUapsqQoL8aTlcW1FK6W+j6VrsXqr61DKoSK6IIYDEqpwQpR2wUzpXw13g
	 A/F74cdkgQ8cz1W4Uz6APYbnHTP/IBLKlA0h6Rrxu8VNUQiev7W3CVeZu4GRhFDRVW
	 1qaDjzRdXE0kFHlzWo1maN/ur8AKo+d9+lQRvLRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/244] platform/mellanox: Check devm_hwmon_device_register_with_groups() return value
Date: Mon, 11 Dec 2023 19:18:52 +0100
Message-ID: <20231211182047.568736675@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 3494a594315b56516988afb6854d75dee5b501db ]

devm_hwmon_device_register_with_groups() returns an error pointer upon
failure. Check its return value for errors.

Compile-tested only.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Suggested-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/20231201055447.2356001-1-chentao@kylinos.cn
[ij: split the change into two]
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 925bfc4aef8ce..db7a1d360cd2c 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1454,6 +1454,8 @@ static int mlxbf_pmc_probe(struct platform_device *pdev)
 
 	pmc->hwmon_dev = devm_hwmon_device_register_with_groups(
 		dev, "bfperf", pmc, pmc->groups);
+	if (IS_ERR(pmc->hwmon_dev))
+		return PTR_ERR(pmc->hwmon_dev);
 	platform_set_drvdata(pdev, pmc);
 
 	return 0;
-- 
2.42.0




