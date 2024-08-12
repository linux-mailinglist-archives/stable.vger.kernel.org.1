Return-Path: <stable+bounces-66533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FE94EE9D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939262829B3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D317C7C1;
	Mon, 12 Aug 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ly77zGC+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F417A92F;
	Mon, 12 Aug 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470384; cv=none; b=rB7algCKk/3ul4B7LBIGzOpLcusq3SzmkR6tE3WczgGIvi74GU4Gy/+YKS5OrJC6CoeB44ZgvJoZVCVUhPLzOlGJOuuSqhBONHmSOiwtc7HryhgyEBM7TYG7uVmBQbZzH/SH1S7HZNxbVPsAngIiErxnGtYb5BDJmpg0ntDmhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470384; c=relaxed/simple;
	bh=RZbrLVmBjMhLipuy8GpOq0fJf7VHPNsfLcYAn3sksuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKmiQBKCbmEhl2m838ZFGz60E/ePxSJFVGHsRHG2qeb4UAe5OjPY6uzNfPcswcAXiWT2d3E24sNkymFJnbE1+2SJx4E4jdYrF9+Eqk6hlReKOlgqq0PjYXZyqYX6W4MeQZEsHOvkaxLfO+1Froa3t+BPsJSPf5DB/rujVkSPgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ly77zGC+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723470383; x=1755006383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZbrLVmBjMhLipuy8GpOq0fJf7VHPNsfLcYAn3sksuw=;
  b=ly77zGC+PpB1BDZk5pA8dPu1QuOL+0D/007ajuIPfs881kWYH8uECe3l
   g322wj6OjvhNQvEc4a+DWu3enhrvNtDm7qXbsNcjNjQcWMcLnaHx4TY5Y
   9jUJswIbMUBL/HS4cJ7b3xnshAHhHQBhTCQuhOcniAGBsvmUdyFeLFCbV
   6RxFCnCk4YwtnTIxzZh/h+7m9sv673UT9kQjeA/rNi9oJjrLu+n7jcT3b
   5828vku3hDlVtqUUjmJTonEZ7lFrI2iuwwzx/90YMQt1N2S3gp/7/USGL
   d+Nm5D4xvWCDTZm/064pSkTm9Vcz3MQ2xMCi7MOBADFL0kv/vv5Szl/s/
   g==;
X-CSE-ConnectionGUID: HB4buidXSeqmwNpL73jPUw==
X-CSE-MsgGUID: EUN+m+JoSkC9OOwio8n1Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21439215"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21439215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:46:22 -0700
X-CSE-ConnectionGUID: 8glDbEsrSvKWCJ8T2p/bRQ==
X-CSE-MsgGUID: hWsnEHY6T0ShmeznxdUgsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62404963"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa003.fm.intel.com with ESMTP; 12 Aug 2024 06:46:18 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: stable@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.10.y] idpf: fix memleak in vport interrupt configuration
Date: Mon, 12 Aug 2024 15:44:55 +0200
Message-ID: <20240812134455.2298021-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

commit 3cc88e8405b8d55e0ff035e31971aadd6baee2b6 upstream.

The initialization of vport interrupt consists of two functions:
 1) idpf_vport_intr_init() where a generic configuration is done
 2) idpf_vport_intr_req_irq() where the irq for each q_vector is
   requested.

The first function used to create a base name for each interrupt using
"kasprintf()" call. Unfortunately, although that call allocated memory
for a text buffer, that memory was never released.

Fix this by removing creating the interrupt base name in 1).
Instead, always create a full interrupt name in the function 2), because
there is no need to create a base name separately, considering that the
function 2) is never called out of idpf_vport_intr_init() context.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20240806220923.3359860-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index b023704bbbda..ed68c7baefa3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3636,13 +3636,15 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 /**
  * idpf_vport_intr_req_irq - get MSI-X vectors from the OS for the vport
  * @vport: main vport structure
- * @basename: name for the vector
  */
-static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
+static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	const char *drv_name, *if_name, *vec_name;
 	int vector, err, irq_num, vidx;
-	const char *vec_name;
+
+	drv_name = dev_driver_string(&adapter->pdev->dev);
+	if_name = netdev_name(vport->netdev);
 
 	for (vector = 0; vector < vport->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[vector];
@@ -3659,8 +3661,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 		else
 			continue;
 
-		q_vector->name = kasprintf(GFP_KERNEL, "%s-%s-%d",
-					   basename, vec_name, vidx);
+		q_vector->name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
+					   if_name, vec_name, vidx);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  q_vector->name, q_vector);
@@ -4170,7 +4172,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
  */
 int idpf_vport_intr_init(struct idpf_vport *vport)
 {
-	char *int_name;
 	int err;
 
 	err = idpf_vport_intr_init_vec_idx(vport);
@@ -4184,11 +4185,7 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 	if (err)
 		goto unroll_vectors_alloc;
 
-	int_name = kasprintf(GFP_KERNEL, "%s-%s",
-			     dev_driver_string(&vport->adapter->pdev->dev),
-			     vport->netdev->name);
-
-	err = idpf_vport_intr_req_irq(vport, int_name);
+	err = idpf_vport_intr_req_irq(vport);
 	if (err)
 		goto unroll_vectors_alloc;
 
-- 
2.46.0


