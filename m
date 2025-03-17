Return-Path: <stable+bounces-124749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C4A6618C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454833A83CD
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD0205516;
	Mon, 17 Mar 2025 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QV5JkdHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E68204F6A
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250378; cv=none; b=MYzpfq52cd/ChnxS5kTcdP3+UwC9DrnZEbZIWPhdyn0vQ1CLrnxOfd/6WVSkNiAZp+X69LL9Ah6yhe5SVWxL4NP2AHs+syTOp22QH2nKmbLA3QrBmWOnJ8FcavU4O7YcSEUkmum7qIgVUKaLRSBAyxPSKrs029nx8VO/mSU2GTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250378; c=relaxed/simple;
	bh=/OgC1U2VnvBlJFfUcxDqHhBqioSZzEp0JuC38ZOEWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksd0/K8a51IWZ3ey/R33FfsvxMzp9Bos/HUgBSOpH7eENypXS+iX4mFebzjczF0oPCu357PMhf4SoVWtb4VEhWdUSd7itfI9JZ5A3ZMLekAYAC/HrPfqASo2v1FDI9DA19SuirM+wcI9hdqbZpw0H+C8sScquvitMmW8fVGnrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QV5JkdHw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913fdd0120so2607012f8f.0
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742250373; x=1742855173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X79TickNkRIrdMFG//UtYd+fzkNYnmIitIHnOlGbjQ=;
        b=QV5JkdHw6ljGJqIR4FrY9jt2SY14dPDikbldVWYUL8sfsMD581YVhGbb8SmRmjmyif
         4Uvelr9lkBCEovmrKfRawgAImGVYe1NSph/f81Z0cQ4iGUZjxKHtbD13JJd8wKUaRRGY
         5sCPxBd3EmNi8WbfIQq6VlKnX1P2TbL7ubOvEUu7TMOJKEjgrT/juo0e58H10wG/gYvX
         +RcMxshaY/aeMS1K8GD91CPw5BtZXJ7cKODvcsuEjWt1FXdFKlwLNL6DgTb+QdxoI4T9
         iJHLkuQS7lISqbejkSSCEUcdlngcz7MJnSz/NDHXLBzXLAZrabD7lh6D1IwzpuVXtG88
         H2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250373; x=1742855173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X79TickNkRIrdMFG//UtYd+fzkNYnmIitIHnOlGbjQ=;
        b=Qoy6pRlvn47OopVGJ/zbFLTDVTK9OPSBdRuRC3pm/l7ABx+ChTSwf2CWKoZsh664DE
         aIofhvZqxH1J4ZkIuTNE0ulOzpkDiN9SxLyXFTOjwVhIiZo8jW2qTdUk3QLC+oF9/Ci6
         lDM/frgzbtF1OPIb0SLRXNbRLC1jNBcKXzQfOyuK9CXBZRfhN81fu+J3Ko78EilAseDi
         M6itkVwPPxb5MXGw1TM0CWJoVmS5bQqZffmrSc7nM7eCY7oHcD/NBjrUk1j0/ijKu28f
         l5v6AM9/EcDzcRjz4tNDyHJxCKUVtoGh/V6dw2/QnETaCGO5tQjQ/R4+eLeqhlsCPaF5
         JhQw==
X-Gm-Message-State: AOJu0YyxLc63gduWEcy+KkEwnG7ynj7xvic/kbeuFEm+Q+5iJhqQrVaT
	4LxOmgBHtGsoXJiPaeCyo0D5Vpwx6bmM/dZf1UI3peRvwz1mqln+BUiT2oUnAvr/RejRdwMbyJI
	ucfk=
X-Gm-Gg: ASbGncv/03v4rDa3TMS1fZJ43NtkhH1vy/suwv3VqCdjYiUsYLfWT2XFSY2POr8M7h0
	I/is0Obi7drndqNO4bkoLSH4uz0r2FHBs/W1hiV1Ehs9+W8ykgpb7tDVH410nW4A0O1Uej8DIKY
	8RoqWlQRm59TgdUGV809sU0cdx2cU3/32xSVpDg6MQV10jFOHSdo4dUhKZXQhq0ao3M7Q5Ks2kF
	DM6kEqEp2b8XkDqBy/BasLkFDJLQW5tZ3KV8YQQ6r0UVNA+navmJuJbGraQ5UTlFnDZfEJi5dtb
	1+B4T9JixWSzhLBtseGt0KR5P7CB5Ng1TaGqVVMOx/h/OkdM5dBjP800a+kKqCL2rzpKlRZ5lLH
	wlvH2
X-Google-Smtp-Source: AGHT+IHiRQ2Vz/kuPZrBACeB3Pt1rDAccyfWJPEJk0QoJqIoaWNWSYzgTPLaewozCSZS6xCE7RAD+w==
X-Received: by 2002:adf:cb83:0:b0:391:2d8f:dd59 with SMTP id ffacd0b85a97d-3971dae8de5mr10718045f8f.24.1742250373294;
        Mon, 17 Mar 2025 15:26:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96d7bsm6426413a12.77.2025.03.17.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:26:12 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 19:21:08 -0300
Message-ID: <20250317222108.2656094-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025031654-gulp-armful-f55b@gregkh>
References: <2025031654-gulp-armful-f55b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug in match_session() that can causes the session to not be
reused in some cases.

Reproduction steps:

mount.cifs //server/share /mnt/a -o credentials=creds
mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
cat /proc/fs/cifs/DebugData | grep SessionId | wc -l

mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
mount.cifs //server/share /mnt/a -o credentials=creds
cat /proc/fs/cifs/DebugData | grep SessionId | wc -l

Cc: stable@vger.kernel.org
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
---
 fs/cifs/connect.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1cbfb74c5380..96788385e1e7 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1582,9 +1582,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 
 static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	/*
 	 * If an existing session is limited to less channels than
@@ -1597,11 +1596,19 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	switch (ses->sectype) {
+	ctx_sec = server->ops->select_sectype(server, ctx->sectype);
+	ses_sec = server->ops->select_sectype(server, ses->sectype);
+
+	if (ctx_sec != ses_sec)
+		return 0;
+
+	switch (ctx_sec) {
 	case Kerberos:
 		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
 			return 0;
 		break;
+	case NTLMv2:
+	case RawNTLMSSP:
 	default:
 		/* NULL username means anonymous session */
 		if (ses->user_name == NULL) {
-- 
2.47.0


