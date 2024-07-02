Return-Path: <stable+bounces-56309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46991EDB2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591F61F20FAA
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94112BF02;
	Tue,  2 Jul 2024 04:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivEu/ESE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F98839F4;
	Tue,  2 Jul 2024 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893518; cv=none; b=OF+8SV+/bJWl7lMJRUcCAkbCAyoZcKAj84TVfQ0T/7b0vghveqZ29+9jM9GEdqBFm0zl5gOpynGvGTOwDbgbLqMls2vcpiSm7ZjNLOLdy2+kDrjQRRkqGeQDAGCRykQ15Gw9qSwoR4fFy7VLerDaDzUIy3prsds1DNatG/AedEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893518; c=relaxed/simple;
	bh=U63gD7ZbW2JihHJgZe5fO8a8nHLclY5LSPu+PTCwR+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kz6HlYfhil7KnZHMqKDZ3djiWdX9xqm/89owis5lhNXIzohDOl2lYodcLL4ZctZwVzDDGM1SxmrvN9T+WQo6MRedtl6K5+radOMNJ637ewBVK9/i24kGQsygQ+IVsIOyPvv/y8I5rZPZh6pgt4f2lGyCYc5+7i9nbFQysUtswug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivEu/ESE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893516; x=1751429516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U63gD7ZbW2JihHJgZe5fO8a8nHLclY5LSPu+PTCwR+s=;
  b=ivEu/ESEWQGtwFOUPilAzDN67FxfeYXKwF6QIqItRREbrSLwVJSZhqPd
   cvkry3nYCAfR0E0Yz9GaqQrKVtxW+po3tQUkFOxz690MTXMjxSZuLj3LT
   NxrtGEVIUfa1ovCbrapPNp7Vrzmyo/gOSzWaik932e94sX9JRyswin/nS
   Q0me1ysNOYURhf98hsj6tbQ6j9bPLR/ON00QFHU7A1d79QIqofBDoOyz1
   UrjkGkFHdq4P/XwN+QkD83W3od2++0beMFoMJN0d2dNCVSnhEIwN0hmea
   C4jXz+ptVVJlPSg/4RLD+z2wXcOm9LceXi9miJvUttroB5oujGm2nIpx2
   g==;
X-CSE-ConnectionGUID: J0sGtZ03TEW4LSvxBj17yg==
X-CSE-MsgGUID: zn1cPLHxRLCogw7ygasvsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20916506"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20916506"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:56 -0700
X-CSE-ConnectionGUID: 0+0d3rO8R+uzETMJEHOLBA==
X-CSE-MsgGUID: s2nPRl6GQJq0fPnKLzu8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50959311"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:56 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 66345201A797;
	Mon,  1 Jul 2024 21:11:53 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1 3/4] igc: Remove unused qbv_count
Date: Tue,  2 Jul 2024 00:09:25 -0400
Message-Id: <20240702040926.3327530-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing qbv_count which is now obsolete after these 2 patches:
"igc: Fix reset adapter logics when tx mode change"
"igc: Fix qbv_config_change_errors logics"

The variable qbv_count serves to indicate whether Taprio is active or if
the tx mode is in TSN (IGC_TQAVCTRL_TRANSMIT_MODE_TSN). This is due to its
unconditional increment within igc_tsn_enable_offload(), which both runs
Taprio and sets the tx mode to TSN.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8b14c029eda1..5fd0d85f83ac 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -254,7 +254,6 @@ struct igc_adapter {
 	bool taprio_offload_enable;
 	u32 qbv_config_change_errors;
 	bool qbv_transition;
-	unsigned int qbv_count;
 	/* Access to oper_gate_closed, admin_gate_closed and qbv_transition
 	 * are protected by the qbv_tx_lock.
 	 */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0f8a5ad940ec..e7664bd81505 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6246,7 +6246,6 @@ static int igc_qbv_clear_schedule(struct igc_adapter *adapter)
 	adapter->cycle_time = NSEC_PER_SEC;
 	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
-	adapter->qbv_count = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 61f047ebf34d..26dbe3442ad1 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -267,8 +267,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 
-	adapter->qbv_count++;
-
 	cycle = adapter->cycle_time;
 	base_time = adapter->base_time;
 
-- 
2.25.1


