Return-Path: <stable+bounces-159931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5EAAF7B6D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9321C5A25B3
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6762EFD9B;
	Thu,  3 Jul 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHskGQu1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5517FAC2;
	Thu,  3 Jul 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555814; cv=none; b=UZmFRsAz1MjuPtrtOIJ/IGfTZCBti1hsJ46bll+Usa02QE74LgoESsholmodAV6d43wuykdlNAUR67X8TRzw6i+yHsuscx/u04JOH4/YXVqEKgW+a3Ju+rAdgtvJPmWAyhzG694Pofce+/hLT/B1WlcGW2UBejiTHqjmvrgOAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555814; c=relaxed/simple;
	bh=OndXkaLkM1TEay9L/vfZkk+JCmW66Fyc0lJNyioSvdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsenMAc5Qlf61ZPTe1I2XcHod/NQTsSm6wb+Fxpngtdl/kuiXr5zXVZk7b+6In4H+5aKPuVuq58GsxymyzqwaJhDKB+/ZUzfz7NohQ5pe6LCCP0uXj1TEQXswkmheNNkIWfTQAm0lQBtyL5zzAKNv/kj+mNpsaQWjGLDNLLdeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHskGQu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E36FC4CEE3;
	Thu,  3 Jul 2025 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555814;
	bh=OndXkaLkM1TEay9L/vfZkk+JCmW66Fyc0lJNyioSvdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHskGQu1pDb5fRViGo8lqxaHYWbRxCtA6uKdco7+8YUH3C1z8Il5cJxZOc7ruCza/
	 24zLBcWMT4bTxyOB6h5GvYuFMHA3+h9675FfKQlEkttsHJJxUuCkPKhzlDhnjNX5+Q
	 kmPSjJ9bJ76ps6mc+4YE7M0O68AwOPeoHeNm+VW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 128/139] ksmbd: remove unsafe_memcpy use in session setup
Date: Thu,  3 Jul 2025 16:43:11 +0200
Message-ID: <20250703143946.192125088@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit d782d6e1d9078d6b82f8468dd6421050165e7d75 upstream.

Kees pointed out to just use directly ->Buffer instead of pointing
->Buffer using offset not to use unsafe_memcpy().

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1345,8 +1345,7 @@ static int ntlm_negotiate(struct ksmbd_w
 		return rc;
 
 	sz = le16_to_cpu(rsp->SecurityBufferOffset);
-	chgblob =
-		(struct challenge_message *)((char *)&rsp->hdr.ProtocolId + sz);
+	chgblob = (struct challenge_message *)rsp->Buffer;
 	memset(chgblob, 0, sizeof(struct challenge_message));
 
 	if (!work->conn->use_spnego) {
@@ -1379,9 +1378,7 @@ static int ntlm_negotiate(struct ksmbd_w
 		goto out;
 	}
 
-	sz = le16_to_cpu(rsp->SecurityBufferOffset);
-	unsafe_memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len,
-			/* alloc is larger than blob, see smb2_allocate_rsp_buf() */);
+	memcpy(rsp->Buffer, spnego_blob, spnego_blob_len);
 	rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 
 out:
@@ -1463,10 +1460,7 @@ static int ntlm_authenticate(struct ksmb
 		if (rc)
 			return -ENOMEM;
 
-		sz = le16_to_cpu(rsp->SecurityBufferOffset);
-		unsafe_memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob,
-				spnego_blob_len,
-				/* alloc is larger than blob, see smb2_allocate_rsp_buf() */);
+		memcpy(rsp->Buffer, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
 	}



