Return-Path: <stable+bounces-12329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632C835612
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB922281DA3
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8D36136;
	Sun, 21 Jan 2024 14:31:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D834CDE
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847475; cv=none; b=sX69BcDgp4dN66a0mDtTQjwVZE3kJgcEmV+lypymgfUnQDBRuhmBGQM3OfzLbWBz59ABhbvh8/NTLF+CMvYDY8rSYYPfAKZmkahZj5C+cMRf18AgJexbhR/LQRYyPu4gps463lYnCLIsObDfjosL5+YFXSMYI8dKZ7AVMkTYLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847475; c=relaxed/simple;
	bh=hK/GKabVvh3j0gUmmY0/RVhu8IEKV1CADsB3G2R/YX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aqj25Ue9KabyZ13pw8XBYvFF4+czBjPhP10kLgQ/VC0Eu0GwkMB3i0gz/OS5OwtF/wPEjZMKHFGcgigF67yUT3/srfwAt3VEyG6GupxccxkpWPM8iJPoq5lJvOpYpTJEPXqKA9TanjyRPj1NSJCzEulJiBGnyHXnWJYaPLDn7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dbda9a4facso13444b3a.3
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847473; x=1706452273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYLSqsnl/mEOxJ0bOYyaErD+nxnTjhp3d/oCSoKEb30=;
        b=JvCgWxUUjjt6POBuc9+l1nX8V7auPtJfp0hOCKjS927GfaxULnPzQ0oS7u8/NEXU+x
         koOhI8NBhn54E/TgBuMvXwKgkdGIEvKyWKvD/WlKUBHbH5YPOnYUraQgKuZ3AlqbFoZ9
         NmOE6mCPkH3tsCSCwwKU26VsmOt6UL6Z90idakjDJNRKLewHpwfePM+xvcWZbwLVN0PX
         h1aA7PXS64VOMgd/OzNLFG9nJnzBSPS+TBniBy2G406JppC3UYEUTh71B56AhUTuCYdY
         zA/yFDkaheWpX315r9Ti4nHmzRrqme7YGm8tOorUEZ8ywK4qw/sDWpMLeRw/bliESEbS
         6Gig==
X-Gm-Message-State: AOJu0Yy3SwgiXqIXBwAe7JerxHYoX114zV7e3wlgGLkdVafJ8izj1r4u
	wVQCWODXPTm9ck7sx+LCe897d5zjMiMZMQmdn8cJ+eg6BJQpCWkv
X-Google-Smtp-Source: AGHT+IEywt4yg0p+Nabto6tkuteD+w3V+Ob29dLXJnEz71YnHgud/onP/2sxr+rRzURlGjGzovxSjw==
X-Received: by 2002:a17:903:64d:b0:1d7:5dd:2561 with SMTP id kh13-20020a170903064d00b001d705dd2561mr769736plb.134.1705847473507;
        Sun, 21 Jan 2024 06:31:13 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 04/11] ksmbd: don't increment epoch if current state and request state are same
Date: Sun, 21 Jan 2024 23:30:31 +0900
Message-Id: <20240121143038.10589-5-linkinjeon@kernel.org>
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

[ Upstream commit b6e9a44e99603fe10e1d78901fdd97681a539612 ]

If existing lease state and request state are same, don't increment
epoch in create context.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index f8a2efa2dae7..d798c1d8f126 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -105,7 +105,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = le16_to_cpu(lctx->epoch);
+	lease->epoch = le16_to_cpu(lctx->epoch) + 1;
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -541,6 +541,9 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				continue;
 			}
 
+			if (lctx->req_state != lease->state)
+				lease->epoch++;
+
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
@@ -1035,7 +1038,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
-	lease2->epoch = lease1->epoch++;
+	lease2->epoch = lease1->epoch;
 	lease2->version = lease1->version;
 }
 
@@ -1448,7 +1451,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
-		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
+		buf->lcontext.Epoch = cpu_to_le16(lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
-- 
2.25.1


