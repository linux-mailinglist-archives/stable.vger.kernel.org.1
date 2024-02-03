Return-Path: <stable+bounces-18171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC48481A9
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DFF282726
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8E28F3;
	Sat,  3 Feb 2024 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgUkBA23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C9125C2;
	Sat,  3 Feb 2024 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933599; cv=none; b=KgbLNvZ/Iqi8oQwoCHRgWkXPk8THeb/atFAF5Z2g5PZiycwOAJqqWw4DdqX744oIY8VY4GMTfGvw666pYctqzIjnsu2yfw4VH+RqJ1jRk4vsFO7SIfGtel1F3BQkQPZzj+aW6z7RFCaN5C4R6dtKs6FSmVD0BTmzm62XGILqyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933599; c=relaxed/simple;
	bh=zbDtbJTGbUp0Bohs8MNvl3gukb8F7m6gn0vzSuPfJXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOgy2FF39UDs26RchEXNWzOmVx92ZKJgB37q3y2U6clIRCmO4spWZWosKCuSwFwehgWWV/76QSJuWgopL7zKR+KznltW1LU1DDReBo0sfpHc/dRJsDTY9A0+lmtuxIiyUgG3HiebmKr6VjPtPP3q/KkgF5LUvnkHS/MYVXzXQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgUkBA23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F92CC433C7;
	Sat,  3 Feb 2024 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933599;
	bh=zbDtbJTGbUp0Bohs8MNvl3gukb8F7m6gn0vzSuPfJXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgUkBA23xsaWtCuoBuBL7xKQGbk3Uc/QRhmVegkVFMx3l8BQR3AiaDImZ3MbLADwx
	 H6YAYfn9w2ZWi3RDcPKbP+37vBy0hsBntSAMM/52851k7T6T1MY2m8dE45TMhOKYrD
	 DEWdk8RePanwz3eN7HwI5k9s2xpEsKdywlO4gLOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 167/322] ASoC: amd: Add new dmi entries for acp5x platform
Date: Fri,  2 Feb 2024 20:04:24 -0800
Message-ID: <20240203035404.629028887@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit c3ab23a10771bbe06300e5374efa809789c65455 ]

Add sys_vendor and product_name dmi entries for acp5x platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20231206110620.1695591-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index f27c27580009..955145448c23 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021 Advanced Micro Devices, Inc.
+// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc.
 //
 // Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
 //
@@ -47,6 +47,19 @@ static const struct config_entry config_table[] = {
 			{}
 		},
 	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+					DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+				},
+			},
+			{}
+		},
+	},
 	{
 		.flags = FLAG_AMD_SOF,
 		.device = ACP_PCI_DEV_ID,
-- 
2.43.0




