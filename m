Return-Path: <stable+bounces-124750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233AA661B4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DEC3B608D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64411A23BB;
	Mon, 17 Mar 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dCYncuMg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34532169AE6
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250730; cv=none; b=Dt0MyHzBRCefeazVq21zNm74uXPyK4MREXFFlg0m/knh7S/cphlzuiJTDFwUhswH+oE7r3UwxZpM2OZqFt2UjLQwUhD3QGhtHcgC8SwtPsblqg7LOlOckT3AM9oxJELfjgCVJ2rV/DU0sahpzu0GE7eLnGy7H2WPwxpIh4NPMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250730; c=relaxed/simple;
	bh=UfP8W1jJI3lb7jiJ4jw3GgccPSI6q/6p+oIjvX4FAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZhPPXLIFyld9e9lbwQGuKNBcXB8RLnu74Gk8pT3hwQh+MtEylQdHf1k+C70dNiLlY+LIVmegB+1ipk3w/X2gdpb6EgjM9SC92yMd0HYa6lPcqqaoRUJ6A62DR69zP44Xelz8u1cugek3HfsYLrt70mdbzjPLQ7itY1EdRnpFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dCYncuMg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913b539aabso3125081f8f.2
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742250726; x=1742855526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlU7lBFWHioIaFZfwF9kQbElCNF/4TYCdlzZGA9gPIk=;
        b=dCYncuMg8I7+D1O0XQec6se5Bj3B3kagw3/VL9T+IjX2nnD7FCS04C9kh7WpHCv/iD
         /CSQc/N5xBhoCq+WQ9pamqMRx/KTQ8dVIfet58Su4El0XJIPzNQlbb9/7QpzTes4yIBm
         MdPObDdBoK4ScjgNelMxMm5lxix/NAaPSsuNxgAwsbkYiygaQ45BkC/4NwHGrd/4cVpe
         rteOqeHmKKk+eGE7453VVFN1rbpHVDoxAbLExCulAW1Mwz5M6s8/wHWtvNufgnbEiCA/
         YiNes2KEhod6BkAK94ud/7l/ZU12Wocc3HTHtb36LSYaUNG42XJJM7ozYAl1U9/pYeHV
         WDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250726; x=1742855526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlU7lBFWHioIaFZfwF9kQbElCNF/4TYCdlzZGA9gPIk=;
        b=xQi55lawglryVmATr6IYdhRTL92+bWS3+Ju6pRWGDkPg2+UoFOvblQ2nIJxaP187uZ
         sN+pI8EweSIOsFobJLCvUR3PxWybr/u8/Drixo22pEpPisYc2tEQqkw/yaXrVXN75iFw
         eLbLB5kEyWos9OM0El0zdsJxYzPxoLd3LHtLdU9vfXfPhHsbGCpaBZ/g7bV/4NfYOdDf
         Rhp7YYSPLu9Eu/nXrNdzaK8Six0nKWY0sFITaWPJu8l+aRl18IiQVYM/PX2WGONulPUs
         Lm9KZwyAd2ngdIQth8J6q7rzctOrbhY40VMDBzbjeEnj6CUDW6aPZGNCW4kdBeKtXkRU
         f56A==
X-Gm-Message-State: AOJu0YyOkG/e7I17RdhpP/el4KYs/exMfbQ6FbDmy1PabCFlTn0fmMLC
	MujhNK9PxK79YN8RLlo/ftw+uwkSm/YxqvzrbtJomn+gW9oZO6Vp1auRHrU6yge2gkF7zFTOSRC
	Fjxg=
X-Gm-Gg: ASbGnctyK/3/bJjk5uhEC7wDwa4W4qnVcnVK8DxFmzqN/99Pq7Tb5d0LSn/TtHoiLdW
	tjMiuBua6EC77WuJKAR4zyrK1Ce31sGr/HgVSIsbssntE+i2WObdSjywC7xYyP76T1uW8CaFnHt
	Avv53QclWGl/gZ29OOPS21F6Y5khH/3FRD/pL3VqM3qbiRhh7rTwKTorVh2veUhVbrGa2cGNQIE
	uj+6vZJuqdZUpaw6ftdgIfTOe7DqpXCAF24tION1HK51faIi19QDaZ3eTKNwIVE9FM0EPKROxfN
	+RIohMiO+5j29qvAlNbU0/4YsdZ4QhIw6FC+IwByNFMypPT4PHoQBeuGbBLd8cnwh34PgkenqJu
	LvKXw
X-Google-Smtp-Source: AGHT+IFM+i7uGPKevazUl5EDrBwoq1etjKYeMV9Q2Pit0zwnw7q8ToGknyRhC1qdJEj0g8Ml6xFakw==
X-Received: by 2002:a05:6000:144f:b0:391:31f2:b99e with SMTP id ffacd0b85a97d-3971ddd8fb5mr16711916f8f.2.1742250725783;
        Mon, 17 Mar 2025 15:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:1e6e:6171:3ed0:ca4f:bf31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9fed33sm7791649a12.37.2025.03.17.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:32:05 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 19:30:37 -0300
Message-ID: <20250317223037.2785749-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025031653-reboot-darwinism-60dd@gregkh>
References: <2025031653-reboot-darwinism-60dd@gregkh>
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
index db30c4b8a221..adb2e6b1cdc8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1881,9 +1881,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 /* this function must be called with ses_lock and chan_lock held */
 static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	/*
 	 * If an existing session is limited to less channels than
@@ -1892,11 +1891,19 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
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


