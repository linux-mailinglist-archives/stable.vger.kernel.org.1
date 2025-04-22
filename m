Return-Path: <stable+bounces-135073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE8A96417
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9AE188558B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD01F1539;
	Tue, 22 Apr 2025 09:22:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B02CCC9;
	Tue, 22 Apr 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313725; cv=none; b=f1EynvGcqaPtGr0ofoBuErpyObnYAvDnicfQiCr9vneU5zdwqXQO5j8eZKOc6N2vTGqFCge2hYpsBDzbkR4NxXgLs6ONLXfLP5aHOpykhQig6L0E1lr2l0sAUCCbo7A22CCSsDoAfdaqAJBoFWGVlB62+X1XbbHIPgb+qus+kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313725; c=relaxed/simple;
	bh=h4t9k9MoPtCmhq7TWMfc+sz/zcEwKZGcekccOzuWkas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0o8ihOmP75Cqzz0yMDKxl2cKOJx5uTsPrrcYNRt0iYBEf3DG6LJOUVhfKDEB7bkn96a8/wzx1KxtYNuBSNLzu255Ah2eI8genpKjiOMAcXQURd0hLA+J0ZcMbv0HMw97iqcfkWO6knFuEIKukpy+ZWaBTbMIGORS+EzOwCR/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4eFSS023531;
	Tue, 22 Apr 2025 02:21:29 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4647442kkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Apr 2025 02:21:29 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 22 Apr 2025 02:21:28 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 22 Apr 2025 02:21:25 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <tom@talpey.com>, <jiyin@redhat.com>, <pc@manguebit.com>,
        <stfrench@microsoft.com>, <sfrench@samba.org>,
        <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>
Subject: [PATCH 5.10.y 2/2] smb: client: fix NULL ptr deref in crypto_aead_setkey()
Date: Tue, 22 Apr 2025 17:21:25 +0800
Message-ID: <20250422092125.3645917-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e51QhKt27oMCDyplDEHLah-XBUi7vEG0
X-Authority-Analysis: v=2.4 cv=UpNjN/wB c=1 sm=1 tr=0 ts=68075f99 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=Li1AiuEPAAAA:8 a=SEc3moZ4AAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8
 a=riu9DmvwmDMTBw3IfOsA:9 a=qGKPP_lnpMOaqR3bcYHU:22 a=5oRCH6oROnRZc2VpWJZ3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: e51QhKt27oMCDyplDEHLah-XBUi7vEG0
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504220070

From: Paulo Alcantara <pc@manguebit.com>

commit 4bdec0d1f658f7c98749bd2c5a486e6cfa8565d2 upstream.

Neither SMB3.0 or SMB3.02 supports encryption negotiate context, so
when SMB2_GLOBAL_CAP_ENCRYPTION flag is set in the negotiate response,
the client uses AES-128-CCM as the default cipher.  See MS-SMB2
3.3.5.4.

Commit b0abcd65ec54 ("smb: client: fix UAF in async decryption") added
a @server->cipher_type check to conditionally call
smb3_crypto_aead_allocate(), but that check would always be false as
@server->cipher_type is unset for SMB3.02.

Fix the following KASAN splat by setting @server->cipher_type for
SMB3.02 as well.

mount.cifs //srv/share /mnt -o vers=3.02,seal,...

BUG: KASAN: null-ptr-deref in crypto_aead_setkey+0x2c/0x130
Read of size 8 at addr 0000000000000020 by task mount.cifs/1095
CPU: 1 UID: 0 PID: 1095 Comm: mount.cifs Not tainted 6.12.0 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41
04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 ? crypto_aead_setkey+0x2c/0x130
 kasan_report+0xda/0x110
 ? crypto_aead_setkey+0x2c/0x130
 crypto_aead_setkey+0x2c/0x130
 crypt_message+0x258/0xec0 [cifs]
 ? __asan_memset+0x23/0x50
 ? __pfx_crypt_message+0x10/0x10 [cifs]
 ? mark_lock+0xb0/0x6a0
 ? hlock_class+0x32/0xb0
 ? mark_lock+0xb0/0x6a0
 smb3_init_transform_rq+0x352/0x3f0 [cifs]
 ? lock_acquire.part.0+0xf4/0x2a0
 smb_send_rqst+0x144/0x230 [cifs]
 ? __pfx_smb_send_rqst+0x10/0x10 [cifs]
 ? hlock_class+0x32/0xb0
 ? smb2_setup_request+0x225/0x3a0 [cifs]
 ? __pfx_cifs_compound_last_callback+0x10/0x10 [cifs]
 compound_send_recv+0x59b/0x1140 [cifs]
 ? __pfx_compound_send_recv+0x10/0x10 [cifs]
 ? __create_object+0x5e/0x90
 ? hlock_class+0x32/0xb0
 ? do_raw_spin_unlock+0x9a/0xf0
 cifs_send_recv+0x23/0x30 [cifs]
 SMB2_tcon+0x3ec/0xb30 [cifs]
 ? __pfx_SMB2_tcon+0x10/0x10 [cifs]
 ? lock_acquire.part.0+0xf4/0x2a0
 ? __pfx_lock_release+0x10/0x10
 ? do_raw_spin_trylock+0xc6/0x120
 ? lock_acquire+0x3f/0x90
 ? _get_xid+0x16/0xd0 [cifs]
 ? __pfx_SMB2_tcon+0x10/0x10 [cifs]
 ? cifs_get_smb_ses+0xcdd/0x10a0 [cifs]
 cifs_get_smb_ses+0xcdd/0x10a0 [cifs]
 ? __pfx_cifs_get_smb_ses+0x10/0x10 [cifs]
 ? cifs_get_tcp_session+0xaa0/0xca0 [cifs]
 cifs_mount_get_session+0x8a/0x210 [cifs]
 dfs_mount_share+0x1b0/0x11d0 [cifs]
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_dfs_mount_share+0x10/0x10 [cifs]
 ? lock_acquire.part.0+0xf4/0x2a0
 ? find_held_lock+0x8a/0xa0
 ? hlock_class+0x32/0xb0
 ? lock_release+0x203/0x5d0
 cifs_mount+0xb3/0x3d0 [cifs]
 ? do_raw_spin_trylock+0xc6/0x120
 ? __pfx_cifs_mount+0x10/0x10 [cifs]
 ? lock_acquire+0x3f/0x90
 ? find_nls+0x16/0xa0
 ? smb3_update_mnt_flags+0x372/0x3b0 [cifs]
 cifs_smb3_do_mount+0x1e2/0xc80 [cifs]
 ? __pfx_vfs_parse_fs_string+0x10/0x10
 ? __pfx_cifs_smb3_do_mount+0x10/0x10 [cifs]
 smb3_get_tree+0x1bf/0x330 [cifs]
 vfs_get_tree+0x4a/0x160
 path_mount+0x3c1/0xfb0
 ? kasan_quarantine_put+0xc7/0x1d0
 ? __pfx_path_mount+0x10/0x10
 ? kmem_cache_free+0x118/0x3e0
 ? user_path_at+0x74/0xa0
 __x64_sys_mount+0x1a6/0x1e0
 ? __pfx___x64_sys_mount+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cc: Tom Talpey <tom@talpey.com>
Reported-by: Jianhong Yin <jiyin@redhat.com>
Cc: stable@vger.kernel.org # v6.12
Fixes: b0abcd65ec54 ("smb: client: fix UAF in async decryption")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Commit b0abcd65ec54 ("smb: client: fix UAF in async decryption")
fixes CVE-2024-50047 but brings NULL-pointer dereferebce. So
commit 4bdec0d1f658 ("smb: client: fix NULL ptr deref in crypto_aead_setkey()")
should be backported too.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/cifs/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 245e2dd5a194..4197096e7fdb 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -963,7 +963,9 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	 * SMB3.0 supports only 1 cipher and doesn't have a encryption neg context
 	 * Set the cipher type manually.
 	 */
-	if (server->dialect == SMB30_PROT_ID && (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
+	if ((server->dialect == SMB30_PROT_ID ||
+	     server->dialect == SMB302_PROT_ID) &&
+	    (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
 		server->cipher_type = SMB2_ENCRYPTION_AES128_CCM;
 
 	security_blob = smb2_get_data_area_len(&blob_offset, &blob_length,
-- 
2.34.1


