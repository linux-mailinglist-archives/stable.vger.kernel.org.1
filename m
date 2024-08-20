Return-Path: <stable+bounces-69731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3842958ABD
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621CBB21885
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBB8F48;
	Tue, 20 Aug 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxFRkPbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96536B
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166540; cv=none; b=Vgb317pNf32aknFIqlXO/WgYXlLRC+5+hJ90WsjXTpuLCssKysg+gXvtSnqgecdQ3dnqI2UDZgOkp0huQUoh25H+hTFs8rc0GGYA1oGI00cqHK4BylbeeBKrr3f7UG3l5HfZ7c8JVB+GJ4SrSukrIsoJMgvqpPItxn9CXuax0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166540; c=relaxed/simple;
	bh=eIBe5VU0rwzRYmoZ+ezGTfEUNZB4FKbZoyKyuWgfjEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GbWaQj0S4m1cvI0bMhQKiF4yvc2wufenat+ZpMs5YiuVBbALvkVSLq25R7cpiwEA2N4teqqAsV725ZnqrLb466gM7LZ6cP2kFrvb2EYnnS+WYB+n+YBoKicGl++QoEM0ONMsTANodVS1wx9l+Si+ou3UjzsRfl2SyiHF2JmxIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxFRkPbH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fba05363so37760535ad.3
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724166538; x=1724771338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/VVL2iFwMtIglkiNUI7sZ7vpqFc9+UuopSaFpbmGHU=;
        b=fxFRkPbHrNQjA/EgP3KSGTQPsDn3wLe2KpPU3pTCFYl1lDjgoDsAsnbNSK6c8khHNI
         zKHKke4RhahixcUEp2yy58on5MfCTfY3hXhEw35bHwrvaHUDV2bUgzaQsYdjPoC8FPHk
         +Kv3mc/t+tGgI+ivy/Y3p+9nJt7aYEfI53b8URsyv0xP6ZZE0CmHvUyq5j4Mbdep6aiG
         8SmTlOtvPYAjRujxE/4F+mDp/3Gt48oN8v4LD+IhPVG10VP3CMSd8RgKKkTYjHMuHPDE
         iIu2a3XCSam3lPNfqoomp/QcosF0qglBOS5pHfIUDVnFlseNdXFh5aDQXtOSkkOglYDk
         veYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166538; x=1724771338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/VVL2iFwMtIglkiNUI7sZ7vpqFc9+UuopSaFpbmGHU=;
        b=m/56qBMT70zIgAHrJWw1wTvmepT36G8A6NlXxYdc41If4zzMNPrBAgpYkF931CFoD2
         QL+6fjRlXBGHCBgzoql4zRct+40dB9aVTM6loSb2lDo0GmK5/Cdyh/YUXw2s/A3fzNgr
         mQ2ywhums6cI0VSj5pcJYQ65VuHwTyBOeaUBDm46IXSB/1tILghKqT6wzGuJ5nXcE3FT
         vtlE/GGfnsinkdl6t+bfrBKHaaGf+7etG5JXIJNqEKDh44M1q0nIZMvJnEeoDbZPaLsx
         zXkoYrBogGtJz4KCojaP33Kp3CspphstoKhF4zENE7/1PSccWYVvBa1ueuElaRBwNG70
         VSzw==
X-Forwarded-Encrypted: i=1; AJvYcCVVwQJB6Th4wUHWfPO7RMFkLx06vSMZ89Z2hXA2+k9/tTDCoENtaSYPxB/kLK7+WCAqvGXpFaYRaRzN8IeCh0nC0mgnYPtv
X-Gm-Message-State: AOJu0Yw7vV9g3RuvJVzMfukhbwqpq9dv0tfcYAGYoEht/pnqKOoDp5za
	3MiDyzwzu7bC/FIylPbfAQP6beEdiE5CbkCEDhZNyHGsJMInOPkr
X-Google-Smtp-Source: AGHT+IFFSAlPPJrEB2CHN3/9oCW5VDc9wktc5KS2Mnp7P63mo1edOgBdh/CJLhEtlPtauLWNHjqYOA==
X-Received: by 2002:a17:903:247:b0:1fd:92a7:6ccc with SMTP id d9443c01a7336-20203ec1b8cmr146835015ad.30.1724166537516;
        Tue, 20 Aug 2024 08:08:57 -0700 (PDT)
Received: from localhost ([36.112.193.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b40csm78834595ad.220.2024.08.20.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:08:57 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: gfs2@lists.linux.dev,
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gfs2: fix double destroy_workqueue error
Date: Tue, 20 Aug 2024 23:08:27 +0800
Message-Id: <20240820150827.139326-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gfs2_fill_super() fails, destroy_workqueue()
is called within gfs2_gl_hash_clear(), and the
subsequent code path calls destroy_workqueue()
on the same work queue again.

This issue can be fixed by setting the work
queue pointer to NULL after the first
destroy_workqueue() call and checking for
a NULL pointer before attempting to destroy
the work queue again.

Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/gfs2/glock.c      | 1 +
 fs/gfs2/ops_fstype.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 32991cb22023..5838039d78e3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2273,6 +2273,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 	destroy_workqueue(sdp->sd_glock_wq);
+	sdp->sd_glock_wq = NULL;
 }
 
 static const char *state2str(unsigned state)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 0561edd6cc86..5c0e1b24d6ec 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1308,7 +1308,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
-	destroy_workqueue(sdp->sd_glock_wq);
+	if (sdp->sd_glock_wq)
+		destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
-- 
2.39.2


