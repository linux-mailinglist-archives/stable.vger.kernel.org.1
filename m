Return-Path: <stable+bounces-248964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKQiLYXSB2reKAMAu9opvQ
	(envelope-from <stable+bounces-248964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80C559DB4
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572AC301953D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D0282F31;
	Sat, 16 May 2026 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITab6yJW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E826ED37
	for <stable@vger.kernel.org>; Sat, 16 May 2026 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897538; cv=none; b=p3v6wKuNDDioXdQDQ3f9Y0PDkWwhPJf77zPCv2qqr12M5S6QOedJh+wHK+5bz++5aGchAhEDwbCoSSLGuFaCJerVoXGSkNXNuT86jNJc5IbKYjx5mWdfH2pj7maHa15s6mlJe0m0/dCrLt0Lw62CjwklrImOg3107Sxy3Cc4WKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897538; c=relaxed/simple;
	bh=AHd5YeVtutAbZkxadD/aQY5HB+EyJsk8qeRwSqLawfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2EY5wTeNwF94jyk/tb12zsyX3wotl3uxlECWrjdqDdYF20R2i/74BRm5vDQcxtTDOcB4lqaa1ABQzznLgCQCrcqUPFjMkKUb5IbydlnQq2uOn150UiNXDECc01xB1cyanXaOL3XNvsKSjP2CIZohP/kFQLarZvV+UUrcKXdnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITab6yJW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bf1eaba464so653257b3.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 19:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778897535; x=1779502335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwMIyvXLF7QVH+M7je+E+kLYonxVYHkOjT0cHPKyEmk=;
        b=ITab6yJW5oyOBuXAB8IXhp4Rlp6SfZ47OF9mMEVrbinRnR4Rb0C6crgMsrcJQZtC0b
         fiu3Go1SlX16PQSbtvT2o+fZ3rHhGbTtan2cdIwFstxkz5HHgCW3a9LsKPOxAeG3EqGP
         pWh3YDHJYIOob6BBUSIDV9khBqaCRTJxV0gFXCNCuYyzw76st0dIourBS3VKJ1yhVKW4
         6x7dXxoBifwn6vhIAxpiyoeF6P10kagNFbiV2jEx43+vmg87DOVlGD7PhEkuoFOqVxdW
         +ZPJ/pwenI7dPA3D7tmCeCY2CCQPXkdlN+5OSvt0++tvxU+Mbfehi8HrLmHPIPQFay53
         Unsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778897535; x=1779502335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwMIyvXLF7QVH+M7je+E+kLYonxVYHkOjT0cHPKyEmk=;
        b=rcJDWliNJ1xPZlGRVAuAMcdSl/XHrWNozb4Htk9LaqNiYge2e3eRPTnnR1IAdl4oYx
         Y6aotXygb6lPtU9KdL5X+X/CoztGylT0GOYuGLRuyqW3IeduDrVmwioqEz4txdt8uA0p
         eEUiVZckX/qlQ+wjARaF74x2mXtA/25wSC6/5Dt/1dDtLuM7ijEFohrDi0EU0nodR6vj
         p8CIHrsnOWBoLN+d4Er49L7A2Jk279XGanGGwhAInrI65kLFVIB7/P2KTCMYBO6UcbSX
         HMiSUzTXzopkOgAOsECuOTbKgdI41SH5r/U9lcygK9/suVch8R4QC7C2W8K3/GKT2uje
         emdg==
X-Forwarded-Encrypted: i=1; AFNElJ/vmgwF0y8mUB1BdO3bs39iLKlcqgmOb5mpx7H1e3a6iYrGQseU0ZomaVcobd3rJc/yejJZPwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndWbSEx/vpYiHr9BARjJD4crJGGoI83lrJav6JYD7Xd07jqXM
	pJGWyAlI3nfeYPCfMNfekkCaclBaSsnw/KJFb+0BJyiIASMeygf7cgfw
X-Gm-Gg: Acq92OGfASAPY8DfXAZ6asjfOrwFgjjtuEzFhNASEnQLCXEPPYL7uzztW/mMzYmS8G1
	hXOFgCVh2UcftxgLk+5txr6cAvlLMv2BKUdVbRmE2d0hP/BjbUxFbeQGW0VN8C4zhFMhzFouR8G
	//Ty5LF1GJcArUyKG1S1jN3GTSX0/KbHfE29ecvVceVCf4SVWNVtFrxsVHfXZIMHhmoeCF338YA
	5TRyITzTCQ23nwjkihJ5Dw4X61uU4G37kWXgYFN9a1dOPZ/8yJbiLcd9Aft2UMDxPPkYEJHQlTy
	fMYiBcJjt1BtICV9WRggDqO6oK4K7mTNJyaAOf2xubo6siSXexm5ul3HD2YOdBQHsVVbsEeOj3A
	L2Haw/OFo2tllJSTYabhN3q+YgBeeI20bQ48B/FZplWKYyvW1QiFBtpl0jlRd4IWedVRyde29/M
	6JJKVA/2DErWNasAaInJved2uYqnJCCi0G/foOa+8u
X-Received: by 2002:a05:690e:1403:b0:65e:39d1:d9f4 with SMTP id 956f58d0204a3-65e39d1e47amr428522d50.9.1778897535504;
        Fri, 15 May 2026 19:12:15 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e3aa93cdasm117281d50.21.2026.05.15.19.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:12:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fuse: fix race between registration and connection abortion
Date: Fri, 15 May 2026 19:11:36 -0700
Message-ID: <20260516021138.2759874-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260516021138.2759874-1-joannelkoong@gmail.com>
References: <20260516021138.2759874-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D80C559DB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-248964-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Action: no action

This fixes this race:
- thread a: io_uring_enter -> register sqe ->
  fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
  yet
- thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
  fuse_uring_abort() is a no-op due to queue ref being 0
- thread a: grabs the queue_ref, queue_ref is now 1, rest of
  fuse_uring_do_register() logic executes
- thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
  and calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
The abort/unmount thread will hang indefinitely in unkillable state as
nothing will decrement queue_refs or wake stop_waitq, and the ring,
queue, and ent are leaked.

Fix this by checking fch->connected under fch->lock after the created
ent has grabbed a ref count on the queue. This ensures that in the
scenario above, it is guaranteed that we either release the queue ref
and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
waiting) in fuse_uring_do_register() when we detect !fch->connected, or
if the connection is aborted after the check, it is guaranteed that the
async teardown worker will be running in the background cleaning up ents
and decrementing the ent's ref on the queue, which will unblock the
eventual queue and ring teardown.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: <stable@vger.kernel.org>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e467b23e6895..99ebb7c9cc61 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -973,15 +973,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
+				  struct io_uring_cmd *cmd,
+				  unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_chan *fch = ring->chan;
 	struct fuse_iqueue *fiq = &fch->iq;
 
+	spin_lock(&fch->lock);
+	/* abort teardown path is running or has run */
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
+		if (atomic_dec_and_test(&ring->queue_refs))
+			wake_up_all(&ring->stop_waitq);
+		kfree(ent);
+		return -ECONNABORTED;
+	}
+	spin_unlock(&fch->lock);
+
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
 	spin_lock(&queue->lock);
@@ -998,6 +1009,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fch->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1114,9 +1126,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-	fuse_uring_do_register(ent, cmd, issue_flags);
-
-	return 0;
+	return fuse_uring_do_register(ent, cmd, issue_flags);
 }
 
 /*
-- 
2.52.0


