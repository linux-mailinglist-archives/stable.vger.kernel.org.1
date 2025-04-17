Return-Path: <stable+bounces-133106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE4A91DF9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAB3ABF9C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A071474B8;
	Thu, 17 Apr 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITE0zC3K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7B35948
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896430; cv=none; b=NC8tkZQD0K+VNqFq06/mA3ieWCXIkshkw7Pj0APz3hpUfZuQY1Ey/IqW9eqnM9dZ0MJwAVVezOdjueMo+7LlBzjMz/2RW2JHSPgxNlLM80OX/hwGXhVH2Wu24SCj7UbMpRCDrTp36RxB2QsZ51joiO7I8HrmvT6f6RLLsGgypNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896430; c=relaxed/simple;
	bh=Vm2J9J8u9U/3gUYOyZWfEhE7sewZ44+74ul3ZGon/TA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KJrdOx+su/1nEffy+NkGk/7OVqIlG3PQP9qHZP19S8mfYUHyRWR5mpe8NrzDo+kLXMBs26ANMPshIKc38fyA8VrN6op4JBtodJx3f0/V+11qOWqNCWw80x81u/mmS7J/QBGOYFBxYCCSjH6RQ/UxGxzP2+jwmrhPBTzYcMxh9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITE0zC3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33FEC4CEE4;
	Thu, 17 Apr 2025 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896429;
	bh=Vm2J9J8u9U/3gUYOyZWfEhE7sewZ44+74ul3ZGon/TA=;
	h=Subject:To:Cc:From:Date:From;
	b=ITE0zC3KcR1mOhdg4uGZepmJQOY9f2xoOOrkkc3IamC85aRDhhtaJQjsqbvZMEc0e
	 qnJLqQZeQvmtuDvxQNwzIUVkUKvHFmSA94+PxrvYYwq00B59MVfnNWV/saRhvvZejK
	 ne77ccpiuWw7GaL2dQTFNgrQqmQ/hyaCdjeRkTKM=
Subject: FAILED: patch "[PATCH] cifs: avoid NULL pointer dereference in dbg call" failed to apply to 5.10-stable tree
To: adiupina@astralinux.ru,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:20:39 +0200
Message-ID: <2025041739-rumor-retention-833e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b4885bd5935bb26f0a414ad55679a372e53f9b9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041739-rumor-retention-833e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4885bd5935bb26f0a414ad55679a372e53f9b9b Mon Sep 17 00:00:00 2001
From: Alexandra Diupina <adiupina@astralinux.ru>
Date: Wed, 19 Mar 2025 17:28:58 +0300
Subject: [PATCH] cifs: avoid NULL pointer dereference in dbg call

cifs_server_dbg() implies server to be non-NULL so
move call under condition to avoid NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e79b0332ae06 ("cifs: ignore cached share root handle closing errors")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f3c4b70b77b9..cddf273c14ae 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -816,11 +816,12 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}


