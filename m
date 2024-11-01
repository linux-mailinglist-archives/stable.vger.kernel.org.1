Return-Path: <stable+bounces-89512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09389B9794
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F4F283A8E
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6215914A629;
	Fri,  1 Nov 2024 18:32:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA001CDFCB;
	Fri,  1 Nov 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485977; cv=none; b=L+0bSm9D76NdREx61U1AX4TWU5kVTzmBD2xQRRKie52pC9fuS1RrjwFTGnudmV+Yr8+7/Y9YG0oX0v/2sbgYSFdT1NXR6r8cfvWakOUSsj0Pwoi9/f5FhaWj9Rr8gpyHud4IrDRgTZL7aD1zSctJKOqbc8LQ0yqQ0musybdwOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485977; c=relaxed/simple;
	bh=NG34A9Sh7NNpVGAXKxos3KmZWrxcYzJCmMqeulvMRx8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ict2JkrznKAF0mtFd1K6MfKBmIlCqLjjKVXRsFWYaIo/p8GoUOYPIC5irtC1F/0BnDs1Pa5Ntk5cDjjw2AkeW9BlMunI+vqvqvptTRWGDywtrAZVmfqMHdmo9dhCEQId7/1navwlDjAvJ8z0CenUDSgDFFE5ag2rpf1L1cHX37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0178C4CECD;
	Fri,  1 Nov 2024 18:32:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6wT5-00000005X40-2Wim;
	Fri, 01 Nov 2024 14:33:55 -0400
Message-ID: <20241101183355.468402456@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 14:33:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Sandeen <sandeen@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 stable@vger.kernel.org,
 Kalesh Singh <kaleshsingh@google.com>
Subject: [for-linus][PATCH 1/3] tracing: Fix tracefs mount options
References: <20241101183327.693623203@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kalesh Singh <kaleshsingh@google.com>

Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
converted tracefs to use the new mount APIs caused mount options
(e.g. gid=<gid>) to not take effect.

The tracefs superblock can be updated from multiple paths:
    - on fs_initcall() to init_trace_printk_function_export()
    - from a work queue to initialize eventfs
      tracer_init_tracefs_work_func()
    - fsconfig() syscall to mount or remount of tracefs

The tracefs superblock root inode gets created early on in
init_trace_printk_function_export().

With the new mount API, tracefs effectively uses get_tree_single() instead
of the old API mount_single().

Previously, mount_single() ensured that the options are always applied to
the superblock root inode:
    (1) If the root inode didn't exist, call fill_super() to create it
        and apply the options.
    (2) If the root inode exists, call reconfigure_single() which
        effectively calls tracefs_apply_options() to parse and apply
        options to the subperblock's fs_info and inode and remount
        eventfs (if necessary)

On the other hand, get_tree_single() effectively calls vfs_get_super()
which:
    (3) If the root inode doesn't exists, calls fill_super() to create it
        and apply the options.
    (4) If the root inode already exists, updates the fs_context root
        with the superblock's root inode.

(4) above is always the case for tracefs mounts, since the super block's
root inode will already be created by init_trace_printk_function_export().

This means that the mount options get ignored:
    - Since it isn't applied to the superblock's root inode, it doesn't
      get inherited by the children.
    - Since eventfs is initialized from a separate work queue and
      before call to mount with the options, and it doesn't get remounted
      for mount.

Ensure that the mount options are applied to the super block and eventfs
is remounted to respect the mount options.

To understand this better, if fstab has the following:

 tracefs  /sys/kernel/tracing  tracefs   nosuid,nodev,noexec,gid=tracing 0  0

On boot up, permissions look like:

 # ls -l /sys/kernel/tracing/trace
 -rw-r----- 1 root root 0 Nov  1 08:37 /sys/kernel/tracing/trace

When it should look like:

 # ls -l /sys/kernel/tracing/trace
 -rw-r----- 1 root tracing 0 Nov  1 08:37 /sys/kernel/tracing/trace

Link: https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ali Zahraee <ahzahraee@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
Link: https://lore.kernel.org/20241030171928.4168869-2-kaleshsingh@google.com
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1748dff58c3b..cfc614c638da 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
 	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
 	struct tracefs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 	/* structure copy of new mount options to sb */
 	*sb_opts = *new_opts;
@@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &tracefs_super_operations;
 	sb->s_d_op = &tracefs_dentry_operations;
 
-	tracefs_apply_options(sb, false);
-
 	return 0;
 }
 
 static int tracefs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, tracefs_fill_super);
+	int err = get_tree_single(fc, tracefs_fill_super);
+
+	if (err)
+		return err;
+
+	return tracefs_reconfigure(fc);
 }
 
 static void tracefs_free_fc(struct fs_context *fc)
-- 
2.45.2



