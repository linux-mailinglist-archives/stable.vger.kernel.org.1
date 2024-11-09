Return-Path: <stable+bounces-91998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72BC9C2C5B
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B71F21CFD
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6114D456;
	Sat,  9 Nov 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4e8/6J0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24212F5B1
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153441; cv=none; b=kw/1uQcYogzR9m5/OU93/dPrWr94fYmgMPBjEcsFTVtVQ9gEi9m91kbDV261kZ5jtJj5V66EFmjGoaGv5n9z52/Lo0VKtYhICsntRehsQjTgdy2RH0g3b3tWDuejTVDhE96k8Lw7O266lU/ejUIaQZifieuHHXMkmm+8R3mtWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153441; c=relaxed/simple;
	bh=T3l/ZmgOZpJyWh4C/k544O5JQmQaz3n8PAAE/GWWRfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qxXaV0MmBuqdtLrCShq6a/WvMFXGO2jdpxyYgNtJFGLjXZgfiiv0aQ2tOJU96sRvPaWrgpfbXqySh+Me3x70b6+r2L9sxzKEg78WH8uvI0TxCQMjbSZzWAcCNZjTbZxEn/5g0inZ9nKv/VbIrEnon0sVJ/8YZBuBDIdTq1ejq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4e8/6J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9016BC4CECE;
	Sat,  9 Nov 2024 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153440;
	bh=T3l/ZmgOZpJyWh4C/k544O5JQmQaz3n8PAAE/GWWRfc=;
	h=Subject:To:Cc:From:Date:From;
	b=B4e8/6J0n0MI8UAdCAQBHfK0ti6AUjvn9R+Tp6IYBfto0Q0RpkU96SCM3GSjJU6UY
	 mPRDQy2+bgGVZRqEUkLWPbLEPfESd4zVLjpLDCHwzTSTTGWK2ZNTaLMpgt+JcP0fep
	 4zCeWD5uma0OQOCJv2b5/BOiuDkUdTy8KE9BD69k=
Subject: FAILED: patch "[PATCH] ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:57:08 +0100
Message-ID: <2024110908-basin-unrefined-82bf@gregkh>
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
git cherry-pick -x b8fc56fbca7482c1e5c0e3351c6ae78982e25ada
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110908-basin-unrefined-82bf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8fc56fbca7482c1e5c0e3351c6ae78982e25ada Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 Nov 2024 13:40:41 +0900
Subject: [PATCH] ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp

ksmbd_user_session_put should be called under smb3_preauth_hash_rsp().
It will avoid freeing session before calling smb3_preauth_hash_rsp().

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 9670c97f14b3..e7f14f8df943 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -238,11 +238,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	} while (is_chained == true);
 
 send:
-	if (work->sess)
-		ksmbd_user_session_put(work->sess);
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);


