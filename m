Return-Path: <stable+bounces-25388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD986B40B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44CF28A21F
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C815D5CA;
	Wed, 28 Feb 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q75XSoDf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4015CD67
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136165; cv=none; b=iYfzSGQjfuqWMHF7tiMlbuioW+JCAn7SOmvcVJW+4V/PKNMX4vEcUPHiNK0+T9B6tlPs/csdIbn42ih5ZVM17tEXxCJNjgGIrwsTGVPa47KBLI08hfWrAXltfulc5EyDEzb0LxCXriC+26dcMOWymOn5f7o4okaBY8g08YZewUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136165; c=relaxed/simple;
	bh=gcmDylT5tOFHkuXUNsAiv9r7CLlIpQpP+An4L8BC66A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdLTi3YTBxvDMejt4y1E65J23qqeYfihCt8rz187kAY+Pb9aQGNmokz2d7FAbvanEOvQFdoBLxSdC3QhTonBN++Uyc2ql3tPR6tXAvJVd+gt3f93MmT7sG/XhwP301cjf9L7b0vcpQh3BEj4E7omV+GZsEkI8QjK1fy7W3ePaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q75XSoDf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkI08nI25MBj/Qiu+niSA2+bh8FbCRap2BNxrenMQ/8=;
	b=Q75XSoDfD4SJQ0Q9CMv5+z1vbHXHmY5XWDbIybMFhhEuIz9tikw6yIwGxT5+HtFU0aLwf8
	Kqh4SfLumnYLp12517NkZpETKD8HsoLBlESRv++cz/3lHB8h1MqDk304Er1Zq+joW5afdx
	NtJTd98P9MwJtTjKaX/qTkx34oKpanY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-FXUrZ07HPJqZ2-FzB8FMoA-1; Wed, 28 Feb 2024 11:02:40 -0500
X-MC-Unique: FXUrZ07HPJqZ2-FzB8FMoA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3bdd99a243so103918466b.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136158; x=1709740958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkI08nI25MBj/Qiu+niSA2+bh8FbCRap2BNxrenMQ/8=;
        b=KT+O5rY8xvv7rTudeegnJT3V65SRdkLyZ9h3+xFq6DLs+4IIcQTOX7JxHbV7EOxF5v
         6tFfeXWrD0tebiFMPOaBK1SlgJJ2w3z5fzCDIkUVmE156N/KMqLufAeu/a+Uk8Th9eWU
         3G7f84QKRXNlB4WqGh/lwqHXUEjne6Op1bbr8dC03pFcyRJ9pHxpM1cY1JAE+WndUJGw
         isBqIWv2uHV9bosBdHm7tFE1CantxkRjjn+pLt3jT2uQEqNwsylzpSZ7yv17UXDuwRM/
         mHDxiAGNN2FpOy0hNW3khT19Xr6hh0mHw4hKywEoCBIBlodrpNBQFU5UrKdUD0Giibcp
         Uadg==
X-Forwarded-Encrypted: i=1; AJvYcCW0jeEiCUY3dwhlswJstCnIUNreGKjCMklklVseJJCkpVnAykUcGNYe5PyDXNAuDzJkXO3/VSOlh7IzoJ91d0oJ23tdcPT4
X-Gm-Message-State: AOJu0YwZZgFde/3Rnac0kGn4ftIw931dnf7bLfOz36P1ORhKLFWbpFHm
	yqric061EOjfcMDF+v0vG8lLOUs1RiHKmz6FzqsxhCTjhby6iOerBTZdpAKKxT3F0w6QI8ZgqC0
	j+Tw15lKf+S0Dm/8k4ZZTP+F2j5AnAr+rAVuZ39BhsZa/RZG1Y6hFyJzYCEIjvA==
X-Received: by 2002:a17:906:7746:b0:a43:e729:7e2 with SMTP id o6-20020a170906774600b00a43e72907e2mr2535802ejn.10.1709136157995;
        Wed, 28 Feb 2024 08:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtyaqg0sFs0DnrHSFhtt4BzD32gz96J4Ljw+YU+3qg/ul93g5YaYWv0q12i7xhgLuFYcajjQ==
X-Received: by 2002:a05:6402:3192:b0:566:ef9:1883 with SMTP id di18-20020a056402319200b005660ef91883mr2676894edb.6.1709136137560;
        Wed, 28 Feb 2024 08:02:17 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>,
	Antonio SJ Musumeci <trapexit@spawn.link>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] fuse: fix root lookup with nonzero generation
Date: Wed, 28 Feb 2024 17:02:07 +0100
Message-ID: <20240228160213.1988854-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228160213.1988854-1-mszeredi@redhat.com>
References: <20240228160213.1988854-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root inode has a fixed nodeid and generation (1, 0).

Prior to the commit 15db16837a35 ("fuse: fix illegal access to inode with
reused nodeid") generation number on lookup was ignored.  After this commit
lookup with the wrong generation number resulted in the inode being
unhashed.  This is correct for non-root inodes, but replacing the root
inode is wrong and results in weird behavior.

Fix by reverting to the old behavior if ignoring the generation for the
root inode, but issuing a warning in dmesg.

Reported-by: Antonio SJ Musumeci <trapexit@spawn.link>
Closes: https://lore.kernel.org/all/CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com/
Fixes: 15db16837a35 ("fuse: fix illegal access to inode with reused nodeid")
Cc: <stable@vger.kernel.org> # v5.14
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ce6a38c56d54..befb7dfe387a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -391,6 +391,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
+	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		outarg->generation = 0;
+	}
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
-- 
2.43.2


