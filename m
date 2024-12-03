Return-Path: <stable+bounces-96330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820969E21E9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDAFB477A5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCE3BB24;
	Tue,  3 Dec 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j3WwX9VJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3BE1EE024;
	Tue,  3 Dec 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236429; cv=none; b=pWw3AkFOjBVs4rE+ojfnsuFXj5edWHJ9/lNzdWOCe5dIVvIIkKlcEOzcbb8d55/sPzRuj59d4VlbTd+5Wxi9a5tWyoOrJ2phS8Nb63k7D2+m1A4qpGGVulNCB9RYjdvOrRlhfNuoGFRmmfkv0/FdFOkl0OGhdlVmFJbViOJlQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236429; c=relaxed/simple;
	bh=+YMQII4bgB8EZrVnXZW4RfbmZBFVVQ24FYUbT8wmEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaCkE/CLGgN5HN0eBKwSXXrcl0q3xHLPAJB0tNlLVihZLWRPjF+aIJgHtprwvR8Yc7ezzmdH6mZlODf0I52kr7y/HSrCkgIwVR4uq6veqe/8qJ8CXQI4wAf3IwADUyR/gz5eSmpLsIj9jgufssqN+lN4Z3pKu7reWUZVwL01qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j3WwX9VJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92179C4CECF;
	Tue,  3 Dec 2024 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733236429;
	bh=+YMQII4bgB8EZrVnXZW4RfbmZBFVVQ24FYUbT8wmEWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3WwX9VJidyIlDPygkfmXG4t9nAliYfR2qlrFQJjrC0xfFxwyKzmEOzayE4/A8GWs
	 kcQC9ZXiU0oYG5UPAlXL3D0nyUMrgcjKYUV2fUayu89MityCMJcU09gmvGPmqSIHLj
	 wdnowiW2TAdx7LIlFvHmiP1T6cv9ECoaHCk16wCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Disseldorp <ddiss@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 017/138] initramfs: avoid filename buffer overrun
Date: Tue,  3 Dec 2024 15:30:46 +0100
Message-ID: <20241203141924.204798881@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit e017671f534dd3f568db9e47b0583e853d2da9b5 ]

The initramfs filename field is defined in
Documentation/driver-api/early-userspace/buffer-format.rst as:

 37 cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
...
 55 ============= ================== =========================
 56 Field name    Field size         Meaning
 57 ============= ================== =========================
...
 70 c_namesize    8 bytes            Length of filename, including final \0

When extracting an initramfs cpio archive, the kernel's do_name() path
handler assumes a zero-terminated path at @collected, passing it
directly to filp_open() / init_mkdir() / init_mknod().

If a specially crafted cpio entry carries a non-zero-terminated filename
and is followed by uninitialized memory, then a file may be created with
trailing characters that represent the uninitialized memory. The ability
to create an initramfs entry would imply already having full control of
the system, so the buffer overrun shouldn't be considered a security
vulnerability.

Append the output of the following bash script to an existing initramfs
and observe any created /initramfs_test_fname_overrunAA* path. E.g.
  ./reproducer.sh | gzip >> /myinitramfs

It's easiest to observe non-zero uninitialized memory when the output is
gzipped, as it'll overflow the heap allocated @out_buf in __gunzip(),
rather than the initrd_start+initrd_size block.

---- reproducer.sh ----
nilchar="A"	# change to "\0" to properly zero terminate / pad
magic="070701"
ino=1
mode=$(( 0100777 ))
uid=0
gid=0
nlink=1
mtime=1
filesize=0
devmajor=0
devminor=1
rdevmajor=0
rdevminor=0
csum=0
fname="initramfs_test_fname_overrun"
namelen=$(( ${#fname} + 1 ))	# plus one to account for terminator

printf "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s" \
	$magic $ino $mode $uid $gid $nlink $mtime $filesize \
	$devmajor $devminor $rdevmajor $rdevminor $namelen $csum $fname

termpadlen=$(( 1 + ((4 - ((110 + $namelen) & 3)) % 4) ))
printf "%.s${nilchar}" $(seq 1 $termpadlen)
---- reproducer.sh ----

Symlink filename fields handled in do_symlink() won't overrun past the
data segment, due to the explicit zero-termination of the symlink
target.

Fix filename buffer overrun by aborting the initramfs FSM if any cpio
entry doesn't carry a zero-terminator at the expected (name_len - 1)
offset.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: David Disseldorp <ddiss@suse.de>
Link: https://lore.kernel.org/r/20241030035509.20194-2-ddiss@suse.de
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/initramfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index fceede4cff6e4..59901e5197775 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -323,6 +323,15 @@ static int __init do_name(void)
 {
 	state = SkipIt;
 	next_state = Reset;
+
+	/* name_len > 0 && name_len <= PATH_MAX checked in do_header */
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs name without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
+
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -385,6 +394,12 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs symlink without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
-- 
2.43.0




