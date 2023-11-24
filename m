Return-Path: <stable+bounces-969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44D7F7D5E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFA51C212A0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E839FE1;
	Fri, 24 Nov 2023 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ve/m9bIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20B39FC2;
	Fri, 24 Nov 2023 18:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F71C433C9;
	Fri, 24 Nov 2023 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850231;
	bh=9HGQzBWWmtuI7dulWCSI8x86xfLjmTVyaPULy5OoyZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ve/m9bIEyXdav8ioDv8LBi2OT6u7E5QwhTSZujQAVJyFjr8O+KjqwYXnv9XknhHBe
	 vK/hZRAIS085N4LlSRSTip2oK1pfG5RkHsSeevbCSy5lGhaVCirYGugano17tMTTCS
	 g6n2B4Pv2pEhlHoNKNlOq6U9xGzrfcXWizjsoq4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 498/530] ext4: apply umask if ACL support is disabled
Date: Fri, 24 Nov 2023 17:51:04 +0000
Message-ID: <20231124172043.308003893@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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
@@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, str
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



