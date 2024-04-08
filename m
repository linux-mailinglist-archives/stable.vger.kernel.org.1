Return-Path: <stable+bounces-37561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722089C56A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689481C22B5D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA997C6E9;
	Mon,  8 Apr 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xFhd/pY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4B7BAEE;
	Mon,  8 Apr 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584594; cv=none; b=Krhby1CY3qzgiorA/oXZ90VTLbgytjyj44hImYty5YXhr4kphcR6cfGTqw1vzmNrPxJUcB3eaY4/Je77xImTzYOnFaHd7P3JrDHCfYUpx19R/Ry/dN2ixrMmErmMSMs8WSSvNR51TzVaYRRqLXQM6bz8uh2k6Wh2H9yj28Lx93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584594; c=relaxed/simple;
	bh=RUvd+Jm121dn6OgbGq/Ukb9PKHyUKexQjZey5ZIXd4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jex1snrQjIib6B8EaVk0i0xZgtYEzUCaeBH9fCn9MbkLNaDDDUYcBdJm6p1m9fSZF3Y1H6LfvsUZ82qiAeOVn6drHuFR3CZ+arvpi0x6ztkeSOQ9+ZVusD+vpEdfryhr7pQQkh1VduRsMfHNIger0Q1OL3jZpqCcaAekQ79OZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xFhd/pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2214C43399;
	Mon,  8 Apr 2024 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584594;
	bh=RUvd+Jm121dn6OgbGq/Ukb9PKHyUKexQjZey5ZIXd4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0xFhd/pYYCTu0qJ0q2ndgYgHYqZj9lYAhTy490qDsWDY8tmRryjZfSNGVM3lzo/yE
	 DR0WS/WVzOumAmUEOKL5EZ8Cv0W8fOMMe4Cv3Ds2GC6vdkl+VXDZE0TF0bgjUYpaPw
	 NZHphOEzj0qrs3psQNC2T01Uq7hX+oLRt+7YbzLA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 492/690] nfsd: remove the pages_flushed statistic from filecache
Date: Mon,  8 Apr 2024 14:55:58 +0200
Message-ID: <20240408125417.452861543@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1f696e230ea5198e393368b319eb55651828d687 ]

We're counting mapping->nrpages, but not all of those are necessarily
dirty. We don't really have a simple way to count just the dirty pages,
so just remove this stat since it's not accurate.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index b43d2d7ac5957..b95b1be5b2e43 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -57,7 +57,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
-static DEFINE_PER_CPU(unsigned long, nfsd_file_pages_flushed);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
@@ -395,7 +394,6 @@ nfsd_file_flush(struct nfsd_file *nf)
 
 	if (!file || !(file->f_mode & FMODE_WRITE))
 		return;
-	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
 	if (vfs_fsync(file, 1) != 0)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
@@ -1022,7 +1020,6 @@ nfsd_file_cache_shutdown(void)
 		per_cpu(nfsd_file_acquisitions, i) = 0;
 		per_cpu(nfsd_file_releases, i) = 0;
 		per_cpu(nfsd_file_total_age, i) = 0;
-		per_cpu(nfsd_file_pages_flushed, i) = 0;
 		per_cpu(nfsd_file_evictions, i) = 0;
 	}
 }
@@ -1237,7 +1234,7 @@ nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 {
-	unsigned long releases = 0, pages_flushed = 0, evictions = 0;
+	unsigned long releases = 0, evictions = 0;
 	unsigned long hits = 0, acquisitions = 0;
 	unsigned int i, count = 0, buckets = 0;
 	unsigned long lru = 0, total_age = 0;
@@ -1265,7 +1262,6 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		releases += per_cpu(nfsd_file_releases, i);
 		total_age += per_cpu(nfsd_file_total_age, i);
 		evictions += per_cpu(nfsd_file_evictions, i);
-		pages_flushed += per_cpu(nfsd_file_pages_flushed, i);
 	}
 
 	seq_printf(m, "total entries: %u\n", count);
@@ -1279,6 +1275,5 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		seq_printf(m, "mean age (ms): %ld\n", total_age / releases);
 	else
 		seq_printf(m, "mean age (ms): -\n");
-	seq_printf(m, "pages flushed: %lu\n", pages_flushed);
 	return 0;
 }
-- 
2.43.0




