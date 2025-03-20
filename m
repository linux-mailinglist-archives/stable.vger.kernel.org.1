Return-Path: <stable+bounces-125621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A796EA69F67
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 06:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699533B4007
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81331A3152;
	Thu, 20 Mar 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ctxvZspA"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4A155753
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448910; cv=none; b=J991F56Jr8iNF8scz1+uSovQE/X8BpJ/IpLfqdH/jAR19QGWitg9wfkaMFz/bLd/cqYS5RPgRTFxiFvlAjrFuiKPsQCVNHrDGE0/7Zznsla9G9ap6o0AnbnQu99k9nDg8YbVXmg+DEbfe1QDRimZ3dqlDBiKS3Wfi+KobpFNF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448910; c=relaxed/simple;
	bh=Kh6qFJK6ewu4O0MP7nHJskhpFYYIXnQx8NZpV6KpKXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=s0M6z0Bdwa0FfUyl89m4JvF/y7YJH5iAgtWPpwR5y7G+5MIqqMEfRXjyCv6KGdcwRPoFY0FTJCylPRIpGrXkCJYpfOYFi/4kcxH2m+cKxcLUKqZ4RGT3iIwp9TlH6vLO0OG8VRTyZYdnv2ZXY6ys6Z2D+fp8rLiyZP2v2xymNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ctxvZspA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250320053505epoutp03eb93136049275659ad0144ddccc1ae82~ubAwxFOs71801418014epoutp03t
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 05:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250320053505epoutp03eb93136049275659ad0144ddccc1ae82~ubAwxFOs71801418014epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742448905;
	bh=uXEHlsrHc0PaEcG2bhAuO8LB/LLdf9iiDvfmyylQX3E=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ctxvZspAFVvDOD9i4sBA7MJE/Qvs85TdE2rcjQwsxb/WK/MSj1Q3ixkoIZBc+lteL
	 vZaRl8TH+x+bpvK4fjUjH9MdlRzf/UHON2yn2iczmwjvXl6hxfX94Ox/IqOfHowKXx
	 l7ewhtlsOUessFeRf7piEg8jLLEmZJ9fZte9L2vo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250320053504epcas1p258c1989427a94eeac2e8d9b920acd34a~ubAwDheyp2163421634epcas1p2H;
	Thu, 20 Mar 2025 05:35:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZJDmm4f5Pz4x9QH; Thu, 20 Mar
	2025 05:35:04 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc~ua5gTa47V1532515325epcas1p3J;
	Thu, 20 Mar 2025 05:26:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250320052646epsmtrp24e45f570fed7eb17e28ac27ea9585237~ua5gSCs8H0607506075epsmtrp2Z;
	Thu, 20 Mar 2025 05:26:46 +0000 (GMT)
X-AuditID: b6c32a52-205fe700000083ab-48-67dba7164f69
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.9E.33707.617ABD76; Thu, 20 Mar 2025 14:26:46 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250320052646epsmtip17e1a4b09afefd031a447464fc1ebaabf~ua5gDlt_Y0859608596epsmtip1w;
	Thu, 20 Mar 2025 05:26:46 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: linkinjeon@kernel.org, yuezhang.mo@sony.com
Cc: sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cpgs@samsung.com, Sungjong Seo
	<sj1557.seo@samsung.com>, stable@vger.kernel.org, Yeongjin Gil
	<youngjin.gil@samsung.com>
Subject: [PATCH] exfat: fix random stack corruption after get_block
Date: Thu, 20 Mar 2025 14:26:21 +0900
Message-Id: <158453976.61742448904639.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK7Y8tvpBo+Xq1i8PKRpMXHaUmaL
	PXtPslhc3jWHzWLLvyOsFi8+bGCzWLDxEaPFjP1P2S2uv3nI6sDpsXPWXXaPTas62Tz6tqxi
	9GifsJPZ4/MmuQDWKC6blNSczLLUIn27BK6M64fYCw5KV3R8uMXSwLhQuIuRk0NCwETi9Jse
	RhBbSGA7o8SplvQuRg6guJTEwX2aEKawxOHDxV2MXEAVrUwSE1sfsIKUswloSyxvWsYMYosI
	GEpsWLyXHaSIWeAWo8S06xPYQZqFBZwl2lZrg9SwCKhKTFy8lg3E5hWwlZiwbDczxAnyEjMv
	fWeHiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS
	83M3MYIDVStoB+Oy9X/1DjEycTAeYpTgYFYS4RXpuJ0uxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwJQWqa4T9WmfuXT3zVOGinyPD7O+381kqJnreGj7
	qUMzvJaFnr84bUv8IskSKxeG/RJqiSLPvz5dfmKle3r/zk+9ydPubnkePrnp6L0dX51/tem+
	/mrcHxe4QH1n8vtHE1duFVnSyXf8cJmlddpEk/vcH97XFv56rBd/t+FK1vypmmVtORv2O1Ra
	F4dMPtF28kvR/MhrBcz3LqoZqxx9f9w1/4zazekW+3dHMN6V+zOx4aAX09rvHsU7X2TY5vxg
	a/xqwZq2ge21z2qljBsWOgJhG1O0v152bNsmObVDwlbW9s0fmejq62fOrHzW/tn9N/P3asat
	QWqz1BnN7yQ/qzxcLHtn1byZDwXnBHAm3dytxFKckWioxVxUnAgAuk1a7cMCAAA=
X-CMS-MailID: 20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc
References: <CGME20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc@epcas1p3.samsung.com>

When get_block is called with a buffer_head allocated on the stack, such
as do_mpage_readpage, stack corruption due to buffer_head UAF may occur in
the following race condition situation.

     <CPU 0>                      <CPU 1>
mpage_read_folio
  <<bh on stack>>
  do_mpage_readpage
    exfat_get_block
      bh_read
        __bh_read
	  get_bh(bh)
          submit_bh
          wait_on_buffer
                              ...
                              end_buffer_read_sync
                                __end_buffer_read_notouch
                                   unlock_buffer
          <<keep going>>
        ...
      ...
    ...
  ...
<<bh is not valid out of mpage_read_folio>>
   .
   .
another_function
  <<variable A on stack>>
                                   put_bh(bh)
                                     atomic_dec(bh->b_count)
  * stack corruption here *

This patch returns -EAGAIN if a folio does not have buffers when bh_read
needs to be called. By doing this, the caller can fallback to functions
like block_read_full_folio(), create a buffer_head in the folio, and then
call get_block again.

Let's do not call bh_read() with on-stack buffer_head.

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: stable@vger.kernel.org
Tested-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/inode.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 96952d4acb50..b8ea910586e4 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -344,7 +344,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			 * The block has been partially written,
 			 * zero the unwritten part and map the block.
 			 */
-			loff_t size, off, pos;
+			loff_t size, pos;
+			void *addr;
 
 			max_blocks = 1;
 
@@ -355,17 +356,43 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			if (!bh_result->b_folio)
 				goto done;
 
+			/*
+			 * No buffer_head is allocated.
+			 * (1) bmap: It's enough to fill bh_result without I/O.
+			 * (2) read: The unwritten part should be filled with 0
+			 *           If a folio does not have any buffers,
+			 *           let's returns -EAGAIN to fallback to
+			 *           per-bh IO like block_read_full_folio().
+			 */
+			if (!folio_buffers(bh_result->b_folio)) {
+				err = -EAGAIN;
+				goto done;
+			}
+
 			pos = EXFAT_BLK_TO_B(iblock, sb);
 			size = ei->valid_size - pos;
-			off = pos & (PAGE_SIZE - 1);
+			addr = folio_address(bh_result->b_folio) +
+			       offset_in_folio(bh_result->b_folio, pos);
+
+			BUG_ON(size > sb->s_blocksize);
+
+			/* Check if bh->b_data points to proper addr in folio */
+			if (bh_result->b_data != addr) {
+				exfat_fs_error_ratelimit(sb,
+					"b_data(%p) != folio_addr(%p)",
+					bh_result->b_data, addr);
+				err = -EINVAL;
+				goto done;
+			}
 
-			folio_set_bh(bh_result, bh_result->b_folio, off);
+			/* Read a block */
 			err = bh_read(bh_result, 0);
 			if (err < 0)
 				goto unlock_ret;
 
-			folio_zero_segment(bh_result->b_folio, off + size,
-					off + sb->s_blocksize);
+			/* Zero unwritten part of a block */
+			memset(bh_result->b_data + size, 0,
+			       bh_result->b_size - size);
 		} else {
 			/*
 			 * The range has not been written, clear the mapped flag
-- 
2.25.1



