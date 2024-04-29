Return-Path: <stable+bounces-41650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1528B5678
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E16B21823
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87133FBBD;
	Mon, 29 Apr 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VCjOiZLW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71192375B
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389986; cv=none; b=WudS6Uo1rBm7I/EBmYe4j1xFCkzcE7PTFf46MmVn2CmxMMRvqASKswNz9jj8HKYhcBPBJhixgE74tz/ywlS3ZfXOCXy4KZqMvGPHStUaNBXjLZF1s7pvaqk5f7ybjnnQCHI2d5MH49ej3muqoyuw/oR/aisA2osmw8d3gMFDQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389986; c=relaxed/simple;
	bh=xAiECbrLfFH8fIeFHnCbfR9AYE1nMs7LtABtdoTan1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qCJwYnN74YS5qKK23QKA68/lHD9sJk3j5qLHS1okFVeB/62xta+/mq9RmWfMNQ4TqyDrjOsyumiO3Syi9GtcH84geY5U4GZ1gyFiYtvXAf9AH3UNoL1Dvy5fpkLmmpuYvj8K/mUw00++wppepO2u6iGeclxIIAPF5GUIVIK4McA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VCjOiZLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCECC113CD;
	Mon, 29 Apr 2024 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389986;
	bh=xAiECbrLfFH8fIeFHnCbfR9AYE1nMs7LtABtdoTan1U=;
	h=Subject:To:Cc:From:Date:From;
	b=VCjOiZLWZbM1EES7HNblSQZqXeh/nt8EvNNEl39xuGh03jM56u9xqrkmFbtaAhzWr
	 fiMS/W+SyXN9m0p7PyWEZktoWLBSktXksfuRd6ib5+j/LHZeO4txx0GLE9fvq6w9Cn
	 vdhkI0V1+zARN1qrJO3eLvfFBCn3kPprUr5JR7kA=
Subject: FAILED: patch "[PATCH] smb3: missing lock when picking channel" failed to apply to 5.10-stable tree
To: stfrench@microsoft.com,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:26:15 +0200
Message-ID: <2024042915-serving-venus-b776@gregkh>
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
git cherry-pick -x 8094a600245e9b28eb36a13036f202ad67c1f887
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042915-serving-venus-b776@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


