Return-Path: <stable+bounces-168109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C6B2336A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307E92A7D03
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C221ABD0;
	Tue, 12 Aug 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6UqJKwr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E13F9D2;
	Tue, 12 Aug 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023076; cv=none; b=KslrunPscD3QZDONYdggN92pk0dM/d0Dyfk5mF1i1fuqttAzfq47qI/E4diXEdHS+Fw6WAG/b9ivgJaisbozmvimdquVHyX/3XLPKd/SXRh6jyIm8hCWPOtPNmmlf73DkPYBQuyf80BprF3Qh9Aaoj0c4qU8a9339XvFoZUZHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023076; c=relaxed/simple;
	bh=efufjF+bi5sGrdDfe5DxoNspvPkQtw5xfEaJqu8UPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2PIpDpO76PRzKnyNobiYa21poPGbUNpCyxb71gZ3xzfyPAACptdB4P6gRHnp5sqPhtRwBbyUyOBb7Xj/6CWSxwiV5KNxfaFfiMX7Y+fs5ssG7V083r9UDAGTcVKXQ2/hzX1HV2e13BJvOhJAKe2b3eCaxH4Ku+BzZRm6yMgDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6UqJKwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B718C4CEF6;
	Tue, 12 Aug 2025 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023076;
	bh=efufjF+bi5sGrdDfe5DxoNspvPkQtw5xfEaJqu8UPc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6UqJKwrjVcu1RDy0VAgkRxSC90mhGQRT/XeiYjdqcJc5CkUVBk+dxMW2mfWJj9Lt
	 WuhM0Uk5Vp7t8UdU3RGEZj4xPgiDAUFjqXDKYf0YSK8qxeih9du/iAfLNSUv0d99uI
	 oq2Bc7j1BUWy0u6q69OWzI5QfJKDS1iYJjlX3beI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 6.12 342/369] ksmbd: fix Preauh_HashValue race condition
Date: Tue, 12 Aug 2025 19:30:39 +0200
Message-ID: <20250812173029.565801622@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 44a3059c4c8cc635a1fb2afd692d0730ca1ba4b6 upstream.

If client send multiple session setup requests to ksmbd,
Preauh_HashValue race condition could happen.
There is no need to free sess->Preauh_HashValue at session setup phase.
It can be freed together with session at connection termination phase.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-27661
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1845,8 +1845,6 @@ int smb2_sess_setup(struct ksmbd_work *w
 				ksmbd_conn_set_good(conn);
 				sess->state = SMB2_SESSION_VALID;
 			}
-			kfree(sess->Preauth_HashValue);
-			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
 			if (negblob->MessageType == NtLmNegotiate) {
 				rc = ntlm_negotiate(work, negblob, negblob_len, rsp);
@@ -1873,8 +1871,6 @@ int smb2_sess_setup(struct ksmbd_work *w
 						kfree(preauth_sess);
 					}
 				}
-				kfree(sess->Preauth_HashValue);
-				sess->Preauth_HashValue = NULL;
 			} else {
 				pr_info_ratelimited("Unknown NTLMSSP message type : 0x%x\n",
 						le32_to_cpu(negblob->MessageType));



