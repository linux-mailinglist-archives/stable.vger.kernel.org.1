Return-Path: <stable+bounces-124748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFF8A6615E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DEF171362
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926331DDC16;
	Mon, 17 Mar 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UViKsZDH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F1114885D
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249743; cv=none; b=FKC4QPZuM46kZhU6YAgg7QZArIDqXQ+iZvXjyzL7V7a6hYeL4TwKmODnFgCK9VZMUd+zhTuHxFsHYzJl0N9uZFU2z+fZaK5Gv69vB4XhRiFU6qFlMIUT0nc+nDFH6/ezlySejLUQj3aS0UpHFjGsY/LZyKOmhpor28n1dl3R74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249743; c=relaxed/simple;
	bh=gwbyCSSmxXbFiPAljLG3eUXdfsDnikxE9KJ8jAPeIB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1oJ66eXtAoX/DEw3n+s4WIyZQNRVPWSaTma2YEz7nGa1Jdhm/YpM1sOl6nFGcv/cDnUODXNNfJyEy/j/D1a6nJFQtBLBtMzHK8loBayO8+LJH79RuJ/8Sg1by6hvv2vs8T3v5KzksTx3wauCxG2mqE4Ee7jsk/ISK0JJDKMa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UViKsZDH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso27995705e9.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742249738; x=1742854538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QijzirKIfC8GrNdkTeAGChafX8fvgvLI/dha6SltH6Q=;
        b=UViKsZDHqNIVUAK/tJ/YzUJYgWNQvm37qeWidAG16AgCNR+xg7P5WuoNd+L9anJ+w8
         p45EuJgQDBcHM7ZrS0E3lvgrLLIzqWlhVhvp+YgnOKbCqAOF3+3fbZLJjdVfllySNhXJ
         SfFKFu0uG+arqiPDb8jyjDkoeCE9JKXPEamzSH0Lypgde3IWSAZ5Df7EIvTBLmaZ9G6b
         4nQ2wYsPV3GWO1iiPoOyo/OUrk1VBG9NdRFrqow/UJpE1b4vU8swDkhxJ2VWCfzLmMMH
         wgSpKGTPWEcv1D8CjznSjRj6Pd5bgB2nKX3JkwIskEg61HWJJKWVQNK/KIDRIlFPbagl
         SUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249738; x=1742854538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QijzirKIfC8GrNdkTeAGChafX8fvgvLI/dha6SltH6Q=;
        b=EYlB+4eaZNLIpJA8cKkuIM4E9jrlXJg3vScZO4Dw5r8uLnFFlTDDQk4P6LWrZtI6hW
         ofnT3mhuJJLwU7atrvni16tzw4Ybf8kDl5IDQlQDDkj+Cxw9+lKOj7T5cTxGm8Qoc/cO
         eU7i3Kjqhcegd1EmFQeFQshSQjHDYDLN2jZmgchMtqaxdQgYM95FNUdo/2EjJUYZWQv4
         WqkrH3dvDxPge0U7o2gJrS9BxIsO1y5vNUHvXybLPl/h1iaLfikW2A+lQA5FxB2otoSO
         eEHzZuUPUiaIiFkwoNEkiObuvYSE6TOMniZ3HzOdckX0TUzGKFKJrRL+NOYkAafpiQ7r
         vrpQ==
X-Gm-Message-State: AOJu0Yyp4CvaFLyEMi1BYhg8Z32wfNeVStX/zMimEDGPRoJFn61rSeQf
	35LSwep3kjo6mJmnj/kFZ3MUTvjZ74Wzd5MFYdmelnzbS9MuXuaVy1w8sB3ewIkO6c+ibYvYJ1p
	axVc=
X-Gm-Gg: ASbGncsIZ3mwoJlXC8uRPBlFWZwUF5AEskP9fX2t5TUwB4doiUCpO/Uz0wZUM+97kTL
	kxsJjHP9rP/6ScjoWdeBJXqkeeTnan+fRNItB4qUn8vnZ4PI08jGPUfcYT4Re4vx7oQfLlgyC0l
	PsImIUJkPNh+cXowgrYVw7OvEVOU5VLOR6OsXX9mzz5A5YJJ2Cv5FY1BxuqyWQqErLJFM1z74Au
	IMhEMNT0H68dfWRlXUQXiyN5+NbNkUJMSCQktGxx2lxNiCbH4awxvmPf5d+HMFXjiMoTb4vmyIv
	nAgz3/VGaweJqhDUFray/M6c5y5qJ5Tti2AFhQzYhys8Dh9b8GjAtIquc9y9T50liPDR+A==
X-Google-Smtp-Source: AGHT+IEJT+nt74B+OH6qXE9xn01snf2Vv4ytHC82VgkCtciYQ+ggUn3fxU2X0TNbSCwaHQoyC1Z1YA==
X-Received: by 2002:a5d:6da1:0:b0:391:4889:5045 with SMTP id ffacd0b85a97d-3971ee44081mr13059511f8f.36.1742249737708;
        Mon, 17 Mar 2025 15:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e02esm8351664b3a.95.2025.03.17.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:15:37 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 19:14:09 -0300
Message-ID: <20250317221409.2644272-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025031652-undiluted-junction-7d5e@gregkh>
References: <2025031652-undiluted-junction-7d5e@gregkh>
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
 fs/smb/client/connect.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index fb51cdf55206..e7ca893f0612 100644
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
@@ -1887,11 +1886,19 @@ static int match_session(struct cifs_ses *ses,
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


