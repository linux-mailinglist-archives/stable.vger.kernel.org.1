Return-Path: <stable+bounces-75704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F869973FC4
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A43B288FB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A451BB684;
	Tue, 10 Sep 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/tl3XqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE421BE235;
	Tue, 10 Sep 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989017; cv=none; b=ovWLVoLyNtO50ncfeTqhEvQoHkKeVUbQ+scPTwKd/pCi3D4DPvpM1m8xDYLCNsnlbrNPjO2yiqeG/LNyy7+D19Ql3IEZdVJe1LgCHJ4FkYE97gRpvKy79YUyqPy7LvaKFnFoXM1ClXc4Z4ROMVIRYaM+gcqObhsHeBwziyT3T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989017; c=relaxed/simple;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGSfaZHozU0lQxA6WtFZj3oGgQRl5lysTVeKBwWTbyyUxBDIr/BpmjmxyRDe4hfbPmaQxs2iQcNXuuXRhBUx0peoWmAbgIWa5oWkgfDxNlW5LnPGOU24oYddSkuZWq2Cq8S3RaNB37Ud7b6WC2kgxMkOl1BgwzYc1/8lXzSw04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/tl3XqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC04C4CED0;
	Tue, 10 Sep 2024 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989017;
	bh=NeZBarf5sytU+4tlKJN+FOzynrWMMCnZ2J23Xvo9Q78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/tl3XqZI7zftomv4KfPGxny7gLOlT3h7mWbBcCIsuOAfA3/69dEYiJUF9rKjEKaQ
	 tm92gvt4bHK9ewOJEEUz7r0eb6okkJjO9mpf24O5D5Za3AS9not1XTbCAKe9kiNcPr
	 W7YFEP9T94D+bw0o0Nv6AcdE9BnZf4egigCF4t5x/ckgZZKx2d2MdsMJi8xQecAqIo
	 Cy1PzFo+gL296InPhcGSMcPTspyBrjQrZtFlb+zdxrk3oeyWMjIur9rXmCMmj3FqO+
	 5Q66sMLXrEKojCsWUpykQKJnx9QGoIubjNPxxrOcU7irmbXQgDgvqDzIuWX66nDCi+
	 QJxdyq6UjzWYQ==
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
Subject: [PATCH AUTOSEL 6.1 2/8] ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue, 10 Sep 2024 13:23:22 -0400
Message-ID: <20240910172332.2416254-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172332.2416254-1-sashal@kernel.org>
References: <20240910172332.2416254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
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


