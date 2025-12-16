Return-Path: <stable+bounces-202715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C565ECC46AB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF25305160C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCF21773D;
	Tue, 16 Dec 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="qqaOUwsW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F432222C8
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903420; cv=none; b=Evsb0kwaj7gV8Vkoa+fEnzcumY5MBRTxmtnNW1FQcGHHscYz53CacF97Vw9BVsG7bJB7On0CADWuQG5GmA4IGxRPQIL836dg161ONizAUHQlgZGLJf4VKeUkNREfe2AzsEnpCvf/hFv1JLgqppNeHORyp9grPjb1VplahAkOIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903420; c=relaxed/simple;
	bh=c/vy1OQJySxIp4gpz4dJ3CMCm6lvu5FSBlUmBdaeNbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiCfGAx8IB+XQm5WNI8z7cglPW9Pmre/alhuNzyZFrPd/HU7FF7iY2kYXSFwhumeQUx7V2kMJut6LYIEzr1zrwjSHF9qyuL7+vi30X/BTlBcwADxMNFBX4rK0BdqyVYSKYOgv6SvNd2V3FXbX8Fz4Tjyxd+8MLztNk7bUB3ZqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=qqaOUwsW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c565b888dso3329316a91.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765903417; x=1766508217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuaSItuMnaOwvl8gzGHA0YebmR1TZFEIwXuhDX+7ZwM=;
        b=qqaOUwsWC4aXWvsXocjwRvgv3NhpMDxH5yxr7k2YLcFqQSjujMEee82qUPMSvasFRu
         XGSnqgh0pZ9kRx9b2+135hcvCZ8ybq2eZIvC9mzbhdULweKurwyszw8Jo9x2InAlNxXZ
         lOIjnQ4+vur6S3fTywwaJwzvxNAUx7Zzcr+JC5y8aRTQktcdovTVInA8R2uvLTs4lN6f
         cckizyMEUVknw+VV5cWrMivbL0nGGGQ8VMYcigqqkgb1I6W3l4Qba6iWgl7dZX3FdGmV
         Rs9KcOQzev8+463by3sJU/sUn82un9rNKwdZOkk4rlYWccE8OG79WW79+egjdyYmZyfz
         6H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765903417; x=1766508217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuaSItuMnaOwvl8gzGHA0YebmR1TZFEIwXuhDX+7ZwM=;
        b=GkCvPBR5u9OuPmz3pGN/y4o9xdK2jYrV7tomufAPFnLzKHtiTKubUNQjyDzHmPOKnj
         qdvvuACGq4Gi/Vwb2ZBztCwiQiCkX2VUOh4EbUgX7Or5W5chckyVuB80cIlz2TTTuYfO
         nxSpfod4jVojecxD/qAgo7s6PEQXk12YaebOtoYO6FXnXGIfRTcAOJokfzvZm8T7r4Cq
         f8AB7QuMu1Vr2O/Z0LSpbywJa3D3UtRAt4saQGssF6HwHTMnsV4lG7RVKnE2463AkFL+
         LigkY5apZCUpF4lIihurMgju+qfuuFsleOI8P5REMqYcLmXjiXV1RXkfC0/e2oxa5O4N
         uk2g==
X-Forwarded-Encrypted: i=1; AJvYcCXBAWPIgeTDB4NQrySeidMs55JFiMXXKCpgmPbDZ+7ABjXP4NUyX8c4BCPyE/RH2QzGxf13f0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1L/s+sVhoXQDvv31zcHXy8fdcvZIsdJu6MBmp7UHe2/NWpRI
	U4mHguIrXU3EgVbHtERfOqeb2uUTe1TRkAdMibsdrJUil6UucYqeNYp7Y62d5XAFmw==
X-Gm-Gg: AY/fxX4QX5thuLTKTslvFh6wafmynh/YpFA+2eEl89m+5ByfkhHe1wNFqIHXeYdFg5c
	gkqouNiDUV+ngQxdBm/H7VpDgMhs7TVo40pq1E9YYVHVgx9cFidKOu6RR3dlSBFx2vts/wJdxgZ
	ALCtJt076qoPIwINLck+rcvOGE/1s0jl8uAJ7ARQEO9hcHtHIGkv3XfO22jJ/diC/S9r4lgvekv
	4T45uEjoLN72BI/53SuSl0o7Hc3GtkSE3TZtXuBFuSisLbncplCNt2v/NBXZaYFxsCba9m6cevv
	XYrMY/QsL+z+wRIaAk37+LVjCzwNOws6kB5kW5ayA6cfgWj7w39zbaeO8e62d/0KMrFAEe2/aRa
	/LaPv1mI/45ol/bozhSZLulLyRWiOgr58AdmHflci+XhKqbtUD8RZr1GTZkvYRVhTM/6bE6SDLn
	+G7gnfdUsEv0NKdEe9OPGSa8gtHGnNuaTHKF4uA1PRibPvdadt7zx9x/3+Q11Z
X-Google-Smtp-Source: AGHT+IEgIM6Vd4gAY8sPNiHEJn4U8FXjlXYPWxVnBxYlbkpoUgcSNpZj4PdQPi6CBSdaTfv1RYmQDQ==
X-Received: by 2002:a05:7022:628c:b0:11a:273c:dd98 with SMTP id a92af1059eb24-11f34bc70bamr10606777c88.20.1765903416936;
        Tue, 16 Dec 2025 08:43:36 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11f43288340sm20028181c88.6.2025.12.16.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:43:36 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: Paul Moore <paul@paul-moore.com>,
	Will Rosenberg <whrosenb@asu.edu>,
	syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Oliver Rosenberg <olrose55@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] fs/kernfs: null-ptr deref in simple_xattrs_free()
Date: Tue, 16 Dec 2025 09:43:35 -0700
Message-Id: <20251216164335.4066425-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025121653-overfeed-giblet-5bde@gregkh>
References: <2025121653-overfeed-giblet-5bde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There exists a null pointer dereference in simple_xattrs_free() as
part of the __kernfs_new_node() routine. Within __kernfs_new_node(),
err_out4 calls simple_xattr_free(), but kn->iattr may be NULL if
__kernfs_setattr() was never called. As a result, the first argument to
simple_xattrs_free() may be NULL + 0x38, and no NULL check is done
internally, causing an incorrect pointer dereference.

Add a check to ensure kn->iattr is not NULL, meaning __kernfs_setattr()
has been called and kn->iattr is allocated. Note that struct kernfs_node
kn is allocated with kmem_cache_zalloc, so we can assume kn->iattr will
be NULL if not allocated.

An alternative fix could be to not call simple_xattr_free() at all. As
was previously discussed during the initial patch, simple_xattr_free()
is not strictly needed and is included to be consistent with
kernfs_free_rcu(), which also helps the function maintain correctness if
changes are made in __kernfs_new_node().

Reported-by: syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6aaf7f48ae034ab0ea97
Fixes: 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")
Cc: stable@vger.kernel.org
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---
 fs/kernfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5c0efd6b239f..29baeeb97871 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -681,8 +681,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out4:
-	simple_xattrs_free(&kn->iattr->xattrs, NULL);
-	kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	if (kn->iattr) {
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	}
  err_out3:
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));

base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
-- 
2.34.1


