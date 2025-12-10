Return-Path: <stable+bounces-200716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B2CB2D8F
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98635302AF3B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F666322B9D;
	Wed, 10 Dec 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeJ9UMDb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAE2D8375;
	Wed, 10 Dec 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367044; cv=none; b=GHFSOgkn3poAHrhWnYMbYjNxaUJqLORw0AGFpTsJvbVDClwUTiu0pU+u+dWVfbnwzj0bN8lwxVqeJuZ2zUvkhLDJuQLSavElK2sNPQsZnAG+wu6ndQqx/DwgorbI1dql8qIBGqGSqjfjttsuUvIqhcKkIMEP8Wj9n4PhdublQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367044; c=relaxed/simple;
	bh=IkfhRNzUnouX7a6mrrN/6q745/lh5kAROmWm94XLLFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4k+OFLGKRgFR9TJg07OVrXs6jF7uAjgvT1IC99qFJKs4526M5QuVqUOvo4LqBibKCzvChR+FQudHKbrww/IElUdAFAQ0ej+Ko3b4IYRn4cBTeiLXtdtgbQI3ujgg6k/hmingc0X0tRpv6o4eNbiOFM2rbhNO6uLKq11Ch7MQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeJ9UMDb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765367042; x=1796903042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IkfhRNzUnouX7a6mrrN/6q745/lh5kAROmWm94XLLFw=;
  b=aeJ9UMDbkv+cggAEtEXA0S1LZeLu4hf36tqrd20xmeIM8PinQ/vWro2S
   9Nyq0XWBp81RomnnGLdC9QgMYfIdnqkjmgIfJcEQUhC0zxvoo2exe69C3
   Mk4Muantd4zBhmiXne9zBWfq/H+ArHlWG9Tm8w4YN5LDDP8KTovy19e2B
   Rk57ROtgh+wDB2R4w3JhEO/DN6KztHki++0YWaz4ZkPPI2oAoPtSiqSiW
   ByNsVnCOBY4Ztzis9aXjrAQs1W5/MGteUqQLcQexueQJvBa5Y7m0vRGUD
   nRUB3B98/u9FGGVyim4uU3CtJn1YZxqSQleWqYhkq3ZtJcLvdIiMIl68j
   A==;
X-CSE-ConnectionGUID: jD9jPYIaT9Whxm64B2uo0Q==
X-CSE-MsgGUID: 7tcTNiEPQiGeQ51vwo7TKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67295044"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="67295044"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:44:01 -0800
X-CSE-ConnectionGUID: q04pivX1QJmDf+uZnJqq7A==
X-CSE-MsgGUID: /1HxCaSnRZm1ArVDnfMqTg==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa003.fm.intel.com with ESMTP; 10 Dec 2025 03:44:00 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-net v2] ixgbevf: fix link setup issue
Date: Wed, 10 Dec 2025 12:26:51 +0100
Message-Id: <20251210112651.5556-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It may happen that VF spawned for E610 adapter has problem with setting
link up. This happens when ixgbevf supporting mailbox API 1.6 cooperates
with PF driver which doesn't support this version of API, and hence
doesn't support new approach for getting PF link data.

In that case VF asks PF to provide link data but as PF doesn't support
it, returns -EOPNOTSUPP what leads to early bail from link configuration
sequence.

Avoid such situation by using legacy VFLINKS approach whenever negotiated
API version is less than 1.6.

To reproduce the issue just create VF and set its link up - adapter must
be any from the E610 family, ixgbevf must support API 1.6 or higher while
ixgbevf must not.

Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: extend the commit msg (Paul)
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 29c5ce967938..8af88f615776 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -846,7 +846,8 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	if (hw->mac.type == ixgbe_mac_e610_vf) {
+	if (hw->mac.type == ixgbe_mac_e610_vf &&
+	    hw->api_version >= ixgbe_mbox_api_16) {
 		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
 		if (ret_val)
 			goto out;
-- 
2.31.1


