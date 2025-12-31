Return-Path: <stable+bounces-204312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C94CEB223
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795B5305F33A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B82E62CE;
	Wed, 31 Dec 2025 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c09rU1ii"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9002E6CA6
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149735; cv=none; b=QZjI1tg2myby68N0WnvkUgknNIQPHjXjghPyQ8x3XXjuhRfSvfTOrPkLQHzFDhrl0RDaXu/dkyph4bxGGU6pGPrKBcjZbGyA53jvBJyL9zKYBBYnL/Mi9/PsJPBVN3/MwHnPrm7DHsnryq1fgBBiqSp0IGn/DYVTthDGKi1GXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149735; c=relaxed/simple;
	bh=ZDstEKMD7WmKxZZCLmwJ/YSTgZ+JJejC8hgxByR/0Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COX3HIqTgMZLrweHimaYQz+KLLvVlqIQvJcuhXf/hd/kiBgSCSNBuxgTthWcBwEXKByFXsKIO1yCmjH0cgxcSwz1NHGYAdgOkRX22tI6rBYjtSRf/A6s/1b0RnzijYhmJjx65bfXLYI05OLZ5gpOrKtaFx3Q8KtrbyfzoCwbkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c09rU1ii; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so4966974b3a.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767149733; x=1767754533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHQgO64N0mSOshA8/jcIaTzSFR+k9jE4B9vdvYmYNSA=;
        b=c09rU1iiRIUXGYCG+xJjTF/72ONz3lxVQWa1Cu5JmKGKTpNKxS05RLVd4/BbA/mZg8
         rWJdzmu3QGd5Nq5UMThcVlBk+/ES9d3U2ffpjcmBezEqXt4fUYApXh9hshsgC+R+yURd
         8KlwQuSGHunMeePGhaZfKUFnWv4bvHmod2NlP7nxQ9eKn+zTC2/d9V0y+LAhh0f1QHZ1
         6Js1DSLhfM4LRVyrdiEocPlFZbioggMqsCfzajAChbu+5GGcPKO3rDQYOaNpuJKxiuIv
         oUwDnlnOjNz56pxCEPL8T6IluM/0FqkE5FoZtfgrFIv30qPeCbSTBqEA3ef3XkuWGOtc
         woBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149733; x=1767754533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHQgO64N0mSOshA8/jcIaTzSFR+k9jE4B9vdvYmYNSA=;
        b=lIwW5mLHWkYaoVmmjDYPxt7GKcvJE4FYiFgGmRGVMIF6tkrz1rdM/cVRKrVpMTKvCX
         ygPy/0LVEBq94skSF5ng3tFhZ7S1sHD2jwQ5xPfJ2at9DZl1mJ+DvFWVSzVOyZBMAVdI
         TjHz6GaPHHycY/cml9dd2w2JBtbNJvyR2rcN9Tj1Jdyn0pWacoAyixCRZrDDHaXS6FhG
         vutzaB5flWp4l5JaN14p6oVE5zp2TNM0bVI0HFz5eS4pY9Yfg+IoFc+EdQVOf6p1FrCb
         LGB8ngSfP11ZrwOGeMUZHU03wt0Heffja0XUDJD5Vxo48n8AtxJ5Rfn66Dhj4Pi7aHgG
         2y1w==
X-Forwarded-Encrypted: i=1; AJvYcCVqxML/6WN+FrDr8zrsq8SEhjwcI6gZQwqwCvuXPwBvzYhIlRgpZyXmzTIHAGj0ixv69ZHn0qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsyqnvINZpl2J6DrEpUkj0wwrKZWIFE5rz2FgK0SaC9gcpsjD
	LGLxjsUsk4K+wbytrXiixsQiBjytfZHDQK25NxF1ZZbK05ETpGFbNfDd
X-Gm-Gg: AY/fxX7YbnmuJzRJO3GQ7YksLPUr3eIyZ+D2SW0PS0UJhz+LizaAo96cl2XKgOct3vw
	LdCvcRAICQ2CjQMsZvg+onhy87pekLhK0Y1mzrFfBbGPgtc/CK3f2MXZ7x3FOUFIrOueZsDXp9C
	rttbXFYcUbS3xUMz4cf3wSrrJahHNJ5i5eeAr524YE5g3DT8YjtfKDk1fbidU5/oEHTwvFpSWAs
	m7Bif1b/0X9TYgCMsNhVf6MhHGRkn5j6i0u0rsPFUOenrwdoJh0lnnTQqwtR/slMXo65bN3vrM3
	mPWm1w/oiJBxHvLV/ZoZTuvtxxjLZwcckncc8YbSAbFiLuYrKcvuMhabWst63l6iRMAIKCuqHcT
	CZYPYW7SAAdglHNa6sweRUxry+tqVa8wLNhJxQaIVxPsdJifFdls0Tt8xQKRit5emEwPfkiIGEf
	D4nQAI/mkMc5+8
X-Google-Smtp-Source: AGHT+IE/6+hfXayWM1JdWA9o6vJZIBu0G6SoALMz31yXzlT5yBq/IAL6FIfaJeCzxB1pm8U2r9/1vQ==
X-Received: by 2002:a05:6a00:8e02:b0:7b8:8d43:fcde with SMTP id d2e1a72fcca58-7ff52d3852cmr33628015b3a.8.1767149732685;
        Tue, 30 Dec 2025 18:55:32 -0800 (PST)
Received: from celestia ([69.9.135.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e892926sm33623646b3a.66.2025.12.30.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:55:32 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] ceph: Fix write storm on fscrypted files
Date: Tue, 30 Dec 2025 18:43:16 -0800
Message-ID: <20251231024316.4643-6-CFSworks@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231024316.4643-1-CFSworks@gmail.com>
References: <20251231024316.4643-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS stores file data across multiple RADOS objects. An object is the
atomic unit of storage, so the writeback code must clean only folios
that belong to the same object with each OSD request.

CephFS also supports RAID0-style striping of file contents: if enabled,
each object stores multiple unbroken "stripe units" covering different
portions of the file; if disabled, a "stripe unit" is simply the whole
object. The stripe unit is (usually) reported as the inode's block size.

Though the writeback logic could, in principle, lock all dirty folios
belonging to the same object, its current design is to lock only a
single stripe unit at a time. Ever since this code was first written,
it has determined this size by checking the inode's block size.
However, the relatively-new fscrypt support needed to reduce the block
size for encrypted inodes to the crypto block size (see 'fixes' commit),
which causes an unnecessarily high number of write operations (~1024x as
many, with 4MiB objects) and grossly degraded performance.

Fix this (and clarify intent) by using i_layout.stripe_unit directly in
ceph_define_write_size() so that encrypted inodes are written back with
the same number of operations as if they were unencrypted.

Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b3569d44d510..cb1da8e27c2b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	unsigned int wsize = i_blocksize(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	unsigned int wsize = ci->i_layout.stripe_unit;
 
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-- 
2.51.2


