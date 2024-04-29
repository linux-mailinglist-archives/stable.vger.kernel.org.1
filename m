Return-Path: <stable+bounces-41657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7D8B567F
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AF1C21F56
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2740843;
	Mon, 29 Apr 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DF20BBDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B12375B
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390010; cv=none; b=qf/UlXvWkCiWvoSdRc7zLL1w6ANI8dLpomWVaAMVHtTey5X8mu88PKnseWeMNv0/aggQhTuRtPMf5i06jBDA12r4GT4zZ21Hck6P8sPgSCTgQ/0yNHBZiPVMyg8NCjPNZ+joIZkmsqdtmJoDhy1IuiEgN2s4lNzQZLgV93gM/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390010; c=relaxed/simple;
	bh=gnWi1ekQr0wmv8L0S3w7v4wIlqc3ITfRK2R8vculV5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HOxAByrrn3wfvtX4SXitQO/5H9/TKFYy6c3c3Qv5XERWMcomL2NwWxHXWAL9VrictozPFJZJMIuYOywE9ebxN+kODQvR4Dmy9YjEQ6ddmloBeX8UIha+wRK21nOQRqiWax8IJdD+7a2SgpXEI7To35aCJU86ET7psCVO027JxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DF20BBDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42315C4AF17;
	Mon, 29 Apr 2024 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390010;
	bh=gnWi1ekQr0wmv8L0S3w7v4wIlqc3ITfRK2R8vculV5g=;
	h=Subject:To:Cc:From:Date:From;
	b=DF20BBDIj+7Tz0tleSvn7ONSwRh/p1RQOebz5CL9dxt0wJUZu1PEPXY5J60az9lA7
	 FdvhHJwvbHxnvS90afa1R3ozx5Qop/Mh1bZuKSxegQJD8/ZcKbQTVgfdHgLTaJ8KS8
	 BM6PdxUR/FJYz8DUyEFcd4GlfUNvffZuQMqFtEeA=
Subject: FAILED: patch "[PATCH] smb3: fix lock ordering potential deadlock in" failed to apply to 5.4-stable tree
To: stfrench@microsoft.com,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:26:31 +0200
Message-ID: <2024042930-undone-willow-c057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8861fd5180476f45f9e8853db154600469a0284f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042930-undone-willow-c057@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8861fd518047 ("smb3: fix lock ordering potential deadlock in cifs_sync_mid_result")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8861fd5180476f45f9e8853db154600469a0284f Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 25 Apr 2024 12:49:50 -0500
Subject: [PATCH] smb3: fix lock ordering potential deadlock in
 cifs_sync_mid_result

Coverity spotted that the cifs_sync_mid_result function could deadlock

"Thread deadlock (ORDER_REVERSAL) lock_order: Calling spin_lock acquires
lock TCP_Server_Info.srv_lock while holding lock TCP_Server_Info.mid_lock"

Addresses-Coverity: 1590401 ("Thread deadlock (ORDER_REVERSAL)")
Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index e1a79e031b28..ddf1a3aafee5 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -909,12 +909,15 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 			list_del_init(&mid->qhead);
 			mid->mid_flags |= MID_DELETED;
 		}
+		spin_unlock(&server->mid_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
 			 __func__, mid->mid, mid->mid_state);
 		rc = -EIO;
+		goto sync_mid_done;
 	}
 	spin_unlock(&server->mid_lock);
 
+sync_mid_done:
 	release_mid(mid);
 	return rc;
 }


