Return-Path: <stable+bounces-124644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D23BA655D1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE1E7A8D3D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0295223FC48;
	Mon, 17 Mar 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P1L1VPfE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A8155A4D
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225659; cv=none; b=oBiqWOx8FBEYtsx375QHrx89DTQmrPX3jN5ofnIXiAxEFhO0KZOcH7V0ZyiJ41rDU+k7e0CbD3W3r/mBHwejVGKiVN1tDZ/DKsYh2YuxhjVF4MUM0hzGex1PQ0aRUJN/V2ksLghRK5YAhJY7vHI/cH0vzjDIH73qf29y3BaiBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225659; c=relaxed/simple;
	bh=ga+Uc4xr7N+5SXjvL/IJVH4zFW+rAOCcyP8nqeAkJQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIKhF0gJOHKgo6nKmOs0PpATYVTVIimgsJGoQgMzzFp98qtwivEdVdCIXYdi0U8EdeNMk5vFFlA3XArcXuNjvMsA1PcbzcUEx52NYZmC5YSs7UvPzjUQnbrqiIcE9duYwZ8bX3kXuryWSbTmLIaYhUuW5pt9nN1YtvSqbwB2/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P1L1VPfE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so14139315e9.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742225655; x=1742830455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N92JKWd5IkpVl1E8LCKpFW47n/9OCf6dkNcfyC82CKs=;
        b=P1L1VPfEJzrNvRYtBmq9tMBQDI1R5/AOOomNQHcW5gUV4gBDhna3+Q6Lsdx+7dSthD
         MuexcDr+9NVvIYuaUAR7M0mbuDkth1WDIbVwUMnVPiH0A8JPsNErZRt/Stqe94be8sNM
         bGF8WagjmdIgEIvqCAIpGnUJ3X8/pJ4/ZB1rB1565SMbdDjZc37OyTCLGrestkpGceNJ
         F4sg4BwlSBd71vWzIZngpGNf1HwBCbZZ4Kdv22vQs3HLJYm3sdwbYemjbnBjdIQvCpKx
         5OGzneikLe1bHlc0Wyh3nYyN03Y1+0XkeLrWiCjqDKH028iZreDSIYaK/RiQKiv2tadO
         +zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225655; x=1742830455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N92JKWd5IkpVl1E8LCKpFW47n/9OCf6dkNcfyC82CKs=;
        b=GMad+BEXyh1rUy2DpytPMiZRyZoU/fGb5MWYmOXmxkwAtcpxJKvYpZYE1KNHKV9cib
         iFJXqe7rI05I+7gUc0NjVgJMM/YvcUErUgGrnfuC17kKIph0Sne8SaVgumuFCBz3yEyz
         hCT2SYe/5u1ExE/7lbJfiwd6YwNj3REdPHQx0WUvS7XbCT5XL8gILGb/FP6Sb7ghObB1
         qUSuSPCYrnikaSkL1GsRzEQz1QD23n4JrwndygUyMmrZxeJ4H4IPODjS7lM496+Mkz10
         qC5jfLIT4LqeNb6GzEJLe3t2BP1xPb+zLliKzACEiGeXAIftXcMQLIZCCJQE5YXtmvVV
         iYfw==
X-Gm-Message-State: AOJu0YzNqh8I7mQ7c3A4ytQDoSzysIt5VTmtexBvCCA01MPYRjZuNWbD
	dN3+sY3umJ1SVlJ2D/sMx/xNdB10Cgp4d37Qg3hYOaXLnezsoMrdAKFW3sYjM1r4gkR1fte0hk2
	Cj/E=
X-Gm-Gg: ASbGnctsPdDCzGxso6zEP4yLJlnC3ff2c8h8EpnCUSizUcmHCaq7369F4DzpPNejG0p
	ASY7iPt81Yxhr8Bo0EmekVixABS9Qj21FsE2SDLgph4VpqfIkL2Y8MwyZn8oDqZdlpi6eYbGGUZ
	IWQy1LnYCb0xbZ0uNST0q52g2mde1CKOQ5xatLMc9OYMCSkqoQpIlxiH676jMIOaL0qP+Uzz4xz
	C+zGYor2BZZRvGqy2D5NBt+0zVAMnPYrhTR9Y6picTqlZ2WULQwpXV+wp14Eb6v+CqAyDGcxZHG
	OA65QJM3GXn8Nx/CbRROV6gYVaH+G2oYh3SjFBEJm6tyD3KQ6Lx3XCxCNtVpeKamOaGJ3A==
X-Google-Smtp-Source: AGHT+IHp9YdMzXAcga06QMQQOh9fXBev75qwV0xIwr040GNBn1LYdKA51txdMk+YIBy7mEh6PTA6Jw==
X-Received: by 2002:a05:6000:4020:b0:390:f902:f973 with SMTP id ffacd0b85a97d-3971d13629bmr13245724f8f.8.1742225655545;
        Mon, 17 Mar 2025 08:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015374f1ccsm3186115a91.1.2025.03.17.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:34:15 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 12:32:24 -0300
Message-ID: <20250317153224.2195879-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025031652-spider-flying-c68b@gregkh>
References: <2025031652-spider-flying-c68b@gregkh>
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
 fs/smb/client/connect.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index eaa6be4456d0..a5d443c42996 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1873,9 +1873,8 @@ static int match_session(struct cifs_ses *ses,
 			 struct smb3_fs_context *ctx,
 			 bool match_super)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	if (!match_super && ctx->dfs_root_ses != ses->dfs_root_ses)
 		return 0;
@@ -1887,11 +1886,20 @@ static int match_session(struct cifs_ses *ses,
 	if (ses->chan_max < ctx->max_channels)
 		return 0;
 
-	switch (ses->sectype) {
+	ctx_sec = server->ops->select_sectype(server, ctx->sectype);
+	ses_sec = server->ops->select_sectype(server, ses->sectype);
+
+	if (ctx_sec != ses_sec)
+		return 0;
+
+	switch (ctx_sec) {
+	case IAKerb:
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


