Return-Path: <stable+bounces-19448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F2850B95
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 21:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8453F1C2173F
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAE5D499;
	Sun, 11 Feb 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hDDrQh1b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444D5381E
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684868; cv=none; b=mMV4pq30cusUAoao85tu23kcpAQ4qJiDLQLKMmBkZcm/bzhfqV7FnrTPqWOSjFD/IbTLgZzYAG7WicS2oApZh5HTIUU+uFflbAQmOcIC72vOOMmzQLo8O7xXGM4yanu3T2zGnAKzQ17IExJj+4/X0vv8Tr0HLJPhBixzHDIiI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684868; c=relaxed/simple;
	bh=GrXZ9Nz2/5QSsD42qQI1yFbBNGJS3ki8p3gG+jZGSIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCCaH5r2v4/Ne+8bGm2ppGJWD/5NDHUAR8C6WP2nLIYJIjLL+7kEycJq5dqxGeKY5joqbfqF8eRnJJ3G69fM4KJXSXxwB43A3KVG4r7QVnGN4xJjiHQ+Er6pwv//SucN5qwEGrkbjr2w0Smr/HPeyxEi223WE/fbccn54thfEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hDDrQh1b; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2971562c3ceso951527a91.1
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 12:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707684866; x=1708289666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3MpZszRya3IsjMi/g6Mr3usta9ZLa8cQmnpdKmp6W8=;
        b=hDDrQh1bSZRIY0WzwCFfyAcDj17Kh8tEsYicbv3aoT/UfzOyUv2ifZ0SIgwV2LuqV2
         97/6PxRpfEshKwRGwEY6gX5ftKcusqkWBgxrSnyYkOukY4WtpCXJ6patX5ay6wRVh5MX
         RgQqGVTGJqXZV3AxlrTTcTcGtQzoD7nzrAOSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707684866; x=1708289666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3MpZszRya3IsjMi/g6Mr3usta9ZLa8cQmnpdKmp6W8=;
        b=qK/kZz76mhAyhS8tpx0x67vbfCgu9fgebmehu2iuGbNVm4cRLvnLHKxxgysI+rNFlv
         vmQUpxESXdIi6OqWPfwaWT9aDgGf2hA6hrGCI5Qzzm+T1UCwywVxVPz5zdopD7kwJ5AM
         WPtprgN/JTnfBkcJqyaJOQAumXygSOQxrAcvR75qTgPTGElMpqGFGPhbYkl45YSKJz7b
         LTb9NYK3bt8G7wn8a6ckGpUWdVMQXCLeqKBe80qU51DNKDSnKmW9ar3Wa/Hb8b+NXNFX
         CKP//DRFauvM/5HijRjMDcmJRKy4PNwepyMRLfRcxM2f0w7Z7VGWQ5QBazdKBF4YCzYD
         +VIA==
X-Gm-Message-State: AOJu0Yw3PbjxXumlUfEyIptKcheeTlm8J9wz0sKifRsDsXwoPM1Fki2l
	VG+9BjXZ7SgaQd/TSQXrZTr4G5jk7PGUnpJ0LVWqZPau4Yb/yYYDM4eBJ3OoHlPcsGkpnhp+5Vw
	wTH1dFy1UU3TR1lRecOqcB5DX1R2Pjs8ztx8NRGppKtsSzD4FawCF1xjbkoVP2NKXawuXEufx8g
	+DzfeDOf/g8F62/pfDeAdlU45gnsiAv46Ck974q7W4/D7oNkNhPXYXFE4=
X-Google-Smtp-Source: AGHT+IHVLjMtlAmti+BUJ2GJift1ahvVrFWYsMWIAVWFf0y/mDb+jvFb+0h7Rz3kbaq9eje/v1MH/w==
X-Received: by 2002:a17:90b:e18:b0:296:479c:7ddb with SMTP id ge24-20020a17090b0e1800b00296479c7ddbmr3010138pjb.42.1707684865517;
        Sun, 11 Feb 2024 12:54:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzq+RQb8B1VIvQaYT+NNmteifgnKQOf9YQRJDYlCGoXmIE+9gjpceWgqEOuSAP1xHs0B6rdbpJNAc/4bVm3uxSz/K5XEGz7QUDyQQzlhi9lrlR/P48u6lxk0FbgVA3VC5tI/CrA/THP1ijj7iA4wKh6TlCAzG/G+PsvYTyzOuq7tFGBIAXIUTVLiAu9V2tBEoGt0F/c4rvzVP0YwBouRYQFvSTezjAOygEOaBx+8n9lQ==
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id cv16-20020a17090afd1000b0028ce81d9f32sm5423735pjb.16.2024.02.11.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:54:25 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 3/3] smb: client: fix parsing of SMB3.1.1 POSIX create context
Date: Mon, 12 Feb 2024 02:23:13 +0530
Message-Id: <20240211205313.3097033-4-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
References: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 76025cc2285d9ede3d717fe4305d66f8be2d9346 ]

The data offset for the SMB3.1.1 POSIX create context will always be
8-byte aligned so having the check 'noff + nlen >= doff' in
smb2_parse_contexts() is wrong as it will lead to -EINVAL because noff
+ nlen == doff.

Fix the sanity check to correctly handle aligned create context data.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Guru:smb2_parse_contexts()  is present in file smb2ops.c,
smb2ops.c file location is changed, modified patch accordingly.]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 541f7d6aaf3d..a358c139ba74 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2095,7 +2095,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen >= doff)
+		if (noff + nlen > doff)
 			return -EINVAL;
 
 		name = (char *)cc + noff;
-- 
2.25.1


