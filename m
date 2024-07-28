Return-Path: <stable+bounces-62024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142593E216
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41250281AB0
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3E18308E;
	Sun, 28 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3HlZ27G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003441741D5;
	Sun, 28 Jul 2024 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127751; cv=none; b=I+ZWoF9vnFmmFI1ov4YBVYmPZIz3em3yzirOsORLl+BcT8t241WIaZrbwD1iSdB5OP34OnKtFFahxHBTNviflV6PzE4i+4ShRdfLacqSZgYuLrYmWlR8/cbM1ORcC8xDOJgGSnzUku85VlF4IRtCciAOycEt1WZ7JUzYZxvmN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127751; c=relaxed/simple;
	bh=NtQtmXw1leWhSEYKdEncehqwVU5K3dFsmXR1G8gyOIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewjAut3ob06dzyTxA9l9/vw4LkKZaTAYRsezPRgf4zn6xXCQBn4fBkFYAPz7Za9jtmCfmc18SKg28ONEP9R/YrcL4/CpLUkZKUDzTb5I+frmymRKeif1PoNWP1j60gUkqWaWB3lmv1qqT755E7rWLoebPZcCxR8WtgBRJJXAp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3HlZ27G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC63BC4AF09;
	Sun, 28 Jul 2024 00:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127750;
	bh=NtQtmXw1leWhSEYKdEncehqwVU5K3dFsmXR1G8gyOIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3HlZ27GcV0sax5H8UsXwS4voLsVWTI0HjxeP5vFNeYi3zjznzCDNpu+UnHA6nQoN
	 9JbE9JLaM41QjlZQ/5sRCCk7Pd7V+hz7dR/b0nnj5gaP7i3ljveHLOa8JWhiY3a6kC
	 mFxUG9V7VDjjVTe1S76FUoetWp7HgskHCfciFeM5uh9bCoOTXUeaYQRZX4sQ0m7eb4
	 B37z6Y42xN8vp6R4Uyy/HbaFwV86aTp+40ZqviQXd9E8jTpZ3f0gd0AtEV0pYqJVA2
	 goiBxsSv6HEX/+k/fesi/MEdSeC6+NEmqlUKOifWpZsWBpAAI5QSRhIEn2WxgRvB50
	 sVWg/78hISp0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 5/6] debugobjects: Annotate racy debug variables
Date: Sat, 27 Jul 2024 20:48:58 -0400
Message-ID: <20240728004901.1704470-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004901.1704470-1-sashal@kernel.org>
References: <20240728004901.1704470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5b5baba6222255d29626f63c41f101379ec5400b ]

KCSAN has identified a potential data race in debugobjects, where the
global variable debug_objects_maxchain is accessed for both reading and
writing simultaneously in separate and parallel data paths. This results in
the following splat printed by KCSAN:

  BUG: KCSAN: data-race in debug_check_no_obj_freed / debug_object_activate

  write to 0xffffffff847ccfc8 of 4 bytes by task 734 on cpu 41:
  debug_object_activate (lib/debugobjects.c:199 lib/debugobjects.c:564 lib/debugobjects.c:710)
  call_rcu (kernel/rcu/rcu.h:227 kernel/rcu/tree.c:2719 kernel/rcu/tree.c:2838)
  security_inode_free (security/security.c:1626)
  __destroy_inode (./include/linux/fsnotify.h:222 fs/inode.c:287)
  ...
  read to 0xffffffff847ccfc8 of 4 bytes by task 384 on cpu 31:
  debug_check_no_obj_freed (lib/debugobjects.c:1000 lib/debugobjects.c:1019)
  kfree (mm/slub.c:2081 mm/slub.c:4280 mm/slub.c:4390)
  percpu_ref_exit (lib/percpu-refcount.c:147)
  css_free_rwork_fn (kernel/cgroup/cgroup.c:5357)
  ...
  value changed: 0x00000070 -> 0x00000071

The data race is actually harmless as this is just used for debugfs
statistics, as all other debug variables.

Annotate all debug variables as racy explicitly, since these variables
are known to be racy and harmless.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240611091813.1189860-1-leitao@debian.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b055741a5a4dd..d6ed4681d2e5c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -81,16 +81,17 @@ static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
 
-static int			debug_objects_maxchain __read_mostly;
-static int __maybe_unused	debug_objects_maxchecked __read_mostly;
-static int			debug_objects_fixups __read_mostly;
-static int			debug_objects_warnings __read_mostly;
-static int			debug_objects_enabled __read_mostly
-				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int			debug_objects_pool_size __read_mostly
-				= ODEBUG_POOL_SIZE;
-static int			debug_objects_pool_min_level __read_mostly
-				= ODEBUG_POOL_MIN_LEVEL;
+static int __data_racy			debug_objects_maxchain __read_mostly;
+static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
+static int __data_racy			debug_objects_fixups __read_mostly;
+static int __data_racy			debug_objects_warnings __read_mostly;
+static int __data_racy			debug_objects_enabled __read_mostly
+					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+static int __data_racy			debug_objects_pool_size __read_mostly
+					= ODEBUG_POOL_SIZE;
+static int __data_racy			debug_objects_pool_min_level __read_mostly
+					= ODEBUG_POOL_MIN_LEVEL;
+
 static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __read_mostly;
 
-- 
2.43.0


