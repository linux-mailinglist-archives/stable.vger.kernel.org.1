Return-Path: <stable+bounces-148127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDFAC85C4
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AEF1BC31AD
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 00:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D03597B;
	Fri, 30 May 2025 00:54:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE633985
	for <stable@vger.kernel.org>; Fri, 30 May 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748566479; cv=none; b=WbDxy4w4DZSENiBEH2bvZ7zOwu5Pn7fAN8TIrtjaySIQ9SeoApf8tbzH9T40P+YRN/oYhTa/MhDanONzMqxF2lIAlKRFPTcMIzfcy8zcTIJbCsx3Ff7byPfDvPu9IMjhnACSWJHSFuF76oj1e2wbU7D30gFOCC/3mSHXibwmQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748566479; c=relaxed/simple;
	bh=/vDECSUspR5a86NpfiK+RCUspBu8M69pZMTkwi3DRy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzSBu8Swvi7LrHPuU5BqwDcf33neLoHn8lCEwNDKk7gQIB/h+gm84WcSA3RvYdjINnVa9bozXYgFsaxfBm0B+jIJaLyQBgb2kGhGPAB/UIHTHpJ0BtYUGDG0XYbyYIEbrtfkamBX2qki1+dp+Ph18HGbOgLlkZXFP87vi3I0cAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b7l611vRCzCtd3
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:50:49 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3892F180238
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:54:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 08:54:34 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.4.y 2/2] smb: client: Reset all search buffer pointers when releasing buffer
Date: Fri, 30 May 2025 08:54:34 +0800
Message-ID: <20250530005434.773389-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20250530005434.773389-1-wangzhaolong1@huawei.com>
References: <2025052437-platform-elastic-f5d2@gregkh>
 <20250530005434.773389-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Multiple pointers in struct cifs_search_info (ntwrk_buf_start,
srch_entries_start, and last_entry) point to the same allocated buffer.
However, when freeing this buffer, only ntwrk_buf_start was set to NULL,
while the other pointers remained pointing to freed memory.

This is defensive programming to prevent potential issues with stale
pointers. While the active UAF vulnerability is fixed by the previous
patch, this change ensures consistent pointer state and more robust error
handling.

Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit e48f9d849bfdec276eebf782a84fd4dfbe1c14c0)
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 fs/cifs/readdir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 157aae931a18..c3156f602b20 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -619,11 +619,14 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 				cifs_small_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
 			else
 				cifs_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
+			/* Reset all pointers to the network buffer to prevent stale references */
 			cfile->srch_inf.ntwrk_buf_start = NULL;
+			cfile->srch_inf.srch_entries_start = NULL;
+			cfile->srch_inf.last_entry = NULL;
 		}
 		rc = initiate_cifs_search(xid, file);
 		if (rc) {
 			cifs_dbg(FYI, "error %d reinitiating a search on rewind\n",
 				 rc);
-- 
2.34.3


