Return-Path: <stable+bounces-60728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8F939B1F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE31C21C2C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0914A4F5;
	Tue, 23 Jul 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QZmzfd7d"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CA14A4D6
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717383; cv=none; b=RYe1SImoLp/bf/coAJENPMXQVu3jCNhr3tqcZ/YWrJGOUHOcT/Hj+rG3a8BBllSUOR1hOX8Cu9SJ4DruGROPnr1ZcDE5eiOR1I10qvkfiQVf5BPPVlGZ3yEQqipYgmI/nr0Q1fUG3meb6mHPzbhhTYakkZdlaAz5eiR91u/KinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717383; c=relaxed/simple;
	bh=RXglqfeki+IhT0XnGlGY8olW3Nregu7ITMlr85haCz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDqxhbFlJAU8T4k+Wi7t4ZcP03GA+PBb16Rv04xiIqRND7vsB3fZAE692XW3tHV2VrGOKbMgfjU0jkwpVCeLVDcg+eA/NCGG3XEH8B3RXQNZM51mxtfADtczXOHD5Z5VikXSc85DpOXiEBBd2Pexi27CnSPzKFIkq1hawfryZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QZmzfd7d; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDC34400E1
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717379;
	bh=SSby+veWhYFs/KPIxtuFQP9fWzklyucEzByPv4c+H1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=QZmzfd7dB0K8vSbyizDbW0rjiOZCmzKQDTD1DS/GKZn7AG4xAk4+d3g535VV4abbz
	 ar3HW4NVPjvnOz/KGsXIgKxSammVFQ/gZvAe05PrQvJarHgI7lE31GkWK0QgL/9ZP+
	 I2T57fHCzxg+GP69ZOgA8sMLSdE+c5tm6ZpFxB9tS4AZA48/hi5sg7qBwIxkDkJzmE
	 IEezJ0S+HDr+B8+aoXzEGt4obRJWKtEkyBSBlLpJigktps1XwOfO9cMDjD8QYbM3ZK
	 SicFBUn+YyQtoglb5OsICfmePMbv2tICdaqTS39pdXpUt8kFAQxt8CrSS98A0dq8t4
	 hFdhb3jlihCJw==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso408442a12.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 23:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717378; x=1722322178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSby+veWhYFs/KPIxtuFQP9fWzklyucEzByPv4c+H1w=;
        b=CY/EDrvSEFKBECxSTN/8z/1SZsscVwITd2Ef9429HcxPfkyq+hRmYA9qRIYtWTO4jL
         ChOph1CQvdIcXNbc+wbhzDgEx7lqOcsSd9Z2g7+zjnt+wXEcipaGMSyh+vZKAOoES/JY
         OnMzdAzoyS/9a1PKdnL05nai02YmJCRJXkyTkHSLGYuY8ck6Hzpk3XRjLuy8AKZ3fuyI
         ZkRat+GXp6BEVmZ6oMrOg7rtXw0b7we6L4Fa313CBs7+mDbOSliQuDDmjOA4sov1adk2
         z5zApDkKQGeUaftPIh5kZVWECsfpfY8bVRxosuIer3YW8l/X+pP4fRwiqPCnqkuAatYa
         6yoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFxeLqwiU01bppiscizqCQyryTATWHy5DhvJtTa5cRLvQqrfBNoFK/2odPeG2Bv5NJhDXsNbgAoZJJ9Gw2eAvNpf7Hdb3o
X-Gm-Message-State: AOJu0YwxqRbQgolzUj17Y2UgR2y6/9hRomtnh6AuTCz9aRzhvkEfD5Jc
	64N+Y2KolqAcWRmHChI/nD1w09nIuIf532j5uLYpbCzL+wgx/8o0efe9IgcrYgyQb9A+Vbsh/ex
	Y3h23DK2t7jnT0vHFXqQJWXAVOSa8T7b+NJ5GmW96+04+9LDRopVn0hWynWVKfa/0VssagQ==
X-Received: by 2002:a05:6a20:6f04:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c44f86c92cmr2109996637.32.1721717378092;
        Mon, 22 Jul 2024 23:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDabqAEkCpkyaJ7TFPUAZCurxHz2+fpzUWqrGvdUCtX2upCViYYzhYgk3ASQ8CzhkJfiBe6w==
X-Received: by 2002:a05:6a20:6f04:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c44f86c92cmr2109987637.32.1721717377759;
        Mon, 22 Jul 2024 23:49:37 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:37 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] scripts/gdb: fix lx-mounts command error
Date: Tue, 23 Jul 2024 14:48:59 +0800
Message-Id: <20240723064902.124154-4-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
References: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(gdb) lx-mounts
      mount          super_block     devname pathname fstype options
Python Exception <class 'gdb.error'>: There is no member named list.
Error occurred in Python: There is no member named list.

We encoutner the above issue after commit 2eea9ce4310d ("mounts: keep
list of mounts in an rbtree"). The commit move a mount from list into
rbtree.

So we can instead use rbtree to iterate all mounts information.

Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/proc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 43c687e7a69d..65dd1bd12964 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -18,6 +18,7 @@ from linux import utils
 from linux import tasks
 from linux import lists
 from linux import vfs
+from linux import rbtree
 from struct import *
 
 
@@ -172,8 +173,7 @@ values of that process namespace"""
         gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
                   "mount", "super_block", "devname", "pathname", "fstype"))
 
-        for mnt in lists.list_for_each_entry(namespace['list'],
-                                             mount_ptr_type, "mnt_list"):
+        for mnt in rbtree.rb_inorder_for_each_entry(namespace['mounts'], mount_ptr_type, "mnt_node"):
             devname = mnt['mnt_devname'].string()
             devname = devname if devname else "none"
 
-- 
2.34.1


