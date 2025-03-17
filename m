Return-Path: <stable+bounces-124733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C46A65C3A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211E67A4CB5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58A1A840A;
	Mon, 17 Mar 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aywwZIbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15B14C5AA
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235475; cv=none; b=OhY5VQMi0pp3bLcnshkVDmsuwe/22cw/H79CdKsbUH9XWMjkAtprACZaxxE0rSmCWjwDLRA5eol+x+D/awZXLBogpvIAMJWwIpTTtVx/FRT+SatvBob55HO08koGLj31CN0liwbBBYIwd4R2a+9GHUQ3PV2vvd4uCG6SRd8e/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235475; c=relaxed/simple;
	bh=Od4Ygc8gvgOgVyiZmiUSYJCWxXNdiXruHcxMWGREO/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPiHkld5Ds1834COhrliNQLnvbBS7gRQyOYoBhJMgByENb8U0+dZN9lESvzY/MXd7YOcji1Wi4ErlUsO/5pI5+JkX5b2QqtBzyMnBnJm97xujsvORbozrsv/lWvs7ahN3SIlPRKLoHta8I3dDIVskNxbaqvyvwgMvJL9xCZuLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aywwZIbH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2364808f8f.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742235471; x=1742840271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEUZ6SgN7EUPHL01UAhQ5NF1qAY7R8r2dg2/lYHhiF0=;
        b=aywwZIbHhHRcfJSO8JDeeRg49OAbJhkcUueEkFYlySNFJU4T4DadGkZGYJhaAKi4vY
         K3+lZlQadID1inSCvA+d2igJemsx6jomLorghc7JhpkRcZF54z9GJv1PeWlVztxR5IFa
         RyMmLQZxuMXOV3kupcfcfYYbV6Y0oS+x8JW5Q/7CHCMIk8nVp4XX8JhdS+M9bLic68N4
         XeiHme78pi5cDKYyzPfaP1AQFn/l7P1qBoUpVrvuMsB1zAHKsHhatMAlKao8/uDfqzHi
         7WmR/Aw5gPH34p75kuIpUrI0s2n+D5HNqO6jwZVBJpDqF8EwCfSofVW6E1ldAin1r3BH
         mJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235471; x=1742840271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEUZ6SgN7EUPHL01UAhQ5NF1qAY7R8r2dg2/lYHhiF0=;
        b=Z+ENEAymeaVYJSE19ZiWTcxLnwHepT/yb1ZUemhMhQx4ijhIU2erZSf/LSTEwn2S6A
         Axu9paAXFmB9ovrON+qs0rJzAeT33Y42Ky6zJzX0DMLyXsLWgXwftEJJUwoKp/34/n/F
         Y/l10uLjZDt1kbVnPOjk7alFD1xAcS/zo8YMNvPrGHFbuM8HUIxVJ/Hkqy3+uxaAkuq2
         EvhnHJfOEVlkBtuz32RC4Wg8LqlfrMw+2ESFzFxSF5zgi8haB30kAiqyrQxuFWpng+y+
         QMMcM9pWvcSzwCQf44lSY8R3pJpjUj52w2QHnjVhFnQWcics6n9gqgdo2IeGcyDDl9Xi
         5qaQ==
X-Gm-Message-State: AOJu0YwFjV9+KTpD+A4RlbE0LpH779ODZUeniABAbt0p4ozk9S0SvDza
	NeyooXiPDVam1MUmc5e4jmqWrBLZiek7vXs91EtgWROHtaBhMCnDyWJ/bSQPycGk8IrQKIvFYmO
	KCEs=
X-Gm-Gg: ASbGnctbZORsXJPfuNoqoBjqB7ZNyFh2EuCcAZCD3PEoCWnFL+Hyc1FfH3gXNd3X26v
	HGUcPv/Xho5kcvvoJpEDkrcDsSHel5LvMvXbLJ9jEERm7Vfmxlv4qm0UhGDDnhGjgIpkwpcrLRb
	SarAQQQjEZENk2TRVG+7UKNmqs7BrYY7KAunw4Wt6v8r2XlKuMaOqHEwafdtLpi+fMUqe3MLpS1
	3V7/D7ETf04dmn6W4qns+jmuPtNEI4htTWUzxp68En+UnPFzhE7rOpFH1eGdwxTTPS2kz7rHgag
	NIo58KHALhUjtmFXtA+nYe9ifzEalQ/NuK+VlY0Q0vfiK5x2bFGozC+wdCh4LZpa3cu2yQ==
X-Google-Smtp-Source: AGHT+IFXFIN9er7PxjTssS/3m1M1TXYav7ZGncsAn3519EBATQMUbrDgEZSXvgMvsrHw+3tfCBCbbw==
X-Received: by 2002:a5d:5f94:0:b0:390:ff84:532b with SMTP id ffacd0b85a97d-3996bb44b21mr378534f8f.7.1742235471274;
        Mon, 17 Mar 2025 11:17:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711559289sm8162301b3a.68.2025.03.17.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:17:50 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 15:16:22 -0300
Message-ID: <20250317181622.2243629-1-henrique.carvalho@suse.com>
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


