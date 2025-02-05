Return-Path: <stable+bounces-112268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640CA281DC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9449E16571D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088020FA98;
	Wed,  5 Feb 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YK7U9Y3U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945CEAD0;
	Wed,  5 Feb 2025 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722972; cv=none; b=kXOGWH7UFHmQIYcdRx9C2pVTq5HHStEH+AIqKRucIkwpT0yA93MzY6y1jOgrJggQdyEcT42gh1m2Jd+TgLjIJwupQOpZnRBU+sgCMNBZCtfpT/7VqeouxjbljjcnKGAZfrTM0RSyRp3mYbL64nbVUyVF0AbgtLqhTc1GXRtM9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722972; c=relaxed/simple;
	bh=HhCIS7TjDEYPBJlyHuTw26lt0WykU+1bGAGU6W+Mqco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrxMNF6KN+X3rSL0zy+RA3RsLlcrdVrQN9vuwZBvwmX42b9TeRtDpK8FX0tIWMUFIxJArO/YoHzuo59CPmEqFDpslQ2NUTdFj4G5ObDZt+Ro2nsleFz0hc+FRyIrKG39xXSYC8WPQT5T3n31dubO1DkSzLKEw+c5SPHtDPKP8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YK7U9Y3U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738722971; x=1770258971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HhCIS7TjDEYPBJlyHuTw26lt0WykU+1bGAGU6W+Mqco=;
  b=YK7U9Y3UdUX3A8t77/ndcTkujrZq4Fti+GlcPTDoXQHphD7N6Yz9F60Y
   d3dJTENcx6wmtcklTuLMBVzqVHYPZ3DVMRD5jB/NAtfiX3s07//cuWfdX
   r4EH4cPjGeF/MvHyXwxXzQiuyrfTG1GGMSMRcUho+RarwIm2Rt2pChDCU
   2SB1UZKZsfczc9XaRyLrpMpCInRQ+YGB7corHjBgmD9/8NJmpTRArx86o
   bI7cL+qk4eRSdl0oOBzzddh2pSz3qmYU9d2zbOFtjuZpFqKiyNmo3fCb/
   Xatd3EYprva0zayL88ON+pVOaRtmyhoOW9nKgatlrCpI+4h4Szy+te0O5
   Q==;
X-CSE-ConnectionGUID: kuDXCEVpTcOfrEYp4a2e9Q==
X-CSE-MsgGUID: 0I0SZ9Z/TZCR3IGJMVHA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50265591"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="50265591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:36:10 -0800
X-CSE-ConnectionGUID: Y4AIYHQJRZeWzE+Xt9rY5Q==
X-CSE-MsgGUID: 5p4O0Ya+S1ibxn2bhXFbGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="111351076"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa009.fm.intel.com with ESMTP; 04 Feb 2025 18:36:06 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Malli C <mallikarjuna.chilakala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1 1/1] igc: Set buffer type for empty frames in igc_init_empty_frame
Date: Wed,  5 Feb 2025 10:36:03 +0800
Message-Id: <20250205023603.798819-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the buffer type to IGC_TX_BUFFER_TYPE_SKB for empty frame in the
igc_init_empty_frame function. This ensures that the buffer type is
correctly identified and handled during Tx ring cleanup.

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 56a35d58e7a6..7daa7f8f81ca 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1096,6 +1096,7 @@ static int igc_init_empty_frame(struct igc_ring *ring,
 		return -ENOMEM;
 	}
 
+	buffer->type = IGC_TX_BUFFER_TYPE_SKB;
 	buffer->skb = skb;
 	buffer->protocol = 0;
 	buffer->bytecount = skb->len;
-- 
2.34.1


