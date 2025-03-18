Return-Path: <stable+bounces-124851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674DA67BB2
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C6C18846E4
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE0211497;
	Tue, 18 Mar 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdnhTqTa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70667212D63
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321422; cv=none; b=JWh2U2qXu3FXXt0fqQtTIfk4m7Q7lueqmfaaQJhM9a0Z290uiZ9+//V0wQE0XX+72UigrIYTR1oJrBjkSHOibTFSU83UUn4dv2g/0QEbov9mp7nZMZ8jg/4upsGKMoDrA+L1muo5y+psJZhytbjSYq+Y1ZajhauozKc3ckk/Eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321422; c=relaxed/simple;
	bh=Od4Ygc8gvgOgVyiZmiUSYJCWxXNdiXruHcxMWGREO/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2w0noEK+jhpU31OZlhULfDWjxzGx+aWYoMVL01GI1gwWHZYhWH6SAzJdFI5vwjkdPRoC5lWQqHd1/l0HEQxRFelUA07VKVWXBpKQhwOB96JXzhR476Mjk1OIpl1TGy4JUxGy9pIWYFCZbKD35jY9ZWTv8TznUGd4nGXyFi/RoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TdnhTqTa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso26927555e9.2
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742321412; x=1742926212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEUZ6SgN7EUPHL01UAhQ5NF1qAY7R8r2dg2/lYHhiF0=;
        b=TdnhTqTaW9eT8KdwuNKcCfsGt1wGRKS7XQQd8gU1AEqxMlxLAzHgKLOf7mnNgqj8U5
         D1SpGW/pYAD5uDHwv2Gz2xmXTzHqceqWfRstNjbTXjgXUYiKP0GNQI64cF/E9jBvnVPd
         m4sQKoUaHE9Upc1qIvXaHRxJYgq8VOS/lRx0nk6Gl4w7Yv8g0+2+CzqnQ+ajKtiH3ntp
         01c7Vyby1xrxcfqVWzj/eAYh9iFOmiJs69NqgKnWp+J13QI7kbOqD3H/KK1HxDCfdT3A
         zQdypnj0YM6WMRpw0Lu1VL7l2NziLcC8dus10DhbtYvqY9Di58pxf/QZ9QH2XH5gK3xj
         tWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321412; x=1742926212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEUZ6SgN7EUPHL01UAhQ5NF1qAY7R8r2dg2/lYHhiF0=;
        b=jtdje79a2m35r6Kmc1bxE+bG5PPWINvOx8jIu19Q6BUvht2ftEScQzJskz92SGE5ao
         yXgjwCCIl/8oNTG5j0xzLCorXmehs9Ol+D+p8ike8wAr2NIQpMsAU5XYGlAJHBV3y1C/
         Q+e7m7CL8vCS5N+zhLxC7+iCJDNDtryj29XlMGdfo4PuG2s3dFKoZJM+mf63ZpxFzDGJ
         103kvfQ/fCdP4MjH8gp2g2Qe9iCUh0tPomVtE0C6nUkt7+WkPBqkFOAOoMOSwodBmzRI
         ktMnLF7OK9bM8lw338/C1gWuOK6F1y0xFFr03CvBy99PxGUaKQOtZEelaMLZGpehnG5A
         790Q==
X-Gm-Message-State: AOJu0YxxDVIdvID/uMSyYvrmD49sB0cEmySw/VUigfcPhTRBk2YQiBeu
	1KG+6+Yu21XNRBzJ7gP1gZ8yhx3orB3hhW6jlsaFCgHw1x+sbbEBLw88kw28xOlggeY0zOCkP1l
	hGNM=
X-Gm-Gg: ASbGncv5Gj82hIyn1b0SgmLxtnGv2OhfO6Dp2i4M0EfEe8F069jt9uFc7fMcXqqUolc
	jbr6mcJTuRanHZ9gmNZzbhfHg20LY1H2Z2IEWXZHVdyzRA4WAYrlIyKKE+M6Urh5B5Pb7PBBdLQ
	4AjvE8BoCxydJP465UH2iIUdG6OgUIh8YGPxsxnfABFNpwv3BA3RduFxcRTCYwXQNGNiSGqWJuq
	nkoTLGvwTUCjoFRCeRFcm2jfzKduWVDOawa0IQqD2qS4husO7d5o+dUgvgvDc5u2acJBzJNAjD+
	EeUIOlZ/hnBCvckMApnS1v0eg8rAi1bNV/D8Zf0ZmZbLsPl6y3D5MHlXj1+y/ZrER0fTZQ==
X-Google-Smtp-Source: AGHT+IFoVBCPC6WzzgT/GvRRAdAFLIp3B4CVORpbUYrLtA/OgC07XyJfweonSEsAaJ0aOoXYifSfQQ==
X-Received: by 2002:a05:6000:1562:b0:391:22a9:4408 with SMTP id ffacd0b85a97d-3971d616a73mr19237014f8f.16.1742321412433;
        Tue, 18 Mar 2025 11:10:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm10254594b3a.140.2025.03.18.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:10:11 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13.y v3] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 15:08:21 -0300
Message-ID: <20250318180821.2986424-1-henrique.carvalho@suse.com>
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
 fs/smb/client/connect.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index eaa6be4456d0..c9273a90d58e 100644
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


