Return-Path: <stable+bounces-62018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410193E207
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022311F219A7
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAED145FE1;
	Sun, 28 Jul 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAgvkwnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B344146597;
	Sun, 28 Jul 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127738; cv=none; b=K5/Kwf4u3puLCPP31J5tgnCsHidP00AOwjGvCnwML+vTvpLo+giD58tF7oWU4EAzp9mPlxw2EFCHUVCi+Y1fIwY7hLpUu/n4bd2uWfB2U1UrNcTAOijm1i3HrzQvsbigyBcjAbvcTMnBmpuUAUCk1TAhTogCDHSVM8Up7I+bfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127738; c=relaxed/simple;
	bh=RxP8BA712Rfwg0TbC9Vb6gyLjI34bhq14iVWKH6RexE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYUUxvBATuT5FQsAREPiTob7n+L4+d9k0iVMJdelq9gWiyWSqtubwBXxO6gOnDeLpmufDH/pFIaTAoB6HvPxMm0pC1ZhdY46EjjvufoIgWuAiG7b+yZj8Joz7VgS5CvnWI6A6fPu1gYIpfUxxGKoICAadzM8FHl1u/kXIQFV1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAgvkwnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B324C4AF0C;
	Sun, 28 Jul 2024 00:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127737;
	bh=RxP8BA712Rfwg0TbC9Vb6gyLjI34bhq14iVWKH6RexE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAgvkwnIODlhz+AnLHkwQS8owZYYEMPok6MOCcZP+HxiP1wJs1elH4f9ZUx12KVt8
	 xd7yaZU8n6axknbKUuH38wtAbbmTzzw/ARTvSgwsLqlIbMUqKM85aY1kW4Kmb9RJI5
	 Z7FqV+1T/kayUXO9yfx8u302wlVLpOCFFm6JoZgYKObEkZHYZDSCwY3DRiNQoxCR9w
	 JVga1rm+2fNzV/XubAU/+6Yj31+JqiVaEiGvrLdhMGkZNVWFRqmZs8au0cfRSXO+3H
	 hjoBVoA7/Liz0R6ja7XFcJzuZzuX8qhlgMrwpt9Ka7TpFusPLYwhHZot4kd/vIcSD9
	 e9moW0ecPy+uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 5/6] debugobjects: Annotate racy debug variables
Date: Sat, 27 Jul 2024 20:48:46 -0400
Message-ID: <20240728004848.1703616-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004848.1703616-1-sashal@kernel.org>
References: <20240728004848.1703616-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 3972e2123e554..0ec1dba42ad44 100644
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


