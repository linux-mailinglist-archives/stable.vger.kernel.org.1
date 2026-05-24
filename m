Return-Path: <stable+bounces-254041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J2mEOfIfE2on8AYAu9opvQ
	(envelope-from <stable+bounces-254041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:57:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 497925C303A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE597300A62B
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53239A058;
	Sun, 24 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/c3vlIp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6202F39C7
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779638253; cv=none; b=FgklFg6N31beWes/PM6rkHfzBkynOB6BF/y2CfV1QyRU6xJky1rb4h4F+6zRkXAXzN1RDmoxCvJzQ3lFUHrAGjH99H7pzl+7suLm8tV2Y23e/YyFliUszvT1y1JS0BlQSspMrUEw+B7pwkPlI2CYFMgfzCEVlvmhlqtikC5+Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779638253; c=relaxed/simple;
	bh=B0H12NhIO374kTIfEBVb6LhF2mHBdABLnBNkL2lfe+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrlUEa1ioPnbxOtDYhzajnqmWQDNJqmPIxb/b37ok4deePfZthvuffjysmPbOADQIMvy5rQik4glGzeXdLoRe08gQ9kvKGwfPM5NtB95saynGsQ9O1Blu8eVZReRCpctWAxrBBvKeAvUeRyQh/2KvMVIGzWUf3o6tyIhXgh1/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/c3vlIp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367d88b9940so5849108a91.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779638252; x=1780243052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pGO8hezM1yTgC77jiIpPHRz4G800mj82NUOkgOlqoc=;
        b=k/c3vlIpFKmmv//bD17jCi28kw3y1ZlyuDuYgNOCkaBUOTzrIyMTzaZsnaw0Pr1DjF
         vv3QVElAeYnfvOTXIvRnkzcnFZLtXI6lL/zmTkkR5lBSoF7QHbuFyOOwoElKVPunmU8N
         r4YZ2eZ4SBdVd6N15rTcmgxDGPCZiLiP22a1bNLst+Gpx1ezDnz851EXFR6NJY/Z/bAo
         8QoslhZZ8MhQJPNXgMhh9Q3iC+teOL4DhCbfa5TFT98EXnF50lP50uzAgewSdrilwdSO
         HH+Opz9KQlaPI30r/TUQT6QJdQ3RG+DEGPuLSeRSLbWAXPhWZEKON3N/uYPzklv4w54N
         J/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779638252; x=1780243052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pGO8hezM1yTgC77jiIpPHRz4G800mj82NUOkgOlqoc=;
        b=l0uErHUMccxp5yRVyM4IWJktDMRdNe7kfifucXaHWSpUAf3S0D+XyRjo5kBF7hm4o0
         8rJsx3yJOA7ZyjVrPaDC7997XlLf3tRPJxjQyy4OByDlb5i6IfCCjXdjhmGCXUUnvnWG
         9lWr0cWheW1Dj4FyZN2IWY/kcBomGUVNi3SnLRxqLUpI27BboX59JF00i152a5PBcjuk
         Kh6bwMy1Fx6IhIZ1TcCtv5eriMa9m0nK4ipnKCIJxw2sjRc22bK6bQx8zlT1pPWZI28N
         48h0Yyb7LATw7xczASlCAn+x0ooWdD7GUmznozC1ARCBQPsFGZMfQv8RmpNmRSZuXfyQ
         INmA==
X-Forwarded-Encrypted: i=1; AFNElJ/C1MFe3Qbeo9Np03qo4ocd/ZPhSeaWaTMuEHZNQgnhVmUuM6NZcQxNBLe2QOEdut677Hhgl8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qx5sMif3WMCJzDNDgNN68WdZ2SfeymeDOeOLvUlmLa7h/9K2
	utLj1SVv/FfQs2Mn73mn0XIpj6Iot3JGr+Cy4OBYHgWVJZ/WLfDBcJ7x
X-Gm-Gg: Acq92OGO9c2a9vKENIfSfocoawFE6udrRsQJG6jAObazBOED3oTWpLotUp9mr7iC9Lq
	2dRyelATPWIZf3/3BG+q+/+qU3dy1paU+9wlMUQ+v/syHr+eAR3YiCZRtpuicnt3e47rvnxIaz8
	zdswzEPWWC0MfxyrTfDhd+ql2T0HhEwLRlWZ6iyGgFtrL0wV8Fd3XaWe6zYn/wCOB4DS8iptyCQ
	zmrFmtcGA1d6/VgyQ8UJYLQYB5FjhjuPS2fs3oYfjZwspMOWnRuN2QDopNklmswaYzF64sOVx6f
	ghS0DJqbRRqxi9Z6c+qX9gGXGeLCF0EV9/ZZ+2J+VkdEMX+XAcG4maC/wxiJZ8C4h9s7+21wraK
	fkhMcHuWrx9Z4xhXrJIw3+fz257Sm7mFbV02W2QMaCHc2b2YHCHDQcdRv00BeCFMcbuWQOt9CGB
	1BwBmjuTV+hqc8HORclT58kzFmtE5IRmLfG3zUjr42gqCUTCIofkdoSXv3bo5iRQREFIcgaSkr8
	ezJXkQWEuhCnRm2c56Zn+koSmc6K8jiF+7lsZbZubBfdV0Ur61HQKc0NKFwTwR1Gm7tXU/ChVjW
	WY4q/LH9njdjWyx5LZ5NWw==
X-Received: by 2002:a05:6300:2795:10b0:3b3:62be:3584 with SMTP id adf61e73a8af0-3b362be393dmr2496390637.11.1779638251896;
        Sun, 24 May 2026 08:57:31 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fbb66bsm6973381b3a.45.2026.05.24.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 08:57:31 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org,
	jeff.hugo@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/rocket: fix NULL dereference and integer overflow in rocket_job_push()
Date: Sun, 24 May 2026 15:57:16 +0000
Message-ID: <20260524155716.90955-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254041-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 497925C303A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rocket_job_push() allocates a temporary array to hold all input and
output GEM object pointers:

    bos = kvmalloc_array(job->in_bo_count + job->out_bo_count,
                         sizeof(void *), GFP_KERNEL);
    memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
    memcpy(&bos[job->in_bo_count], job->out_bos, ...);

Two bugs exist:

1. Missing NULL check: if kvmalloc_array() fails, bos is NULL and
   the subsequent memcpy() dereferences it, causing a kernel NULL
   pointer dereference.

2. Integer overflow: in_bo_count and out_bo_count are both u32, set
   directly from userspace-supplied in_bo_handle_count and
   out_bo_handle_count with no prior validation. Their sum is computed
   in u32 arithmetic and can wrap to a smaller value, causing the
   allocation count passed to kvmalloc_array() to be smaller than
   intended. Subsequent uses still operate on the original counts when
   copying and locking objects, which may lead to out-of-bounds accesses
   on the temporary array.

Fix by using check_add_overflow() to detect count overflow before the
allocation, and adding a NULL check on the allocation result.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..71f64bf2bb7f 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -8,6 +8,7 @@
 #include <drm/drm_gem.h>
 #include <drm/rocket_accel.h>
 #include <linux/interrupt.h>
+#include <linux/overflow.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -188,14 +189,19 @@ static int rocket_job_push(struct rocket_job *job)
 	struct rocket_device *rdev = job->rdev;
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
+	u32 bo_count;
 	int ret = 0;
 
-	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
-			     GFP_KERNEL);
+	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
+		return -EINVAL;
+
+	bos = kvmalloc_array(bo_count, sizeof(*bos), GFP_KERNEL);
+	if (!bos)
+		return -ENOMEM;
 	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
 	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));
 
-	ret = drm_gem_lock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
+	ret = drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);
 	if (ret)
 		goto err;
 
@@ -220,7 +226,7 @@ static int rocket_job_push(struct rocket_job *job)
 	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inference_done_fence);
 
 err_unlock:
-	drm_gem_unlock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);
 err:
 	kvfree(bos);
 
-- 
2.53.0


