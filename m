Return-Path: <stable+bounces-11880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62058831692
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B5E1F21D75
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50592033F;
	Thu, 18 Jan 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4hQfXVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5D520333
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573262; cv=none; b=VZdNnC6Ykv9GpXhNe9gcnPhhFxGNhglT5j3WMLu2iRUUeZvq8pfUUvD1WGg9mazWR2NO1Xb3ZAGM8smpDD4aG1Vz65Ymjwi5l2GCpNkCyuOsmiFgCZD8qzfU+TmhPjzyUe+/8GDu4x82r4T+0xA9OpOkRyFa9bwiIDKtzLlHU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573262; c=relaxed/simple;
	bh=1jID6WlO72grRCJwDRl5nSG3TJ60OxoLfvslG7LHRx8=;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=lPHiH61EWtiPofi6gNb7cfAg3g62TeRAWr+SQqi2I34W151Pp9XymQK/BexdL9E0c0BZzejNG8hLv/WA0V3E1ttD4KH+SY1DjV/r6zgFAxVHYt5ju9ogIZCQVQ6qxKrgVqijufAONX9kgRO7GsVX+xER4ccu2SFsH+atLcpvwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4hQfXVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA16C433C7;
	Thu, 18 Jan 2024 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705573262;
	bh=1jID6WlO72grRCJwDRl5nSG3TJ60OxoLfvslG7LHRx8=;
	h=Subject:To:Cc:From:Date:From;
	b=M4hQfXVqtBDTCu96P0IWyy+Rs/1N1QN7aPwWN5m6ZeneSt3h8VivumSiySCkxBlYq
	 3a8glwbOjgnxASoYQSNLQSUGvi9ADa5Ry2pVuyxqelXMo/n4YjrLwD0mbtQ6HbxCK+
	 tzvXZUsziT3ZbILzwCwfhAsRuIcgZteD2owTPs44=
Subject: FAILED: patch "[PATCH] ksmbd: free ppace array on error in parse_dacl" failed to apply to 5.15-stable tree
To: pchelkin@ispras.ru,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 18 Jan 2024 11:20:59 +0100
Message-ID: <2024011859-dragging-hermit-6aa8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf9bedfc3c47d24bb0de386f808f925dc52863e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024011859-dragging-hermit-6aa8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8cf9bedfc3c4 ("ksmbd: free ppace array on error in parse_dacl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cf9bedfc3c47d24bb0de386f808f925dc52863e Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Tue, 9 Jan 2024 17:14:44 +0300
Subject: [PATCH] ksmbd: free ppace array on error in parse_dacl

The ppace array is not freed if one of the init_acl_state() calls inside
parse_dacl() fails. At the moment the function may fail only due to the
memory allocation errors so it's highly unlikely in this case but
nevertheless a fix is needed.

Move ppace allocation after the init_acl_state() calls with proper error
handling.

Found by Linux Verification Center (linuxtesting.org).

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1164365533f0..1c9775f1efa5 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -401,10 +401,6 @@ static void parse_dacl(struct mnt_idmap *idmap,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -414,6 +410,13 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,


