Return-Path: <stable+bounces-215736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJJPBbLgi2kVcgAAu9opvQ
	(envelope-from <stable+bounces-215736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:51:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACCD1208B0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B35C83008332
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D22C15B0;
	Wed, 11 Feb 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8/1joD/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AD29BDA5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774703; cv=none; b=ZoInyS/nYiuIi7wmqwDJ4kr+yByHrAPhdvmhDLLlExdlR0ahwuBLg6VqQ4IPowhJ+pnAlI2MI2iVQBo1/YVlp1nPa7OqiFD1y5S5iCqDFAflS2ihzFTRPvdlSEb/GW4ImTgwFmc+sq8FWdLovtMJuHpVzyHFIWNSSUk417Xjld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774703; c=relaxed/simple;
	bh=aeazTpxisGRJ4cM7R4dFbxvIEp42mH8LnFF3RNc2J/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=begpzxmsPUtQX/2aRtJKY/x9tHO4G6ILFPeIuhQRnQ/7flM4Q8VZTVo3QOszsFo/wzIVpUrzQkSlkPhIV72kFuhnYR7oX0NuBU14k9hPOWnWx3cRatIllS8ZU8HXiqYJ7ulSiV/lL4BUyD4yjAtStK0FPDl8iLsYN7XuF1NWRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8/1joD/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-794fe698e36so15928467b3.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 17:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770774701; x=1771379501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGhMFSn6RfxMnoUYJqlK2uZRccorF8Z8vHJFhcv6GqU=;
        b=J8/1joD/xXreqabLnuhqZNMxGzTcElOvGEBiEySjowZ/Dh4xcnmMRWxrufQIF8K7Z3
         sHvbt0h2Bl0M5sxwxWjspfbEOU75d7g9znaZICPscbpOWZ2pe40pET0DBss3uQXg3kS/
         xBWcrd3JDBQ9Eub90vCzVazFpAmXP0BU4emKJfYHMcCHFGa0A4aMfOeCM/rBF3iXrvDn
         g3/nKicTDVr43KJ8jP2zDPDfXJhorzjO10+IAwRInnCb31kPhx+7jxJkKot4mPO2k3+e
         oZ1KblD2NosxAx5QB8eQNt77Vo8RTK4YdOycrGk52OnvsBYbo2yQM+7ECCJNFDwC2kZP
         Mi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774701; x=1771379501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGhMFSn6RfxMnoUYJqlK2uZRccorF8Z8vHJFhcv6GqU=;
        b=uptg2FCXxLZpdnzvm3DxVtIgqqEWumVaQRYIra64Dob96wkCW+7NJPvPGfrlc3u33n
         s4jlN/VYvX+r94wWKzMBHD4WICm7ugG7z3YcwIawt1DDnFNr/ja837TrsiVhdjmA/Jm8
         82Ok2IRSZQ8f6WKFz1U+zKPdlZn7boBMU81sSM+WuCIyPhV7H8mBrALFA1fpcbsbwCnC
         0ZwdvpVVpXCCVVS0DRAbJBY8mn9LpsIUnznLn7phQRjpHinwsYFGhgk8rd+nRAS1i7eB
         wybiTEIBZITrxVOmN4iSLbpZ+mptgx4amgbWE7RBQO4y37u2DI/Yu5jffuRTFA6GlA9i
         S/wA==
X-Forwarded-Encrypted: i=1; AJvYcCU62qBRNRZ1xQ5Mk2dwzcQFrwBpkh2C6HJdNN/4FPrbdtGz4BzhdUpHIeHrsl2OYDwPbb3Zdjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHpmoUmyxcioObms1qX24yp1e1wf6woItAoaihyYQZd24WIpo
	dGeFic9Io7xdomXV+jG0NNiF5Ug5sbn15LQYYihFPDQLHXSLmpeynOia
X-Gm-Gg: AZuq6aJYmVAGZzthnpHNenTWKr+6gSVchMCN1EKvl7MEp6AX9wagqtXd0tdMQHe4hSr
	xB/k04CBvITlJddRYa7cnrcjfOmyAe382HfOxUeTWS2zd5Pddu8cxTm5pFgZi3id3bd4qjpSarl
	bdU38o423StAxG0FVpKegdPL8y5Ke1klQ41+JZXMvqL4HquBOFVsXjvZS5bZNFzN6gRjZuFaap5
	4KDPlnos6h2Ww//fbrRmh2fDbr0ByZQA/53tvZ2KW2r75Lyy6PdIvMMy7TyQZ4za4AeGablq2hZ
	SsWt4K5Bm6MebgFpv2Wd1QRTcz0zfjzQ8dsm32nM03goCWWNgGOSbf4BKe9rjUvt3DjQapYYJ3C
	mD9I034ZX1waoppbhF6VGQkJ38Hn82NrRmoKpSpRkch+LTGFVEI2CipP9E6AyAVN5p2OQn26Rta
	4TVhRJ8CCq80/NoBk/IELj/iR41GmQTmOs22R4wwX9grZhqhs=
X-Received: by 2002:a05:690c:102:b0:796:3842:acc5 with SMTP id 00721157ae682-7963842e384mr109295857b3.41.1770774700832;
        Tue, 10 Feb 2026 17:51:40 -0800 (PST)
Received: from 5163NRD-SPRABHU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e7c6sm3751557b3.1.2026.02.10.17.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:51:40 -0800 (PST)
From: sw.prabhu6@gmail.com
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	pankaj.raghav@linux.dev,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	Swarna Prabhu <sw.prabhu6@gmail.com>,
	stable@vger.kernel.org,
	Swarna Prabhu <s.prabhu@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/2] scsi: sd: fix write_same(16/10) to enable sector size > PAGE_SIZE
Date: Tue, 10 Feb 2026 17:50:42 -0800
Message-Id: <20260211015043.2608866-2-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260211015043.2608866-1-sw.prabhu6@gmail.com>
References: <20260211015043.2608866-1-sw.prabhu6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,acm.org,gmail.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-215736-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[swprabhu6@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: AACCD1208B0
X-Rspamd-Action: no action

From: Swarna Prabhu <sw.prabhu6@gmail.com>

The WRITE SAME(16) and WRITE SAME(10) scsi commands uses
a page from a dedicated mempool('sd_page_pool') for its
payload. This pool was initialized to allocate single
pages, which was sufficient as long as the device sector
size did not exceed the PAGE_SIZE.

Given that block layer now supports block size upto
64K ie beyond PAGE_SIZE, initialize large page pool in
'sd_probe()' if a higher sector device is attached ensuring
atomicity. Adapt 'sd_set_special_bvec()' to use large page
pool when a higher sector size device is attached.

With the above fix, enable sector sizes > PAGE_SIZE in
scsi sd driver.

Cc: stable@vger.kernel.org
Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/scsi/sd.c | 79 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f50b92e63201..0e0c5dd1c668 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -112,8 +112,11 @@ static void sd_shutdown(struct device *);
 static void scsi_disk_release(struct device *cdev);
 
 static DEFINE_IDA(sd_index_ida);
+static DEFINE_MUTEX(sd_mutex_lock);
 
 static mempool_t *sd_page_pool;
+static mempool_t *sd_large_page_pool;
+static atomic_t sd_large_page_pool_users = ATOMIC_INIT(0);
 static struct lock_class_key sd_bio_compl_lkclass;
 
 static const char *sd_cache_types[] = {
@@ -922,14 +925,27 @@ static void sd_config_discard(struct scsi_disk *sdkp, struct queue_limits *lim,
 		(logical_block_size >> SECTOR_SHIFT);
 }
 
-static void *sd_set_special_bvec(struct request *rq, unsigned int data_len)
+static void *sd_set_special_bvec(struct scsi_cmnd *cmd, unsigned int data_len)
 {
 	struct page *page;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct scsi_device *sdp = cmd->device;
+	unsigned sector_size = sdp->sector_size;
+	unsigned int nr_pages = DIV_ROUND_UP(sector_size, PAGE_SIZE);
+	int n = 0;
 
-	page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
+	if (sector_size > PAGE_SIZE)
+		page = mempool_alloc(sd_large_page_pool, GFP_ATOMIC);
+	else
+		page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!page)
 		return NULL;
-	clear_highpage(page);
+
+	do {
+		clear_highpage(page + n);
+		n++;
+	} while (n < nr_pages);
+
 	bvec_set_page(&rq->special_vec, page, data_len, 0);
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 	return bvec_virt(&rq->special_vec);
@@ -945,7 +961,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	unsigned int data_len = 24;
 	char *buf;
 
-	buf = sd_set_special_bvec(rq, data_len);
+	buf = sd_set_special_bvec(cmd, data_len);
 	if (!buf)
 		return BLK_STS_RESOURCE;
 
@@ -1034,7 +1050,7 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	if (!sd_set_special_bvec(rq, data_len))
+	if (!sd_set_special_bvec(cmd, data_len))
 		return BLK_STS_RESOURCE;
 
 	cmd->cmd_len = 16;
@@ -1061,7 +1077,7 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	if (!sd_set_special_bvec(rq, data_len))
+	if (!sd_set_special_bvec(cmd, data_len))
 		return BLK_STS_RESOURCE;
 
 	cmd->cmd_len = 10;
@@ -1507,9 +1523,15 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 static void sd_uninit_command(struct scsi_cmnd *SCpnt)
 {
 	struct request *rq = scsi_cmd_to_rq(SCpnt);
+	struct scsi_device *sdp = SCpnt->device;
+	unsigned sector_size = sdp->sector_size;
 
-	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		mempool_free(rq->special_vec.bv_page, sd_page_pool);
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		if (sector_size > PAGE_SIZE)
+			mempool_free(rq->special_vec.bv_page, sd_large_page_pool);
+		else
+			mempool_free(rq->special_vec.bv_page, sd_page_pool);
+	}
 }
 
 static bool sd_need_revalidate(struct gendisk *disk, struct scsi_disk *sdkp)
@@ -2920,10 +2942,7 @@ sd_read_capacity(struct scsi_disk *sdkp, struct queue_limits *lim,
 			  "assuming 512.\n");
 	}
 
-	if (sector_size != 512 &&
-	    sector_size != 1024 &&
-	    sector_size != 2048 &&
-	    sector_size != 4096) {
+	if (blk_validate_block_size(sector_size)) {
 		sd_printk(KERN_NOTICE, sdkp, "Unsupported sector size %d.\n",
 			  sector_size);
 		/*
@@ -4044,6 +4063,21 @@ static int sd_probe(struct device *dev)
 	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
 
 	sd_revalidate_disk(gd);
+	if (sdp->sector_size > PAGE_SIZE) {
+		mutex_lock(&sd_mutex_lock);
+		if (!sd_large_page_pool) {
+			sd_large_page_pool = mempool_create_page_pool(
+					SD_MEMPOOL_SIZE, get_order(BLK_MAX_BLOCK_SIZE));
+			if (!sd_large_page_pool) {
+				printk(KERN_ERR "sd: can't create large page mempool\n");
+				error = -ENOMEM;
+				mutex_unlock(&sd_mutex_lock);
+				goto out_free_index;
+			}
+		}
+		atomic_inc(&sd_large_page_pool_users);
+		mutex_unlock(&sd_mutex_lock);
+	}
 
 	if (sdp->removable) {
 		gd->flags |= GENHD_FL_REMOVABLE;
@@ -4061,6 +4095,14 @@ static int sd_probe(struct device *dev)
 	if (error) {
 		device_unregister(&sdkp->disk_dev);
 		put_disk(gd);
+		if (sdp->sector_size > PAGE_SIZE) {
+			mutex_lock(&sd_mutex_lock);
+			if (atomic_dec_and_test(&sd_large_page_pool_users)) {
+				mempool_destroy(sd_large_page_pool);
+				sd_large_page_pool = NULL;
+			}
+			mutex_unlock(&sd_mutex_lock);
+		}
 		goto out;
 	}
 
@@ -4101,6 +4143,7 @@ static int sd_probe(struct device *dev)
 static int sd_remove(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	struct scsi_device *sdp = sdkp->device;
 
 	scsi_autopm_get_device(sdkp->device);
 
@@ -4110,6 +4153,16 @@ static int sd_remove(struct device *dev)
 		sd_shutdown(dev);
 
 	put_disk(sdkp->disk);
+
+	if (sdp->sector_size > PAGE_SIZE) {
+		mutex_lock(&sd_mutex_lock);
+		if (atomic_dec_and_test(&sd_large_page_pool_users)) {
+			mempool_destroy(sd_large_page_pool);
+			sd_large_page_pool = NULL;
+		}
+		mutex_unlock(&sd_mutex_lock);
+	}
+
 	return 0;
 }
 
@@ -4446,6 +4499,8 @@ static void __exit exit_sd(void)
 
 	scsi_unregister_driver(&sd_template.gendrv);
 	mempool_destroy(sd_page_pool);
+	if (sd_large_page_pool)
+		mempool_destroy(sd_large_page_pool);
 
 	class_unregister(&sd_disk_class);
 
-- 
2.39.5


