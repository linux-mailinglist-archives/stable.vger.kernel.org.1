Return-Path: <stable+bounces-194654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965AC55815
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B618734BC49
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F02741C0;
	Thu, 13 Nov 2025 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REJHIpeQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8C263F28
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003108; cv=none; b=e1WypOkRZjIfjfai3uKCaiMMZusVZVMHrjn6ndonVLHLav11VUs2jY+yAcZPwRkHtpNZiY33pPZlPA83iSGXUIKZf1jxKq3FzWas8ihI1iVRVyeOY7M7y8PKH+Hf2r/Nzm2Z3nqfwlgZP+IlOWEAC+G52y3NdEVx8irvm0Zb5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003108; c=relaxed/simple;
	bh=O9zV8bAoUVd2ZzjVizrq0aVJWNKCtlsakqD1EEwfl7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sp7F69W49juKCeBrmIHh87Ip60Z5Pq0lVq7lCCCMhZ2OjR1U4J2Kqd5A8pDT9TLEQpxT3PZDVtjlPbytZK3QfYbXHww00R8NRtTh4URB9bsumispSnczS0DSbkLKsG3Rhn0xBnTl0vN2Kfdu28CJCe3eLfaEIEJG/ueEjbe1ICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REJHIpeQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29800ac4ef3so846115ad.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 19:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763003105; x=1763607905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79ZFMgyqh7NLEU0bjPwPQ0uTiSQzLvP0WrsYbbAHZdM=;
        b=REJHIpeQMqCyfBtuqBxxYToslfUaJjbaFtZz5LA1BkKaq31+IeB3Jvot6lc7oTh8dp
         N5v4UFmTRDFJx7ISkKvslA/ySRIhVewBJ8qPZk76bAgxgkQj5ATGEgEzwWVb3S3TWISb
         evA8YWqeqgy5RO+c8aw3FK8GLXvj/xcxXQtIqpiUgKY+C2ZYDVSh8sVWfFIjPLi9UYo2
         rAJKukHDY0JQVbtyBbmACUbHzS1KtmwLOQc6TZOEDZ77IOCUeQjSq0EVwKxXBmrRK5vJ
         Bk1xdp9iGrjBqvP0BG6iPTRAy2LeOO5NHyELTzxS3M4OAVBWlF+PoljBx+D6BjJENoPx
         +1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003105; x=1763607905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79ZFMgyqh7NLEU0bjPwPQ0uTiSQzLvP0WrsYbbAHZdM=;
        b=SlmjEW/TtTlDc5VwUPnOvK9N/ofHcom2KgSS1xgPuGHglB5g0dIKDbyU9Pn09KeCYq
         G4EtI5ebX19QuqTa+KTNvxl6Zw3oZdWOLqFWiFfHn2exGSk2X4U42mhU8FHdqWAS7aI8
         RJ6NFsMwWzu/Vt+ip/2LfK25eus52b7xfUQZsNBldusNY1ny4OtmCOuIewUxexdXzxan
         VPmNAx7vsfbo9ypnXMKGO9StCoyO/H22BcS18YO+HV7fI6I8HBPqGJ3uxFBDW7W0zmWp
         OvxtnCSi8pJqWdzh+wyw2vc56aYRiywq7Rf+93rA1RDJlSsAgRiKQsSXRfonSHkAE9C5
         kPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFQQos2w1tB38SrgZ5O+Z07efthvmCFUxq62DnfL/0ufSur7HK8qxABMU7oJTo1QAkBgBHNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPHmgCJZp/y6CKRnh0HzNBnH0XXXZ8fP8OJZznQWBDhL158Yx
	+Zg+zhyugb2mClwNFB5t2PG5zsop9QEclAuqvLVhfmBiqPltYGToldec
X-Gm-Gg: ASbGncsqDexMhhWFw0TfKLAGa9p7mzy4E+pS5qEpv8u4oNx6HGdoqMPEJoOqmTHwLbg
	HgailNh3u6lUC72Y9/eDB46A9N2cO8y2K2//OsT2AiWaJE5/7AUYRzLmHxKtEfldlC6kStV48xM
	HZQyb5caZoJ7JWc87wb97y3FFKjVru2arnsE8PVS0+y3nb4m80YwXUM4WkobnZgTeQTK6lpUGxi
	+VNSdD7ysEF0Qs/7GXdXGTjjCEYiKdbnnwoUkX3ek/i3oykp7uGVL1uSSkJTg8+fA4H1GCJKCGS
	dazUdi6c9rR7sn6FcWL6qDeDEHawXXjR1Qs4Ie4ql4lX898zOclkbsFZ6auviMFmGFyQVU1VznT
	G4tZ6Qh9y5e8w//Y3+iBC0MxmLJ/VzmkFzz2DAt1bgkDG5O//KC9GRugRAqTuRCvKN/QBbPDqXn
	AxxQsmysGfHY62M575RvC6hqr7/bdI3H4QZ6GjQw8GJprVVmMr370cpjpHqoqgeg==
X-Google-Smtp-Source: AGHT+IEw90g2Hzt/8ufbJVQWlDjtChK6HX/U5OEBYjDIouhOWonfZhzrah1NQrxITRslczO8iIzXZQ==
X-Received: by 2002:a17:902:db04:b0:295:247c:fb7e with SMTP id d9443c01a7336-2984edfb282mr36630385ad.11.1763003105365;
        Wed, 12 Nov 2025 19:05:05 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm6739945ad.7.2025.11.12.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:05:04 -0800 (PST)
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
Subject: [PATCH] ksmbd: vfs_cache: avoid integer overflow in inode_hash()
Date: Thu, 13 Nov 2025 12:04:53 +0900
Message-Id: <20251113030453.526393-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025111234-synthesis-wimp-7485@gregkh>
References: <2025111234-synthesis-wimp-7485@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode_hash() currently mixes a name-derived hash with the super_block
pointer using an unbounded multiplication:

    tmp = (hashval * (unsigned long)sb) ^
          (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES;

On 64-bit kernels this multiplication can overflow for many inputs.
With attacker-chosen filenames (authenticated client), overflowed
products collapse into a small set of buckets, saturating a few chains
and degrading lookups from O(1) to O(n). This produces second-scale
latency spikes and high CPU usage in ksmbd workers (algorithmic DoS).

Replace the pointer*hash multiply with hash_long() over a mixed value
(hashval ^ (unsigned long)sb) and keep the existing shift/mask. This
removes the overflow source and improves bucket distribution under
adversarial inputs without changing external behavior.

This is an algorithmic-complexity issue (CWE-190/CWE-407), not a
memory-safety bug.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs_cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index dfed6fce8..ac18edf56 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/hash.h>
 
 #include "glob.h"
 #include "vfs_cache.h"
@@ -65,12 +66,8 @@ static void fd_limit_close(void)
 
 static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp;
-
-	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
-		L1_CACHE_BYTES;
-	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> inode_hash_shift);
-	return tmp & inode_hash_mask;
+	return hash_long(hashval ^ (unsigned long)sb, inode_hash_shift) &
+		inode_hash_mask;
 }
 
 static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
-- 
2.34.1


