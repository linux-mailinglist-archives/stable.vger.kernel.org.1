Return-Path: <stable+bounces-114964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFEA31816
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E021886BCE
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E048268FD3;
	Tue, 11 Feb 2025 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tkj48yUe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F2268C6A;
	Tue, 11 Feb 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310237; cv=none; b=IT/thKd6mDoT4Oe+Dz/m8uid+IRi81NSqPKv0lFJZHWm7FeFDd60n5tekWrWJvCNbHBbo8qhwjTg1CpaaZyqxrtjNKOTPSeyi7mnkvQrT8AR9s6DPYghp3TvcjddMT64x/TSwVt1q5UvDhjSANEzoG720KKzoLtr6/tU3kKOfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310237; c=relaxed/simple;
	bh=d9zeaMR664NzUXf6EBUiewejYWNnTZCHSt+tZuySPb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPCImUU8bBFDmKTTqhxsGsV2i+SnEp271ZZBVoxMhYmwSOdWx3y4N2fLOveYMhSB/sdx6U4CpddFZXCO4G9LtgmskxHYft0qTfAYz1U9/BIrXReOPYemfZJgjL02D3sNQcrS9EkUXSu16ONNi6TYIDZHnNGallisDmkLV9xISvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tkj48yUe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310235; x=1770846235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9zeaMR664NzUXf6EBUiewejYWNnTZCHSt+tZuySPb0=;
  b=Tkj48yUeubkhdpY/QrpFxtgJJlMMxuHHqBjVbFK+4BuZuXCl/nxFiI6v
   32HyhXvRCx7omVe04o3Sy5s/lBUfXxSXrRAbNQ+2Uxk6nda3XrbDl4WVL
   jA4qIrRRxfQniGd34gach93x0pxTZ0n42APUCd+/k+1FKy9zx2BNFssBl
   6iA3UPrMH5/TcN8JV0bCCMX2lyqI9bZgDOvvK1HWD9qrJGTK86Ep7OZrg
   kTASaNk8CLZykK3MCfhT9gW8wjJwy+eEmmJxPB1KllIDkWJU+UG9V1r8b
   s3u7xdfiH+GCCGJcVfjr8KgwhtyFQh//hGm7Vv9hV27G7qVBNSbqZB8Qz
   g==;
X-CSE-ConnectionGUID: qjvqGWWORVGtLhX4tSXP1A==
X-CSE-MsgGUID: S2EPNpZ+Scm+zkM6W5NhSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185260"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:49 -0800
X-CSE-ConnectionGUID: MApgYnpDTa+vfRVKFQ9z+A==
X-CSE-MsgGUID: 5ivteSjPTySvVIVu6FF92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478684"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Song Yoong Siang <yoong.siang.song@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	vinicius.gomes@intel.com,
	stable@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 6/6] igc: Set buffer type for empty frames in igc_init_empty_frame
Date: Tue, 11 Feb 2025 13:43:37 -0800
Message-ID: <20250211214343.4092496-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Yoong Siang <yoong.siang.song@intel.com>

Set the buffer type to IGC_TX_BUFFER_TYPE_SKB for empty frame in the
igc_init_empty_frame function. This ensures that the buffer type is
correctly identified and handled during Tx ring cleanup.

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 21f318f12a8d..84307bb7313e 100644
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
2.47.1


