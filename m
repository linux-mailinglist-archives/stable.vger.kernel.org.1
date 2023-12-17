Return-Path: <stable+bounces-6915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13E81616F
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF88B21619
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A646B8E;
	Sun, 17 Dec 2023 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GV86kpMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46646451
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 17:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA1BC433C8;
	Sun, 17 Dec 2023 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702835543;
	bh=p7QREjEXIpysCrt9Lc1z3rvkhkZIzirWZYfPfp+nCOY=;
	h=Subject:To:Cc:From:Date:From;
	b=GV86kpMgr0gYglkYfyjLJEslAEPk6m7nspgYdauXeza5EY7c1zGX/AsgI/1mMkLI7
	 3bvgzcybe3L3NZAeTy+WLEh5AR9Fh03UlXE+4RT2z5vkpdwu8YDxd6aupMs73/R7aj
	 oRPb4E7bOZ84S3yOdJuAD8lJZFzo+io0lmHIde5w=
Subject: FAILED: patch "[PATCH] ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE" failed to apply to 4.14-stable tree
To: linkinjeon@kernel.org,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Dec 2023 18:52:14 +0100
Message-ID: <2023121714-egomaniac-enslave-768e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 13736654481198e519059d4a2e2e3b20fa9fdb3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121714-egomaniac-enslave-768e@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

137366544811 ("ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13736654481198e519059d4a2e2e3b20fa9fdb3e Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 6 Dec 2023 08:23:49 +0900
Subject: [PATCH] ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

MS confirm that "AISi" name of SMB2_CREATE_ALLOCATION_SIZE in MS-SMB2
specification is a typo. cifs/ksmbd have been using this wrong name from
MS-SMB2. It should be "AlSi". Also It will cause problem when running
smb2.create.open test in smbtorture against ksmbd.

Cc: stable@vger.kernel.org
Fixes: 12197a7fdda9 ("Clarify SMB2/SMB3 create context and add missing ones")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 8b603b13e372..57f2343164a3 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1145,7 +1145,7 @@ struct smb2_server_client_notification {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"


