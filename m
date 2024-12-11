Return-Path: <stable+bounces-100609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CC9ECBC3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58314282CEB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2D21505B;
	Wed, 11 Dec 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipvg6f/x"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B11EC4E3
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919086; cv=none; b=t6NeC/PfBnSXt92yZLJUZMq+KqgWOC9p4KWlY46wIQqE25hVFnXHrGYrWMqlbGAyq1z046KrAC/6ImblZv8+UFsd1oGFt5TCqkBpp6cAD9sHK+d1/5EoigQlKnhTsIj+Z3/4RAtn94sCSuvU5/iwOkW4CPvhjjIahcaFDksQBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919086; c=relaxed/simple;
	bh=WKncBlVrIEckiGDzFEHninTQ03F1YT+gLvQhBh6YAho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4ADa8y3RJBIma5TMZc7MH53ondX6e/fMdvv3U/W8VDYRx+oOCAbpcZ8k5twNeO8j6DFMFIkGUAxRGHjSER0D8Lk824dnXoICD53BhDuRHBVPKWufhcE+3GRley41R1cS/CM3Nzqkcn9lc2N4LGg/+wzOreIpKfs1gzL1nrf2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipvg6f/x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733919083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLdwmsIBE7jK5stVDngUdJnOwOLDtzp3iizvGFR+HqM=;
	b=ipvg6f/x7c+py478vV3rAYaUjQxd3hmPvBxC4OjQBCcrur+z+RQSWkumXrBkfrUmlsQn85
	PnHLM2AkSs+ytuXcQasYHYXIJBzmeUqDfAmiDiEbT3LUVnhuQp/qlERBKTafl7U5IZd2wz
	d8R/Tw1ZC1CvEisQzHoC/WmLNRTBUuQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VGgOdodkMbuhNuQquVtZ3w-1; Wed, 11 Dec 2024 07:11:22 -0500
X-MC-Unique: VGgOdodkMbuhNuQquVtZ3w-1
X-Mimecast-MFC-AGG-ID: VGgOdodkMbuhNuQquVtZ3w
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa634496f58so198038066b.2
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 04:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919081; x=1734523881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLdwmsIBE7jK5stVDngUdJnOwOLDtzp3iizvGFR+HqM=;
        b=n7/sFKFOIfdAWpg2QD9RlKtPtNKyoz71nbeiRyPvqo3teA/2UZFBVP712Y5ohUkogG
         QoD+xxwHQs5FAtfCIdcM6TMymDon9qYnXQrAcQ7gJ70tOjKG9HWoW00GvdyvZN6wWB/T
         7uE9zlOURsataAHi0etbRa3vSJ8Fm9hmFk82kNgtcW8BN2d3VhOblDGLigMdRREDYbRv
         QG7SL+IFWq0JemqL04JqsBmpB1vcKfGkgr6DDRNGjx3yvUqGKhPR3wh4ckGo2jB0V6sF
         2Y3M/dpP6/uZSewLFaYrHxkkd4MdViwPM4ULHH7+nhs75EIUz/HE7ckV0/DWgC9+dC5c
         +7uA==
X-Forwarded-Encrypted: i=1; AJvYcCUEnNfQ7ME1IGyBsfHP6cy7PoGEUlU1jAjX/x5rkVkMkA5wo3+xW2q4FjNRnPJrmnp5AEYuD30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbN0Ahb8WzESh/JfNRneisbzD3d2JU0buoGnHUJfxmLUuRwrt
	mYi0++ERaWInB0v053JKdea6jxsYoOH5rXYS/QQluWiHcsp9Mf76WRqkyw5uSF0TNSI1LDSi2s1
	qqwcaGrI3y3xRwgzYW+vJkfQyJ0d/jbt2SFNtbFI8G7f+380yakOAZA==
X-Gm-Gg: ASbGncsc8s/Pk/xlhAsWMhZ8/IOWFZe48b2nHEqNHKAM+nCOUJ8zLf9yZFMK4yYHh5E
	hLebqlUUC447oJJHi2OII/rJECee1QOUOFH6T4YTIkCe0y34nuMo0o0NHbc43UCkUluKYx1U9UH
	81PsCduPTUU91I0LZSjaQ88jUBPNOvzwdNzyC4Ck/xJttTRpqN1onOlr57sLyXvZC9iIFus3GNS
	G75fF9zxcSN1oL/BQrtTWD2b67TzZHquyzSE5sz/dwkFuujuEUG98cdYz7bVRM4KKo/3ltSqjJp
	iGnI0b1ViA+0yt8xVP5zuWgDEWgDWrQ3
X-Received: by 2002:a17:906:4c1:b0:aa6:7cae:db98 with SMTP id a640c23a62f3a-aa6b1141a54mr232894766b.10.1733919080838;
        Wed, 11 Dec 2024 04:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn+9tNg7qM0MsjYiMIikQJQVEFRtrpJlQIw5d8nJQ+akaG9Z+TIu3BcfzfZK6NiP8vBpy0zg==
X-Received: by 2002:a17:906:4c1:b0:aa6:7cae:db98 with SMTP id a640c23a62f3a-aa6b1141a54mr232892366b.10.1733919080435;
        Wed, 11 Dec 2024 04:11:20 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-181-212.pool.digikabel.hu. [91.82.181.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68d027f36sm421542966b.176.2024.12.11.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:11:19 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs: fix is_mnt_ns_file()
Date: Wed, 11 Dec 2024 13:11:17 +0100
Message-ID: <20241211121118.85268-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1fa08aece425 ("nsfs: convert to path_from_stashed() helper") reused
nsfs dentry's d_fsdata, which no longer contains a pointer to
proc_ns_operations.

Fix the remaining use in is_mnt_ns_file().

Fixes: 1fa08aece425 ("nsfs: convert to path_from_stashed() helper")
Cc: <stable@vger.kernel.org> # v6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

Came across this while getting the mnt_ns in fsnotify_mark(), tested the
fix in that context.  I don't have a test for mainline, though.

 fs/namespace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..6eec7794f707 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2055,9 +2055,15 @@ SYSCALL_DEFINE1(oldumount, char __user *, name)
 
 static bool is_mnt_ns_file(struct dentry *dentry)
 {
+	struct ns_common *ns;
+
 	/* Is this a proxy for a mount namespace? */
-	return dentry->d_op == &ns_dentry_operations &&
-	       dentry->d_fsdata == &mntns_operations;
+	if (dentry->d_op != &ns_dentry_operations)
+		return false;
+
+	ns = d_inode(dentry)->i_private;
+
+	return ns->ops == &mntns_operations;
 }
 
 struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
-- 
2.47.0


