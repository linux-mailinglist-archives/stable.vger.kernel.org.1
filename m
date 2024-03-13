Return-Path: <stable+bounces-27584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13787A716
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E11C231C2
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E03F8D1;
	Wed, 13 Mar 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ltS+Drkh"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAF3EA95
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329231; cv=none; b=OisdsVhRIGxGPS2oXW8Dx9anEX4v8PZ/BNEiSveMx5rE8s/UmjJSUyPyVR1F2ZWWlvpz1vjKiQQcNqb8P66H+qMrMvGj/cbThzq+HyrK1QXJQps4WeGpaUY/l/yIk26ToEogDUx81TYyiwk4iRIoGYA7X3AcIsCT8jfeVAcBalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329231; c=relaxed/simple;
	bh=9mL5zrW/1kL0kbZ7LHMR3IMlLbAp4r/DDRF9xbj7goA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QeJwcGHkFXKiwTvppPXzyk3gn1dTmLHiEoRATbicFibs8n75I0FnGRVsA16TtGmpzvG6ZUSnv8OjCXf7WzZVudaPTueDsIDR+0LUMzlZaImplNQQjnF94gD41ojEQASoerdJVm4EJzQaTMbqF2DmB6TAwkrYJBxnIFg2yD4JiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ltS+Drkh; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240313112707epoutp01b2e3ff789880347a0d4f6966c9abaf47~8T171xPJw0959709597epoutp01w
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240313112707epoutp01b2e3ff789880347a0d4f6966c9abaf47~8T171xPJw0959709597epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710329227;
	bh=z/iX8u48RiPJtssJ/S7+Jur1BNiD0Y0QneJIHgZwemc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltS+DrkhRmpbcJYLNYyF901F1eOXxnrY2nbNdjt7MFshj21Ou8KJDlxu1aZpACp3U
	 DYRfTepd/okpVllkQVk3cFQC3/2wKAshzuu0i5iaABTocbQsxTKtfHck41TMB1NtbG
	 U2w5UWRioK0cc+UiGMANcQF0lFzNuv/Wyo6oLifo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240313112707epcas1p3e218a4a1a7d74ac5d93e2eeae90950df~8T17VEUhJ0101901019epcas1p3p;
	Wed, 13 Mar 2024 11:27:07 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.247]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TvpBf5pYCz4x9Pp; Wed, 13 Mar
	2024 11:27:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.EB.08572.A8D81F56; Wed, 13 Mar 2024 20:27:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6~8T16rGmrQ0994709947epcas1p2f;
	Wed, 13 Mar 2024 11:27:06 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240313112706epsmtrp27aff4350cb0f46f1c58a09a71c5b5963~8T16qdkeQ2918429184epsmtrp26;
	Wed, 13 Mar 2024 11:27:06 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-17-65f18d8a0578
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.15.07368.A8D81F56; Wed, 13 Mar 2024 20:27:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240313112706epsmtip1fdff2586b5837b9f479ee51f70110939~8T16fyx4Q1478114781epsmtip1l;
	Wed, 13 Mar 2024 11:27:06 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Sunmin Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH 2/2] f2fs: truncate page cache before clearing flags when
 aborting atomic write
Date: Wed, 13 Mar 2024 20:26:20 +0900
Message-Id: <20240313112620.1061463-2-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313112620.1061463-1-s_min.jeong@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTX7er92OqwZYDuhanp55lspjavpfR
	4sn6WcwWlxa5W1zeNYfNYkHrbxaLLf+OsFos2PiI0WLG/qfsDpweCzaVemxa1cnmsXvBZyaP
	vi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
	CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5da
	YmVoYGBkClSYkJ3Ru+0gS8EVvorD/86wNjCu5e5i5OSQEDCROLnpMGsXIxeHkMAORolH8/4z
	QTifGCVWfv3MBuF8Y5TYdWM2UIYDrGXdHD+QbiGBvYwSe84rwTUsW3aIDSTBJqAj8XDqbRYQ
	W0TATuLWzUWsIDazwB1GiRUP6kBsYYFEib8r74PVswioSrS+fAs2nxeofv5/HYjr5CVmXvrO
	DmJzCthLvJy4hBnE5hUQlDg58wkLxEh5ieats5lBbpAQ+MkucXfrRFaIZheJmzsnMkHYwhKv
	jm9hh7ClJD6/28sGYRdLHJ2/gR2iuYFR4sbXm1BF9hLNrc1sIAcxC2hKrN+lD7GMT+Ld1x5W
	SDjwSnS0CUFUq0p0P4K4TUJAWmLZsYPsECUeEr0PIiFBNYlR4tVL7gmM8rOQfDALyQezEHYt
	YGRexSiWWlCcm56abFhgCI/S5PzcTYzg9KhlvIPx8vx/eocYmTgYDzFKcDArifDWKX5MFeJN
	SaysSi3Kjy8qzUktPsRoCgzeicxSosn5wASdVxJvaGJpYGJmZGJhbGlspiTOe+ZKWaqQQHpi
	SWp2ampBahFMHxMHp1QDkybfr/5wPo7ta5j/PWgp+b/q5EmDfxuf1B126ziu+WbVxM0bL94K
	5tQofWjNwvroV7Z/stgKVk1D2wRDk5ImuzWeW6KTXVM4LAUmq+xbvfjdYqa0idXSVrvUe/W2
	q/slr5xm5S8kFvf7DuOTRz7/djozmt9Skd2r9WFyVVLTwsPinX+79LI+3ytpev5ni9C1JPft
	a6rX5EoqRocKuu+8v+TlSt5jR9tYdzwLu9MmMaGmY3duj7rwr5m6lnwtP2xndy1Sbyp/nXFf
	4a3xu7UW3qrphnZvfYUmL+1zyTtZMiNUqefx/ae7+mI5Yhb//33L6LpD3OI1jH+Yzly7Hhny
	c93LIzt2hzQZXH+891X1OSWW4oxEQy3mouJEAOR6GSgYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnG5X78dUg4+9Uhanp55lspjavpfR
	4sn6WcwWlxa5W1zeNYfNYkHrbxaLLf+OsFos2PiI0WLG/qfsDpweCzaVemxa1cnmsXvBZyaP
	vi2rGD0+b5ILYI3isklJzcksSy3St0vgyujddpCl4ApfxeF/Z1gbGNdydzFycEgImEism+PX
	xcjFISSwm1Gi+elaFoi4tMSxP0UQprDE4cPFECUfGCXePNzN2MXIycEmoCPxcOptFhBbRMBJ
	4v+NdnaQImaBR4wShxoWghUJC8RL/J3XzwxiswioSrS+fMsEMpRXwE5i/n8dkLCEgLzEzEvf
	2UFsTgF7iZcTl4CVCwGVzJ24nRXE5hUQlDg58wnYLmag+uats5knMArMQpKahSS1gJFpFaNk
	akFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcIBraexgvDf/n94hRiYOxkOMEhzMSiK8dYof
	U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgmtG/KWCr
	gDG/68++LuFpUa27vbmLA9kmhtw+5OzC4vf26HQDzZD1P+Xk3WdyWn681cVc23NB6NCsnQKS
	PNmMHuovHm1fnPAy6rfQH4Hz5ZHXhXgeFjBX9jWzBnxafdNRs+LU5CUL51eosqhMeLb61nXn
	9yu9lYNnpm5Zsyb6S838VYtLmT/eFZxwSzvWuHO6vU/0NNNO6b88D8UKG1QWGmwOMA489GNf
	tvjD4KNPZmufudUVVGB/Y21KolvAnrjyV1qSGlkaukxpzGpmfeIltlOdaw8U7k+bc3mznHq1
	i7OM3JGNUdqNlfrcj+5KsjYunPV6N9/1pqwPH8rdD2ypudL8bl6LXp+qrc+BheeVWIozEg21
	mIuKEwEMcDDM3wIAAA==
X-CMS-MailID: 20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6
References: <20240313112620.1061463-1-s_min.jeong@samsung.com>
	<CGME20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6@epcas1p2.samsung.com>

In f2fs_do_write_data_page, FI_ATOMIC_FILE flag selects the target inode
between the original inode and COW inode. When aborting atomic write and
writeback occur simultaneously, invalid data can be written to original
inode if the FI_ATOMIC_FILE flag is cleared meanwhile.

To prevent the problem, let's truncate all pages before clearing the flag

Atomic write thread              Writeback thread
  f2fs_abort_atomic_write
    clear_inode_flag(inode, FI_ATOMIC_FILE)
                                  __writeback_single_inode
                                    do_writepages
                                      f2fs_do_write_data_page
                                        - use dn of original inode
    truncate_inode_pages_final

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7901ede58113..7e47b8054413 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,6 +192,9 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
+	if (clean)
+		truncate_inode_pages_final(inode->i_mapping);
+
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
@@ -201,7 +204,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	F2FS_I(inode)->atomic_write_task = NULL;
 
 	if (clean) {
-		truncate_inode_pages_final(inode->i_mapping);
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
-- 
2.25.1


