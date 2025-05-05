Return-Path: <stable+bounces-140303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3449AAA74F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868AA18865D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D4336B6A;
	Mon,  5 May 2025 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIOlaCK4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7D336B74;
	Mon,  5 May 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484601; cv=none; b=oPys9KBGyFFpERXWK5v06vFO2QvJIDdsD+L8d/SLtVlAuMcXjm2K/XuI4JUFg19YAOmfncxVIz7MzEHxEgS8Z7NWuRyEhnLnDWHbJT/GeM9vgcEUEXGUwPMkNq5isSn+zn3voWZ0TDKu2236i64+839t6KzSIBn5urWMJ6u3HJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484601; c=relaxed/simple;
	bh=7ZwOUkW9ETmUFHyzF9HXliCgfHLsWwg6FVhZ87z5ZNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A3zN3Z+nlvXj1jGG95+SxqOYDvHF7EmOvrEO1ryBXNlV2zvAQxifTnL3LhsoUsbL5l4UsGl+CksRjIPaTcpvxvO+JIDzHaEVlplt9sbSBFOlkY3FGsnZnM2GvGrV/3yQpKlNF5dvOA2JrWZE+SppyhtHY9bc1ILeBEM100Gdl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIOlaCK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E60FC4CEEF;
	Mon,  5 May 2025 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484600;
	bh=7ZwOUkW9ETmUFHyzF9HXliCgfHLsWwg6FVhZ87z5ZNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIOlaCK4eGtY51M0G9X+hfvZj7/xKItOwuLImTgwqEMVdS7jq5bkcC5u4rziT426Y
	 0OyOnFcL9OL0vwMdJ7XYn44+QfeYMf/pKiBIqpL7gdk4xZRoLZCYrXffQqcHLjCWkK
	 ACVoqXIidBjBRpsrTpXO5uWZKCksbeXhLD65q6XW5lFu+WzwTdLn2aI5cK0fc2AgYW
	 NL+MLBtPyEmm1QlDIkvCBu9CyHs3Hbgh9W/g+WLPO/+iRmX7099Xlb8HV08D3rqaQM
	 ZjoVKFcReRvqAQLiTUjV/Jf4zlj8VM9NDnZQHWiYloLD7OItK1dg/xVvkk1pHNdZ2I
	 A8XkhE5y9K8IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 555/642] ice: init flow director before RDMA
Date: Mon,  5 May 2025 18:12:51 -0400
Message-Id: <20250505221419.2672473-555-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit d67627e7b53203ca150e54723abbed81a0716286 ]

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e13bd5a6cb6c4..d24d46b24e371 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5186,11 +5186,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5198,6 +5199,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5221,8 +5223,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.39.5


