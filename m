Return-Path: <stable+bounces-41653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FAA8B567B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2658F1F22F97
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0F40843;
	Mon, 29 Apr 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vp2c/XIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4E2375B
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389996; cv=none; b=Up79ZP7A7h3RsVBdZUpGtOuaonItXoYn+APuWzLyonkSAPMcRGBnJ8868WXb+5EOFX4d90b7kETYeDkRDpy9Ud9aVPqa9oaGkoNTKrRYhsIBYiQvGiii+MYvhfoq3Cvh/MSfwIv0T+IbTqJJmWMXd124cDDbc8D56+mwrm+L4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389996; c=relaxed/simple;
	bh=1iajA0kHXeTM7pr6TFUyU8qAjzugDVGdt6WlBCKxHdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r3PrjSeo04sWcJdt2UD8rH/Ct4xilximkX61RjfyVS1HXcKm2wGgz+3yTf/z4rM6Zq/wqFKjuIdH98Lux+YLLYWMa3V0gWtKUmk8RM4MZYmY0LqLTuNeUU6VeC2PAbylxfeT5YwTMtAxjA94A79zvUtT5uisSWtuGNR3Am556og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vp2c/XIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9E4C113CD;
	Mon, 29 Apr 2024 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389995;
	bh=1iajA0kHXeTM7pr6TFUyU8qAjzugDVGdt6WlBCKxHdM=;
	h=Subject:To:Cc:From:Date:From;
	b=Vp2c/XIO5o1n2R3SFi74PlMiFgCW+saaHer/nTFBXXuXDJEr4N5t/jk3Zh+uEgLQF
	 lCFBq4kZvgb92Okwtklf5zhiQP+Vvz5rQupR6omJn7ph+cX28TUoZgVtmtKX7AaLft
	 6YFe7+OVKcSZO3wTX+Q7n48zZOYrDbLZsaFhOgsU=
Subject: FAILED: patch "[PATCH] smb3: missing lock when picking channel" failed to apply to 4.19-stable tree
To: stfrench@microsoft.com,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:26:17 +0200
Message-ID: <2024042917-regulate-exquisite-3f14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8094a600245e9b28eb36a13036f202ad67c1f887
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042917-regulate-exquisite-3f14@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8094a600245e ("smb3: missing lock when picking channel")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
ea90708d3cf3 ("cifs: use the least loaded channel for sending requests")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8094a600245e9b28eb36a13036f202ad67c1f887 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 25 Apr 2024 11:30:16 -0500
Subject: [PATCH] smb3: missing lock when picking channel

Coverity spotted a place where we should have been holding the
channel lock when accessing the ses channel index.

Addresses-Coverity: 1582039 ("Data race condition (MISSING_LOCK)")
Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 994d70193432..e1a79e031b28 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1057,9 +1057,11 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 		index = (uint)atomic_inc_return(&ses->chan_seq);
 		index %= ses->chan_count;
 	}
+
+	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);
 
-	return ses->chans[index].server;
+	return server;
 }
 
 int


