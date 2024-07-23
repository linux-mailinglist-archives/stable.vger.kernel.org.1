Return-Path: <stable+bounces-60730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA6939B23
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60C41F22A28
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3214D28F;
	Tue, 23 Jul 2024 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j69J5RcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A914AD24
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717385; cv=none; b=EmUrW69zpHEPlHZJyPdMPn1YIJoBGkzSfYzdncNPvLejqwRdPMxJONUNt9lcNApaLE+tO1qfOj+XNPrgKL+NbEEMyC3v+rIerKThe08oZFntJIh+umrDqv5fdFpz/um/S1fAz6sHe2VSr5muNh2q7YmQKUec/qACK/gllWcc53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717385; c=relaxed/simple;
	bh=0Q5Y0u/59VsSKABp0rrGvwf2iG094BtB/MJhwlXZjN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rG0Dh9VlcKcsha+rQoZAHPT8FqvE2d1B7S1sKNzJ9Ki1ggadYnHJpcksBLB827bLA4xL3Kvvz4T8VeCMBD5bkbKADaUhGFS7YIXLjKre/M0l8ABKJJzsizvm+ZZgROyOTnhe7y8mMBN7sSthqcpeBblCtxbzt0BJuefhuJbas/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j69J5RcG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 292A8400E6
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717376;
	bh=FZLjJAcXmHbLrd6SXPvE5R1r1QmGlvoXd3SP54bkBhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=j69J5RcGCzLUn5UlZ/qkrBR1Ps94MbfOkcZ5rtUQ5gQWBH9Gr+fVIia2RB7KYjZsg
	 bALczu06VN9yjkRlqhCNpx6DlX61YnDYeRz2UvO8xVl0CF5bd0aYG3oR4zCXIFlh+Z
	 aL1mbnh//8Lr2/s9RZ9RU/5SOoft5TZam0TF05hxSsT+E6g9L6yiVCFbLv/I/PzzKf
	 7fgXigCqXefQX47ITElK9prElTe60AU2alN80mbvY/x/buN6zk2E+YbLcP0kFn42cY
	 8IGQGjFmn2YRCCPFc0naJ2m7/wtdBU2TqYjF/Im3C+v2WgG41osL89/r72eSIDHhnv
	 QkfTrMEuqHbXQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb5d93c529so4529180a91.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 23:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717375; x=1722322175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZLjJAcXmHbLrd6SXPvE5R1r1QmGlvoXd3SP54bkBhg=;
        b=SetylwkECcQT288wt+AR4Z52HsVsRefSU/KnorGY0LjGfPp5GC33aWm9adL8vxzB+e
         CR5m6ElnOHdhfANs6FLpWYhAVUIhnrd1GkDOOPVRlM2rVkQFVGwShRmtOMpee+6LU9uy
         cZ7nb3tJf+Bd+dxUCdw3JGDSOrAaNFM43o02DL0aUvo9o7NI5qxercnFVW1PUpwAFIjB
         p8EJAbiStJq+uM3JzDnF0050RZGz9yl7VxsY/x4ybQxEGtd+UfGWKL3bUpb3N7iWN97U
         CSaIYU4JRmFEGpETAFbFYYHL6kVWSAxbFf2TXM/xRQMg/3P64RWXXer3VBUggX9Ig1Va
         malg==
X-Forwarded-Encrypted: i=1; AJvYcCWIVJgPulpS855Kv9TvNw/EARC+S7wisZmxet6FS//gyXDyhwkY20pjrGmmHXLYij8X8l2RGlCEeAao3W9yf1tsTl6oOZgo
X-Gm-Message-State: AOJu0Yw648Mtb2x1bTnlSgnGsN5TLjnucf4fUs6S4qwbMpnUs9eq6M6S
	nK72Eh555SUayUOoPkGrKFdeqmEA7EH0wfXOy8FI9nUpcmw0Nof1jSvRAmEcHSI2fwRIJmQc/2B
	BxbuZyxtybdyVJLcBYzD/inXNO5+lixh8/hYEC8QoaLySg4uD/lH6jjaoxfNZDwSMq6oQig==
X-Received: by 2002:a17:90b:1b01:b0:2c9:860c:7802 with SMTP id 98e67ed59e1d1-2cd274adcc9mr4794631a91.28.1721717374741;
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyHMUKv6gR8JgkHmVIVGpYTx4tb8B3QCJ9HWDbWwLfpovncTtZcuCPQHfoJdvHkml9CbbRnA==
X-Received: by 2002:a17:90b:1b01:b0:2c9:860c:7802 with SMTP id 98e67ed59e1d1-2cd274adcc9mr4794620a91.28.1721717374355;
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] scripts/gdb: add iteration function for rbtree
Date: Tue, 23 Jul 2024 14:48:58 +0800
Message-Id: <20240723064902.124154-3-kuan-ying.lee@canonical.com>
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

Add inorder iteration function for rbtree usage.

This is a preparation patch for the next patch to
fix the gdb mounts issue.

Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/rbtree.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
index fe462855eefd..fcbcc5f4153c 100644
--- a/scripts/gdb/linux/rbtree.py
+++ b/scripts/gdb/linux/rbtree.py
@@ -9,6 +9,18 @@ from linux import utils
 rb_root_type = utils.CachedType("struct rb_root")
 rb_node_type = utils.CachedType("struct rb_node")
 
+def rb_inorder_for_each(root):
+    def inorder(node):
+        if node:
+            yield from inorder(node['rb_left'])
+            yield node
+            yield from inorder(node['rb_right'])
+
+    yield from inorder(root['rb_node'])
+
+def rb_inorder_for_each_entry(root, gdbtype, member):
+    for node in rb_inorder_for_each(root):
+        yield utils.container_of(node, gdbtype, member)
 
 def rb_first(root):
     if root.type == rb_root_type.get_type():
-- 
2.34.1


