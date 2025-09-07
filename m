Return-Path: <stable+bounces-178658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C6B47F8D
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6184E12CC
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A68269CE6;
	Sun,  7 Sep 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxFB2jKR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652B4315A;
	Sun,  7 Sep 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277542; cv=none; b=mRBU+iaUaNCoRcUFD+my/vVS1ztpQg0DnOTLatcRwirCstrKx2oe42vrb3Cdzjw/pkRi6OzWHETpW8B9vYpL6ogLlCViIxU0VZM1BKxxKw+92IGdlcmBJONCINjR3qF2e7Hj1UT0wJVDyWm8BHbsFoAYfFPI7HDM8RM2vcfL/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277542; c=relaxed/simple;
	bh=5LKZV9QrdIpezDJDe7iIWhRiDVJgUmXyBSMiQlkvw3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VW67n2UJEBDkZ4uXdS3hJklLEsB/wnfc5gpLsyPGFhuscrPZ2WygnFzVtRWTiFUm7sF4TRqSO7X5eKy4fGXna4TH7UqmIfmn9nPCC30pNs5Sz+T48CLzt5z/znxAkBLuUBlS/OhLO9IUepN3z/wxVz1lGl8gU/ntCPiyHLf4jnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxFB2jKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA273C4CEF0;
	Sun,  7 Sep 2025 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277542;
	bh=5LKZV9QrdIpezDJDe7iIWhRiDVJgUmXyBSMiQlkvw3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxFB2jKRFw5qJSSHRY90nRsHa1GwyeTKYEz9RTDCxs26tqo+7FsOx8vn/FcAr/FC9
	 ItX5Gmk3YcHOO1b0MJ7giBxbc6i9418IxYH5fdveFopbAeAhTicm1VSMDJ21147Q0n
	 3SaF4AqzTb3cOCRNrc20VKZEz638Vv2iG49yX2Y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 047/183] wifi: iwlwifi: cfg: add back more lost PCI IDs
Date: Sun,  7 Sep 2025 21:57:54 +0200
Message-ID: <20250907195616.894030079@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 019f71a6760a6f89d388c3cd45622d1aae7d3641 ]

Add back a few more PCI IDs to the config match table that
evidently I lost during the cleanups.

Fixes: 1fb053d9876f ("wifi: iwlwifi: cfg: remove unnecessary configs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250828095500.46fee422651e.I8f6c3e9eea9523bb1658f5690b715eb443740e07@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b66a581c2e564..4e47ccb43bd86 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -670,6 +670,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
 		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xF000)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0085), SUBDEV_MASKED(0xC000, 0xF000)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
 		     DEVICE(0x0082), SUBDEV(0x4820)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
@@ -961,6 +963,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24F3), SUBDEV(0x0004)),
 	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
 		     DEVICE(0x24F3), SUBDEV(0x0044)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F5)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F6)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
 		     DEVICE(0x24FD)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
-- 
2.50.1




