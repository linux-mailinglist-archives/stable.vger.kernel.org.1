Return-Path: <stable+bounces-133107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745EA91E07
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F107A7A9D35
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B4223320;
	Thu, 17 Apr 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rK/IoPci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E32376E6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896432; cv=none; b=K8Lk50bpemLV7fxXMdLTKDsFGICKum3CPiDPRxxGUrcjxSQvbGeJtPMXeOFfIP7OkX0fjJhK/sHz8mEVBjNpbAR2zJky5iXidxBbrTNmeWpS2UUMhFujpKkqwE40tf4//b7o45ihuHHNvp5JaWromWFSFbetl5XwPcwZ/jWcdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896432; c=relaxed/simple;
	bh=f9SJAVtXTSonB8QOqi2INDTvErAjfZ53w+E62ZvJaeo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g7GVZowCufi68n6t8fr3GEupUb2LFXQOhd3rileM7igXVGNUmknRzUFgt2O/GPVn2iCgCNFL4R0mhBSqMtNnc7RDK6GSXhUwas0euQsNCnfu7UGw4/pOR+RV9uJLHh7IkwbFMys5f4RRijXiA+J7lBUHYvrGC1csQTW94WgpLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rK/IoPci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A608C4CEE4;
	Thu, 17 Apr 2025 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896432;
	bh=f9SJAVtXTSonB8QOqi2INDTvErAjfZ53w+E62ZvJaeo=;
	h=Subject:To:Cc:From:Date:From;
	b=rK/IoPcitb41nj06VLe8PjVpz5L44hgqcI6GduwgGOJ8469ZdKC6GDa7/vx7lPHFP
	 fun5L+zGUoXRK8S72HKNougbYL2iVu5Vhz/OvcODLFpzgdlpIAN/eNJQ8av2cg2S1i
	 xemKkEDj1VDYyH6fpQvgeaH0OtQeZ1d+bWtzHrrQ=
Subject: FAILED: patch "[PATCH] cifs: avoid NULL pointer dereference in dbg call" failed to apply to 5.15-stable tree
To: adiupina@astralinux.ru,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:20:39 +0200
Message-ID: <2025041739-swivel-handball-0839@gregkh>
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
git cherry-pick -x b4885bd5935bb26f0a414ad55679a372e53f9b9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041739-swivel-handball-0839@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


