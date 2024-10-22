Return-Path: <stable+bounces-87755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF99AB419
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0179A284412
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A41A4E92;
	Tue, 22 Oct 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BWEb8Sd+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12754FB5
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614913; cv=none; b=MRSzsfsWJFtRAYga4kt5xi420S5dKzgEE0dDWH/QzgPBeRYV6Tw5bkBkw7scUvu45C6GvY5f8z5o5uLemXHgD9R9LI+SrI54eMpXZpZ/0LAYGxdllU59mEOmW745WUOxki2Mq+xy/ZQ7nW7a0XxPh6g8U8Q42LK/AuSrc1AwUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614913; c=relaxed/simple;
	bh=YEGaqXFeFdFYG9REsH1yDX/ZD3rSnchB5tQzRGh+vL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dc0h3VfcU1Zw7tyfcFSnA44llg1my6DNwuemNEQXtjwo5GtiOtFAuOoXRtwKyTa+t43UNt/mI/yY8NuU5eFVR/5LUQn8yTPF8xVRBMet6YqBw/3MmOzQF3JGrb3nm+gJTHjk040DYu21F0+zEQ5cfBJCBrCd7cp2ddpi2S3hzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BWEb8Sd+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729614911; x=1761150911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fqjjI+5sBZSIuqTvLiOPTp0Chgi1KsAWApvWt7Twseo=;
  b=BWEb8Sd+LIDM4hzR+R9md2LilfBsJf+b74g8AkLbB127VQHGVVumEQhz
   yhDeDCsr1mhFI3j5vXi9zPnSldNHJvsPvFw8EdTeHW3UzG4Q1sxI/NFoL
   lehPkjnbBDuWOLpXKUihwInM7riEhFR31Uq0Cplyek3aVSWevK30oj/zv
   c=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="139625415"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 16:35:09 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:10384]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.95.25:2525] with esmtp (Farcaster)
 id 3fca39c1-2b47-4c85-89b8-d4fb14a7f33c; Tue, 22 Oct 2024 16:35:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3fca39c1-2b47-4c85-89b8-d4fb14a7f33c
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 16:35:07 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.253) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 16:35:07 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 22 Oct 2024 16:35:07 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTP id 025DC4030E;
	Tue, 22 Oct 2024 16:35:07 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id B894D9C3F; Tue, 22 Oct 2024 18:35:06 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <jack@suse.cz>, <hch@lst.de>, <tytso@mit.edu>, <sashal@kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 5.10] iomap: update ki_pos a little later in iomap_dio_complete
Date: Tue, 22 Oct 2024 18:33:46 +0200
Message-ID: <20241022163346.125127-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Christoph Hellwig <hch@lst.de>

upstream 936e114a245b6e38e0dbf706a67e7611fc993da1 commit.

Move the ki_pos update down a bit to prepare for a better common helper
that invalidates pages based of an iocb.

Link: https://lkml.kernel.org/r/20230601145904.1385409-3-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
This fixes the ext3/4 data corruption casued by dde4c1e1663b6 ("ext4:
properly sync file size update after O_SYNC direct IO").
reported here: https://lore.kernel.org/all/2024102130-thieving-parchment-7885@gregkh/T/#mfbffb1eda9472c6885ce2c627c302c9eff7bda1f
 fs/iomap/direct-io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5becd..8a49c0d3a7b46 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -93,7 +93,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		if (offset + ret > dio->i_size &&
 		    !(dio->flags & IOMAP_DIO_WRITE))
 			ret = dio->i_size - offset;
-		iocb->ki_pos += ret;
 	}
 
 	/*
@@ -119,15 +118,18 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	}
 
 	inode_dio_end(file_inode(iocb->ki_filp));
-	/*
-	 * If this is a DSYNC write, make sure we push it to stable storage now
-	 * that we've written data.
-	 */
-	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
-		ret = generic_write_sync(iocb, ret);
 
-	kfree(dio);
+	if (ret > 0) {
+		iocb->ki_pos += ret;
 
+		/*
+		 * If this is a DSYNC write, make sure we push it to stable
+		 * storage now that we've written data.
+		 */
+		if (dio->flags & IOMAP_DIO_NEED_SYNC)
+			ret = generic_write_sync(iocb, ret);
+	}
+	kfree(dio);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
-- 
2.40.1


