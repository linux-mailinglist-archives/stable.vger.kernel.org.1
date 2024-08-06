Return-Path: <stable+bounces-65507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F03949AF9
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 00:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA33B24714
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1245171675;
	Tue,  6 Aug 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ka0jjhP0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22D16B75B;
	Tue,  6 Aug 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982180; cv=none; b=U+MOqYGDtaRjOsFvIAhPfRPQgqSNxPB90ta0yc6vmzEspwAjOyjufCqQZ/CJjHjAMFZfPvc+CAHE2u0rkxGJlJEEbAWujMvarQZivWH3x1P9LgGlBviFD+I4u8pijtNsAWWIN69+tnwMB27x1TFL1d3ySRE2p7eXdMfGtwYg4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982180; c=relaxed/simple;
	bh=dT153xs/qwEfmlJ+ZgCCDVJ/hlCQl8Ti9arrnK2GHb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKUgude6mOYPm5wlXNH6iNx/YicLGskXwgimpXlRfD/mTcTjkz7CBzT7gG+b/GUVyH17mJMtyI9AYBFefVOnEndo/DTcdLSk/NQBP4Mz+C/n4pfv2inMWb1o1POHBpk7rYKPzzsK5buc74yY6Rxxw83WvEjBbZaxO+x4Gz/B9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ka0jjhP0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982180; x=1754518180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dT153xs/qwEfmlJ+ZgCCDVJ/hlCQl8Ti9arrnK2GHb0=;
  b=Ka0jjhP0cdt7PEt5tzhQHcGNNxE2KN9kMO4bt7xabO7jeGCHOZrjjZve
   LLbHLbs1df/1d9fh83aZrY/vVhgbdiqKeEeDpc8WHhcpCC0i8fhNde+tT
   PMLvMGK8KFrz1FmN+R8x+6hIt9jgCTXGuB1Y6NSDgbG8so1OdZtOUKv+M
   u2Co8qd8M5mX+0PQWSmAHF6rrAo8CBx/Ci+dIwhRW7hDSP2qy+4fAkwdT
   9CZHocRh97kl6qGCMkt7Bsps9s9an2qqPRak1q/WAV6FxeKLUD+Y78oHN
   r/6yfS0I5ZET5AhDxWMi2QRGUPhvAoJiEH3HvJC7fUfRTyg7PPceYzO3m
   w==;
X-CSE-ConnectionGUID: 0CX0T7VsTpagfGnVxe7MmA==
X-CSE-MsgGUID: RE6DQa4lQF2mjm1N9L2SVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21172198"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21172198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:09:38 -0700
X-CSE-ConnectionGUID: qKptz/5FShCzcPbEQhKpjA==
X-CSE-MsgGUID: IVSaxke3QRSPif3NY5s1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56297920"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 15:09:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 2/3] idpf: fix memleak in vport interrupt configuration
Date: Tue,  6 Aug 2024 15:09:21 -0700
Message-ID: <20240806220923.3359860-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
References: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

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
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index af2879f03b8d..a2f9f252694a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3780,13 +3780,15 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
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
@@ -3804,8 +3806,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 		else
 			continue;
 
-		name = kasprintf(GFP_KERNEL, "%s-%s-%d", basename, vec_name,
-				 vidx);
+		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
+				 vec_name, vidx);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
@@ -4326,7 +4328,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
  */
 int idpf_vport_intr_init(struct idpf_vport *vport)
 {
-	char *int_name;
 	int err;
 
 	err = idpf_vport_intr_init_vec_idx(vport);
@@ -4340,11 +4341,7 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
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
2.42.0


