Return-Path: <stable+bounces-2521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA147F8493
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9601C27E21
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5B33CC2;
	Fri, 24 Nov 2023 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzvBvo/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67538DE8;
	Fri, 24 Nov 2023 19:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E9C433C8;
	Fri, 24 Nov 2023 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854089;
	bh=4mAjaUOPE3kZCzRKPs7ynw6pJCcWlXLET3Ne85P4ifs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzvBvo/Kp76IIaSU0935vhTe/K669NKVbzvVkvQQOMXZVaAVqvx7IK3HQruuBlFqA
	 35uCMm7FfSS0KOezdi8X/bFW5l2tKObLQi4gAiI9VHnuBrRZH3nC5SA22Wc2XwMHuW
	 Zwxf2l3pfitqusOLVIpm3v4ymMCmrQykzf2q5zgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 127/159] ext4: apply umask if ACL support is disabled
Date: Fri, 24 Nov 2023 17:55:44 +0000
Message-ID: <20231124171947.113456027@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

commit 484fd6c1de13b336806a967908a927cc0356e312 upstream.

The function ext4_init_acl() calls posix_acl_create() which is
responsible for applying the umask.  But without
CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
and nobody applies the umask.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on ext4:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Reviewed-by: "J. Bruce Fields" <bfields@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/20230919081824.1096619-1-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/acl.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -67,6 +67,11 @@ extern int ext4_init_acl(handle_t *, str
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */



