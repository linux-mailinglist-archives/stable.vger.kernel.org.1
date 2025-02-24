Return-Path: <stable+bounces-118773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466DA41B3E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1301892C32
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EB24A069;
	Mon, 24 Feb 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCa7wy2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08563245033
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393240; cv=none; b=r4QM0/Qgeoekui2oFdfYr8TG6IcLnrokF5p3ULH55bBFvubbJ8S4q2Cr2EoV6/zdaO5nwLtUsGnpNuMYhyW8H9QrQfbECg6+mfreQH9OAT6zxzYsECN9NeX8+C2cnHRtNyup9Xt9UGJKWH2cdjLhFAos5FwzwigiCfNTkURvuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393240; c=relaxed/simple;
	bh=TT7Tpj/fvg00keNdHzWiF6IO0W44NaisZBWQATvi9gg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LbxEYtKhHBWBEHBHHy+5NIWnBu2xQilJdEh770kzQBDuqVicJAl+2U+2ch0gbe9ztc2DgBKd7jsKu3+e+2n69haefWab/tkouxQ5mRZSmoL5oAGKfeyycVToBIcWQs+NPrTR9jKpD99GuQEmfGocODOvLGxMclUAoN9QHBU/WGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCa7wy2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FC2C4CEE6;
	Mon, 24 Feb 2025 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740393239;
	bh=TT7Tpj/fvg00keNdHzWiF6IO0W44NaisZBWQATvi9gg=;
	h=Subject:To:Cc:From:Date:From;
	b=FCa7wy2R+suPvvDb3W/O2V72nirgZ8/oOfJFxi1V1KgKvQqECxQmroIh8wQJHASDE
	 nQSi7Z3X75YRhysew1z3N0Rv1KnvpZ0cIFwOBOs/n+ZrRqoNeJ21/aYmrVoP2/wAFP
	 LwAYxJC1+cLG1zCgUCwwp+3s4F+YTQEdxgx4bw9U=
Subject: FAILED: patch "[PATCH] smb: client: Add check for next_buffer in" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:33:46 +0100
Message-ID: <2025022446-armrest-ibuprofen-7690@gregkh>
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
git cherry-pick -x 860ca5e50f73c2a1cef7eefc9d39d04e275417f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022446-armrest-ibuprofen-7690@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 860ca5e50f73c2a1cef7eefc9d39d04e275417f7 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Mon, 17 Feb 2025 15:20:38 +0800
Subject: [PATCH] smb: client: Add check for next_buffer in
 receive_encrypted_standard()

Add check for the return value of cifs_buf_get() and cifs_small_buf_get()
in receive_encrypted_standard() to prevent null pointer dereference.

Fixes: eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 23e0c8be7fb5..4dd11eafb69d 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4965,6 +4965,10 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
+		if (!next_buffer) {
+			cifs_server_dbg(VFS, "No memory for (large) SMB response\n");
+			return -1;
+		}
 		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 


