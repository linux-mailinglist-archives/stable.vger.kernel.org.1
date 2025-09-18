Return-Path: <stable+bounces-176117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA0B36B4A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BFA583A7D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E1352FD0;
	Tue, 26 Aug 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBIHiLMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B1350D7C;
	Tue, 26 Aug 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218825; cv=none; b=Tyw11Lv2S2tfwe7xk67FSjFaeeYBV2ItaJiRBcfbC2+KIaNSSIJ4uzUepeW626Cro/SPfhGC6N4NKDYBr4AHpCjkJymrNiBym3M9JrlKrldXjPL8K19FEoTOYMStw4aMjlC/1cG5rW4PfM1j/7NWYjBSX+72AUbl+ie9SnhrV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218825; c=relaxed/simple;
	bh=Td0PuyMOHlyZ4vgFi1dm7A+Y4Lq+E7+6qVbRAR3ZB2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj4N6JVBhEx3H45d5vTK6rs7dKzwMNA+tHon0DeJTA6VvsLRdYcFrwA/9tjcBUEDwPgZmwA5F67BlIqWqA5bztUJunN2kP85YogQiilKkrHcBJGokT7/BqUGVHL94N7VtjJd+2jucoGW4Q42AjdIvi0W2GaLDUGwkdqXVvqZi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBIHiLMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D34C4CEF1;
	Tue, 26 Aug 2025 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218824;
	bh=Td0PuyMOHlyZ4vgFi1dm7A+Y4Lq+E7+6qVbRAR3ZB2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBIHiLMtAt4cmN6xZSYtHOBBWqp27GmZaXvEWQ6WGnmNKhKGOx2D9rPc4fTBKT3Zw
	 mOa762WcUYR4v/i4HoHao34SmrtQwPT1m8KaUSWPO4L9jnth+47JiPoeDK+KQvsda8
	 3/QyH6bn+OVBYRApBQ+ubEOZgCUTB4SaDkKgCT3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 146/403] smb: client: let recv_done() cleanup before notifying the callers.
Date: Tue, 26 Aug 2025 13:07:52 +0200
Message-ID: <20250826110910.809760168@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit bdd7afc6dca5e0ebbb75583484aa6ea9e03fbb13 ]

We should call put_receive_buffer() before waking up the callers.

For the internal error case of response->type being unexpected,
we now also call smbd_disconnect_rdma_connection() instead
of not waking up the callers at all.

Note that the SMBD_TRANSFER_DATA case still has problems,
which will be addressed in the next commit in order to make
it easier to review this one.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smbdirect.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 0842a1af0b98..72df002e8ae3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -495,7 +495,6 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
 		log_rdma_recv(INFO, "wc->status=%d opcode=%d\n",
 			wc->status, wc->opcode);
-		smbd_disconnect_rdma_connection(info);
 		goto error;
 	}
 
@@ -512,8 +511,9 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		info->full_packet_received = true;
 		info->negotiate_done =
 			process_negotiation_response(response, wc->byte_len);
+		put_receive_buffer(info, response);
 		complete(&info->negotiate_completion);
-		break;
+		return;
 
 	/* SMBD data transfer packet */
 	case SMBD_TRANSFER_DATA:
@@ -565,14 +565,16 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 		queue_work(info->workqueue, &info->recv_done_work);
 		return;
-
-	default:
-		log_rdma_recv(ERR,
-			"unexpected response type=%d\n", response->type);
 	}
 
+	/*
+	 * This is an internal error!
+	 */
+	log_rdma_recv(ERR, "unexpected response type=%d\n", response->type);
+	WARN_ON_ONCE(response->type != SMBD_TRANSFER_DATA);
 error:
 	put_receive_buffer(info, response);
+	smbd_disconnect_rdma_connection(info);
 }
 
 static struct rdma_cm_id *smbd_create_id(
-- 
2.39.5




