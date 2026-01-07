Return-Path: <stable+bounces-206220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A2D00192
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6F830E068A
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18F32D0D0;
	Wed,  7 Jan 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ228q7n"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AC30FF25
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819741; cv=none; b=rbSGJGBMN4+Wb3RUNB+9Tj3yj6ZwENsUYHcyR7nyZ18cmACrSlXQ91bTuPZkLY4oJ/Klsq+V9xaZ8kkDIk3bG0iqCamaMqS+4jHlG9DT96542oJGnmZzQy4HsEetuhFWt8xtJGYrqgGUDtUWxaMlwqX0ZaUZmatiqlSE9ZgRbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819741; c=relaxed/simple;
	bh=O4kJF9S8XzpGPOZTeoLxtkvaxDvktVpfrz2nWxquEuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfCEHyNb11NiqpfJx7u8PkQtcabkviJLZW43PstzIDDjJm5IzzIeSdvjr5JLrKYhmEdMtUkMORNzibHYwNeeDdkWQzYC4UbRXrsKLRR1hiu5TGQrq/xOO+Cu61+sbPnnq4/23BqCrOjo18stX2gCnik2MUGJ7bxjAqm8wGp1mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ228q7n; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae38f81be1so2145918eec.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767819738; x=1768424538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJJ0g2KBjvWnpkx/2r0sdFCRqcFFwKJ2lW+TX7dGrPo=;
        b=YZ228q7nU+FpFr8bxyTL76iqoG32WY9xJ+K9pzlxW8VuxBZabMuBFAgj3LkdxQmyfP
         ocmwlOXATpEs9sGfgR2Bmi0OGNGLyuS7Vt88FWTvUe7/FdFqQktOuMLEtTGRCowjIc6F
         7MV27qtOpokvJ51mWpaexNliACUHhjd5wcHOFmjh4M8SsqrjWkZagWMzm1qtbmkNYkX7
         8xwn7Fy/eLxm/bz3DXeiOneMOU2mufMHPrctG+2f8KpPlkBN670L1bvMmnpiKy9amdxc
         +BEoKFMLIEcVVEUejpGE+pO24FNgEE1ceTuiEjrItp1l/6DPxq+FpDftivcr+U7aFn6a
         VivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767819738; x=1768424538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJJ0g2KBjvWnpkx/2r0sdFCRqcFFwKJ2lW+TX7dGrPo=;
        b=LzQFKbtreWXodqaS1LqgxUWKzMxC7Up31RpvwTuFHwXO6JdXeW+7Qi9wVOWe3/M96v
         JtbM5OjoeWx26m6NLMtGUVunqF0L9ynv6oByb6WvnFv3DHtw6YLpjGgo1MXdUmQBfU55
         wfku3294N3lXggIsyK3d75FOnGMsp7CgJw1bQCsytOb5gSim/ossUj41wwDaceZW7aH+
         M1sogmuUXqP43gdpt3Pvh19py5HTcs6BASoqBpj8BIvxM1qNtJNILblyRKVon965CcTq
         X4ZF6zKSR00zc2FARaxqy6H2CGjkYj2btcH75mdmW4TocbfP9fv0c/EyjdXBJBsyeC7v
         gJaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZj2ixngbKC3NR8ikERASht9Wi4i7RgmBOMU11Oge1kGTB2Tz9RS4NZ18WqZoonF2pnRKKGZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfkBvYcpBph+kxXPUHe6E3CmcwNhaoUQ669G/GJBijohAaMxs
	eZB/W+hE1goRHNCBjG2NX9yFbMN549XXzGJ/FXaA4p6/eSTCydP7LRtY
X-Gm-Gg: AY/fxX6+DCChuhCBT4CGgz7pYToxvUXa3h4PPKqddD6E45rsPTf5WOK9zZETdIg6AMz
	VkRyPH4TNGPuoqb6wpIKP5pBWNgOtvbCBSFgDosb8wbIpwpTTnAOs2krJkZFVhM+E5glUDj5upx
	lsALpCpfwreBU5IeNyIGslcpa56c7o7LJzN5cvkeMaI4yppkyqgKJ/Ez5unnpDHmJy1jLk4Upbp
	0HMQGYF8L7/HibzLMCUsnxP0q7M02eWb0ltj42apXnoG1RRbeWOa0y39JIRWyLCRxmTGiKrIuOX
	No+yDFNBoiCH+Zui3fX3AwvfAuuHvZinPiDZne8q0MIyqPpCmIA4wG+nTBeKnWMUiuG2kda7AXV
	0FE+WlZQtj3Lwv/aklv8E22YHdyIs10MvZYOh2t+VfBwG4/StlRrWw+0x1tjIUgi9n2RL11aheS
	TBp9FmvxWUh06buGpPbWdV04Np5Wa8S4k1rtX0Dyd0Cjx9/nF9vExJ4/K4C+Dc
X-Google-Smtp-Source: AGHT+IFiXkVljkFfXOH3V04S1IN5M4BxUMOD54SyXL1mMom6Qzw8P2Jruw0xmxP9w0kMsCs2QmlqOA==
X-Received: by 2002:a05:7300:4347:b0:2ae:582b:db80 with SMTP id 5a478bee46e88-2b17d1f023emr3128728eec.9.1767819737617;
        Wed, 07 Jan 2026 13:02:17 -0800 (PST)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673b2esm7730320eec.6.2026.01.07.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:02:17 -0800 (PST)
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
Subject: [PATCH v2 6/6] ceph: Fix write storm on fscrypted files
Date: Wed,  7 Jan 2026 13:01:39 -0800
Message-ID: <20260107210139.40554-7-CFSworks@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107210139.40554-1-CFSworks@gmail.com>
References: <20260107210139.40554-1-CFSworks@gmail.com>
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
many, with 4MiB objects) and correspondingly degraded performance.

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
index f2db05b51a3b..b97a6120d4b9 100644
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


