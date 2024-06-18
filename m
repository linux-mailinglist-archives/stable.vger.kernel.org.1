Return-Path: <stable+bounces-52663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C790CA08
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAB1C23616
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA519D081;
	Tue, 18 Jun 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noGvblci"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA019CD14
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708986; cv=none; b=UE4ShvaRPdTddFSGW2hvY17qnRdntu132Tsi/ZYyy2VEjU7ft7C/GcDnOjU1cJ02NUS0pJ0OG1lRxC+HcgyT2k8/BpQQt85XijY6aKORZuhQEvkJj0K7KqZ7ts9do/Yk++ggebp8UpDY7X0K1+FV2FV6/25LJz7ayIr1Yt7K4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708986; c=relaxed/simple;
	bh=gYQyUg/Qp9lvizh/u7OWMq4EjZERZT55dn0OGTlHUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNSwpef//EYRsCqu3Ilu7Qfblr27nf0wLvpvCmaPYrIbT26y1+BBIDYOqPAGiP1LihCpc54t/WqArkZiPaUbML490iDsDt/dho0eLJl6GqQWx3bS3k15HJiKSKiEvV75YFyXYfOx2almFU1Q4eCzWgeBgjrSokGvimb1ILEnIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noGvblci; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718708985; x=1750244985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYQyUg/Qp9lvizh/u7OWMq4EjZERZT55dn0OGTlHUJg=;
  b=noGvblcik1koQL2bTZAFET3N4J0rRNbo1GyTO7MkCwpkjW/lCmlCgv1D
   UZ80zccl+SwR7Caqj5w4A5wil7/c6SVEWofHjg8MSp7k58yT0ttEP1z2K
   ygjJnhclKlUGc3QvxYZgGO/AgVVB9sY+pxp3E/THNA7939PG9s1AftrBU
   kNir0WK1/tiLpkjzCToLNonV4mTFU6O2ybvZaa2YEAhto1U7tg3wOmC+2
   a47bgAdT9jvMYaggTIBRdw1xfWO4hx2B+3trdhH1YBugtN7wb7MvBuTtA
   L6+LuFT8L+UrhM2OUVl1XnV4yuVt8mvgxrGYHXVDtBrwMTjkPrTx+katv
   A==;
X-CSE-ConnectionGUID: h0kgYGduRWe45wq+ESCSVw==
X-CSE-MsgGUID: t2XeuOneTIipvkHmMRTiqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26992552"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26992552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:09:41 -0700
X-CSE-ConnectionGUID: ssaOAw1URq2bJzPzM+9FuQ==
X-CSE-MsgGUID: 7u/3M+0pTh6Cu2TCX7FEYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72262549"
Received: from egrumbac-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.245.249.213])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:09:40 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6.9 2/2] wifi: iwlwifi: mvm: fix a crash on 7265
Date: Tue, 18 Jun 2024 14:09:24 +0300
Message-ID: <20240618110924.24509-2-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
References: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 788e4c75f831d06fcfbbec1d455fac429521e607 upstream.

Since IWL_FW_CMD_VER_UNKNOWN = 99, then my change to consider
cmd_ver >= 7 instead of cmd_ver = 7 included also firmwares that don't
advertise the command version at all. This made us send a command with a
bad size and because of that, the firmware hit a BAD_COMMAND immediately
after handling the REDUCE_TX_POWER_CMD command.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218963
Fixes: 8f892e225f41 ("wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240512072733.eb20ff5050d3.Ie4fc6f5496cd296fd6ff20d15e98676f28a3cccd@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index df3b29b998cf..f33e595dcc03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -894,8 +894,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	int ret;
 	u16 len = 0;
 	u32 n_subbands;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
+
 	if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
-- 
2.45.2


