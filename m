Return-Path: <stable+bounces-180816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AF3B8DD07
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E851417ADC4
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E491474CC;
	Sun, 21 Sep 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9fZPTbk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA245948
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758466837; cv=none; b=hQoGpcUL2iMkH/4wB+12dB8zfLYZctl+GvXLIM3roH9gZRVPBu3hQFPUUTjrgHuW9f7FPZ2/IlZAl25BEcEOwreGfMBUJRfFrHm73jGF/NKLzsw3O+zqJ1EQ2u6usoNmp2bq7c1UafBY/XpZvC2ioOXF8DZ2l4iE6rKF00U/MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758466837; c=relaxed/simple;
	bh=AZhEj6Zb6slKI4zDpNW8OZowGWtQFOY6kwDH6AD7vW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHjdX7eEdqk6SJFNL3tERrB3gKuFKG2rnkf5fWiJ970INLrhWNHGhhPEqL0/o6XuAS3zX5WoS0je99PWLEH0oneDpjuCpItblzyMvH3lXqp6jojg0jpyGd9BtiCodszCqDBEqmo9zkpjBNw1+wTudi35+JGbv3Uqx3HV8am1rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9fZPTbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C6C4CEE7;
	Sun, 21 Sep 2025 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758466836;
	bh=AZhEj6Zb6slKI4zDpNW8OZowGWtQFOY6kwDH6AD7vW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9fZPTbkC13i2aprcIHrNzwmXZtYK3O/VDFfikuxMozFJIcL2NiF4Nie8LpHURNCg
	 Mf96XMIg1InJpI9cKhR3E5uoy/rKYSKYz06kDBpSrPkIom6TR1unZ5PU10U5yIu2PG
	 C3Oq4oGiQ5t+M2QMRsDfxo4narC4bAjr4vEDLwc53ZHg52Xmn8ocGna1Hwvmfnl/8W
	 ZGhD6g7aNj/QQ/Xj5TmCOd/+7CdTSBACXAAlt9N1oyAfs2JiilGXnlD6YE7phCC2b1
	 391WpgZOG22l9tCvXgnkJuwv4DXl+Nai7GxDZe7X8Q2bQhTXZHbUbezfrRN+Zj8l+t
	 YFjuw3AhqkXZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	"Luigino Camastra, Aisle Research" <luigino.camastra@aisle.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: smbdirect: validate data_offset and data_length field of smb_direct_data_transfer
Date: Sun, 21 Sep 2025 11:00:33 -0400
Message-ID: <20250921150033.2932212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092118-portside-cheesy-44d2@gregkh>
References: <2025092118-portside-cheesy-44d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 5282491fc49d5614ac6ddcd012e5743eecb6a67c ]

If data_offset and data_length of smb_direct_data_transfer struct are
invalid, out of bounds issue could happen.
This patch validate data_offset and data_length field in recv_done.

Cc: stable@vger.kernel.org
Fixes: 2ea086e35c3d ("ksmbd: add buffer validation for smb direct")
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Reported-by: Luigino Camastra, Aisle Research <luigino.camastra@aisle.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Applied to fs/ksmbd/transport_rdma.c instead of fs/smb/server/transport_rdma.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_rdma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 2f02632905842..4b79df7c8caf3 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -548,7 +548,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
 		struct smb_direct_data_transfer *data_transfer =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
-		unsigned int data_length;
+		unsigned int data_offset, data_length;
 		int avail_recvmsg_count, receive_credits;
 
 		if (wc->byte_len <
@@ -559,14 +559,15 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
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
 
-- 
2.51.0


