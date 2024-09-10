Return-Path: <stable+bounces-75692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243F0973F87
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59901F29F1E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56F1B9B4D;
	Tue, 10 Sep 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRkUVtxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783761B9B3C;
	Tue, 10 Sep 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988987; cv=none; b=nt306osVEUB2a7lbfQyyl5oXuwo2tAZiL9Ijx8FN7nOke+ehkhJIiQPrufjAKtZCvm2XPxclhgre2kvoZB+0Orx7OXe7T9jiuvXAwasIy6PfiE+1anU2Uy06cctjQHRt3837ZkPh1RdVtbh/fDWOfPCN8E6UEZnclLXKpzeU0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988987; c=relaxed/simple;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVPGFbmz3ueLheNXA5JWJ3xOAmzmPOMEQqGkZ59enO4JW9vCwtGBBEiL1AQbAYGYTtpcC0GWJMCEN4yGY+2Q8CqQx0gt1StIxxYF5V1vgSNebqf2iYTHW4Ec37BeW2DNPOPMAKPeMgDrKpXY1fgdcyyliN3Fyf9RjBSPDnLrneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRkUVtxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B68C4CED8;
	Tue, 10 Sep 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988987;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRkUVtxeRyALDpbPc2ifVh0Wi/8aLUyursPkWikvmLBc/pKlH2t8mPUqli8XoZB0C
	 vTZQ2N4Tc27TFYlD3/3X5lTYeBKzlNzwHZ+zvdaiU0dNcbtAEGPv5O/P1WzJ5ossC9
	 C8R3Mlh/6GAdSKD4Va4VYsov/Vw2ICjqpgZ5IK58KfDZFo8aDjF32ok+SnCw8+OsuA
	 b57Leda+TbXRlVbBiP1Yk0VF6WUVMGYhMJqswWXM241nxLFAmTfR9MnlXBsVSMYLwq
	 t99X1xgUCmAZX6wpV8hNphx64mGjMx88hB0H66y+500ml61YqqyY39OBrHbATLzUtf
	 FfdCwLIjsZayg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/12] ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue, 10 Sep 2024 13:22:44 -0400
Message-ID: <20240910172301.2415973-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 839a4ec06f75cec8fec2cc5fc14e921d0c3f7369 ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://patch.msgid.link/20240823074305.16873-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 5e2ec60e2954..e4c3492a0c28 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -84,7 +84,6 @@ static const struct dmi_system_id lenovo_yoga_tab3_x90[] = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90, codec missing from DSDT */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.43.0


