Return-Path: <stable+bounces-192778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2C42CEC
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 13:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC5F53489DA
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE754654;
	Sat,  8 Nov 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbZfQk2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1951258EF0
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605381; cv=none; b=XTe6BzL/4gu7DZxCjkKBLNyVAhqaqLdO+jfmuCt7iuYplsw0JEcjzYp+QyQeHsOp6Vjlkj39T8XjgIpjAtfKns3jkqepOQTysQbaC2m9QIw6hfhyPakhDrY6/9kmX0I80eBDHUMi/LO/wpklA7ysN2WOwjsviB62wQOqrD6L1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605381; c=relaxed/simple;
	bh=uRVHkf74PN+NsgRpPhLx88tlLbm6OItPRVdDekAJNfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbFLVXCwBaFG2B6AN/CmgrfEhaG6TskJW2uVq0b95uzfpD5wGD2Wvd5hhCZcWBolJbol+C18hStzsUP0EqEai07Ej9aw1qZ3RtIqePix5G3l9TPyW3vjrP1cIltwUw0sL7Z8vYD7WDTwJ6dGwOA2T6+QcZ2m1xUfCDs54F/NVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbZfQk2p; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba3b6f1df66so119483a12.3
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 04:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762605378; x=1763210178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb8819sRG4CMNnKbcxDJ79PlxuoIzXm9ZoWrsp3orTM=;
        b=SbZfQk2pS/PzjUrbA9LceOfFNNiwGZDO1+ZftxUBKKIigRfxtITCbQjrXobUAO78vj
         XPGhYREsChQoWpuSCejJa3n+PhWkXF1kpIDbn5mB25xct4cBcl9dAfeWxCC2eKpbL2Ue
         xyt3gGbaCLYA+6okZ8tQw+KQD+Anm9ts+Osvq5DmoSOTz/xiPr8tnsS9cpGcW4HAA8HM
         sPK4lBckeVNoB5Ghp/9vV8sZaa2N96HRxpapjCAnIWe4KiLWsp8q/6RlGtllrafXwyRf
         fApRQquKHVRb36aVyydfMxRxUzhVi5fEfyTtGDR+sqvIZe/mDHaQfypZzBY/V+P9Qxwa
         9Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762605378; x=1763210178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kb8819sRG4CMNnKbcxDJ79PlxuoIzXm9ZoWrsp3orTM=;
        b=s/klsB8cNDl37W5GKp+g4OpiXlXWZAySncJ6w7vD6+l1sPEBvFjTcurKfhVCb9odYG
         P61nFfExRSoJgQHrdf6qggdKbEMSUwGDJ4TxdspPpeAhNbfiLg8RHylc3Fs51O/LzlvN
         fzZuJMUu7xXHBgbCTPom2sYJ98Xmech+cuZqx0pO/kbwcWjiPElEr5v8Fkw33nk9TJWY
         P5qZvPoPVBxCsUyVG3yH1edjkzGanCmDj2pddKmdsb6MS5tqCqEglzAmkfowfelN3nSk
         nZycXs56SK+pUlPU4RgB8OqBKgQxGNHg8ni/b71LiqX9gHLKOoI+XKpPl+LkgOMgU1Y+
         xUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH8iWCEmfMB+std+OuAIaCIxYttsbmzH4p2/iHJdq3QZudI7b44fzUeUkQzmpimLHKW3h67KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11HtSKuRcUtnLSZJq/YnYQLg32CHa5ilAh+lK0ch+R+/1mLUj
	ZjJgbLtjD+eGQW+iZpzDcbtbo+6w1nMQi2H9UqB7uWtD75sgyTOJZ9lC
X-Gm-Gg: ASbGncsX2KO4LW5yJpJXhOY/9OfCCX41/pe6ZyF664dmpDWLibXSb+uxbui+nAe0QKq
	/dy1t8ptS58t/rzGVNGjLGU7aq79UPXKbNlL9nHaJBxRKH26WXvjh+vqxpYVyCiUXQXcgrLyx/V
	YO3arZGlDpFtCI2hel6KOvRVmPnzUZN/vcbmEUoGMeSVgETcNBheoXdEL7MF41Tr9o5kCrPUP5X
	GIxxnpUUi5wOFXo7bhTmKLNxJJwOh8/xHu3OcqsWRqgzMWvjMrDjClo3itNaCFbvPCM7C57agf2
	kfLWJ696/UMqh9MSq2zyQ22MLCrToP8j4vmKAofEjvlimSw9KcccN/rNO5/WG+Z2bv8QSTrWH8m
	3X7qjTkx/Tl0fYiuGKBCkYOUpgHnQEcPtlfTNGTMDU2Oe8tq/caDwTwdvpMWZLJQYh2xHwVFG/k
	O/ZxoOQ206MeT+09jHXz9g/pvbKtX8Y71MNmgZVcR+deWI5q52iFlhLVpCHQW0wnHkxeedg9oNk
	0np/LNy1l8=
X-Google-Smtp-Source: AGHT+IHbxRfdUT4HVX6GH+hFiYMSSiTWIZoTQpxma32JqxsfSwUnqkfo6IFizDS0NzlaG/f8uasiNg==
X-Received: by 2002:a17:902:e847:b0:296:549c:a1e with SMTP id d9443c01a7336-297e5649f22mr15677755ad.3.1762605378467;
        Sat, 08 Nov 2025 04:36:18 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901959a47sm7648305a12.28.2025.11.08.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 04:36:18 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: vfs: fix truncate lock-range check for shrink/grow and avoid size==0 underflow
Date: Sat,  8 Nov 2025 21:36:09 +0900
Message-Id: <20251108123609.382365-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110803-retrace-unnatural-127f@gregkh>
References: <2025110803-retrace-unnatural-127f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_vfs_truncate() uses check_lock_range() with arguments that are
incorrect for shrink, and can underflow when size==0:

- For shrink, the code passed [inode->i_size, size-1], which is reversed.
- When size==0, "size-1" underflows to -1, so the range becomes
  [old_size, -1], effectively skipping the intended [0, old_size-1].

Fix by:
- Rejecting negative size with -EINVAL.
- For shrink (size < old): check [size, old-1].
- For grow   (size > old): check [old, size-1].
- Skip lock check when size == old.
- Keep the return value on conflict as -EAGAIN (no noisy pr_err()).

This avoids the size==0 underflow and uses the correct range order,
preserving byte-range lock semantics.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2..e7843ec9b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -825,17 +825,27 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 	if (!work->tcon->posix_extensions) {
 		struct inode *inode = file_inode(filp);
 
-		if (size < inode->i_size) {
-			err = check_lock_range(filp, size,
-					       inode->i_size - 1, WRITE);
-		} else {
-			err = check_lock_range(filp, inode->i_size,
-					       size - 1, WRITE);
+		loff_t old = i_size_read(inode);
+		loff_t start = 0, end = -1;
+		bool need_check = false;
+
+		if (size < 0)
+			return -EINVAL;
+
+		if (size < old) {
+			start = size;
+			end   = old - 1;
+			need_check = true;
+		} else if (size > old) {
+			start = old;
+			end   = size - 1;
+			need_check = true;
 		}
 
-		if (err) {
-			pr_err("failed due to lock\n");
-			return -EAGAIN;
+		if (need_check) {
+			err = check_lock_range(filp, start, end, WRITE);
+			if (err)
+				return -EAGAIN;
 		}
 	}
-- 
2.34.1


