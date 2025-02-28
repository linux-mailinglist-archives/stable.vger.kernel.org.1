Return-Path: <stable+bounces-119920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE8A494D9
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E11A1711C1
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74AF2566DF;
	Fri, 28 Feb 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CgXmWRrZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0351F30A2;
	Fri, 28 Feb 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734728; cv=none; b=Aw7vwUYk1y1g/TMCp+7I3aBpVy181bPgERKvOAHPBj6Eg9k++Q2Scy9riT1Gg6vZXblzMbxfrrdOkVH3a+XRtlqnFsIJK7inWeDg4PYdmwHB+cxWe9Eq5aj/54qOi6ZVf92SCvMckW4wIK3k4o2OtG0hZOvJtw9R1cqrmvhNvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734728; c=relaxed/simple;
	bh=oAPbqbblLWp21an+z84tAVzI3aljqmgqN18ng4MMmEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ml1jdJAE6Z7MdGW5dCTUgd4kNpiYizJqwycA256DOueBMKDDGZqGuZQIpzz1JeSDV7wWrT20+UomFCw12Y6jUvQ0DnzaU6QOTrl4anYst758phbclwFARioxkVekfLA49ZshE1iQs6JO+TSJ0ewZwH9eiJqEEpFXypVPLav0lY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CgXmWRrZ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t+QWg
	uMxoLDRH5vcXi4r28RqexjrSgeJPwqF3tPYLt8=; b=CgXmWRrZM2xX2nJAyw40J
	Tk1nm51ZOnW4v/HxyQzhfxewHVx+ZluJqUH53ETnT3WSUvZRjeA2XGHcwmWX+fWO
	MpyP+yaHfF1U3L7oAyLtAXZ257HUv2Zky5hmG8qK7lV4tBPuJOOHjjdRO2li59di
	EaB/0cXsRaJaDcI5Ry0C9M=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCnnh3kgMFn9GRbPQ--.63080S4;
	Fri, 28 Feb 2025 17:24:53 +0800 (CST)
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
Subject: [PATCH] qlcnic: fix a memory leak in qlcnic_sriov_set_guest_vlan_mode()
Date: Fri, 28 Feb 2025 17:24:49 +0800
Message-Id: <20250228092449.3759573-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnnh3kgMFn9GRbPQ--.63080S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kAFWrtFy5ur4ktr15twb_yoWktFcEkF
	17Zr1rX3yUCr9xK3y3twsru342gwnrX3WfZa4FgayrtwnrCF4jyw17Jas5JFyDX3yrZr9r
	G3Wayry5C34IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hkCbmfBfo4+eQAAs2

Add qlcnic_sriov_free_vlans() to free the memory allocated by
qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
be allocated.

Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index f9dd50152b1e..2c01a9ad444f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -454,8 +454,10 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 
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


