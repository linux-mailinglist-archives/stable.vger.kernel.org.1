Return-Path: <stable+bounces-12334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF6835617
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774441C21236
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34E36B08;
	Sun, 21 Jan 2024 14:31:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EB33CE6
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847494; cv=none; b=Yrkq45sbnhEZRWE46Qd67CaQHsvEo0aUehcnN2nw4JThoEJcVLPmkkTO9J6REXov/zNyPBR1eIdhHj3BatMrVRLG6Jdto+QQyN2vJgZ3Ft0T3CSOhtsT2CIRDGHMyHtNJdkGoAOwv7p6vlDl4hEIrmDPp8IvdQyut9sv7ikuUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847494; c=relaxed/simple;
	bh=5nwLvsb87L5ViJinNOgon4Egv9oUf9ywwq/K7kHpaIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmyEq2jw4R44AtRwhoAcKwEoJQSCGMnulgFf8c109WOKWBzDdlBeGky5dADYogdVUEuJtVf8D2JireAoAOQV4nuYHyGKWfXgcWNh5i5D9K+H5NYBAxSTlg4+V1lwguE6uturb6JzAG+5tTsapOhn58qVBkETMS6fw5PDS881Gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d755a120daso372425ad.1
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847492; x=1706452292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q4osaEvIGyZ1J2M0s1Mps80itYZRfW3C3pahU/NhiU=;
        b=FpXQ/UjtJQjSD9C6Zaw8nA/gzvFwOQeWh44D86s5u7JZGSHSl4BInPJFD3kLQlY4o4
         6ji4npiYMiI0ZRt0DDsLd08cdfzWM0Gknvm+awA6iZ/WBnL6POk6uAWOX3FtBVeGlCOz
         oEA+Lt6TqtfnZyeV0iW7/3UZewmZol/ElKO2tOJ0O46ZNwyEmMzbkTb46FxJr16KHcIJ
         Q2xQnOYCo7n0uD31/G9yc1RiqhURmfakcArt234HYf6Vt2hIhoMvP1Tjau4T2VMgTCIb
         msziwJX6Zp+fIZ+ZcEExtvZ8ehKDS/rs+RAJOl9N6mHWiAj4w2q+ACSHbIaVD+DJsn6V
         UjRg==
X-Gm-Message-State: AOJu0YwL+JIFmoWTni7lHoqwJm/YUCbTd/CBHiANSSqnUNwSj74ExXHM
	2TfbFzh8MKt04BY2LKRjn9GLhXn/XoU04IBcsRZRv15Pi8vtNMU4
X-Google-Smtp-Source: AGHT+IG8DcnaDMMv99OJJt2xtWIWZpdjDQpdHSsh5ydKkrY9YWuthUzhqN6Rc8EhlH/4h7pzdWf95A==
X-Received: by 2002:a17:903:32ce:b0:1d7:199:cfa8 with SMTP id i14-20020a17090332ce00b001d70199cfa8mr3829298plr.10.1705847492682;
        Sun, 21 Jan 2024 06:31:32 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:32 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 09/11] ksmbd: validate mech token in session setup
Date: Sun, 21 Jan 2024 23:30:36 +0900
Message-Id: <20240121143038.10589-10-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 92e470163d96df8db6c4fa0f484e4a229edb903d ]

If client send invalid mech token in session setup request, ksmbd
validate and make the error if it is invalid.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22890
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/asn1.c       |  5 +++++
 fs/ksmbd/connection.h |  1 +
 fs/ksmbd/smb2pdu.c    | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index 4a4b2b03ff33..b931a99ab9c8 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -214,10 +214,15 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 {
 	struct ksmbd_conn *conn = context;
 
+	if (!vlen)
+		return -EINVAL;
+
 	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
+	conn->mechTokenLen = (unsigned int)vlen;
+
 	return 0;
 }
 
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 3c005246a32e..342f935f5770 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -88,6 +88,7 @@ struct ksmbd_conn {
 	__u16				dialect;
 
 	char				*mechToken;
+	unsigned int			mechTokenLen;
 
 	struct ksmbd_conn_ops	*conn_ops;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 795d3554abe2..7e8f1c89124f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1414,7 +1414,10 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	char *name;
 	unsigned int name_off, name_len, secbuf_len;
 
-	secbuf_len = le16_to_cpu(req->SecurityBufferLength);
+	if (conn->use_spnego && conn->mechToken)
+		secbuf_len = conn->mechTokenLen;
+	else
+		secbuf_len = le16_to_cpu(req->SecurityBufferLength);
 	if (secbuf_len < sizeof(struct authenticate_message)) {
 		ksmbd_debug(SMB, "blob len %d too small\n", secbuf_len);
 		return NULL;
@@ -1505,7 +1508,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		struct authenticate_message *authblob;
 
 		authblob = user_authblob(conn, req);
-		sz = le16_to_cpu(req->SecurityBufferLength);
+		if (conn->use_spnego && conn->mechToken)
+			sz = conn->mechTokenLen;
+		else
+			sz = le16_to_cpu(req->SecurityBufferLength);
 		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, conn, sess);
 		if (rc) {
 			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
@@ -1778,8 +1784,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
-	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
-	    negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
+	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer)) {
 		rc = -EINVAL;
 		goto out_err;
 	}
@@ -1788,8 +1793,15 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			negblob_off);
 
 	if (decode_negotiation_token(conn, negblob, negblob_len) == 0) {
-		if (conn->mechToken)
+		if (conn->mechToken) {
 			negblob = (struct negotiate_message *)conn->mechToken;
+			negblob_len = conn->mechTokenLen;
+		}
+	}
+
+	if (negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
+		rc = -EINVAL;
+		goto out_err;
 	}
 
 	if (server_conf.auth_mechs & conn->auth_mechs) {
-- 
2.25.1


