Return-Path: <stable+bounces-119641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF273A4595E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0790E7A66C7
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07C20AF8E;
	Wed, 26 Feb 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQN9Sy5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD431E1DE8
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560654; cv=none; b=BSnKbcLwqlLy2oZ1t3ItlZXpBpYM0ghlxc21NeA5kkQBPReLNB24WUn4QonhczEjo075F7o6Y66Zk7llr4NvaoLBi7LVhZN1Lu/TGSjRepM92bjw/SeHwwuK7AbbvN+ypz/AohiNlHHt/GSMQGtWnFElYKRUa46rII74QyKQ9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560654; c=relaxed/simple;
	bh=JYVd1OTFimZlMmj/OMKoN3U32JvtW/pbUaD9FKJgfhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnJAu5LgxKvtHtKQMlkbe0N+1IMxk2Q0MfaxB0w09weetwGJCZTbiDdcM4It3iHcU3pA9MfuLgSXRrwcoiDsuZlDVf1KZ05nGKqcqosxVPVG8WK2WXCsieXYSLq8ACUiNHQOpdL9TiZbdHGjHH4efdWiMHxUhx0W9FjlLXzapR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQN9Sy5Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbf706c9cbso1632295a91.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740560652; x=1741165452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYXJdYifFv8UK938F1cugEpkcZ70y4SI16ovjUtT/x0=;
        b=ZQN9Sy5Q567OnYKWlb7Yjp44h/Kkn6Od7zMhYg3VLmEzNfbbKy4bnXe/O1J23ApE05
         TO8vkDsJQqNcdVcTuv9rurczQ+PzVmdnSMk21bF0+6kwLVELnAqmaKc5kQ0XnLU+ogKY
         TFwbWn8p3hkGquQYOReOS7+577thj5EOvMds/ORRJOrnK7h6gTt3GSaMUWbTLPFGNDT2
         QvMUPgmGARZyxgOMW5uxaclniWhuepCXOb/iIpFk5/we0/Aks/QrJEEjqpBH+qmlOokT
         hFjOgHJHFjkiz1wPI6M6W4/Nv6pKT3+TWd+peU65EkQVHhwsYnWjPHdwpkPAgPrbEaOo
         /bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560652; x=1741165452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYXJdYifFv8UK938F1cugEpkcZ70y4SI16ovjUtT/x0=;
        b=a1bUzDljwNIykCMOPDLxyf/w7dWe9WRrmMig8ptf+3/1WEtG5NUza+v3K11Eyq/0n4
         eJDH3pNC9U4PY/RHEEPFfVgLk1McBiHp30TdJY1Gk+kpKz0SqgI3dOS0I/fiZJozi+gc
         xf1pmG3jSthTIDtf3H/tyA5wFMUJFDbZDQrG2gCYnS1QFFSgw/8t8Qh4tS7njrJAU2EL
         D/94qGedhLUBiOvoP9mSOA4tFljpCo/EFdzpAaf569IHNnaZj8uKZ8cPkRbeVgBFdPiR
         KgaMQG6ixVuUsstqKhlAgqPgfgmTKXLWtPkCXZpQAYVeLfJIs41lc+yVucuJQuE7RD/L
         mWwg==
X-Gm-Message-State: AOJu0YwNJVJD2mMee7LuoLR4PzIr8zzrMZylJUJT115bbHkbPvDzfuuj
	SK0hY1LIH6X1/Q5Ps9s9DspwhJblnindn3VnW68LutNl92x862U+9wD3akaW
X-Gm-Gg: ASbGncvZH3DGlp+Xe8UogxWTg7K4lY4pNfWqnu0NSqaVWJ8Yr6Jpls+KjTKdC2LXU52
	UkcgchudBh4SHdKsJmtqMYlz9W04xuqCkUNF/BOMman2gd7diQ+i8BOnjvs3wTFtD3Sbw7uXjEA
	ENTIFbIIMjQ2MEnymhb55O6KptMwRiJYiZvRMqejoeP9bIB3GkxLzOYKXmabwTMAP3xzJNQAKAP
	IwJqFmtcve4SoCUYsvtaGCBJqXKMQ9UoGM5qKMrwtuPqYFu1sd991Y61YkvAolRkL8VuehkiRVe
	K8MKw/bz6X04gBlyDI8tyd6Xe7/syJRuvqHwgZ+N1A==
X-Google-Smtp-Source: AGHT+IGN/kCQjDMNZbwjB01rpnJryg/o3mwsYIxmGETwIZTNoDtv31j8J3yVYS40IY8Vu0nmmfLErQ==
X-Received: by 2002:a05:6a20:6a05:b0:1ee:e99a:469f with SMTP id adf61e73a8af0-1eef3de0a8emr13671990637.9.1740560652234;
        Wed, 26 Feb 2025 01:04:12 -0800 (PST)
Received: from localhost.localdomain ([182.148.13.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda7e84cbdsm2253498a12.24.2025.02.26.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:04:12 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: liuqianyi125@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH V3] drm/sched: Fix fence reference count leak
Date: Wed, 26 Feb 2025 17:04:06 +0800
Message-Id: <20250226090406.472480-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianyi liu <liuqianyi125@gmail.com>

The last_scheduled fence leaked when an entity was being killed and
adding its callback failed.

Decrement the reference count of prev when dma_fence_add_callback()
fails, ensuring proper balance.

Cc: stable@vger.kernel.org
Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
v2 -> v3: Rework commit message (Markus)
v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp and Matthew)
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..1c0c14bcf726 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


