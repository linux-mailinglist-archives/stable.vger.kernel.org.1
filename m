Return-Path: <stable+bounces-118790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A10A41C5E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31003B159E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E56825B697;
	Mon, 24 Feb 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0AFVzZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB24BC05;
	Mon, 24 Feb 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395818; cv=none; b=TKecOnNDm0BOn73xUndHUkVwWonNzdlubhpnleiFD/vLTE12y5WTmqhIn5MvGj72aHAwFqkvycctjs0cM6dLBlRJrehJzYwi2w6jevYQkV9yUOHBKYNb4AHaJSabpEtO9FkstRwVwCB6a3lcGxpqS+MuWgH/YOgvYexISs4yaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395818; c=relaxed/simple;
	bh=Gq+haqX0nI567jwvu+ZRFBnlmRquVkLV4V6jXuQP6S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoM5C8c9YK7sOorK6QKGh7p8PUFbJ5//A6u+oQRN9IOwG4z5iKYaTIbYQ3GR6lbWxf0MHbDKt0kyAfhqpX0H9dpk3XjMmKh/iKUs7kqbguolgYAGp3451EwkhU0pR8ZsmuCd8KN68yLyarIpvYZtSNohXLVh+sJfGThFZnO3ZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0AFVzZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8EC4CED6;
	Mon, 24 Feb 2025 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395817;
	bh=Gq+haqX0nI567jwvu+ZRFBnlmRquVkLV4V6jXuQP6S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0AFVzZxtu/Wkw6pgJLXyIIepSJ8SPDrxPRR5k7YNEPKo/bKjFy+qBkHl2DcblIO8
	 3diVcCv7z35IM2BhV8E8Y9fvX3CZ62JnDwDZqyxLi1NSS7OgiwQuMZ7sNdJSJh/+yT
	 Z0gSiYJazPSvxLTA1oTcrbO3v4415pmvptsPeaLKjoFiSzHk8byXrT6qXzF/Bm0Sep
	 4Dnf5gnjFz+6RFiDcPoQvCSFf55FnHKR8zvnlOkV6wXeRVI0RajhSk7mzrr2DndTMA
	 cGLDebVtMgQtors//eJ7AbdwGX8T+qVKjqtOcd6cUbuZHNP0fWtQPtbDlohX5uHkvE
	 A3Vl0gwQixMIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday M Bhat <uday.m.bhat@intel.com>,
	Jairaj Arava <jairaj.arava@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 06/32] ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled in PTL platform
Date: Mon, 24 Feb 2025 06:16:12 -0500
Message-Id: <20250224111638.2212832-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Uday M Bhat <uday.m.bhat@intel.com>

[ Upstream commit d8989106287d3735c7e7fc6acb3811d62ebb666c ]

    This change adds an entry for fatcat boards in soundwire quirk table
    and also, enables BT offload for PTL RVP.

Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250204053943.93596-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 352c7a84cc2e8..e3e474fa4dae4 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -747,6 +747,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_PCH_DMIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Fatcat"),
+		},
+		.driver_data = (void *)(SOC_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
 	{}
 };
 
-- 
2.39.5


