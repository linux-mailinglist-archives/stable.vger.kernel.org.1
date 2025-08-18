Return-Path: <stable+bounces-169957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8DB29E85
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4792173375
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2A30FF1D;
	Mon, 18 Aug 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en/DVWKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772530F81E
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510949; cv=none; b=UOq/Y1vWr5joI0S+6nK6gqNHVb1EkY0pZvMGhMRJ3yL22royzVGgbtGmjPitOhjXqodnHMVG5+Ylp7Xa0sxbE71/zHxvlVBVmnnpIu7BwA18nzMebpX+XTsvZTAKkrBO62WuRm+/g7IWBCaDR+KEratiE4LN5Ve0/VqgLkO2khY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510949; c=relaxed/simple;
	bh=x+EYW3a9qjYkUpSVZwUaBOkmWTCZ1Xs0nf74Thb9d2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=budRl8ADsqUe5WTI7E02OFhq4pvf3LRvXup7Q5GRtQMTSTI2ZWbMrpvzvnzkt47ZbRBwRkQJDhB2c8pyAqk0T34bGkAjNaBsKkdBLQAxxBXIr+XJTxE84Cg+E4ljdicAj8I7WaJClueIrhJI80Yrc//I+LRvDLMEx+tBFyRll2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en/DVWKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87658C4CEF1;
	Mon, 18 Aug 2025 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510949;
	bh=x+EYW3a9qjYkUpSVZwUaBOkmWTCZ1Xs0nf74Thb9d2s=;
	h=Subject:To:Cc:From:Date:From;
	b=en/DVWKV3jdFkBYg60QQv3IEbFUSm5GbvRRzrp8LEbCk851C8DWE2Bz7FiCAcTJOm
	 54V3STGrXyoFAanPnH+8V+TovxQHMuDlJYxjbnZR0L4u7GQmplYXvrZep+5H6EWFHT
	 9rSyb+GFODTqwM3ktXuD3IZ51B3LInca5QL3qUug=
Subject: FAILED: patch "[PATCH] cifs: reset iface weights when we cannot find a candidate" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:55:45 +0200
Message-ID: <2025081845-cork-enable-a1e8@gregkh>
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
git cherry-pick -x 9d5eff7821f6d70f7d1b4d8a60680fba4de868a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081845-cork-enable-a1e8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d5eff7821f6d70f7d1b4d8a60680fba4de868a7 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Thu, 17 Jul 2025 17:36:13 +0530
Subject: [PATCH] cifs: reset iface weights when we cannot find a candidate

We now do a weighted selection of server interfaces when allocating
new channels. The weights are decided based on the speed advertised.
The fulfilled weight for an interface is a counter that is used to
track the interface selection. It should be reset back to zero once
all interfaces fulfilling their weight.

In cifs_chan_update_iface, this reset logic was missing. As a result
when the server interface list changes, the client may not be able
to find a new candidate for other channels after all interfaces have
been fulfilled.

Fixes: a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 330bc3d25bad..0a8c2fcc9ded 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -332,6 +332,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
+	int retry = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
@@ -360,6 +361,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		return;
 	}
 
+try_again:
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
 				     iface_head);
 	iface_min_speed = last_iface->speed;
@@ -397,6 +399,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
+		list_for_each_entry(iface, &ses->iface_list, iface_head)
+			iface->weight_fulfilled = 0;
+
+		/* see if it can be satisfied in second attempt */
+		if (!retry++)
+			goto try_again;
+
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}


