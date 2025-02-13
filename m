Return-Path: <stable+bounces-115781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A2A34593
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D62B189BD1D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8DA1487FA;
	Thu, 13 Feb 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTuCyspA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5C26B0B1;
	Thu, 13 Feb 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459232; cv=none; b=r6wNB+KpYcDi79Cql8Cvd6s9csnYBnhJFbfO5saVByLxjWs+leeUMaFw6iN5a4wy26sNQVa/GzWvW/h71pC30WxBte6QavhjPbvoAv+qhcLMsjDVTvu48qHRwyHF6zwOIHbVpkCmpPephAR4AmccPqvB7h1Ze3amT3nyYvSPVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459232; c=relaxed/simple;
	bh=yTcKQOyesQ2zWt46gDXyQo0yzLa/QffaKby7R/5+8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9d5Ed0O9IMwCwa4cgeyxkAp29JDaRVpfcqBF0v9f5TvXWGhUWqyI2/bmldpaf6VmVInzrbBrv7PLpYYc3QRpSNjk+ojfgRp0yWAPx840/OimMnLl9LBSU3Ci7ULBdppD35Lx/hu2Lk5SEvDEyTwiEvzL1VPnMVUXiRQtt42zTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTuCyspA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA49DC4CED1;
	Thu, 13 Feb 2025 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459232;
	bh=yTcKQOyesQ2zWt46gDXyQo0yzLa/QffaKby7R/5+8zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xTuCyspAFqoh/g8CzBsZ2pqsAqoddvg8RMQQSpoWyV8Delke1C1BU2wxTLItB5De0
	 sHTyg9Z9tH5S/4XrM3U3DhxlBa4P1ySKoBHnpH6jZ/uqdWlhA9pSuzKdL7mmfLDUtG
	 tcfOla41AqKGm1cDXvLfw0vqb8Jx+g1nWi3WfCNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13 172/443] ksmbd: fix integer overflows on 32 bit systems
Date: Thu, 13 Feb 2025 15:25:37 +0100
Message-ID: <20250213142447.239516105@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit aab98e2dbd648510f8f51b83fbf4721206ccae45 upstream.

On 32bit systems the addition operations in ipc_msg_alloc() can
potentially overflow leading to memory corruption.
Add bounds checking using KSMBD_IPC_MAX_PAYLOAD to avoid overflow.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_ipc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -626,6 +626,9 @@ ksmbd_ipc_spnego_authen_request(const ch
 	struct ksmbd_spnego_authen_request *req;
 	struct ksmbd_spnego_authen_response *resp;
 
+	if (blob_len > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_spnego_authen_request) +
 			blob_len + 1);
 	if (!msg)
@@ -805,6 +808,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_writ
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;
@@ -853,6 +859,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioct
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;



