Return-Path: <stable+bounces-76799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC73C97D39F
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4913BB25877
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971914A627;
	Fri, 20 Sep 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I495jk7S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFC13F431
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824588; cv=none; b=ZRoT73wKK6Yg4Mi9trM6e3tVDjnCGpW2TlOHlhu5lsSn7W8ynJy/k9xSgfI/p4eTb6Lj2xhVlG/1tsglKT12PMaXCSVHqZk4Z8rV7Y3Sh8TIEhKYY2Q5uLRDdzpVmCkSPNnAqX4YgDD1wvxusMWhF2BBLM1yO5TPXHMMJLiKpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824588; c=relaxed/simple;
	bh=9MZtO4pMsMgZA5NKh6DQkkEhR1hdcxeFeuw9OUT+70g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnEW7f6DyNtPkviQNyhkgcldPAs2EIZvWwYgD2YYzfaSW+QHHtHhxvIa4psipLNBmaMkwNWfpRx8cF3fK4y7Gw5x8Jw6XyNiqkvvUqfG93bn2PdMhPKkm0vpqvwNeL/runpGyJcBhMgY1KXZ6q2RzVLHxFzoYPNQBzGRKwvfM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I495jk7S; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1585712a12.1
        for <stable@vger.kernel.org>; Fri, 20 Sep 2024 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824586; x=1727429386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6G1XyyHmTiq2WDwRPGekYqFouv7LbPfag0LTJ+NgWc=;
        b=I495jk7S9MnQ2zQgtb2uFv8rOEBrk7x4Sz7x7W98YPmESh5JxuYjE0QjyNVbCAVazU
         R0l2C04aSlixTqHZRZmUcB7Vwe7YgPRZt1JJBRgO1jsXIM2HfLkwB4iD13eJdnFSvBa5
         rvfX/4m7gvnWQnG9lgI0+xkJfq8Ys9+w72kMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824586; x=1727429386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6G1XyyHmTiq2WDwRPGekYqFouv7LbPfag0LTJ+NgWc=;
        b=IKci1zqeq4GQpkt9PMBJvmHSs7s3rJsAmDlkaQ6us12gTjHb0521z+XJYuJemhs+Zn
         ICwDW2w6WOprizxD4W7t0jfeOQ+slPmN0xaWcwZQDyZhWdEh389Tt5G85WXLpd3nHhd4
         OC9s5B+pHUa3o+PZNQHdEHNKBy9bksXRG1zmKrKMVydozk80fbdIqJ1AWyChJC5IvSrf
         aON0PeOTaLHg/ycwL6NEDWpGEupJYXsdneF3N8dCwWhbmt6N99sSymoibyQMEXn+qpMd
         xaH9y7Taefww6IJ9kWFoMW/IoAWMj69D5iJmh48P/PMATrRfm4J/gidEhsonc3QPhF9L
         xZGw==
X-Forwarded-Encrypted: i=1; AJvYcCWcJZGUIislYR/OqAbW9dLS3duTmnLnmGaxHvmVtdJfrgee3sO+wFiEpuw1oDhnH21Q5S9HqCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+EDjxozuBAJWzsdlI+bR54aVlDYXgAZxPnv+7fQ7Y/nRaiqM
	Xy+/s1ai8mDiD8+TMUEt0HBg4HC/EcY2pMMVVX9uCxzhsC5Z4LZf2ofDPCi8kQ==
X-Google-Smtp-Source: AGHT+IEou51vRerlXYIhSSEnuZfBRBLijez9RDl368UsUl6lm7Q/6/Jas90sX+8oRjoaZW6UnWnZpA==
X-Received: by 2002:a05:6a21:83:b0:1ce:d403:612d with SMTP id adf61e73a8af0-1d2fca71fe1mr6745387637.13.1726824585788;
        Fri, 20 Sep 2024 02:29:45 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4a5a77edsm9097767a12.25.2024.09.20.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:29:45 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: pchelkin@ispras.ru,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: chenridong@huawei.com,
	gthelen@google.com,
	lvc-project@linuxtesting.org,
	mkoutny@suse.com,
	shivani.agarwal@broadcom.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	cgroups@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Waiman Long <longman@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yafang Shao <laoar.shao@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v4.19] cgroup: Move rcu_head up near the top of cgroup_root
Date: Fri, 20 Sep 2024 02:29:36 -0700
Message-Id: <20240920092936.101225-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

commit a7fb0423c201ba12815877a0b5a68a6a1710b23a upstream.

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v4.19.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1803c222e204..4042d9e509a6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -467,6 +467,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
@@ -476,10 +480,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.39.4


