Return-Path: <stable+bounces-180749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC78B8DA82
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438E4176FCF
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D02E40B;
	Sun, 21 Sep 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRYESiWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735834BA52
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758456939; cv=none; b=bGsOv7rluxZRxQdfX4rEVGyWhG9plxoeqmWb1LAMOaRCCnWX9wm0qRDegssjqHXRmGR/vM820boj2gnoFePCYB/UhTjjIi2LrgNSJBsUBf082hgFzU6RyswIvSYe/fs/x9zTEAsEFFubguutJ+kspwx36QqEM6HA9b2yqshzf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758456939; c=relaxed/simple;
	bh=2dz19DWtftTjd4YTPuALx4dtDXX7ASmiONsf9J3mt5Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CLR1TJ53VQPOQSZnwA4ge8hhJqvPWwbwXUwV0/sjeFMzVTairSDHpBlD7TUgKjDu3Cy5HYjfhyzFrD14p35c/0f71iYOGTuMONnIToE6YnRbiBQXSG5746JznxKx/ldkx5qc2IhRo8koQ1JOyFfLx9gfoIl1dEzbXkZIxvZ7otY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRYESiWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D380DC4CEE7;
	Sun, 21 Sep 2025 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758456938;
	bh=2dz19DWtftTjd4YTPuALx4dtDXX7ASmiONsf9J3mt5Q=;
	h=Subject:To:Cc:From:Date:From;
	b=JRYESiWMERpYsZlNcSjT2ehqyNXY4NHJGhxpYhGzPbYENTToVxDvhJhyRwXHjQQtF
	 3yCYwABNcAVsN+yV7/1N87J3/bk4oGuqvU+MQ0g7mBP/i9j69MeJH3fDRUanbFtkpy
	 a8lX84RfVW0hZFrdfU6rJF4e8Hujkk+nMQb6z874=
Subject: FAILED: patch "[PATCH] ksmbd: smbdirect: verify remaining_data_length respects" failed to apply to 5.15-stable tree
To: metze@samba.org,linkinjeon@kernel.org,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:15:35 +0200
Message-ID: <2025092135-estate-gander-564d@gregkh>
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
git cherry-pick -x e1868ba37fd27c6a68e31565402b154beaa65df0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092135-estate-gander-564d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1868ba37fd27c6a68e31565402b154beaa65df0 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 11 Sep 2025 10:05:23 +0900
Subject: [PATCH] ksmbd: smbdirect: verify remaining_data_length respects
 max_fragmented_recv_size

This is inspired by the check for data_offset + data_length.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: stable@vger.kernel.org
Fixes: 2ea086e35c3d ("ksmbd: add buffer validation for smb direct")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index d52f37578276..6550bd9f002c 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -554,7 +554,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
 		struct smb_direct_data_transfer *data_transfer =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
-		unsigned int data_offset, data_length;
+		u32 remaining_data_length, data_offset, data_length;
 		int avail_recvmsg_count, receive_credits;
 
 		if (wc->byte_len <
@@ -564,6 +564,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			return;
 		}
 
+		remaining_data_length = le32_to_cpu(data_transfer->remaining_data_length);
 		data_length = le32_to_cpu(data_transfer->data_length);
 		data_offset = le32_to_cpu(data_transfer->data_offset);
 		if (wc->byte_len < data_offset ||
@@ -572,6 +573,14 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			smb_direct_disconnect_rdma_connection(t);
 			return;
 		}
+		if (remaining_data_length > t->max_fragmented_recv_size ||
+		    data_length > t->max_fragmented_recv_size ||
+		    (u64)remaining_data_length + (u64)data_length >
+		    (u64)t->max_fragmented_recv_size) {
+			put_recvmsg(t, recvmsg);
+			smb_direct_disconnect_rdma_connection(t);
+			return;
+		}
 
 		if (data_length) {
 			if (t->full_packet_received)


