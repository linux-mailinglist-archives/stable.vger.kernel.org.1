Return-Path: <stable+bounces-26322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC19870E0C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FD0286ADF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748981C6AB;
	Mon,  4 Mar 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgOuf3rZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339038F58;
	Mon,  4 Mar 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588421; cv=none; b=oCTPgyL+Z7ZQJKLcSqsy6qBM6qw5+sZh7r3wHWDgBuBb/7Cppn3jDLx6c+9OX3MXuhGjx4xBLGXdTV12iuYzWQw9Xvhr0X2ikZZpRbJPiGm3ZxzpeE0d4VorLhGmR55PyPcLjjyhwGmM4CFbfieXMJEKXwsem8qswIoRFudeaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588421; c=relaxed/simple;
	bh=AC0dypErLt0vscaPavG8u8hglEBMMEDp6qmcJwSeaJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoGBuz4mmh+1qjL7g6NfrnfsTMAt8EtJ6fNkhGnzzilRCmifT40UqjjE1m3D9pi/+PF+2F/bJrEf+Nntmo1A/GhNN1P8pQ61ipiNS6luL9oqPgR4iqumvjo7hstlY2k1qxukfkPq17ovtEJxJzgzW9mRXIaOdxzOXPKaY8CcRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgOuf3rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2E0C433C7;
	Mon,  4 Mar 2024 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588421;
	bh=AC0dypErLt0vscaPavG8u8hglEBMMEDp6qmcJwSeaJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgOuf3rZP/wfkYFQA07xd96qY0K/UJi7Xh7y9iG0UoEtTnfdG0281u7FN1yg4A0Bu
	 5yQer+3C1NVIlVe/8KjXQWWhSIZMh8CQP1Kz9+1nk2OMnO0MbOrIib3a+xuNrVXMq7
	 jQHYV1q7HM6Ckmz/OcT4byLR9jLIR/35j51/sRhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jann Horn <jannh@google.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 6.6 076/143] landlock: Fix asymmetric private inodes referring
Date: Mon,  4 Mar 2024 21:23:16 +0000
Message-ID: <20240304211552.350980376@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

commit d9818b3e906a0ee1ab02ea79e74a2f755fc5461a upstream.

When linking or renaming a file, if only one of the source or
destination directory is backed by an S_PRIVATE inode, then the related
set of layer masks would be used as uninitialized by
is_access_to_paths_allowed().  This would result to indeterministic
access for one side instead of always being allowed.

This bug could only be triggered with a mounted filesystem containing
both S_PRIVATE and !S_PRIVATE inodes, which doesn't seem possible.

The collect_domain_accesses() calls return early if
is_nouser_or_private() returns false, which means that the directory's
superblock has SB_NOUSER or its inode has S_PRIVATE.  Because rename or
link actions are only allowed on the same mounted filesystem, the
superblock is always the same for both source and destination
directories.  However, it might be possible in theory to have an
S_PRIVATE parent source inode with an !S_PRIVATE parent destination
inode, or vice versa.

To make sure this case is not an issue, explicitly initialized both set
of layer masks to 0, which means to allow all actions on the related
side.  If at least on side has !S_PRIVATE, then
collect_domain_accesses() and is_access_to_paths_allowed() check for the
required access rights.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Shervin Oloumi <enlightened@chromium.org>
Cc: stable@vger.kernel.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Link: https://lore.kernel.org/r/20240219190345.2928627-1-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/landlock/fs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -820,8 +820,8 @@ static int current_check_refer_path(stru
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS],
-		layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS];
+	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
+		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;



