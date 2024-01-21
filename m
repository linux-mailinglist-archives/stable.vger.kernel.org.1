Return-Path: <stable+bounces-12336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E2835619
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EC71F21298
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E99374E3;
	Sun, 21 Jan 2024 14:31:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21D374E6
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847501; cv=none; b=P3umVPSxAhUDcNgeFRzS/a+omOFl4HNaNOj6S0jy3uTqujtKhkJfvu8wwI//7/uFAwbWgSu0Jfg4GEqVbgY/fSnZ/sNSO4cwIpLR5BFWaozstptQoT6Dg2WVjN3Gx9j93kbpMbgRuecrL1elSCL45b3uay7b9BBfcymTjAKYUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847501; c=relaxed/simple;
	bh=qAC3dx8ohmHi63R/TC8YjWox1zE/ivTj5+nBWmskpK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvg120R37/ydNTT04ETer9qr3G6O+ceh7nrCaX/J0KtlA3B8vjvzMW/WGFniRLV+qnkoSPC1DevcyrnSSUnRhblQ61x6WfGb9UxslaTRjkom0ZiM+wUkVA6vj8SyMqIEYu+ZGvAbidrZ3Un0WOXDEGS06z4SoUMBskLe8D4rk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d711d7a940so19948075ad.1
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847499; x=1706452299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWqKWl5V7KyJR+laVPBjebQvgsCWsQR26+x6I1cUMfk=;
        b=jlsbO/MIY2p+3XXrw2Ha/oilBVxcU4paOlSDz2KjmRNZmkSda24uD+iFdKxxHhNS0+
         co+tWK8+3VBeHJcvmXKcCNnBMDCFj5HhdGPW0K1v7ACmDAlxhlqE4vraP0cE5iT7Vfh3
         zVk6TVmiF2DEceu2cNsk0T4gyg+LQtugUbVBn25FvdOsXTAiEvocWkNCJ44oyGlM/Nse
         RJlY6f13bCyik3AfmQghQI5BxeFm+qfNnVKYE6e5ROEN91gBSu0TcyT0HBRbslW+qvcF
         nFWyy4wpxX+52ZM0sPTAhSTbc2eryg73h69W/4oq40CEfIdvvUgauhFpnWTdtWFzgkKU
         +z4g==
X-Gm-Message-State: AOJu0YwqqBS8SyMINR8Ee829kmDWdt0Q5PMID2yMfImTM02KYCnswS3Q
	sebr1kSurv7OY5zKUx5wp58bKQYceoYyOTHLgbnvd0jWb2o/uGiDUzV/tSbG
X-Google-Smtp-Source: AGHT+IEvd8v/81AReis1kwqOvXLv+wI0GREwwqBYdOkF9/6ymzjUkGX+vMBaILSN9+WhF5CID5H8Bw==
X-Received: by 2002:a17:903:2450:b0:1d4:ef61:2407 with SMTP id l16-20020a170903245000b001d4ef612407mr3259267pls.74.1705847499570;
        Sun, 21 Jan 2024 06:31:39 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:38 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 11/11] ksmbd: only v2 leases handle the directory
Date: Sun, 21 Jan 2024 23:30:38 +0900
Message-Id: <20240121143038.10589-12-linkinjeon@kernel.org>
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

[ Upstream commit 77bebd186442a7d703b796784db7495129cc3e70 ]

When smb2 leases is disable, ksmbd can send oplock break notification
and cause wait oplock break ack timeout. It may appear like hang when
accessing a directory. This patch make only v2 leases handle the
directory.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 5baabcb818f0..4e444d01a3c3 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1197,6 +1197,12 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
+	/* Only v2 leases handle the directory */
+	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
+		if (!lctx || lctx->version != 2)
+			return 0;
+	}
+
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;
-- 
2.25.1


