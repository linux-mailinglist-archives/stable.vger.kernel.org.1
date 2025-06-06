Return-Path: <stable+bounces-151566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C99ACFAC9
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386BF189AFAD
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AC2BD1B;
	Fri,  6 Jun 2025 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bq5TnVtV"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628DDDC3
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173864; cv=none; b=XyVloH8tmxqRcYOjcC7MHrGdnMgeeimtP1Os/EEixerwuxv/vJZQzqUcEwQ+1AhzdiOt7sKc5zVAqiRUhsXtxS3DfU3Tz3kqkDiasir4FABFCCTzkXZRaBxGJ/SfKIkBzqlM9VbLmBWszM1RdnjnL7RfR1VAmai3umoBagzAQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173864; c=relaxed/simple;
	bh=rU53L3BUdNsvRvKjs1p3GQ82tOLLY5OqBKm4TnUKetE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XyVUYJ4MYVW25zSiI1RNnmrGfFFQTZFXXMYUes2xwVEx01dT8UoR9aSbVQoCUe/5V+QXrgksY0xOzAFL8yV+DaJeRMO0HlYiDoBfJXNwlsXjFXqGx+/SSdYUsNXZLhKlEkEzQ72PbJi5kouplA3uRaLqSK4ZvghWtVoVLA+a13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bq5TnVtV; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749173555;
	bh=a5PmcZuhN7gRvm7WfcdPqPsL0XXs87K7sSoG1KeeijQ=;
	h=From:To:Cc:Subject:Date;
	b=bq5TnVtVw8q9rXKPiMtCl8BbU2zf8PwJchPAc6FnsfOzkBOwkGs9AH0qdwbuHRBrI
	 7BmCF9XfP33JxmjK13BOFq0WpMPU4KiVW+JjrrQm/X4ZHvvrc7gjI6E7tX1IEzRDfT
	 bdgh9MF2Jx4BTCDkdz/C53YW14JEPXHEyhVvqq+I=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.17])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 80AB4C14; Fri, 06 Jun 2025 09:32:10 +0800
X-QQ-mid: xmsmtpt1749173530tehw3azif
Message-ID: <tencent_9DBF1F0C925FD68D381D304A0D6CB4993508@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9OttY7N8cstWb2PZ0q13E0kYlt95lgfEHzlMrEegRW/0+Awsngm
	 C0/RaKpQK50KZH5yNo6jFqoThmC8WKueE2MlPxDTruHAk+R3gpDacNujBZIRaSnw1Xw6r0VxpK8G
	 pI+7uW653DJCZQnFykwW+IPVx1grxw0SMzZZzCoULZlKyPSXzVaippBI2AaKF+8Db3oNkBEqmQ32
	 08OHSKmg0q5qv8pJydIQjyw6/AAY0taVs4vBVx/lwG9u3zqeGTdwxhb76P5efn1WJPPeggyoiOTA
	 wT8xOJV5iySa7Kf2ZBB2HWC3yQyrf9rA2//NJXX5hlf2W1e8LAcGOI899meH6GZERx7g/wToOLZq
	 BjYkXT9TnllVii1dYQiKNgqGplXU5reeQHBYBFnkXX82X+olGOjMCtMuEFVWWhYp6BqS0Jwbgtak
	 +qGaxm7gefK4i4JRMWQfCkB3Gyp1Y28lWG5O4pc32Tv7tBsUOR7uDG22gElgcgAW80TKT1lOmmdZ
	 ymqK2vvrDx564IbOzw0dQHAG08BseEtZJ/rn+VnXgNJsHdoidI8iAZ7/10K+uHJiSkpJC1Nz/Tlo
	 Bj+EA6IVZ677YfYjFYxgJXT0lgZw1M8sQzTpse5wg4MBvR8eGSmYh4wxoMOoscrVxlvuvpZQp9dX
	 kqaR0jL78Ow0xxfV4aPVJS+wrM+b4f6FmGnpSb329bOKDwu0uuNX0gn87ULf8MWsWh6XDVOYp5B0
	 CZJxVv6Vj1S5d6Ya5EoX4xvJaCbIpj4yIkgG1Pa7vUDqL0aRzrV9aBnRj4z1ZCsZPACHT/3hMsXI
	 qVgwHxnmZjBH1+UmVVcHtr7IJJpIPntZMmHovNCLqGQyAYeDsdSFNF+Te+ebOgEs5hmauHJJ0ymR
	 WuUYwpEKjSHPy9Aa346HsMX0n2pgowDPkrfGo2ugRq8e+q5xL1Afm/14uOa1UKVbYqgoLnYJNai+
	 3iR03WMvYnxByfMzR+Or/BEu98MHtHLElTe4gvpf4WmRfhz+smjZD8Im1WBAhQeWbLJgEA9bF7f3
	 v+nNtMEw197+wlC3BKioghs+bEJp0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] block: fix adding folio to bio
Date: Fri,  6 Jun 2025 09:32:09 +0800
X-OQ-MSGID: <20250606013209.17758-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 26064d3e2b4d9a14df1072980e558c636fb023ea ]

>4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
is supported, then 'offset' of folio can't be held in 'unsigned int',
cause warning in bio_add_folio_nofail() and IO failure.

Fix it by adjusting 'page' & trimming 'offset' so that `->bi_offset` won't
be overflow, and folio can be added to bio successfully.

Fixes: ed9832bc08db ("block: introduce folio awareness and add a bigger size from folio")
Cc: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20250312145136.2891229-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
The follow-up fix fbecd731de05 ("xfs: fix zoned GC data corruption due
to wrong bv_offset") addresses issues in the file fs/xfs/xfs_zone_gc.c.
This file was first introduced in version v6.15-rc1. So don't backport
the follow up fix to 6.12.y.
---
 block/bio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 20c74696bf23..094a5adf79d2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1156,9 +1156,10 @@ EXPORT_SYMBOL(bio_add_page);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off)
 {
+	unsigned long nr = off / PAGE_SIZE;
+
 	WARN_ON_ONCE(len > UINT_MAX);
-	WARN_ON_ONCE(off > UINT_MAX);
-	__bio_add_page(bio, &folio->page, len, off);
+	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 
@@ -1179,9 +1180,11 @@ EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		   size_t off)
 {
-	if (len > UINT_MAX || off > UINT_MAX)
+	unsigned long nr = off / PAGE_SIZE;
+
+	if (len > UINT_MAX)
 		return false;
-	return bio_add_page(bio, &folio->page, len, off) > 0;
+	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
 }
 EXPORT_SYMBOL(bio_add_folio);
 
-- 
2.34.1


