Return-Path: <stable+bounces-191592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D3C19CD6
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 11:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D23EC357B52
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D82FF161;
	Wed, 29 Oct 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHSr1cXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB3253F39
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734186; cv=none; b=ChvzRBFyVco0wQb/9/dEVSdqvn6ClzkA4snC70uGVPR3aX4E9LGpcDhVpr6bX8pkdfNUOYY7/sU83vd39ctVZCE6t4Ey15AAjNu7LFGCbTzyGxfSsjEogHGQ6H7uXEJOw7lneeOHrv9qho06D0Ds3pJCCZxZgcl4XBzLn5vSrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734186; c=relaxed/simple;
	bh=qGgmprHFx9TQr6ugYP6tLUTZ9Ofc/4kf3sG+I54H4Lc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cA+D3zwVSlCasJVIRp/z1oXoR9+68DINNVWku5UgDwjnv8X4gN9ZqwJuc+jJV5a4X5PulBJrwM8FNhGaNnqg1ED1NHI7IajYdPSHNwXF+JAj8wYIVmDi1U5v3DjckR/UCFfjFfi5nHxO6Egf01GdP9ngeadgpcUwm51L70Vbpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHSr1cXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E7C4CEF7;
	Wed, 29 Oct 2025 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761734186;
	bh=qGgmprHFx9TQr6ugYP6tLUTZ9Ofc/4kf3sG+I54H4Lc=;
	h=Subject:To:Cc:From:Date:From;
	b=tHSr1cXJStDemnODOdKd1IYUA4LrlB7B/PzqgAIIVwMbZ8nELUd3ykjrng/p87jwb
	 gk3za6zgXsWTyp737jjEqFtgtbL7u42OUrRjQe7Bl6ThbyIFtYsl926mJyVQ1bYdWI
	 rWRREpyrPuLNlbnqKlWOP/7DBH1xQ8J+K3EnFzyA=
Subject: FAILED: patch "[PATCH] ksmbd: transport_ipc: validate payload size before reading" failed to apply to 5.15-stable tree
To: pioooooooooip@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Oct 2025 11:36:20 +0100
Message-ID: <2025102920-mace-herbal-edee@gregkh>
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
git cherry-pick -x 6f40e50ceb99fc8ef37e5c56e2ec1d162733fef0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102920-mace-herbal-edee@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f40e50ceb99fc8ef37e5c56e2ec1d162733fef0 Mon Sep 17 00:00:00 2001
From: Qianchang Zhao <pioooooooooip@gmail.com>
Date: Wed, 22 Oct 2025 15:27:47 +0900
Subject: [PATCH] ksmbd: transport_ipc: validate payload size before reading
 handle

handle_response() dereferences the payload as a 4-byte handle without
verifying that the declared payload size is at least 4 bytes. A malformed
or truncated message from ksmbd.mountd can lead to a 4-byte read past the
declared payload size. Validate the size before dereferencing.

This is a minimal fix to guard the initial handle read.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1ce1c..2c08cccfa680 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,10 +263,16 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
-	unsigned int handle = *(unsigned int *)payload;
+	unsigned int handle;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
 
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
+	handle = *(unsigned int *)payload;
+
 	ipc_update_last_active();
 	down_read(&ipc_msg_table_lock);
 	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {


