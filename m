Return-Path: <stable+bounces-180690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F525B8AFAD
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5D11C87B0D
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EA27816E;
	Fri, 19 Sep 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqPDI1uA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9A2690F9;
	Fri, 19 Sep 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307808; cv=none; b=jeQjbsHGQ9q1y6mfpA9k6+2nB1wW60v89xWaYipzjE+v4F5mDPwy/Yb/WBWI8P2Obslxmmy4hF7NqHKwlECHOrAmiKORYC2fws7cteXLRs1H0lKlT5AoktcZ6le0T75zl1osVFDnuC9wLvt79g59hk5Du9JSqw4MagFzwRsnO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307808; c=relaxed/simple;
	bh=sSa9+vEqcuU4R1ZoK/EtFjHhG88i08/MRkfxv2zXZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Sx46jFInDEkwh0IA8ScgDQr19Gto3yOEOpDJq4IznB7FiidEHcEwROqsmS9tUvicxgfwJxZR6NX5QekClunJlCIJBcst02+0XwXKy9Ncac15PS3SjRLLCu+k4quDbKehEo4Gx3ZuT/Dq8Ex8dxsae9sr8q/bK0kDZYmWRa5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqPDI1uA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307807; x=1789843807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSa9+vEqcuU4R1ZoK/EtFjHhG88i08/MRkfxv2zXZ6Y=;
  b=AqPDI1uAIE43Cpe2i8THA2COTKvxWtqjTCXS0u+/fDklRIjJWWfZX6rM
   aif98duY5gHapj9B3IjhzVwuNmpeps1V523gaBSxtY1KiNcrzlY4hhtdp
   cEV2IL/CiOl6ZLAEx00LGxeDKXY3T0t/7oELqGJrSdQDEdwvMKa7qjmxv
   HSnN09nUG1DrweACmZnFLSM9Aak8gjfM5pQiZRi+L4dKNPg8/Lwuqk/iW
   nwyizOTdc1CRNCEtYK/K7D1U/Dcxg9TMgmlE5F4TLpvyqCuZ/JIlkDHO0
   XzmToCXBwPu5M5l30DsH6OtDME5r2QiIzdNuZJXCYYQKg1F+HZGI5gwDh
   g==;
X-CSE-ConnectionGUID: 9Mg8dcsORmaetrWrzyuO4w==
X-CSE-MsgGUID: DJlpoWMRTROjNh9TDDf/SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589738"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589738"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:05 -0700
X-CSE-ConnectionGUID: kHffiX91T9ifGCS+A5bCkw==
X-CSE-MsgGUID: kH6TlU3CSZyqCDUsrlkZPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458771"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 11:50:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	leszek.pepiak@intel.com,
	jeremiah.kyle@intel.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>
Subject: [PATCH net 3/8] i40e: fix idx validation in config queues msg
Date: Fri, 19 Sep 2025 11:49:53 -0700
Message-ID: <20250919184959.656681-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
References: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_vc_config_queues_msg().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Kamakshi Nellore <nellorex.kamakshi@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1c4f86221255..b6db4d78c02d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2395,7 +2395,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2416,7 +2416,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
-- 
2.47.1


