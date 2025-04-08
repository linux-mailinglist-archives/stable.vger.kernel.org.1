Return-Path: <stable+bounces-130322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107ABA8042C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243F446624F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986D263C8A;
	Tue,  8 Apr 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yO7rBDAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F897268FE4;
	Tue,  8 Apr 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113411; cv=none; b=sJz/y2gQmI6w8C2rOkORy94L01OBUHt3tuklLW/LexfLY+H3V2RXcxVoDfdL15xuzb4rdECjmqTHFXcpRJwwpbR5SLk/HuQ8xMrOwaabjvbgjraw8r2Wfr+7ao2QmrOYCmKLjRCyBZzLF+p0N4eNMlra8ypA/+Bt5L3X4v9sl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113411; c=relaxed/simple;
	bh=22puVEXRB6zLIsZpPQOu+/fVV23zDOq50Jfo9jHCerc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTF8MFgtgEF3KC0hLAy0HgPGLVnwrXGJzTNrrph+VKBM55nz3kw/uZ7SIRZfWz3OffCVA/y6bd4EItIRoEoXA6JLvwfHYkqnQs2jXQNvp7bJXK+rQGZbmuN539Lzxy06/1OIdaNDT0eJpVm6cWpYsL/tx9sI19g6N1edzkZ09bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yO7rBDAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E5C4CEE5;
	Tue,  8 Apr 2025 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113411;
	bh=22puVEXRB6zLIsZpPQOu+/fVV23zDOq50Jfo9jHCerc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yO7rBDAn/+2KxdjVCiD2m/E0dmLyrMB/hcaU/prpAWt70jP4fEYpXmhd6dLukiyv3
	 YVnnuewoqU5Gy1Lg9jjCL/6FhvIKa4+ak3JNWFBWYtC6FvB//in1zYz6tKtLo3w6lh
	 Tlj39kKJ4al+2qTO1sd7wbWlA5Q50btoGPKuAYYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 147/268] ksmbd: use aead_request_free to match aead_request_alloc
Date: Tue,  8 Apr 2025 12:49:18 +0200
Message-ID: <20250408104832.496991960@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 6171063e9d046ffa46f51579b2ca4a43caef581a ]

Use aead_request_free() instead of kfree() to properly free memory
allocated by aead_request_alloc(). This ensures sensitive crypto data
is zeroed before being freed.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 58380a986af55..c3baf6537fadb 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -1213,7 +1213,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 free_sg:
 	kfree(sg);
 free_req:
-	kfree(req);
+	aead_request_free(req);
 free_ctx:
 	ksmbd_release_crypto_ctx(ctx);
 	return rc;
-- 
2.39.5




