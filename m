Return-Path: <stable+bounces-111278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6BBA22CDA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89049167D2C
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62499145B27;
	Thu, 30 Jan 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUrJhA2z"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACB1B425D
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738239308; cv=none; b=LcejlDPQBz7TNd0cP6zPOfhlhZTf++Q9+/jJLi6c4hBC1zTNjqZlVreBeeK+D4nKYAbM9YpZYUxNcTr2S6rJa/kjcelHhbtyc8stPEGUtiyXWTR8rm+NcA85POyYKMYQiyjEdb3rDLCc+cDccFcGovlwaxYqobos1XvIpYhJN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738239308; c=relaxed/simple;
	bh=L/HzaWK+Mf5oCl5UzPJt7+ry9UO4teQWCL9KurqGKVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sktviigN3l+HkLorQTdN5uFRnWWykeTzBDcH+mpmlhGA3mrpMc+4+DaQDjmO4ICSLVvHF9uhaeo6b8icZ5tLr+xpfk4/6jXyCEC5jst849VLk+MXgb/neUxxVS9xXANZTylGpGmP3mThZ293FEdcl9LOYD9W1xeJrv58VT+V4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUrJhA2z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738239305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OiusD3begRRW7APeSFSQ6Arycu2IGY+MUliMR9kuAdI=;
	b=JUrJhA2zVM1c7onUE6LO+3CLgXqSaedTyd5uo4orYOksHYcW2aOUMlAPjaFvRl10eA1tfn
	CUN1mxP5NyqtopZ8EJ3+96pj0W4e8mnGH9W8zf1QPpQZSG7NI7cyxDJSSQBCPNrlt5mBVm
	rmFV/mTYKR/Fz4+5LE8UshSGrYJpSJA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-gAZfwyfFMVS_RbKUqR4yAw-1; Thu, 30 Jan 2025 07:15:03 -0500
X-MC-Unique: gAZfwyfFMVS_RbKUqR4yAw-1
X-Mimecast-MFC-AGG-ID: gAZfwyfFMVS_RbKUqR4yAw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf921b8a85so88324166b.0
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 04:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738239302; x=1738844102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiusD3begRRW7APeSFSQ6Arycu2IGY+MUliMR9kuAdI=;
        b=quCZgg3V5TG4QPEtMHjr1XQoqWANQkmRyZ+zxZk5OH0qtZ8DJe0W0suPoesJuSbJ/y
         hsFjcqR98Y6lggpVFAX8xzaKC4EK8RN/9O/dOtMZGuPTe6GiN4xgJz88OSuvt+MIPb0e
         yjjSZWT7bZ0A+08foh+TQ3jVe90z5ggYCWpmlhFMxdVJ/tU9VbsOyW2sY6oloxtVlJRQ
         YS3ifIoQq0qNDdXNb+DrWqNzwI05kLXT1594mV7/zEEM2Xw5nMhK+JPiY19UYnVhO6KR
         WobHa/xMPp23Te7tpzfBC0Nn24v7v4YnzbuR2x2PkXnhOx1AbFUAh7gD3c9eSXN/Ga8S
         OCOg==
X-Gm-Message-State: AOJu0YyMIL7dImgKinI53JSMsuL5IZwuqnmsnhsTL3w1oVfvajl8qTDS
	RR6LRAt72p8+GD53P7ABVjk7+AL/DBM5kc1I3SlFvB81KCWdggRBrGX/8SksFeLNom5cssaCanj
	e3QGwTkHpiJKwaLrJLc212DAl9IoLvABE8yNuFCL12Ygz+9ZPCouIhA==
X-Gm-Gg: ASbGncuyyraNso5OZO0k2EVNli1Nd4ToWpJQfsxHxGLU9ooxCxXXgAmPnTY1KDekbgv
	OiTkn0gPdSw75KgzRkQ2m4gm3og7U7ro/mERVFtSAFtBDauNTA/I+HqWifCaPIQX+Glzlf1h1kA
	8vbHSwDkcccRoea/8aTMwP/YbkFFZR488xOUi0QCjBbuufsB1+kfeLSTZCak0plKFBtQ2YsHmhg
	n50AyuST7cze0lrnGASln9vUdPhZIpC/+RN7tEfWg7wYFAn83hxil79CV0fr6bZSpeX+yDPsSV3
	IiJg7PeYje78eImgpoejxIn5I4EgtQQWXqRLP9dWxORQvUR+lZhkag6V
X-Received: by 2002:a17:907:96a9:b0:aaf:ada2:181e with SMTP id a640c23a62f3a-ab6cfd06362mr638299766b.26.1738239302306;
        Thu, 30 Jan 2025 04:15:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQy5RJ5hPlEs9JHVwni7wmhgnbKCW4s3FKsL50YonKScgJxob2fSBerQ8vbb9GFkTt/hMe2Q==
X-Received: by 2002:a17:907:96a9:b0:aaf:ada2:181e with SMTP id a640c23a62f3a-ab6cfd06362mr638298066b.26.1738239301944;
        Thu, 30 Jan 2025 04:15:01 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (87-97-14-196.pool.digikabel.hu. [87.97.14.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7fd9sm111699066b.34.2025.01.30.04.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 04:15:01 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] statmount: let unset strings be empty
Date: Thu, 30 Jan 2025 13:15:00 +0100
Message-ID: <20250130121500.113446-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like it's normal for unset values to be zero, unset strings should be
empty instead of containing random values.

It seems to be a typical mistake that the mask returned by statmount is not
checked, which can result in various bugs.

With this fix, these bugs are prevented, since it is highly likely that
userspace would just want to turn the missing mask case into an empty
string anyway (most of the recently found cases are of this type).

Link: https://lore.kernel.org/all/CAJfpegsVCPfCn2DpM8iiYSS5DpMsLB8QBUCHecoj6s0Vxf4jzg@mail.gmail.com/
Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
Fixes: 46eae99ef733 ("add statmount(2) syscall")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cb..9c4d307a82cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5191,39 +5191,45 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 	size_t kbufsize;
 	struct seq_file *seq = &s->seq;
 	struct statmount *sm = &s->sm;
-	u32 start = seq->count;
+	u32 start, *offp;
+
+	/* Reserve an empty string at the beginning for any unset offsets */
+	if (!seq->count)
+		seq_putc(seq, 0);
+
+	start = seq->count;
 
 	switch (flag) {
 	case STATMOUNT_FS_TYPE:
-		sm->fs_type = start;
+		offp = &sm->fs_type;
 		ret = statmount_fs_type(s, seq);
 		break;
 	case STATMOUNT_MNT_ROOT:
-		sm->mnt_root = start;
+		offp = &sm->mnt_root;
 		ret = statmount_mnt_root(s, seq);
 		break;
 	case STATMOUNT_MNT_POINT:
-		sm->mnt_point = start;
+		offp = &sm->mnt_point;
 		ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
-		sm->mnt_opts = start;
+		offp = &sm->mnt_opts;
 		ret = statmount_mnt_opts(s, seq);
 		break;
 	case STATMOUNT_OPT_ARRAY:
-		sm->opt_array = start;
+		offp = &sm->opt_array;
 		ret = statmount_opt_array(s, seq);
 		break;
 	case STATMOUNT_OPT_SEC_ARRAY:
-		sm->opt_sec_array = start;
+		offp = &sm->opt_sec_array;
 		ret = statmount_opt_sec_array(s, seq);
 		break;
 	case STATMOUNT_FS_SUBTYPE:
-		sm->fs_subtype = start;
+		offp = &sm->fs_subtype;
 		statmount_fs_subtype(s, seq);
 		break;
 	case STATMOUNT_SB_SOURCE:
-		sm->sb_source = start;
+		offp = &sm->sb_source;
 		ret = statmount_sb_source(s, seq);
 		break;
 	default:
@@ -5251,6 +5257,7 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 
 	seq->buf[seq->count++] = '\0';
 	sm->mask |= flag;
+	*offp = start;
 	return 0;
 }
 
-- 
2.48.1


