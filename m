Return-Path: <stable+bounces-181307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E0B9307D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF3118904EE
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B62F2909;
	Mon, 22 Sep 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bOuKs4Rd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473A2F0C52;
	Mon, 22 Sep 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570207; cv=none; b=YbOtNOPZjyq+E1vG4nF1pnIRCracVZUuUDji5eMNnfF39HbyR5DmADaaXU27zUt0SDKddgjBpDkAvd8FuTIKWDS8B+SdxxCxx7ng5KLncKFtGtTfWbhU43b9ZLHlI/asES4l8O4s8QbdSBC4vJ4BOw9v69q660OLX2m2hMs4RhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570207; c=relaxed/simple;
	bh=lVyV+apTjMaeqHJOaDRHdj3HOSKCtu+0ynLsnWqqg0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iypu6AfhhuqNaK3GxQTnuDl+xSivmVQtRKyPRnBC9icFBUJmKH/qSLHK5bhYsWrXHHtYITeOtZfP9SfMQgqzFrwVx8/CqLIgN66wbGzdVOcPwRZ4HeStO6iy4x8/T4SckmKE8WaTu0EZaB6+RdVw5TEMvKYfilzA8NQYf0kB/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bOuKs4Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE08C4CEF0;
	Mon, 22 Sep 2025 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570207;
	bh=lVyV+apTjMaeqHJOaDRHdj3HOSKCtu+0ynLsnWqqg0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOuKs4Rd9r/WsUTyPnsyaHg1BdthMdZ97ywalwqczdBlqevR9ggxzBe/A6e4aHEEA
	 TWYK331AIgnPHB0qZqDjpyMPVkc/9Ptcd5qm3CoT5hTJcwh/BzRTQD3qhDWy+XFYdD
	 9kQSI5sm8PPx2x9GTL38btYHykxBciomUJis3WgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	"Luigino Camastra, Aisle Research" <luigino.camastra@aisle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.16 047/149] ksmbd: smbdirect: validate data_offset and data_length field of smb_direct_data_transfer
Date: Mon, 22 Sep 2025 21:29:07 +0200
Message-ID: <20250922192414.050024563@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 5282491fc49d5614ac6ddcd012e5743eecb6a67c upstream.

If data_offset and data_length of smb_direct_data_transfer struct are
invalid, out of bounds issue could happen.
This patch validate data_offset and data_length field in recv_done.

Cc: stable@vger.kernel.org
Fixes: 2ea086e35c3d ("ksmbd: add buffer validation for smb direct")
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Reported-by: Luigino Camastra, Aisle Research <luigino.camastra@aisle.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_rdma.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -554,7 +554,7 @@ static void recv_done(struct ib_cq *cq,
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
 		struct smb_direct_data_transfer *data_transfer =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
-		unsigned int data_length;
+		unsigned int data_offset, data_length;
 		int avail_recvmsg_count, receive_credits;
 
 		if (wc->byte_len <
@@ -565,14 +565,15 @@ static void recv_done(struct ib_cq *cq,
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
 



