Return-Path: <stable+bounces-69664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E63957BEE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 05:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6651828499E
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 03:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE5481CE;
	Tue, 20 Aug 2024 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaWFJbzJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91472E3FE
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124719; cv=none; b=etdtKv4D17jgcuD4bQeH3tTzEls8rmG7jvGm9YOlyCXpv+ZAhnxCsYimVG7AbCsm5/hIyKPGwbI5wl1Ze9TcA6j6c7e7GQomsTrlt7gDxkB3iZVF9+nxHsdg72mhCEAoW27gAu+nHSC4LR0htbM0rCS0xazd2pV4WjrAVuK7OHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124719; c=relaxed/simple;
	bh=Lsks9gT6Mzx0h2HgXjICoo9sTX9N2S+fZp6knFYb9CU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJu74hMYwv0Uj+2Lt86DlGxX1tEW3qVLZBYAzZUkKD+9p7ZF+GBLSJzO64tT7t1u3SJqRvgCr1K8L1rBWAZUR8iQpUq/qkj9HmNNJpcatLGKH9ZmfWZiSBSLkNAl4J040RkC1oi5hhSwB9RUAFRAJfsazbdMDHtox+TKAdMlRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaWFJbzJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201e64607a5so35324325ad.2
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724124717; x=1724729517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBpomUDHMNH7osuoqx8GMBZw65c4SL4hGXGtEruA0HY=;
        b=PaWFJbzJYV5oYdwbqpVZIOkBfMNuTnuA1+scvrFdUkWdm8ynzLj4A8fAWS1Y31nnIL
         ZwIT/qVMm8vVZeHyVIFWQLG/F/aAHBO788ALnl1YcNeUVhyXw6EVC0JI3hnu+R99lHzX
         4k2T5rH0xHvqznvFR36VPhnGxUaMiMvsBY24Hm1GnT0it4Lv5IfQ8Nj0bolqAU3HuQum
         PwRKh6Kg2I3zDpHKg0dDxtA/ilM46mK3t1Ekr925NE50vEfcnZPi22VrsaF/3qvgWjJe
         0Ijpoiupxa9nbzXY+1usxBqpH99zbHU5gcM4d1K3vRbT9VTVUazoFXs4rvuMZlRjOiDD
         LHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724124717; x=1724729517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBpomUDHMNH7osuoqx8GMBZw65c4SL4hGXGtEruA0HY=;
        b=ZcCc1e4dWCU1Ys7s2dLhFey/iOYXNhN2WRqOL+ppxIdnMnEQccHD11AHvGDR3gSfuG
         U5mU5+Wu6xMBZOegmOzOH511ysvg+SIIackwnfWNrtvtlMZBTkZZqkhZCXvVQ39EHzzm
         p3O7rQCC1o86rKHm4plLYKoExGgXN5tP6ZTLNvGjBzmlomTAFl+z7jq6ApChhMV5KwSH
         CYz3gLdqrMvpNqj6b4SvYNFwjsTSpNMUugN9IWYKsJq3Zo2F7aHswta/BdbmxxWY5Xcn
         q28tWeZxW3s8hr82L9BZAsgxZ+YnTJkt2D6eQuvbM8P2NjBWMLjlPZ0z8S03ZK7h05pC
         8tYg==
X-Forwarded-Encrypted: i=1; AJvYcCVG/AZ/pByR5qjnuwXKyPjyQ2REDtHJoM1tWDNla28P32zpn46zhkcXPy3Rz9UbRRB3rOtFovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkiaY+20y1ngM7jj4cQakM+ur2nVA0rfn8FjDo0lYsvxnGDSkq
	K51hWyApQtW9SYqKHzv6/uARjg2bticEAKSnN+qB7ch2O/q1YDLC
X-Google-Smtp-Source: AGHT+IEffL7jXIh+0ls5CoWvCOqF31cquBrZihGEprotxLlNle5BEtjn//syfW/d1AuHY06fynYBNQ==
X-Received: by 2002:a17:903:41cf:b0:1fb:973f:866 with SMTP id d9443c01a7336-20203f47a9emr140920385ad.52.1724124716575;
        Mon, 19 Aug 2024 20:31:56 -0700 (PDT)
Received: from localhost ([123.113.109.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0302d28sm69242465ad.31.2024.08.19.20.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 20:31:56 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: gfs2@lists.linux.dev,
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: fix double destroy_workqueue error
Date: Tue, 20 Aug 2024 11:31:48 +0800
Message-Id: <20240820033148.29662-1-sunjunchao2870@gmail.com>
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
index 12a769077ea0..4775c2cb8ae1 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 	destroy_workqueue(sdp->sd_glock_wq);
+	sdp->sd_glock_wq = NULL;
 }
 
 static const char *state2str(unsigned state)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ff1f3e3dc65c..c1a7ff713c84 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	gfs2_delete_debugfs_file(sdp);
 	gfs2_sys_fs_del(sdp);
 fail_delete_wq:
-	destroy_workqueue(sdp->sd_delete_wq);
+	if (sdp->sd_delete_wq)
+		destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
 	destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
-- 
2.39.2


