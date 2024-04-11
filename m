Return-Path: <stable+bounces-38620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480088A0F91
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A67F1C21C5E
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF51465BF;
	Thu, 11 Apr 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MaaUtbY0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4613FD94;
	Thu, 11 Apr 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831105; cv=none; b=Oa8haoP0ZBqkRQKG3kJaTyj6w9sVSETNAGqt4D+g6k53EZokFlct6LkuYmc0mtbWYEzLXDP1dPVKhIMnb2T8A9QLluR8GPaBggSNqmqc+Y5Hv3+F3X26Mhoe24/mVyPnjYAK2NnJay7gd1ozkhokDioDYjcEwyBt3JwPkkL2T+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831105; c=relaxed/simple;
	bh=F0fQnfoFIQscobq5j8sxYgab5MIYibLgF3/82tsAztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/U96aeKEgU+XoSTT7LRHjMlDfthLqEOU48o4Wjk8n0CpH81h22Pxyh8Oak5N6F1I3dnKpc8bQ1wjeeYnZ2rejfXFtY0suVi3D6O+OqSKyGS5M19MY3/LdEU9deRbdLFPwt6IEyy7dLwwHcpm9UBOL7BkGiZCpnzQZ/INDtRR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MaaUtbY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1338C433C7;
	Thu, 11 Apr 2024 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831105;
	bh=F0fQnfoFIQscobq5j8sxYgab5MIYibLgF3/82tsAztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaaUtbY0YoI97PWyK99c9ZjDj4Z9p+6cfTrhcPUOMBY3NAL4vMmY8kEqqpdHrVXrl
	 hhJZmHRlqg/gYIgEbhEtdfGx2O0xZqcvWnAqQhlPLoouKHEYbO+bCzlOyD9SfBkE4y
	 TrJx5FUctjmlgesXO5/aTJTiccw0vSY7JtDyR3sE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/114] wifi: iwlwifi: pcie: Add the PCI device id for new hardware
Date: Thu, 11 Apr 2024 11:55:37 +0200
Message-ID: <20240411095417.176315818@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit 6770eee75148ba10c0c051885379714773e00b48 ]

Add the support for a new PCI device id.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.fde32107e0a3.I597cff4f340e4bed12b7568a0ad504bd4b2c1cf8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bc83d2ba55c67..dea4d6478b4f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -502,6 +502,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
-- 
2.43.0




