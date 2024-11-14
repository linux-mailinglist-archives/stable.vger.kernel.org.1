Return-Path: <stable+bounces-92980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EE9C862F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B7C284CD9
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943501F76AB;
	Thu, 14 Nov 2024 09:30:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C601DD54C
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576656; cv=none; b=kjGVLfzIVQBvDdbBvb7ZYyET/cDYs30g6GteDsd1OBcMgpiq8WgQUsb1v/BLycM68e2bWQ/ZjLubIbPmfxbPEb/CTHvMArasLqXdii3AfEyFF7tJ5/RG8/iK5muTZ787lP8ZANocQFAukCm6boTI3latP9+cq6MzsjNp//FJN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576656; c=relaxed/simple;
	bh=AoN5subEhD5ph6GECCMk9G3jg73z1JEEzAH0q0kFPVE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/p+bJnGT4BlW5hKMq+4h4aX3xHOkCjOHI0JevgkU6yVLIzlc3K/eVJ1DKFv7rbpjKINUfnlDZ4h4kQSfwucxuEwvMBCZE70XerzmDT+jdtgzJbCMVO0q8s4E74J/FDwUoOjgT3XQK79Iz7D7Jw4ZkubY4nZR1J2cjH+2J/B85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8e1X5028941;
	Thu, 14 Nov 2024 01:30:47 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpmkm3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Nov 2024 01:30:46 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 14 Nov 2024 01:30:46 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 14 Nov 2024 01:30:45 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1] fs/ntfs3: Fix general protection fault in run_is_mapped_full
Date: Thu, 14 Nov 2024 17:31:07 +0800
Message-ID: <20241114093107.1092295-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1f4WUb_K2Xvo8rAm_mZ39LfyaeCymh3C
X-Authority-Analysis: v=2.4 cv=ZdlPNdVA c=1 sm=1 tr=0 ts=6735c347 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=GFCt93a2AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=xcN3r6YJb35t5HIqOz4A:9 a=0UNspqPZPZo5crgNHNjb:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 1f4WUb_K2Xvo8rAm_mZ39LfyaeCymh3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_03,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411140073

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit a33fb016e49e37aafab18dc3c8314d6399cb4727 ]

Fixed deleating of a non-resident attribute in ntfs_create_inode()
rollback.

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/ntfs3/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 026ed43c0670..8d1cfa0fc13f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1646,6 +1646,15 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 			  le16_to_cpu(new_de->key_size), sbi);
 	/* ni_unlock(dir_ni); will be called later. */
 out6:
+	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
+	if (attr && attr->non_res) {
+		/* Delete ATTR_EA, if non-resident. */
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
+	}
+	
 	if (rp_inserted)
 		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
 
-- 
2.43.0


