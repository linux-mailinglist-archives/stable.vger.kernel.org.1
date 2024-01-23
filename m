Return-Path: <stable+bounces-15501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F043838D96
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E9528983F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CA5D75A;
	Tue, 23 Jan 2024 11:39:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81C5D73B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009990; cv=none; b=nGiMxb8OHNWpbeZXuqpQgd/z+CC6zN4YWfnrNbf6ezpx3BugDOVuWd7XC1Y0EkYgEkGYvgdrHVv+4qwjsrfNtHSAZqHLPv3l9A/C4IWmXBICe/D6l63IBpJLu5wfC/W+QXtALDh1XaBUDcvxI1baorF3ukRnO4KndCwmzoLYgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009990; c=relaxed/simple;
	bh=32dkTu70X1+3+AeoRvL7kQq3dSDfduKml/2AnIt9SPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjI+4Ex+j3XCLfJq52LSHRNUuZwuUKOt6Po+GR8tOdVUp8QP5GtkCa4nW5ZdccQcb+FX15Rb4/fUp74x5G5/KIg/9UsUn+AyvYEWMhsZ+hoBKfhm3yTgrEF8xzZ813ZszShh1iu+I1DHC84/42axhib9OheLnT3hH2I0q65iBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598bcccca79so2311813eaf.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009988; x=1706614788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/Ivv6rZPGHIz0WpOk4UTJzrefA+g69Z5DPYhbPcD1g=;
        b=A7tkCH+YGr93URl+lWpP/UUc1yM3nw0XmX13FmKROpGgg0s7ulKeS05Ilp+bxv/jZW
         cONW9PySCuXSr/Zk6aQh5yHCS3KmvnAG3+CSLPnBcYRfvuvEGQAxLg2exs5+tI+keH+g
         rWGcbgBiIYA4uHNXRNw+hLkKHF9wdEMQ5ClvBCqfiXIGq2Cfz7eXYvkUbOTgXly5N4su
         o5SxTb+f3/dQxuB1g+oKUbq2ZKMciiDzI5UuCncBqP2IbJayrWJLiQx0ogbXFucg2qTf
         2tLujC79dXUJHRiW2f40mvm04+TU0AQwxGyCe6gyv5e8Qpq2CV8+j6Jzfp8wh5MdjvYa
         cNCw==
X-Gm-Message-State: AOJu0YzziXZ5aj51xZdQm9LRbKRVVf/zainWwzQxcnFa2k/XeBH5Q+qH
	NAKY7j2OHSDXjHZ+5ao8btAD2CD85Aq6iXPkhCZGDNu0qJrU6mtP65uhRD/b
X-Google-Smtp-Source: AGHT+IEN5LdfWFc0r8IdNj3dL/IK/ly+Gx6UIMj5Xv2lp9JEL9Z8eicnJqWC4debZ+6llDQwsnM3rw==
X-Received: by 2002:a05:6359:4c05:b0:175:733f:32a7 with SMTP id kj5-20020a0563594c0500b00175733f32a7mr3077414rwc.14.1706009987974;
        Tue, 23 Jan 2024 03:39:47 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:47 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 3/5] ksmbd: don't increment epoch if current state and request state are same
Date: Tue, 23 Jan 2024 20:38:52 +0900
Message-Id: <20240123113854.194887-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123113854.194887-1-linkinjeon@kernel.org>
References: <20240123113854.194887-1-linkinjeon@kernel.org>
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
index 8adae5871e44..e577d4f97f10 100644
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


