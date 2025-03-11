Return-Path: <stable+bounces-123148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E212A5B8FF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146CE188E14D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1B1E9B1A;
	Tue, 11 Mar 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKNUdRd8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5321DEFE1;
	Tue, 11 Mar 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672980; cv=none; b=i1ehk8x1diCiWcT8AgyPsd/Lddc6yhtAGxpGZlt9U8uNu0acy/A05D9//X46NPAUCRPcHxtzZg4/H8tw/0ptyK1aV+mYfGohGZPjGhUKtMKakIkbSXvCV+RwyTbY2amKr6rRiSLpMGmTOnlQmwkoGFDt8DLyNbKyiwIcoN0NP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672980; c=relaxed/simple;
	bh=9jIh1Wyi30pmEBp9BoWmxxJ0GYh1HzKxRLFX4UCd7Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2mVqMeBEIn7oeIGggtfa71PYfGgF6PkD5Htb+YdyEwCKFzbjnrgeEqzc8sWD3QQEaBz5uNbA59cvL3lZkjObfGNjkHTCDT1eYeIrbuuN+OG/9G8skW6sx4Sc8rN0OHsWJn17hsMwg5RN56O5oqIBTEBXPx3/erR8aUFomuCOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKNUdRd8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22403c99457so10179495ad.3;
        Mon, 10 Mar 2025 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741672978; x=1742277778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JulbF52Nzw24BwpCt4Ixlc53AouAB03xm9qoZqBqETw=;
        b=LKNUdRd8wHCL+NGNZ7yTF5jjkOA++jOXalzkpRxxuSDwMTmadU+bgZ9/2q66XOovLv
         U/A500P/cgfxhXg+WEdbrdeLY0K09QyALTcPRE8fyuzdEGo5Bnb716SzU1o59OVd/fzZ
         GjScPE8L9eBg9v34v5emNOnB95+xln3n9ZY943gLQQll0uI5heeIiJGU+nm8Y6sISofu
         hirewFqAdry5XSrJGzcO9VxCyD/aJ+6FmLRxox4VdX1dTk2nsiC55bxjRMetNOK1upuq
         PtdGrgoin4IcxFbIlldGgrCj+IhPRyH173eJbg4B55XfKoVJtPclNsgwHuddB4Zr0pdh
         Zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672978; x=1742277778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JulbF52Nzw24BwpCt4Ixlc53AouAB03xm9qoZqBqETw=;
        b=teNYAB66Mi+nykXXM5JLDcWi/Rr9RSElTz24xIja0PHqZ0ut8eRfvT5LUtL3zSvCTJ
         4UsDYkrYZxxm7drtEJxCdY/S452/X3TBDlpmiqQRaBnHjVdm9r6vUuu7p6AH6bUMk+PH
         k5VHcmKgu/xCBFrfHUHbDr71YU7OYKcuxcsS/uDH/AWzGrhfD8H2o3jNN33vg2mxfdfs
         /5s4BGz5ozWt8Hm7YdJbgHZDnHGsNmg3e3O/PKAxUBuPO01Ny5zv7JVhfXblKxxM91RI
         Jez72bgu4buloO45JjpDgIAEQcbVbDZ/qDdIFttWPbBxGMR+KvoLuKmz1odq9rr7P0BJ
         DpyA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaNghoVQ5cFWlCU3MVDQrSDUcxpoNGx4fSEkV75PnWTX9ldW+v2nBLLAxRXzPIEVAaX9RuI8KLQZS5W8=@vger.kernel.org, AJvYcCW8ev5vJYTQIGA4vgR7nk08JIMhHEEbwQQ4cPJ/6zgtDKyM+FowEyL0+fhTgiX1j5bdn/m2OMCQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnrJnoGcQK7rhYGPoZc/TZyGKJFi+fD2oIpEWUtWGuV3iQpdD
	u0M3kiW1YE2H3x8SKyUmEhZ7LUgNz73qsrfXGoqHD169VczMgz/S
X-Gm-Gg: ASbGncsxLhYfoVve9ofj9PTFZl38Cvxm0GnvP6uShcXWVyY1tJRXm3aRwNKR6ysUfLo
	54bf6jLiHF9y/B7l6w2XRfRz3um8wRLiGnAL2Bp7QTtxnxOVNZIcHH7SMmxadguWb2CjVmz2xoV
	wZayy+GNTfQCB2vz/2lrExDKlffEA/5323Z8VHfRYf6IhTLqnMJkGn1E4S8XLhPAJgWYUoemnI3
	9BLORkRaqtmSbM6v8SgZIboCwrhM08OmjgOjXE2T3q7FMSnqPccl/xaO6u9rIj8L3+wf+d5HkxM
	0cycfXOn45fTdaqYON0GCIl19ifgSSdlf+eJxeTYSyIq6JmPcqLpSm/bepoMeg==
X-Google-Smtp-Source: AGHT+IE4gF9L12lkMnnuy83IJhQOl+v0FkPavSfxpwEcmbXeQ7gR2r0o8PwM4B1Z0tBb/fM5R+7Ywg==
X-Received: by 2002:a17:902:e802:b0:215:8d29:af0b with SMTP id d9443c01a7336-225932f6a0cmr12423375ad.14.1741672978048;
        Mon, 10 Mar 2025 23:02:58 -0700 (PDT)
Received: from localhost.localdomain ([182.148.13.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91b8asm88833735ad.171.2025.03.10.23.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:02:57 -0700 (PDT)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org,
	airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH V4] drm/sched: Fix fence reference count leak
Date: Tue, 11 Mar 2025 14:02:51 +0800
Message-Id: <20250311060251.4041101-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianyi liu <liuqianyi125@gmail.com>

The last_scheduled fence leaks when an entity is being killed and adding
the cleanup callback fails.

Decrement the reference count of prev when dma_fence_add_callback()
fails, ensuring proper balance.

Cc: stable@vger.kernel.org
Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
v3 -> v4: Improve commit message and add code comments (Philipp)
v2 -> v3: Rework commit message (Markus)
v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp and Matthew)
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..da00572d7d42 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,16 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			/*
+			 * Adding callback above failed.
+			 * dma_fence_put() checks for NULL.
+			 */
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


