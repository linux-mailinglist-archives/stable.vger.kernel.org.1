Return-Path: <stable+bounces-146230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAEAC2E14
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CED34E0014
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD81DF261;
	Sat, 24 May 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kTo4zrev"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF38C11;
	Sat, 24 May 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071677; cv=none; b=ZoIRzo2RAtBWHCqHfdkx7MNE1tzxP4d5vGKWxisD052ek0A/XrHgd3vH466NwtFHRs4ZXL6fWTSEYrSWzt5S34FfNEHNOcCuebXN5bVK+7iUKFQEQ3xtxz28WRtA2sF7zMgqaytqw/t/PNwVtguZPTFe6n+qsGJpeKCg+wsiDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071677; c=relaxed/simple;
	bh=QsHCdBici6uZQb0MMP/UeIRDZiWNUzkYoYcveEjC4rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TASr3t3com/js+Rd+AwutJzSL84rxCFeX8YEnUgBuQIJ+vKHiZTTcIuqmRm6Mwgl3n/m8hQHz7Tef+WFJrRqhiqfSqEuTGMyzg0pknrldYnJXCM6cHD5IK1yA+ZtvLB0NpLw3vHEbgSGnhXfEQrjRquaseQbge9QNV+q5jfhMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kTo4zrev; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hu
	286s57mP1NPRtFysQLi/doib7qC4IDVyR6e/Hyw78=; b=kTo4zrevTgjipbrONC
	5E8JWrSIjZ5R3+wDOjHE7BVrCcnQThZgLl3PBWAHEBXfId7ntFqu5S733kmCpxo8
	bGTNCao/v0r58BcWLXaVHWxfTz7rF09XECe4bOjHFe7/O5H9v04qoC8VvIyiCe9e
	7/D7hV+M1EOnFW31KUxtdAWPI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCH2R_DdDFow8_GDg--.1286S4;
	Sat, 24 May 2025 15:27:00 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sergey.temerkhanov@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Sat, 24 May 2025 15:26:58 +0800
Message-Id: <20250524072658.3586149-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH2R_DdDFow8_GDg--.1286S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1fXw1Duw47JFyftFyrJFb_yoWDJrcE9w
	4SvFyfJrW5KryFv3yYkr47Z34SyF1DXr9Y9ay2939a9wnxGryDXwnrZr93Xr47WFyDuF9r
	Ars7ta42va42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0g9TbmgtChXmaQABs0

Add check for the return value of devm_kmemdup()
to prevent potential null pointer dereference.

Fixes: 2ffd87d38d6b ("ice: Move support DDP code out of ice_flex_pipe.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 59323c019544..351824dc3c62 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2301,6 +2301,8 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
 		return ICE_DDP_PKG_ERR;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_DDP_PKG_ERR;
 
 	state = ice_init_pkg(hw, buf_copy, len);
 	if (!ice_is_init_pkg_successful(state)) {
-- 
2.25.1


