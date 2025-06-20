Return-Path: <stable+bounces-155040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046AAE1730
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237061890C5B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7D27FB14;
	Fri, 20 Jun 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6nutRDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBE23312D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410646; cv=none; b=YMpsSfTEKSAnYdIHjx/Yx2krOYec1i5jl2wBVb6FPqsP/ZK2di/UWMfq2NhFAkaJetgQGSOOCvPjK1NY/C1UWlx0hJu8JV4ua2Z+R+TTO+jyWIrS81HAeIF7VtdRooZ3bvSgtPkW62hdcbmq+k4IzLyyUqdEEqz0Hu3olBRaSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410646; c=relaxed/simple;
	bh=K5IFjVJXo3gk8wy3NygWJN32Uu8UoQD+pATZre8h0AU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pg+WARiDUkl1haqTscammBX7XBE7cVUun+IwHL3HMO4ozPYD2eqNsV8ibDjfe1FNSlVBBlW8Zn2jTClRWNnnBNTc6SYyCOG1dCple1HEAcwwRU2n4tKEvjHKs7Teti8JkH9DsAPmygl1pajweuujPV8VTYVFGOL1g7UDwZ2Vwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6nutRDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FBC4CEE3;
	Fri, 20 Jun 2025 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410646;
	bh=K5IFjVJXo3gk8wy3NygWJN32Uu8UoQD+pATZre8h0AU=;
	h=Subject:To:Cc:From:Date:From;
	b=e6nutRDgnKy3cZ84osx3hw/ljA9S4W7dlqZ+OoclOwGJYBd65v5AayPTEoUmZvHNx
	 CQbMYmll4bML3/ujvYRK2Ti752JKsPZpKjzpOmMOtTy1S9OeOAMLdf2pccLsMwzoDj
	 boPcLiMZhtFJ1vT3gMJhO8hCZeUMqr8AKmfEj4iM=
Subject: FAILED: patch "[PATCH] cifs: update dstaddr whenever channel iface is updated" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:10:43 +0200
Message-ID: <2025062043-uplifting-dissuade-3e0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c1846893991f3b4ec8a0cc12219ada153f0814d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062043-uplifting-dissuade-3e0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1846893991f3b4ec8a0cc12219ada153f0814d6 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Mon, 2 Jun 2025 22:37:14 +0530
Subject: [PATCH] cifs: update dstaddr whenever channel iface is updated

When the server interface info changes (more common in clustered
servers like Azure Files), the per-channel iface gets updated.
However, this did not update the corresponding dstaddr. As a result
these channels will still connect (or try connecting) to older addresses.

Fixes: b54034a73baf ("cifs: during reconnect, update interface if necessary")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 79b4bd45e31a..ec0db32c7d98 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -445,6 +445,10 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
 	ses->chans[chan_index].iface = iface;
 	spin_unlock(&ses->chan_lock);
+
+	spin_lock(&server->srv_lock);
+	memcpy(&server->dstaddr, &iface->sockaddr, sizeof(server->dstaddr));
+	spin_unlock(&server->srv_lock);
 }
 
 static int


