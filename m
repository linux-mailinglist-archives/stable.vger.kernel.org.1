Return-Path: <stable+bounces-8980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C28205B2
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B0B211AC
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315FF79EE;
	Sat, 30 Dec 2023 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t2kepHZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FA79DD;
	Sat, 30 Dec 2023 12:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68191C433C7;
	Sat, 30 Dec 2023 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938261;
	bh=NFIO6hjcA85MJTwp0i7WTWUkChUPbe+fmDZOTddbyTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2kepHZIDfiaqYJox67v+PC4uTEuH/F603OHj96k/ifQaYQpKl52VKIZ4NkwdETEK
	 t+OSt/FkOMosXTViv3Trp9nLOMN+rV7Xkk2DQGoOsmSmOc+o5uF+xzPw5kontnXHOD
	 0i7eAmEU3acaN9Ro0AAyNGdSImAG2kVbpCFTqPmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@canonical.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 089/112] loop: do not enforce max_loop hard limit by (new) default
Date: Sat, 30 Dec 2023 12:00:02 +0000
Message-ID: <20231230115809.666462326@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit bb5faa99f0ce40756ab7bbbce4f16c01ca5ebd5a ]

Problem:

The max_loop parameter is used for 2 different purposes:

1) initial number of loop devices to pre-create on init
2) maximum number of loop devices to add on access/open()

Historically, its default value (zero) caused 1) to create non-zero
number of devices (CONFIG_BLK_DEV_LOOP_MIN_COUNT), and no hard limit on
2) to add devices with autoloading.

However, the default value changed in commit 85c50197716c ("loop: Fix
the max_loop commandline argument treatment when it is set to 0") to
CONFIG_BLK_DEV_LOOP_MIN_COUNT, for max_loop=0 not to pre-create devices.

That does improve 1), but unfortunately it breaks 2), as the default
behavior changed from no-limit to hard-limit.

Example:

For example, this userspace code broke for N >= CONFIG, if the user
relied on the default value 0 for max_loop:

    mknod("/dev/loopN");
    open("/dev/loopN");  // now fails with ENXIO

Though affected users may "fix" it with (loop.)max_loop=0, this means to
require a kernel parameter change on stable kernel update (that commit
Fixes: an old commit in stable).

Solution:

The original semantics for the default value in 2) can be applied if the
parameter is not set (ie, default behavior).

This still keeps the intended function in 1) and 2) if set, and that
commit's intended improvement in 1) if max_loop=0.

Before 85c50197716c:
  - default:     1) CONFIG devices   2) no limit
  - max_loop=0:  1) CONFIG devices   2) no limit
  - max_loop=X:  1) X devices        2) X limit

After 85c50197716c:
  - default:     1) CONFIG devices   2) CONFIG limit (*)
  - max_loop=0:  1) 0 devices (*)    2) no limit
  - max_loop=X:  1) X devices        2) X limit

This commit:
  - default:     1) CONFIG devices   2) no limit (*)
  - max_loop=0:  1) 0 devices        2) no limit
  - max_loop=X:  1) X devices        2) X limit

Future:

The issue/regression from that commit only affects code under the
CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard, thus the fix too is
contained under it.

Once that deprecated functionality/code is removed, the purpose 2) of
max_loop (hard limit) is no longer in use, so the module parameter
description can be changed then.

Tests:

Linux 6.4-rc7
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLOCK_LEGACY_AUTOLOAD=y

- default (original)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- default (patched)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	#

- max_loop=0 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	#

- max_loop=8 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- max_loop=0 (patched; CONFIG_BLOCK_LEGACY_AUTOLOAD is not set)

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	open: /dev/loop8: No such device or address

Fixes: 85c50197716c ("loop: Fix the max_loop commandline argument treatment when it is set to 0")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230720143033.841001-3-mfo@canonical.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 426d0b42685a0..d74f8eb7f5293 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1777,14 +1777,43 @@ static const struct block_device_operations lo_fops = {
 /*
  * If max_loop is specified, create that many devices upfront.
  * This also becomes a hard limit. If max_loop is not specified,
+ * the default isn't a hard limit (as before commit 85c50197716c
+ * changed the default value from 0 for max_loop=0 reasons), just
  * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
  * init time. Loop devices can be requested on-demand with the
  * /dev/loop-control interface, or be instantiated by accessing
  * a 'dead' device node.
  */
 static int max_loop = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-module_param(max_loop, int, 0444);
+
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+static bool max_loop_specified;
+
+static int max_loop_param_set_int(const char *val,
+				  const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret < 0)
+		return ret;
+
+	max_loop_specified = true;
+	return 0;
+}
+
+static const struct kernel_param_ops max_loop_param_ops = {
+	.set = max_loop_param_set_int,
+	.get = param_get_int,
+};
+
+module_param_cb(max_loop, &max_loop_param_ops, &max_loop, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
+#else
+module_param(max_loop, int, 0444);
+MODULE_PARM_DESC(max_loop, "Initial number of loop devices");
+#endif
+
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
 
@@ -2093,7 +2122,7 @@ static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
 
-	if (max_loop && idx >= max_loop)
+	if (max_loop_specified && max_loop && idx >= max_loop)
 		return;
 	loop_add(idx);
 }
@@ -2277,6 +2306,9 @@ module_exit(loop_exit);
 static int __init max_loop_setup(char *str)
 {
 	max_loop = simple_strtol(str, NULL, 0);
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+	max_loop_specified = true;
+#endif
 	return 1;
 }
 
-- 
2.43.0




