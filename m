Return-Path: <stable+bounces-168748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44AB23686
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A9D7B8A3B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1F2FE588;
	Tue, 12 Aug 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Tu4Sx1F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3532F90F1;
	Tue, 12 Aug 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025207; cv=none; b=PW+XdIyg9dAHJF64SBS2RmjwtQGDax7wsGtK78mF0C1Xix5UOdFz9Z/LLcpglwMZI7/uDCfbEY5IABCDSujIU5hyPDuQhxxPIstTfH1V1dPRF/D9H/HSNu+piP5/oWukCPeSZa1ne+x1PgKO74x2+xSbCsDaEwtLzap5bhRrtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025207; c=relaxed/simple;
	bh=xUYJQ2Key9ozI4GqlK8IAEJT76gzZMAbyuwcdS6g/50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ols3bQBLfHqPrxQ30XTeTWnmhN4RwfxBww4ggxpiMRnNhHTisnaVyi3i2OztDwcNuNte6eFDT28qZa/uwqZ1KJK+2bX+JZo6JbLY4fGMbcNcI/2PvR6jnSUn6kt+ia3H1CAMlubZ1SkodC8tbkyavPMNqf2/tiQ9H6B58KpGv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Tu4Sx1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C121BC4CEF0;
	Tue, 12 Aug 2025 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025207;
	bh=xUYJQ2Key9ozI4GqlK8IAEJT76gzZMAbyuwcdS6g/50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Tu4Sx1F4RPZIKpBQCot6lP+MXOkDQ0LBzhhr6R46KbKQR50p6x8PkEb4/GDrkz9c
	 rYMJK+L8ayRWCKhoTgbeMw/7p7QwV5FclZ5AEFICcyoxQarPoADvCKnP9p3tZ5I4A4
	 /a09yXadLv9q8YX9YQQmhp7g9ynyLO8J+atYXsSY=
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
Subject: [PATCH 6.16 567/627] smb: client: let recv_done() avoid touching data_transfer after cleanup/move
Date: Tue, 12 Aug 2025 19:34:22 +0200
Message-ID: <20250812173453.452553902@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit 24eff17887cb45c25a427e662dda352973c5c171 ]

Calling enqueue_reassembly() and wake_up_interruptible(&info->wait_reassembly_queue)
or put_receive_buffer() means the response/data_transfer pointer might
get re-used by another thread, which means these should be
the last operations before calling return.

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
 fs/smb/client/smbdirect.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index d26b8cef82d6..47f2a6cc1c0c 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -479,10 +479,6 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		data_transfer = smbd_response_payload(response);
 		data_length = le32_to_cpu(data_transfer->data_length);
 
-		/*
-		 * If this is a packet with data playload place the data in
-		 * reassembly queue and wake up the reading thread
-		 */
 		if (data_length) {
 			if (info->full_packet_received)
 				response->first_segment = true;
@@ -491,16 +487,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 				info->full_packet_received = false;
 			else
 				info->full_packet_received = true;
-
-			enqueue_reassembly(
-				info,
-				response,
-				data_length);
-		} else
-			put_receive_buffer(info, response);
-
-		if (data_length)
-			wake_up_interruptible(&info->wait_reassembly_queue);
+		}
 
 		atomic_dec(&info->receive_credits);
 		info->receive_credit_target =
@@ -528,6 +515,16 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			info->keep_alive_requested = KEEP_ALIVE_PENDING;
 		}
 
+		/*
+		 * If this is a packet with data playload place the data in
+		 * reassembly queue and wake up the reading thread
+		 */
+		if (data_length) {
+			enqueue_reassembly(info, response, data_length);
+			wake_up_interruptible(&info->wait_reassembly_queue);
+		} else
+			put_receive_buffer(info, response);
+
 		return;
 	}
 
-- 
2.39.5




