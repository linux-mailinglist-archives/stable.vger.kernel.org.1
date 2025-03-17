Return-Path: <stable+bounces-124746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359EA6611A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7FD7A7BF7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417C1F6664;
	Mon, 17 Mar 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MlSlILfO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904842070
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248777; cv=none; b=cXxeJSwEwaKDBAv16tjCSqfCp46ecsawwIbeb40GNyb/YWgGwVT5y/qnYm+93b4d41DI3E2/BsUw4rS922zznS/Fo5/8s0iMeEP72C4dO2Fyx6ihzgfYAkwSOdyOpFbZV4Xyp3MMuiAe2d+CtZbyjxPad0x4TJRCcIQ3WyhdOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248777; c=relaxed/simple;
	bh=wuq8Z+HaloErbnnK69OYkF6E7EIkoxJ9QuOBvhusNwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOZPgwSNTFdM+80JHTWa+Varrp9VCx31Sovyd2OtrmEVNSo5oZc6IjInKfY6aYaiNa6V0rKN5ekGuqAIoyj/f1FSysuvLCUTeh2MbuW/IOq/Qz5VyPlBzCmrJIY1/R+cGEB1x22JZfFvrGPrsWoI/EWMycq0aFMtCR1v0tUWv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MlSlILfO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390fdaf2897so4606700f8f.0
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742248773; x=1742853573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+AJzOGID0GLKLTCvjQjuj9o/Xs5IIxbaM1hQes408M=;
        b=MlSlILfOvYgcgkW0GPQodeb0mDNX8AEbmntXzmrw/wHiqGzp37KmZSx8lt2QwbAJZB
         /ugI1foCD8RujGfSZ3Ga+1nl/m4e+4O4YDcN4yLr5QfoU2THKT4Zv2jYq9JF4TfHEmK+
         984oe5ACrwkCCvPl0eyMhrAn4PlyaBL9pTDghE5wuC6Cp4gJxw0+KiB84HlsOx83hxnJ
         6WFI63XaDdRquuF9jsVG7kusko00VCuITk5JuTMKlxkVJP3TtMDLBUQJRiaYVHQcHcWg
         MA1Emf/8oXoCF5SEB1eZXy0rE0ZDnp8Asx87GL0H3qZkk8iF58Am40c2iuxj+gk7ZZj9
         cFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742248773; x=1742853573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+AJzOGID0GLKLTCvjQjuj9o/Xs5IIxbaM1hQes408M=;
        b=RC1cuReAfwexFBswjONAkOe/I5ndEWDNblNz4SNweRdOrDWVrt38UVsnbTJ1gnHtCW
         bRqA4nIfk1X2RoCo+n16SNrW6k0THAGw9AxtgXSLf0RSBb5RlIP74vACLHTn6aofW9l2
         leb1iVfEfoSkzLwDTJeUj8CiTiyLdlkclu8xk6g8AR+F19TiXRon/rxSnxMtUGXpHZwp
         zvFkpzMiFVW3zTLc0f1nq6fYzY7rlkjS84JoScVp1gldJ+MfjxWKIo9VIQD9P5VL7X9H
         7QZf1sg5SnSkZvDlsYBqSKwQa/a02DYhSiV+uFYU7Lw2wLyqK8CEdgS93jTcQgEp82cb
         VS0w==
X-Gm-Message-State: AOJu0YzbWUo6ktGbtbtwOBGdGHMlkVGM20oktuxHs3E24BOWeUEaaKlo
	KnZ2l3PmOpk0f59vyKDdaFPqmiU66EIIYqvEfZ8M/N0eZZQi7nDxGaLaAaXnpDTXhShEjgCkL52
	ZMEk=
X-Gm-Gg: ASbGncuMSDBIUQvWoDtCNTNxzXmI7Sgo0iVcLjzUff33wotGFQSc6v+wAr4AI3bL/cX
	XLoFfK2BLlw+ROlf13/sm5d+d/a/CzZ1X3DQYoys+MSohaQ8m90wuZapH1WlEXVz9FQ6yp1UDBu
	/bwSi8gY3og7F/ia++j1WzIO7bC0MscZBvzVeaDsgbpakgDXBrpTXS+96bWZnByxTErfnb1YSkp
	AXLPzdDZPGXt4ki7uMtzliKSXye5oppUo4hE9NJ2+gUXxvZyy0/4n9ONn2TtmXDltogImmJoI9R
	2OJPNQU15jYqRQt4WFhDYOKtcHLRLWxcoBA684TN5WziyoQOwroRbQuvVBRv6sSQNaQAsw==
X-Google-Smtp-Source: AGHT+IE0+xmjN8YNsqjeSSeqUK3mJlurli1lsIVyG5Qlgq6uKpFCbZSRnMoF8x4rA1Eqgi4KbeFAkw==
X-Received: by 2002:a5d:6c64:0:b0:391:328d:65a2 with SMTP id ffacd0b85a97d-3972029e7abmr20316151f8f.38.1742248772884;
        Mon, 17 Mar 2025 14:59:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a74adsm80812695ad.69.2025.03.17.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:59:32 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 18:58:00 -0300
Message-ID: <20250317215800.2608506-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025031653-guide-earthen-3c35@gregkh>
References: <2025031653-guide-earthen-3c35@gregkh>
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
index dbcaaa274abd..13eec2eed315 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1884,9 +1884,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 /* this function must be called with ses_lock and chan_lock held */
 static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	if (ctx->dfs_root_ses != ses->dfs_root_ses)
 		return 0;
@@ -1898,11 +1897,19 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
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


