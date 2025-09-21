Return-Path: <stable+bounces-180748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F3B8DA7C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DB189A898
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39060253B4C;
	Sun, 21 Sep 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0vuMbTr9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3604315A
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758456683; cv=none; b=dSk/0U99istD6CzAg0nKcOm8ZnRYzCEAxIeegOlt6VN/FNkmP8imLDBIkTHbPQSwMli71hUElyR8r885V/5k6pzKDp9uQOEU0k12QlniNFMhIa1uHyWtyW5/RKAhfA327yxNDHgIT3SDTdNVzvMece3LYiniXHvRlAH9RTSVpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758456683; c=relaxed/simple;
	bh=yvGKNc9V02KHhl8YO85Cys9QHWv8jOc1X1oPyyPvxG8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=feg3zOl+kwBWwdaw3XLnJ3wzscEtJhBnOPQHuqhVGSfb9/TEW0LTwpK9v5heSaj4R8MK5jlgA9Og2liSnZR2JqfVPKXO36KOYHQylcntksW3Y9dBSjFowLB2LXT9Ocp2+zNos4xJ/v72uoB6OIV9EJ+RWT8bkgt4+LR4RlTYMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0vuMbTr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E74C4CEE7;
	Sun, 21 Sep 2025 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758456681;
	bh=yvGKNc9V02KHhl8YO85Cys9QHWv8jOc1X1oPyyPvxG8=;
	h=Subject:To:Cc:From:Date:From;
	b=0vuMbTr94vLVkows5P3Cl/qBeg8bAMEiH0OJRwd3FrVfexkZbfL7jMewnqjwfXFMs
	 cz/xgHdrtxVxI5Z2grg7EDqVE02LOAt9MYljpAR47cl/PjjefQfKW04CADy6vcGMYD
	 Rc1RAKY1fYutQE0eT0Fs8AwWncRRA+G7vNhzlFOM=
Subject: FAILED: patch "[PATCH] ksmbd: smbdirect: validate data_offset and data_length field" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,luigino.camastra@aisle.com,metze@samba.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:11:18 +0200
Message-ID: <2025092118-portside-cheesy-44d2@gregkh>
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
git cherry-pick -x 5282491fc49d5614ac6ddcd012e5743eecb6a67c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092118-portside-cheesy-44d2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5282491fc49d5614ac6ddcd012e5743eecb6a67c Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 10 Sep 2025 11:22:52 +0900
Subject: [PATCH] ksmbd: smbdirect: validate data_offset and data_length field
 of smb_direct_data_transfer

If data_offset and data_length of smb_direct_data_transfer struct are
invalid, out of bounds issue could happen.
This patch validate data_offset and data_length field in recv_done.

Cc: stable@vger.kernel.org
Fixes: 2ea086e35c3d ("ksmbd: add buffer validation for smb direct")
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Reported-by: Luigino Camastra, Aisle Research <luigino.camastra@aisle.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index cc4322bfa1d6..d52f37578276 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -554,7 +554,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
 		struct smb_direct_data_transfer *data_transfer =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
-		unsigned int data_length;
+		unsigned int data_offset, data_length;
 		int avail_recvmsg_count, receive_credits;
 
 		if (wc->byte_len <
@@ -565,14 +565,15 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 
 		data_length = le32_to_cpu(data_transfer->data_length);
-		if (data_length) {
-			if (wc->byte_len < sizeof(struct smb_direct_data_transfer) +
-			    (u64)data_length) {
-				put_recvmsg(t, recvmsg);
-				smb_direct_disconnect_rdma_connection(t);
-				return;
-			}
+		data_offset = le32_to_cpu(data_transfer->data_offset);
+		if (wc->byte_len < data_offset ||
+		    wc->byte_len < (u64)data_offset + data_length) {
+			put_recvmsg(t, recvmsg);
+			smb_direct_disconnect_rdma_connection(t);
+			return;
+		}
 
+		if (data_length) {
 			if (t->full_packet_received)
 				recvmsg->first_segment = true;
 


