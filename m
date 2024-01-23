Return-Path: <stable+bounces-15507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8873838DA2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9622899E3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F25D753;
	Tue, 23 Jan 2024 11:40:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFB5D8FC
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010054; cv=none; b=AMssZ9io1KzlpcOqBPt6SJD8+dtniVRgPXG+U0PtKylAgsh+ANyuqk27BQEiSIKhiRZQEhht1NtHQpJePX+HpEK77U8uANZOWpYyp+lbB5zcib1UzHvrQo8mtV/vnxdHrB9N43W8Gc2gLi0rDD5rF0KD8p/JMv3myk2+cU8iKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010054; c=relaxed/simple;
	bh=KN7PDGJcgFQTXxLPW1IR/weDAYk5goYZBzjDxAhJULM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OT/XR+prCZi4YlviDq7cIO3rhqlvXkPvfIdATTvKax4hC9KbEY5sMgz3vSKV6WsC42auqB3SB4CuYV6O7CoaudLe2mM5S49TpplRb+DxhRVf1zQcQDn753mpfNS049DDKQWvFAueN8urCRBKe0JS0kqI+3iHzceZazB2o2U9OGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59998b4db25so703091eaf.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010052; x=1706614852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxf6+tHlAVbbaOPT/+raKtwYOjTzH2trQdAOpOzNZwc=;
        b=Iaae8LYIG8XWhCELFybc12oo1GF9Abi3qbXZN8GciSjNwBf8Avbo4mBYkuz89eyY7q
         +zZE7qxKgS/oHGmebd3ehWmmUDv37LXPj9fQA2d2bsWqFAxJb3Jb2G00PT5Q6Xm8x4SO
         /bEk/fvZTH6484lsniePEabI84wc+BFD+/+5laYlUFkbg6T5R2ohUv7Z20ywztm36uE1
         F6R3KikMOBDL+2daWiEaRHj/affquDrmtGTN5sTUVvNHM2xh1WjbtRzQl4LnkUxN0Ns7
         DAKTuV3d7Y/qQ2yFFUz8UnVkstBe6A3gF+XFd+DLGpY0lCzF1TX81gbBLzB4jE2B9pdN
         Po/Q==
X-Gm-Message-State: AOJu0YwTXT/BN4WtD7H1i6qcJ11b1CAn60K5BVn3/A5XvizldfH5i4v3
	rk00LpXZd9KLu2LS0hGpC/F6hQAPhsBUbhfRH1pRVFt+84yMeWmrSUkz/mWS
X-Google-Smtp-Source: AGHT+IF96JDvUSXA2LAyyxCUtCTLEHPCpZQctWWKuVSO9VBzpZwkDtF2PNMcZNUJcr/MTgPU6USXMg==
X-Received: by 2002:a05:6358:5915:b0:176:5437:fd13 with SMTP id g21-20020a056358591500b001765437fd13mr1813924rwf.14.1706010052543;
        Tue, 23 Jan 2024 03:40:52 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:52 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 3/5] ksmbd: don't increment epoch if current state and request state are same
Date: Tue, 23 Jan 2024 20:40:29 +0900
Message-Id: <20240123114031.199004-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114031.199004-1-linkinjeon@kernel.org>
References: <20240123114031.199004-1-linkinjeon@kernel.org>
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
 fs/smb/server/oplock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index c58ff61cf7fd..3209ace41ab4 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
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
 
@@ -1454,7 +1457,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
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


