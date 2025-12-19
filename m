Return-Path: <stable+bounces-203051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AEFCCEC49
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 08:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD0FF30842A8
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB202D59FA;
	Fri, 19 Dec 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jCcjDrt7"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2C2D4B57
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128312; cv=none; b=XxXMj0UWBvPaPLZSMPdMDrvkFYj0SjtdMSZy+AtwJDqVbNl6/KfXvkmCXU70xfA6fanvY5m38oBn4vS0M8cpfNkkKQ9QwxUKBGo/JVLqANchABLLfgTNuTquGfqNJL3IVLdjmJsJkK/oSTIxw0fyvoXG4myjZE9E4tltYS+ojaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128312; c=relaxed/simple;
	bh=gb0wVKb2w4secK47ohuClP95wO4o7IEP5VkB/zbF7Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fS5iC5qOAzC2buxlRVBS+wUJoBK2264SmvXA6ov+75mxfzBT820AfHh7fNzZbpdga9TTAkTc3dNhG2SrYOs0hJ2E0zjXT1LyGo4gS7KapjzQzdpQDeLDKpZtza1UCI6a6dKsaUQyt3WeBqSMC2Vfb8hp8dXI1bSIGJPYnAcZwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jCcjDrt7; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251219071141epoutp04c96bb26f4d9013ea03d8d5baa3f7ef02~CjFVMsDJn0974409744epoutp04l
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 07:11:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251219071141epoutp04c96bb26f4d9013ea03d8d5baa3f7ef02~CjFVMsDJn0974409744epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766128301;
	bh=UtCVg1Sk3vENqrZPryuqewEpnykLjYm5HB63m+fb6zY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jCcjDrt7LeelML8xluF1a7BnBpUHZct1KO8CF4+POIZRnPfVb69F7HQ/+U5HcQwJl
	 EjNm1xF4jrg8f2h87FiqUW/ISXHYi4CWr0hDxTGfgUx4KXgz/v/VXjW/lPlTmlhI/I
	 pjfqLBp5q35hruOMtZt1bsp20NeBEtT9kCplpfhI=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20251219071141epcas1p3a4d92a2bfce352ef539b8ab5c12826b5~CjFU7xSXb0562705627epcas1p3n;
	Fri, 19 Dec 2025 07:11:41 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.118]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dXdxn2dP0z6B9mK; Fri, 19 Dec
	2025 07:11:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219071140epcas1p35856372483a973806c5445fa3d2d260b~CjFT-2bdf0562705627epcas1p3k;
	Fri, 19 Dec 2025 07:11:40 +0000 (GMT)
Received: from junbeom.yeom (unknown [10.253.99.78]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251219071140epsmtip2d11eadd7ab78bdd4184cd1da2ac5eae8~CjFT9W_Dm2747727477epsmtip2L;
	Fri, 19 Dec 2025 07:11:40 +0000 (GMT)
From: Junbeom Yeom <junbeom.yeom@samsung.com>
To: xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Junbeom Yeom
	<junbeom.yeom@samsung.com>, stable@vger.kernel.org, Jaewook Kim
	<jw5454.kim@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 16:10:34 +0900
Message-Id: <20251219071034.2399153-1-junbeom.yeom@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>

erofs readahead could fail with ENOMEM under the memory pressure because
it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
for a regular read. And if readahead fails (with non-uptodate folios),
the original request will then fall back to synchronous read, and
`.read_folio()` should return appropriate errnos.

However, in scenarios where readahead and read operations compete,
read operation could return an unintended EIO because of an incorrect
error propagation.

To resolve this, this patch modifies the behavior so that, when the
PCL is for read(which means pcl.besteffort is true), it attempts actual
decompression instead of propagating the privios error except initial EIO.

- Page size: 4K
- The original size of FileA: 16K
- Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
[page0, page1] [page2, page3]
[PCL0]---------[PCL1]

- functions declaration:
  . pread(fd, buf, count, offset)
  . readahead(fd, offset, count)
- Thread A tries to read the last 4K
- Thread B tries to do readahead 8K from 4K
- RA, besteffort == false
- R, besteffort == true

        <process A>                   <process B>

pread(FileA, buf, 4K, 12K)
  do readahead(page3) // failed with ENOMEM
  wait_lock(page3)
    if (!uptodate(page3))
      goto do_read
                               readahead(FileA, 4K, 8K)
                               // Here create PCL-chain like below:
                               // [null, page1] [page2, null]
                               //   [PCL0:RA]-----[PCL1:RA]
...
  do read(page3)        // found [PCL1:RA] and add page3 into it,
                        // and then, change PCL1 from RA to R
...
                               // Now, PCL-chain is as below:
                               // [null, page1] [page2, page3]
                               //   [PCL0:RA]-----[PCL1:R]

                                 // try to decompress PCL-chain...
                                 z_erofs_decompress_queue
                                   err = 0;

                                   // failed with ENOMEM, so page 1
                                   // only for RA will not be uptodated.
                                   // it's okay.
                                   err = decompress([PCL0:RA], err)

                                   // However, ENOMEM propagated to next
                                   // PCL, even though PCL is not only
                                   // for RA but also for R. As a result,
                                   // it just failed with ENOMEM without
                                   // trying any decompression, so page2
                                   // and page3 will not be uptodated.
                ** BUG HERE ** --> err = decompress([PCL1:R], err)

                                   return err as ENOMEM
...
    wait_lock(page3)
      if (!uptodate(page3))
        return EIO      <-- Return an unexpected EIO!
...

Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
Cc: stable@vger.kernel.org
Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
---
 fs/erofs/zdata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 27b1f44d10ce..86bf6e087d34 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	};
 	struct z_erofs_pcluster *next;
 	int err = io->eio ? -EIO : 0;
+	int io_err = err;
 
 	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
+		int propagate_err;
+
 		DBG_BUGON(!be.pcl);
 		next = READ_ONCE(be.pcl->next);
-		err = z_erofs_decompress_pcluster(&be, err) ?: err;
+		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
+		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
 	}
 	return err;
 }
-- 
2.34.1


