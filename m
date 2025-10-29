Return-Path: <stable+bounces-191638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2DC1BEDA
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB1586685
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FA2ED154;
	Wed, 29 Oct 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRESZDay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8142E5B2E
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751223; cv=none; b=hh/0l0DQJSOM+Rua4kTAXp+eR/aP8GNOBbgwyLUSO15CDoSx0rQKNXv4ohIrNvM62SQRkoUr8VXpgGL3UcrLA3l7Ipu3HQkj/kYIDTeGRCyNnbnSVrvdBcOBcOUyIEkkXLV/9Zc2v5UkjGnKhKEgQXmVvtMn3WaDbvgQt31CkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751223; c=relaxed/simple;
	bh=opUHfshMkV6CljdmqbBuFhDH3bpWtrB/upGxuVHUN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgMPF/QgSbOVzCBO8yhVXb8QrSIykYlS7uGJrlPGQVOi4K3Kg5WvrLXwRqcSyl2Z3JRm6X+8iOZQsDM7I/lzzSO+Tm9ggC5lKcfzGZVIB3rDJxmD6ioGhQnb5/v4dlt6v2+mEanTIniKMjqoBDv1TzptGGgsYqLpfhI4NGOcGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRESZDay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F6C4CEFF;
	Wed, 29 Oct 2025 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751223;
	bh=opUHfshMkV6CljdmqbBuFhDH3bpWtrB/upGxuVHUN0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRESZDayN6+e87e2/4vxdlQWZBaz+X9M9cCVTXRj8CjFvLdGGeTW4grv9puyd9Jh7
	 8ZwtRgw06hQGFOm5dkoa0KQPAaFazMD77Mq5gVWdnczqfEe9vsl07sdba+Tq0RmpZn
	 laQQasEQcg7fjDlAeqgWdw9miyUX/gl/dS3A7DijU8KbbWGk7J3Kdj4Df5qowPDeOS
	 dYgalUxVKRJGDfy6OLHDh1nzMFpY5DdlbrxaJlThxLOH7PWchhGmhzCGNWvzp+16Ed
	 tlsNM5asjWBuBIGDoV6iQ0YceEeXj+CwPoov7YlLXU0vPxO0+H6k+3kX1oDI45W1DT
	 fDk7YQRmp2zlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianchang Zhao <pioooooooooip@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: transport_ipc: validate payload size before reading handle
Date: Wed, 29 Oct 2025 11:20:20 -0400
Message-ID: <20251029152021.1583258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102920-mace-herbal-edee@gregkh>
References: <2025102920-mace-herbal-edee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qianchang Zhao <pioooooooooip@gmail.com>

[ Upstream commit 6f40e50ceb99fc8ef37e5c56e2ec1d162733fef0 ]

handle_response() dereferences the payload as a 4-byte handle without
verifying that the declared payload size is at least 4 bytes. A malformed
or truncated message from ksmbd.mountd can lead to a 4-byte read past the
declared payload size. Validate the size before dereferencing.

This is a minimal fix to guard the initial handle read.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ applied patch to fs/ksmbd/transport_ipc.c instead of fs/smb/server/transport_ipc.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_ipc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 7e6003c6cd9bf..1d57426e9e022 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -248,10 +248,16 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
-	unsigned int handle = *(unsigned int *)payload;
+	unsigned int handle;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
 
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
+	handle = *(unsigned int *)payload;
+
 	ipc_update_last_active();
 	down_read(&ipc_msg_table_lock);
 	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
-- 
2.51.0


