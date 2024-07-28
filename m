Return-Path: <stable+bounces-61991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6E93E1C0
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23081C20B04
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E543144;
	Sun, 28 Jul 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz1EAb5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCE42056;
	Sun, 28 Jul 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127681; cv=none; b=bILdVmavzq60BjzbNPnAxG6EP4HZQD3WbZUzlFw35AqXXGcIM/Pmdg4hxoTROkxH8bCD5eDsnYhhZfGl2Ulnv99GnwknUVECth1Iy8qUBv2JHWmfoUja6JPkThV2c8QACBLSS5f8c9Br3vFaXYnLgF9FGpDuddiWCev0mQNm4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127681; c=relaxed/simple;
	bh=ncLGoDuk41L2i7dbJYgfWKI1y6PoUooW60RNXH7iss0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK2y4T7bgBbQ5mUKNV10+3mRr8pMTbNtBE8oU2L4rBcRrPQurHyxo8pJ3ovgupxnqFp+7P4Rpl18P1iF9daLSGc+phQCJSbt6bSeR+dl1hPTUPLAx8ozXQFRKw9ZEc6aEfAFHbM1NQNjwVypZ3DoD/EArvgBFvnOI2pILF88Mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz1EAb5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEBAC4AF09;
	Sun, 28 Jul 2024 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127681;
	bh=ncLGoDuk41L2i7dbJYgfWKI1y6PoUooW60RNXH7iss0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mz1EAb5jsgrQfEe9EJk0l4+B8G61Ix0eW6QWdKdI/GbZsEFRDYqH64bKclohlr0Xu
	 n2ntTLunmDqVwHZ65Sab6jSAS+zkknIySSUOHQAJpNBaokAh5se1sQ//sTSF1gpbvk
	 icRbwU1O8HEGVtyAQxROcrPWQEl/UUR2fEOtOkt3Ibt4VejC87ZL9u+D2vWyIeSCDZ
	 ro97A+VwCjDyeuSt9PgcWuNekYfLr7AIYEZyiVHicN+vwwWbqLGnDyfG+h4pNrCZE9
	 y+UxfWfYijUzW8owi6Cw6jAHmMnkTUdZVQySIZ8JtAa7o/e9r25/sYtrznrMFDn6OJ
	 KZ52ZxK/nNuyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 11/16] debugobjects: Annotate racy debug variables
Date: Sat, 27 Jul 2024 20:47:28 -0400
Message-ID: <20240728004739.1698541-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index fb12a9bacd2fa..7cea91e193a8f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -78,16 +78,17 @@ static bool			obj_freeing;
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
 static struct kmem_cache	*obj_cache __ro_after_init;
 
-- 
2.43.0


