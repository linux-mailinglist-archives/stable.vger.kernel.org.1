Return-Path: <stable+bounces-21374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4C85C899
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13271F213E6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C29151CDC;
	Tue, 20 Feb 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7oJGSvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2E2DF9F;
	Tue, 20 Feb 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464223; cv=none; b=nv/QNTQIMXFPWc3olM+/GnjRzk89NWcbb/sIV4JeDj2stIBQmz+cknpeVQjAt9fTjHMlBUtg+CSCwI3TunhoZ0k1zy7lomhMj5BQzmtoqm4W1GKAZvx3sfcfv35YGedeS75SIkssOb+/Wj08qA5z1uKgv9Eq3qQLvRWrr47o7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464223; c=relaxed/simple;
	bh=n1X3Oiu8ACS9wiFFr4yuwrVgnLsQa965qXoerOmnFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfoMXKZAqwabb/0A1/+vXNqFHqzeYsKIJaXIJfH6S4voG9OManaY6uq5UzkDrzfAfGYFCrr+ZdRqxoKxBhZh2S0lCBMw9I4qvOroIUT9BolqcW62K8oYVYEfEQrSz9EH3HOmYJkECpSR3ABjX0jN0WFUAxBzwZF2c3XibRYxvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7oJGSvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4B4C433C7;
	Tue, 20 Feb 2024 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464222;
	bh=n1X3Oiu8ACS9wiFFr4yuwrVgnLsQa965qXoerOmnFYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7oJGSvGW72vL4RTUrlkAaEBwAjlcb4NtjGAkUs2bQNOrYrZY23x4RRzpNVFNCmWs
	 NS1wHsFqatTLeW69W9cFIALnB2vBIRucLYRAYGkPgZWUNz778ZQHc4cUGg5C2dJdn9
	 ZMnkt6T4crxF9y0AIXSsTz8d9nJUwuBGjQ10g4q0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Ubisectech Sirius" <bugreport@ubisectech.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 290/331] tracefs: Check for dentry->d_inode exists in set_gid()
Date: Tue, 20 Feb 2024 21:56:46 +0100
Message-ID: <20240220205647.109883743@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit ad579864637af46447208254719943179b69d41a upstream.

If a getdents() is called on the tracefs directory but does not get all
the files, it can leave a "cursor" dentry in the d_subdirs list of tracefs
dentry. This cursor dentry does not have a d_inode for it. Before
referencing tracefs_inode from the dentry, the d_inode must first be
checked if it has content. If not, then it's not a tracefs_inode and can
be ignored.

The following caused a crash:

 #define getdents64(fd, dirp, count) syscall(SYS_getdents64, fd, dirp, count)
 #define BUF_SIZE 256
 #define TDIR "/tmp/file0"

 int main(void)
 {
	char buf[BUF_SIZE];
	int fd;
       	int n;

       	mkdir(TDIR, 0777);
	mount(NULL, TDIR, "tracefs", 0, NULL);
       	fd = openat(AT_FDCWD, TDIR, O_RDONLY);
       	n = getdents64(fd, buf, BUF_SIZE);
       	ret = mount(NULL, TDIR, NULL, MS_NOSUID|MS_REMOUNT|MS_RELATIME|MS_LAZYTIME,
		    "gid=1000");
	return 0;
 }

That's because the 256 BUF_SIZE was not big enough to read all the
dentries of the tracefs file system and it left a "cursor" dentry in the
subdirs of the tracefs root inode. Then on remounting with "gid=1000",
it would cause an iteration of all dentries which hit:

	ti = get_tracefs(dentry->d_inode);
	if (ti && (ti->flags & TRACEFS_EVENT_INODE))
		eventfs_update_gid(dentry, gid);

Which crashed because of the dereference of the cursor dentry which had a NULL
d_inode.

In the subdir loop of the dentry lookup of set_gid(), if a child has a
NULL d_inode, simply skip it.

Link: https://lore.kernel.org/all/20240102135637.3a21fb10@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240102151249.05da244d@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/inode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -215,6 +215,10 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 
+		/* Note, getdents() can add a cursor dentry with no inode */
+		if (!dentry->d_inode)
+			continue;
+
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 
 		change_gid(dentry, gid);



