Return-Path: <stable+bounces-3915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C538C803F6A
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015261C20BC4
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805B35EF4;
	Mon,  4 Dec 2023 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdQghO4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE435EE4;
	Mon,  4 Dec 2023 20:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB0C433C8;
	Mon,  4 Dec 2023 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722019;
	bh=h0/53uKqJP9rqBgpQtyJ/HFjcSItrRZENrMDnnnrps8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdQghO4rId+dxZJpuSVEqen+dbLCr+Us80zVQvSXHELoCu4q3QmN6zAvvYhDctyA2
	 R97ggW55cM9M3Ybn65KAGccE+QYi+MSWAy2W+OHAyxJaLgZpWVzfM8kWm3bMSkaL6C
	 ZcGN7a10C7WYIm+n+jAp7fZ0DfHWqfxD2C7qLkz+euj2DRLC3UpWJyoC1cbc6DMoiY
	 zHfGfBf5OzfE6OnU05Fuoi6NEodr3sad0Y9FRtgJxdkV5Hi+ka7ApNbOzB171Q6qIi
	 s2AuF8B3xVFYj9SnRw4S0uDn6JWr0Xh6Dauq5KQXkcy+Mbj6xpq21g2UzGIpR42p0b
	 uhkr2qklN6VAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/32] ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
Date: Mon,  4 Dec 2023 15:32:28 -0500
Message-ID: <20231204203317.2092321-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 9ac45ac7cf65b0623ceeab9b28b307a08efa22dc ]

Directly set SMB2_FLAGS_ASYNC_COMMAND flags and AsyncId in smb2 header of
interim response instead of current response header.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a85f3cc7c181f..7eaac1098f637 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -657,13 +657,9 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 {
-	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = ksmbd_resp_buf_next(work);
-	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
-
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
 	if (id < 0) {
 		pr_err("Failed to alloc async message id\n");
@@ -671,7 +667,6 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	}
 	work->asynchronous = true;
 	work->async_id = id;
-	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
 	ksmbd_debug(SMB,
 		    "Send interim Response to inform async request id : %d\n",
@@ -723,6 +718,8 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
 	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
-- 
2.42.0


