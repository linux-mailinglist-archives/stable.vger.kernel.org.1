Return-Path: <stable+bounces-148122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2AAC85AF
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 02:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896743B11B1
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 00:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F258F40;
	Fri, 30 May 2025 00:32:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08803A59
	for <stable@vger.kernel.org>; Fri, 30 May 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748565137; cv=none; b=ryxr44YEuX437k3mcQWk6jmGh5TfdALbK9COgUVLaeQPrcsReTSnN3Dm0XKe5as8KEkyUUvSxVJFyUmtk9HAe4iAF7Sz3jOqMKnVHT2rZz8LbgV71Ea8WgBg7/aLQYxW4iWneux4LXvfilomdVCS19lyKHGua0CqbP0N2bBZpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748565137; c=relaxed/simple;
	bh=VUAY2kbT5Trolsfe0519/FsRVJ7m/y50F2UnX8kbbNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWD0bT5ETVw0EeL2mq1xn3vihqUo0mpd5js8sgYplNsu1zpJnu7w3WVzvZTjaKadXYbUMq5DMVs9cjFK6lzJIHJrU2hzDjO1BQ7WTLjPGeCqfOJQbRcOwgnFqZe6kwC9nMaO6n9tyRatHAB9Z7rWnYbPggVHGcf7uMroybFSlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b7kfM2SSdz1d1H0
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:30:19 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C30E140118
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:32:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 08:32:05 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 2/2] smb: client: Reset all search buffer pointers when releasing buffer
Date: Fri, 30 May 2025 08:32:04 +0800
Message-ID: <20250530003204.607177-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20250530003204.607177-1-wangzhaolong1@huawei.com>
References: <2025052432-deafening-parted-13e0@gregkh>
 <20250530003204.607177-1-wangzhaolong1@huawei.com>
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
---
 fs/cifs/readdir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index de6077ab7cd6..6aa3c267f4ca 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -760,11 +760,14 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
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
 		rc = initiate_cifs_search(xid, file, full_path);
 		if (rc) {
 			cifs_dbg(FYI, "error %d reinitiating a search on rewind\n",
 				 rc);
-- 
2.34.3


