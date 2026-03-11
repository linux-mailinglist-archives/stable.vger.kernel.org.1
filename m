Return-Path: <stable+bounces-224642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DuUIkUIsWnhpwIAu9opvQ
	(envelope-from <stable+bounces-224642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:14:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B401A25CB6F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D18E305ED0A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FB35A3AC;
	Wed, 11 Mar 2026 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="empGvesb"
X-Original-To: stable@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55F3603EB
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209665; cv=none; b=ekmVVdw0EnYULpISf3ZAPRPzFIgIHtjHGrvX27XEd/i6mfIe87jphg3gGIaYynrudAJfxIFgMnZze9jPzUgw2JkN4HZDxgGEcvzrR5agNAfqOX7UuDoy5co6/KQbdCV1aGVlpYTwAeXHrsP6mvsPlt+gWLIPPpetKeHiPAnZi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209665; c=relaxed/simple;
	bh=10zzseX5cgjIhhU4gPZWnW4t36Kkkcg0GQGMIsnpNxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDrNUO1ewBZB6Beugaajr2QNcotU3UyyHK31jfoz3HQ+2mW1ESzIt+9bLBZYON/+qQuaVZ9JhAUhxajYCotcWvSVCxQSUS5owHC28luwdZ3UemZXEQQO5TDlimFpEoBu6X66FT/ODHeEXX9Y8cZWibf0cX+ScRD5olHwPFvUWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=empGvesb; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62B6DT4e065108;
	Wed, 11 Mar 2026 14:13:29 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fW0lK5W2cz2PKjkQ;
	Wed, 11 Mar 2026 14:12:13 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 11 Mar 2026 14:13:27 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <stable@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>, <hsiangkao@linux.alibaba.com>,
        <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 6.12.y] erofs: fix inline data read failure for ztailpacking pclusters
Date: Wed, 11 Mar 2026 14:13:34 +0800
Message-ID: <1773209614-1961-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 62B6DT4e065108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1773209622;
	bh=BBAx27HpV+NwLuVJohZyH+4JURvDSTgGJc+LZBlgtd0=;
	h=From:To:CC:Subject:Date;
	b=empGvesb26diQO3+MQ2ScENbzgBTKwQJdx7sZR1xPmw/1nDpFhgYZORT2AMF8xTTz
	 uNcWlIsKKC8j5up/DDs3hFsladvQ6CQZXO6wB1/aXpG/paO1fJi5r1fqYJErWlU01W
	 ygTsPr5dxNq2roRdht97aKYe6x1IZxY0eTHjsEXzkQcqj/n1DB8j3ZCvYqa/OvODgD
	 Ig7vXwTbceHiItDOEjpqyRGI03aLVhOf/AgsvVDHa76w3AYYuNscPRcRBna0JoY77t
	 6R/fQ1iaPZYcxhoF2Pwba79oLpjoDM1ub9sBxF5FFm0QlZ/i8HV0187B74ICRqvPWA
	 F/TdN9Eejfp/A==
X-Rspamd-Queue-Id: B401A25CB6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[zhiguo.niu@unisoc.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,linux.alibaba.com,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-224642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[unisoc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]

Compressed folios for ztailpacking pclusters must be valid before adding
these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
may assume they are already valid and then trigger a NULL pointer
dereference.

It is somewhat hard to reproduce because the inline data is in the same
block as the tail of the compressed indexes, which are usually read just
before. However, it may still happen if a fatal signal arrives while
read_mapping_folio() is running, as shown below:

 erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

 ...

 pc : z_erofs_decompress_queue+0x4c8/0xa14
 lr : z_erofs_decompress_queue+0x160/0xa14
 sp : ffffffc08b3eb3a0
 x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
 x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
 x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
 x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
 x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
 x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
 x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
 x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  z_erofs_decompress_queue+0x4c8/0xa14
  z_erofs_runqueue+0x908/0x97c
  z_erofs_read_folio+0x128/0x228
  filemap_read_folio+0x68/0x128
  filemap_get_pages+0x44c/0x8b4
  filemap_read+0x12c/0x5b8
  generic_file_read_iter+0x4c/0x15c
  do_iter_readv_writev+0x188/0x1e0
  vfs_iter_read+0xac/0x1a4
  backing_file_read_iter+0x170/0x34c
  ovl_read_iter+0xf0/0x140
  vfs_read+0x28c/0x344
  ksys_read+0x80/0xf0
  __arm64_sys_read+0x24/0x34
  invoke_syscall+0x60/0x114
  el0_svc_common+0x88/0xe4
  do_el0_svc+0x24/0x30
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1bc/0x1c0

Fix this by reading the inline data before allocating and adding
the pclusters to the I/O chains.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/erofs/zdata.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7116f20..0b3ca62 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -788,6 +788,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct z_erofs_pcluster *pcl = NULL;
 	int ret;
+	void *mptr = NULL;
 
 	DBG_BUGON(fe->pcl);
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
@@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
+	} else {
+		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
+		if (IS_ERR(mptr)) {
+			ret = PTR_ERR(mptr);
+			erofs_err(sb, "failed to get inline data %d", ret);
+			return ret;
+		}
+		mptr = map->buf.page;
 	}
 
 	if (pcl) {
@@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		void *mptr;
-
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
-		if (IS_ERR(mptr)) {
-			ret = PTR_ERR(mptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
-			return ret;
-		}
-		get_page(map->buf.page);
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		get_page((struct page *)mptr);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, mptr);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
-- 
1.9.1


