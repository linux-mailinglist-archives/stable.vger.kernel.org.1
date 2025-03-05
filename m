Return-Path: <stable+bounces-120411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263ABA4FB54
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8613A70C2
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB48205AC8;
	Wed,  5 Mar 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VEtUkFYf"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB586340;
	Wed,  5 Mar 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169444; cv=none; b=PGBO+J4eD2BypOl9uYOc1GKi/tioCDHQCOF18aW5nQHPi7aWF7c2/WQPMC5ClPusTgl7IlZKuyr1m9XNggH6excohLx2sq/nek9iWn3Y+Dhiovqu0p36h/FWgKIB7HVfGaROhgCstHvJD5Ks1f0QUmUAWcYchVeDZZpnDNd/kgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169444; c=relaxed/simple;
	bh=p7qCmbn7qh8IoaNpypSjjh8REnQqe2JM+GRz9TM9Dek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BP66su3c7m497yNxhsS8L3OLWkW/yKBFJ491sCkoiqNgaGzfKguCb/W/+NGfxsstkHLQcEDa3/ML1tcsjBwzjc6NVxgYK8rcTlmivrly4jUoXQoFV9rf69iFHt9ajZ2GNqzt5clyOpDqCMRFbRF+1CfwEV3ZCqdTTPaejEdX/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VEtUkFYf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=luJmq
	zW3D/PHhjjmaO84ghpqEdiImWkNJgLVp6gRUTA=; b=VEtUkFYffxFzvHLt+hcDo
	JGgjbhLHIJPu+hpxz4JaEO4TjYLKnwk+mjovJMGdNoqnwVqrMoQarfq5PS1BGanC
	ZJm0VVD/CPvAsNz/nFKXBI8ZD3928rjiLIqfQ8IAqHMkIGm/cYW+CO5ySgCcK06T
	gG0As/Wn6zwyWZPmFX8SNM=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCXviTwIshncgV_Qg--.37440S4;
	Wed, 05 Mar 2025 18:09:53 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rajesh.borundia@qlogic.com,
	sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] qlcnic: fix a memory leak in qlcnic_sriov_set_guest_vlan_mode()
Date: Wed,  5 Mar 2025 18:09:50 +0800
Message-Id: <20250305100950.4001113-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXviTwIshncgV_Qg--.37440S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW8uF48Ww13Jw1DCr4kZwb_yoW8WFykpF
	47ZFyUWr95JF4jkws5Zwn2yrZ8C39Fy3sruF9xW393u34Utr4xGw1DArnIgrn0yr95GFW8
	tr1DZ3W5XFn8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hQHbmfIHmJ4MQAAs1

Add qlcnic_sriov_free_vlans() to free the memory allocated by
qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
or "sriov->allowed_vlans" fails to be allocated.

Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Add qlcnic_sriov_free_vlans() if qlcnic_sriov_alloc_vlans() fails.
- Modify the patch description.
vf_info was allocated by kcalloc, no need to do more checks cause
kfree(NULL) is safe. Thanks, Paolo! 
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index f9dd50152b1e..0dd9d7cb1de9 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -446,16 +446,20 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 		 sriov->num_allowed_vlans);
 
 	ret = qlcnic_sriov_alloc_vlans(adapter);
-	if (ret)
+	if (ret) {
+		qlcnic_sriov_free_vlans(adapter);
 		return ret;
+	}
 
 	if (!sriov->any_vlan)
 		return 0;
 
 	num_vlans = sriov->num_allowed_vlans;
 	sriov->allowed_vlans = kcalloc(num_vlans, sizeof(u16), GFP_KERNEL);
-	if (!sriov->allowed_vlans)
+	if (!sriov->allowed_vlans) {
+		qlcnic_sriov_free_vlans(adapter);
 		return -ENOMEM;
+	}
 
 	vlans = (u16 *)&cmd->rsp.arg[3];
 	for (i = 0; i < num_vlans; i++)
-- 
2.25.1


