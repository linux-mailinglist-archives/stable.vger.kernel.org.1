Return-Path: <stable+bounces-111223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111CA22438
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316237A2454
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C551E25FE;
	Wed, 29 Jan 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX0HPjMV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127631E0DE3
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176466; cv=none; b=e5hDSh+2l9gfTAZyue9w2eZR7oGNRWfStfNAX5sXPQEngUt/HOQjQN+9vg6PdG0gTJbp6ITcGE+t1OOIGJE99UbAusxtMYNc2nDaq6dGLSKh2n22BOqEaZfG/J0szTuUlrExhqmtU/GBh28roAnV/8GofRhwWJqf5a7e6a8WOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176466; c=relaxed/simple;
	bh=nlKAKjE149Af2XC0RpXacMY4QDyb3HAXsiSCZSJSCWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/XcWBKy6UC90ZuPLnXRRuac+Zkpv6TiHBnY0i4paubpoHYpwoZDH5wMTKUJ122NKqlECxOV3PcgT9gDII3PcJywvNZwUexyizkIEX7U8r8mvPnK1/bKVqYr106D1WdFFlFfN9eEhGs32rdFbbQ1xN26d1RHH5b4l+D7FEazY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX0HPjMV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso14169795ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176464; x=1738781264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsqNBTxTg5VLgSF/MQnVgayF14la3OeWniqWubX/tuQ=;
        b=IX0HPjMVsBlcfZ1lDb29mmE6x96by4334K0v+HtIr+OX3fkC0s+gX9LtHQx54Ix3ap
         cJrAhsSGuaIcmksTkiMt5i1YG/wm9/p23dJZPqnhOzJWKQGKkulGpZso7i/jz/EDDj/d
         yitvv9jnmC7vIZfjFfIGvzIkgi3FLkSPhUo6G8J6y1dUpH0n9Blbuq//uBaJo+P6MWRz
         UVi/MZmoOcvVZR/BaG1c9Z9+NeP+Q7qIkB5w3D2eHaKeP1QgJzq+pD4+q07dl3xjxggO
         5XyLjt0ekWD1NNJlFPfbaQXajkVuwItdp7+MrhIXnJUCE2EvEunk+TJDlcZdsm3gmDQ3
         xxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176464; x=1738781264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsqNBTxTg5VLgSF/MQnVgayF14la3OeWniqWubX/tuQ=;
        b=Kz3vvlx385GegmzxHtdeJvwaG/anMUrhm5WTsCnm4kfjcq8VitvIngcbceFaHVkmLl
         evs2sz4JGZNviHrzferwrKejw8SlsDqPmtaChyEoDq5pfip63vHbHX917XW6Ys31gLTx
         1VJpKNwm7pLvI1qNmwHJeJzAy/jMWwlDSpAfqf8Xd1h86XImpRWBiJu5aKrIdBAtC+NY
         DMF9bS6u+rv6C9iHhLhmWIorj7/Wkv7IU5EfcUT5FgThaFk2fudnrckdO5afjVWIyzZ+
         fC3+HhYfy+cvG0zsteBMOH3x0CBQ2m92G2w0LG3kkXZBYFbEIuKMz97GfzpUv29p7KSl
         PuIw==
X-Gm-Message-State: AOJu0YwpxTpAW02U7y09F2vH2zirwajv7+ydMTzyrvpvhNhhGmdQmqvg
	0HN4LUcKrelPPL5rd2qWhfFepIa7405NGKUINTQExxLW5NADv/SaLoypVkMp
X-Gm-Gg: ASbGncvTHi8wQWUL5zj5FzqMztOr7RhMjBkxLKhHURE94HVS7nM+NRnbE2BVfPNPxad
	xGA6AmnzhmIyYC7gpsn0TQ8h94wzm3/RdZb1HD3wIFtttdc4AzZNhIXubHR6d7i9sFjpLsnx/Mz
	wRJuoxAt7Vpc1Cq+ffPG8PSLvt1TLGLUBSFBvNgQo07cL3YwQIyS2nwdynt7ucjNlNf//+6ICDZ
	x9AOydbU207gJhD/WCSUPPaeCVg2NCTXkcIQOgiLfSQTxxmdPxjy5rJnvChAMRgNYYmMu9NlpL0
	Uo/3YvJOESZKcCHEeLHIz8Kpig+X6P+RPaPeO+F1WpQ=
X-Google-Smtp-Source: AGHT+IGPnQhWsdghC4PFXwd5zfxo3Z6suAaDZl8cwq2SUR9MVZ9dljTgropIVJwiMXceIW6Tc/O4PA==
X-Received: by 2002:a17:902:f70f:b0:212:996:353a with SMTP id d9443c01a7336-21dd7c653acmr73252985ad.12.1738176464080;
        Wed, 29 Jan 2025 10:47:44 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:43 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Leah Rumancik <leah.rumancik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH 6.1 13/19] xfs: up(ic_sema) if flushing data device fails
Date: Wed, 29 Jan 2025 10:47:11 -0800
Message-ID: <20250129184717.80816-14-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 471de20303dda0b67981e06d59cc6c4a83fd2a3c ]

We flush the data device cache before we issue external log IO. If
the flush fails, we shut down the log immediately and return. However,
the iclog->ic_sema is left in a decremented state so let's add an up().
Prior to this patch, xfs/438 would fail consistently when running with
an external log device:

sync
  -> xfs_log_force
  -> xlog_write_iclog
      -> down(&iclog->ic_sema)
      -> blkdev_issue_flush (fail causes us to intiate shutdown)
          -> xlog_force_shutdown
          -> return

unmount
  -> xfs_log_umount
      -> xlog_wait_iclog_completion
          -> down(&iclog->ic_sema) --------> HANG

There is a second early return / shutdown. Make sure the up() happens
for it as well. Also make sure we cleanup the iclog state,
xlog_state_done_syncing, before dropping the iclog lock.

Fixes: b5d721eaae47 ("xfs: external logs need to flush data device")
Fixes: 842a42d126b4 ("xfs: shutdown on failure to add page to log bio")
Fixes: 7d839e325af2 ("xfs: check return codes when flushing block devices")
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_log.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 59c982297503..ce6b303484cf 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1889,13 +1889,11 @@ xlog_write_iclog(
 		 * the log state machine to propagate I/O errors instead of
 		 * doing it here.  We kick of the state machine and unlock
 		 * the buffer manually, the code needs to be kept in sync
 		 * with the I/O completion path.
 		 */
-		xlog_state_done_syncing(iclog);
-		up(&iclog->ic_sema);
-		return;
+		goto sync;
 	}
 
 	/*
 	 * We use REQ_SYNC | REQ_IDLE here to tell the block layer the are more
 	 * IOs coming immediately after this one. This prevents the block layer
@@ -1921,44 +1919,47 @@ xlog_write_iclog(
 		 * writeback from the log succeeded.  Repeating the flush is
 		 * not possible, hence we must shut down with log IO error to
 		 * avoid shutdown re-entering this path and erroring out again.
 		 */
 		if (log->l_targ != log->l_mp->m_ddev_targp &&
-		    blkdev_issue_flush(log->l_mp->m_ddev_targp->bt_bdev)) {
-			xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
-			return;
-		}
+		    blkdev_issue_flush(log->l_mp->m_ddev_targp->bt_bdev))
+			goto shutdown;
 	}
 	if (iclog->ic_flags & XLOG_ICL_NEED_FUA)
 		iclog->ic_bio.bi_opf |= REQ_FUA;
 
 	iclog->ic_flags &= ~(XLOG_ICL_NEED_FLUSH | XLOG_ICL_NEED_FUA);
 
-	if (xlog_map_iclog_data(&iclog->ic_bio, iclog->ic_data, count)) {
-		xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
-		return;
-	}
+	if (xlog_map_iclog_data(&iclog->ic_bio, iclog->ic_data, count))
+		goto shutdown;
+
 	if (is_vmalloc_addr(iclog->ic_data))
 		flush_kernel_vmap_range(iclog->ic_data, count);
 
 	/*
 	 * If this log buffer would straddle the end of the log we will have
 	 * to split it up into two bios, so that we can continue at the start.
 	 */
 	if (bno + BTOBB(count) > log->l_logBBsize) {
 		struct bio *split;
 
 		split = bio_split(&iclog->ic_bio, log->l_logBBsize - bno,
 				  GFP_NOIO, &fs_bio_set);
 		bio_chain(split, &iclog->ic_bio);
 		submit_bio(split);
 
 		/* restart at logical offset zero for the remainder */
 		iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart;
 	}
 
 	submit_bio(&iclog->ic_bio);
+	return;
+shutdown:
+	xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
+sync:
+	xlog_state_done_syncing(iclog);
+	up(&iclog->ic_sema);
 }
 
 /*
  * We need to bump cycle number for the part of the iclog that is
  * written to the start of the log. Watch out for the header magic
-- 
2.48.1.362.g079036d154-goog


