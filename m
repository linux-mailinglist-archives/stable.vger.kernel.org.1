Return-Path: <stable+bounces-12332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A11835615
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E531C2095F
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2D36B08;
	Sun, 21 Jan 2024 14:31:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103314F7F
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847486; cv=none; b=VxLvDR/zwxBUVCP/Bch7xPbHKHkUZeNR3omkz/TPI5XBZNQf0g5assbvjpib7Q7xPfzqCyO1wnRdjJ838G8XQQxtjzf4insyk2kWTYtY0RMxgqn3w72WP7NlnTDvgqqE6KEW13hCdxM2pFQ2QydKA/ZPhf1u4FeRg5aK4CdSQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847486; c=relaxed/simple;
	bh=D3RYdV9vBfaNr5D+SoZYhj0jArmhpFT2/dgZNAs9uuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8E5QrzRE6ifE0t8qybhwVka2Xg+9DvssNmbnGC/+7QgFu2b7nPvxjSCM2J2bJ7NZxh8awlvM848675UAf2LymlOTvwN/r7i3N60hudrrEysRYWgGiqRf+8XnORuAfeiDSylP0jbx434Qhu1IONusq+yvTUAOBq+IVuEAk9bP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so956806a12.1
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847484; x=1706452284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO7M/8QjnaaDum7BAY8bT15vMmfaGjQ+wVP2Q1oxsTI=;
        b=qMWfAUuH7z51euYJ96JB2ibaG3OuX7pPPDppJ/KytEh29J2Sdufj3UI6XD4/O/yQw2
         WVG/27xU3F37k1JfP+wi/q56EEuXZMhRmQdalZbtD5al+D7ZEgjR0K3D+GbTL4NLuj4i
         1+ChdHdJJu1yQkXhsaUYzFyZsiw7Ws+4GZbIBAi3MJwf9cCXCQkDxzT7P3PYf3793EDe
         dtjJM8arBzVe3mlYRoz5m/1vDddjVWWgDBp1/YKPkC19rF2qMWUG/NVan8x4Ibgix/GZ
         Ipxp6yOK63H5g/UoFBuGa9ypvr82+V9Vakdydvhg7RcwI+bSHhK3+zqGEiWzEa06GfmB
         D2sA==
X-Gm-Message-State: AOJu0YxKEweFWaXG13TT+ytKkb/6dTpNaESy9O59t2Rc7FDZMbIFNtgM
	tvCrE38gxxKabmiVgj2BpPozYaOQROPonVvBGdzyYaXDq39dQgkM
X-Google-Smtp-Source: AGHT+IFJb1aVk3ImsJdj+9hp6n7QN2Z3TOqMxXf/76IeI3lc2/hT+BNa46bh+/tjDb8DjPjwrQJL4Q==
X-Received: by 2002:a17:902:ce8f:b0:1d7:35ba:6a39 with SMTP id f15-20020a170902ce8f00b001d735ba6a39mr614247plg.69.1705847484291;
        Sun, 21 Jan 2024 06:31:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 07/11] ksmbd: free ppace array on error in parse_dacl
Date: Sun, 21 Jan 2024 23:30:34 +0900
Message-Id: <20240121143038.10589-8-linkinjeon@kernel.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 8cf9bedfc3c47d24bb0de386f808f925dc52863e ]

The ppace array is not freed if one of the init_acl_state() calls inside
parse_dacl() fails. At the moment the function may fail only due to the
memory allocation errors so it's highly unlikely in this case but
nevertheless a fix is needed.

Move ppace allocation after the init_acl_state() calls with proper error
handling.

Found by Linux Verification Center (linuxtesting.org).

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smbacl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 9ace5027684d..3a6c0abdb035 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -399,10 +399,6 @@ static void parse_dacl(struct user_namespace *user_ns,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -412,6 +408,13 @@ static void parse_dacl(struct user_namespace *user_ns,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
-- 
2.25.1


