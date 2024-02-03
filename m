Return-Path: <stable+bounces-18621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570EA848373
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E51B2AAA9
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C111721;
	Sat,  3 Feb 2024 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIsp12oV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37F171D4;
	Sat,  3 Feb 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933933; cv=none; b=cBYTxJp6Yj0f/gmYPyljCWA3f2paZdEAgRZgZsvx+tkIMHOjvbojbTXLfdSIFmnnDg9Prd8F6OC3XCJEs1S3MACtNdEfzdLE8YXbYRSzihhgs5Ftd0OoKc7o+jMbo43TVglG8Sy/R9zNJ5wefdr5MqGXZnYL4ZbnV4RVcKXsBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933933; c=relaxed/simple;
	bh=BmElAY0PogGK/FqA5g55EmPGpJJeXBrgtxvykjpIu78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGxt0H/vFNx6vir3epZF1h8XsbSB3IrNlFIkYlprKkkT/AcPoNIpzo+wGPgZeSlGx/nLPOd22AWZQElWGvWGEm/pkt/QXxkMyaVfBtlBApxDRju2ugeCj96fyoLaizbeEA/yucWl+pgZUelhqYHB6dC4TGxNiP22LNys4Zmc878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIsp12oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C62C433F1;
	Sat,  3 Feb 2024 04:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933933;
	bh=BmElAY0PogGK/FqA5g55EmPGpJJeXBrgtxvykjpIu78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIsp12oVlfPymom5yy18vJa+lZPFukh76jVeJnKLgTLegnFcdu2qwTAURuTohATNk
	 GDjfyVytb8LLQAfu+NiQno8ITIE2afHnSZf2c+ixXjZna2iw5tAzSPI7yWCb1eHz9E
	 KLMumUk/EnkYmVsZQWx9sODizB1rPNQDMQ66GH5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Marco Pagani <marpagan@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 294/353] kunit: run test suites only after module initialization completes
Date: Fri,  2 Feb 2024 20:06:52 -0800
Message-ID: <20240203035413.108871080@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit a1af6a2bfa0cb46d70b7df5352993e750da6c79b ]

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed a wild-memory-access bug that could have
happened during the loading phase of test suites built and executed as
loadable modules. However, it also introduced a problematic side effect
that causes test suites modules to crash when they attempt to register
fake devices.

When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
MODULE_STATE_COMING states before reaching the normal operating state
MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
MODULE_STATE_GOING before being released. However, if the loading
function load_module() fails between complete_formation() and
do_init_module(), the module goes directly from MODULE_STATE_COMING to
MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.

This behavior was causing kunit_module_exit() to be called without
having first executed kunit_module_init(). Since kunit_module_exit() is
responsible for freeing the memory allocated by kunit_module_init()
through kunit_filter_suites(), this behavior was resulting in a
wild-memory-access bug.

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed this issue by running the tests when the
module is still in MODULE_STATE_COMING. However, modules in that state
are not fully initialized, lacking sysfs kobjects. Therefore, if a test
module attempts to register a fake device, it will inevitably crash.

This patch proposes a different approach to fix the original
wild-memory-access bug while restoring the normal module execution flow
by making kunit_module_exit() able to detect if kunit_module_init() has
previously initialized the tests suite set. In this way, test modules
can once again register fake devices without crashing.

This behavior is achieved by checking whether mod->kunit_suites is a
virtual or direct mapping address. If it is a virtual address, then
kunit_module_init() has allocated the suite_set in kunit_filter_suites()
using kmalloc_array(). On the contrary, if mod->kunit_suites is still
pointing to the original address that was set when looking up the
.kunit_test_suites section of the module, then the loading phase has
failed and there's no memory to be freed.

v4:
- rebased on 6.8
- noted that kunit_filter_suites() must return a virtual address
v3:
- add a comment to clarify why the start address is checked
v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Reviewed-by: David Gow <davidgow@google.com>
Tested-by: Rae Moar <rmoar@google.com>
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/executor.c |  4 ++++
 lib/kunit/test.c     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1236b3cd2fbb..51013feba58b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -144,6 +144,10 @@ void kunit_free_suite_set(struct kunit_suite_set suite_set)
 	kfree(suite_set.start);
 }
 
+/*
+ * Filter and reallocate test suites. Must return the filtered test suites set
+ * allocated at a valid virtual address or NULL in case of error.
+ */
 struct kunit_suite_set
 kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		    const char *filter_glob,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1cdc405daa30..3dc9d66eca49 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "hooks-impl.h"
@@ -776,12 +777,19 @@ static void kunit_module_exit(struct module *mod)
 	};
 	const char *action = kunit_action();
 
+	/*
+	 * Check if the start address is a valid virtual address to detect
+	 * if the module load sequence has failed and the suite set has not
+	 * been initialized and filtered.
+	 */
+	if (!suite_set.start || !virt_addr_valid(suite_set.start))
+		return;
+
 	if (!action)
 		__kunit_test_suites_exit(mod->kunit_suites,
 					 mod->num_kunit_suites);
 
-	if (suite_set.start)
-		kunit_free_suite_set(suite_set);
+	kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
@@ -791,12 +799,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;
-- 
2.43.0




