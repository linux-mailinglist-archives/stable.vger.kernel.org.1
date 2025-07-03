Return-Path: <stable+bounces-159293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF14EAF6F58
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1084E6CF0
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99C2E03E0;
	Thu,  3 Jul 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bAHTcEfK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40E2D6632;
	Thu,  3 Jul 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536474; cv=none; b=t2ihWeVzc9Zwo8fGz5x9ASi1AS9RGHUmb3LpwjwrAWGI0Tf6c1/DmTRTZM2oVooKitvpBvajfgFFBtUnm788fvNkOU2BXnkEGiSJUnJ5x62XocX1WbLJwj0CS5rQKbKVOTraApxctvzXhUBPcYxdWbiBdTPTTz01Gq4Q5UstPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536474; c=relaxed/simple;
	bh=M30E5phtsRgNt9bWOudN+Wz7g5IN3dIUI9pAYWfH0GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEJfRb5NErvfibJsvYOT94IdwOMmRGBj0S50rM0V6PaVRiETpkAfy5bTvzG7UWO6TV9aTE0C0ZIsT+PVDPY8lUZ+gd1RNqL5xxlErlim3+/IG/WtB8hYIfnO26gH5n65JQ8+3dwcECVh86PItpm/hlwPZsIIfL832LBoZ3YQ3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bAHTcEfK; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zq
	yqcmzFSBUDYjqKQmxZony3sGHurYaKa67pNQBSGA4=; b=bAHTcEfKSMHDjwiSZg
	hJQ1k1nBR2UbZQb12xuRQuvCRQ9Xd9enEtlTpuU7z7n35kSLjZdBvnz2rD+e/ads
	0g3RaJ0Ewzwe+dgE76P5mbh4YmVGgUTsIGrL4i6Co093ISlPjAWJJE1/9RuZ7pss
	5zW9hO6D75dXQQmvKzQxzCc3U=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXz5_hUmZo74LVCA--.57467S4;
	Thu, 03 Jul 2025 17:52:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Thu,  3 Jul 2025 17:52:32 +0800
Message-Id: <20250703095232.2539006-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXz5_hUmZo74LVCA--.57467S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1fXw1Duw47JFyDWr1xKrg_yoWkKFg_uw
	4FvFyfArWUKr1F9w4YkF47Z34FyF1kXFykua12k39Y9w15GryDXa4DZr9xXr4qgF1DuFnx
	Ars3JasFyFy2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKiiSDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBEgB-bmhmSx75sAAAsR

Add check for the return value of devm_kmemdup()
to prevent potential null pointer dereference.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changes in v2:
- modify the Fixes commit number. Thanks, Michal!
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


