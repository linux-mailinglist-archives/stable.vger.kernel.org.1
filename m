Return-Path: <stable+bounces-12326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839883560F
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC101C212D7
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8A374E3;
	Sun, 21 Jan 2024 14:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240F14F7F
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847464; cv=none; b=uzTABgGfpCs1uUHkAxfkoAVizDNeB5q79deMdBcBQq2wH6bS6d0St1ududKNvsvqZWgTaM3mhXA/lQpcLgKLxaBffD+a+rBxEuK+GcqPU5tT5ijqTMexbzXdJDKDfo479pTWe+fhOHF3q5k++TCpdk8/OEK/kGCJoaMg5ya6Cz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847464; c=relaxed/simple;
	bh=yU+M0q0NdpP1t5CFMqhsre8+qrJNB31Cxzw/296xyno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJnCtK1yPclwrPpYYdUg1kcj9l1cK3x2KJ9axZtweg5cKGZ4N1AX/JmQwEJe6VwVA8T7dgCrBG1FuV2Agl8q/okzUziyHHfXU1ZaumkAZszAi0ddHFr3u0LlWUBxvHfzbuZBXy/208eoqMjFWEEGunef/atVp1B95+yIXtQ2Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso846438a12.3
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847463; x=1706452263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b09IwAek24Qwzms3Z7BsHvyt26cy6Qdnj3C9U7IJ8M=;
        b=o8EhGpsYfj4mcGx+L47Dr/NSEng5i9+Fx7onjECV0LejIysJb5v/Paj3J4agcDEjCV
         KXnF0oBnB9fpIBRnzA058ErThBnERBoi2iYXt8CRQCLNoK9XCPjUlfK9t47mcGvh2sL/
         hzIM+S21jpOZYOo4tZ9pyWI1Ms4P85MF1LMXfqZs/w5PuZZVQMX1ayrbpZZgegO4Uv5S
         Xz4R3E5vWUJW12Blwg2we+QBkgTUtjpFYbPqdDAC3Kyl66iAJxBQBbw9h4vrTQ34ts2k
         ITNaJ3RDaBjxy78NB8bsNFcvn4PiHKoJVzv/4JNNTxf+nnw1DeDW4SvsEzuxp8U31WyS
         ZYUA==
X-Gm-Message-State: AOJu0YwhZoO57D+fFF7kciOSH/4HbCkLQJnIX6QrmStYk/xA6mucalxc
	xFRi2L8ef7riT+k+DJZ3DZ36r3pdDGwYYqRgrLYVwHv7q3Uh67Wr
X-Google-Smtp-Source: AGHT+IFJ7gPahfcaiFhUircFCmpPs/61gxAwhmwo5oc3KavndtPSpxnd/LYRKCqECt9pmXlmlLglMA==
X-Received: by 2002:a17:902:74c1:b0:1d3:aab1:6273 with SMTP id f1-20020a17090274c100b001d3aab16273mr1249102plt.118.1705847462742;
        Sun, 21 Jan 2024 06:31:02 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:02 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Li Nan <linan122@huawei.com>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 01/11] ksmbd: validate the zero field of packet header
Date: Sun, 21 Jan 2024 23:30:28 +0900
Message-Id: <20240121143038.10589-2-linkinjeon@kernel.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 516b3eb8c8065f7465f87608d37a7ed08298c7a5 ]

The SMB2 Protocol requires that "The first byte of the Direct TCP
transport packet header MUST be zero (0x00)"[1]. Commit 1c1bcf2d3ea0
("ksmbd: validate smb request protocol id") removed the validation of
this 1-byte zero. Add the validation back now.

[1]: [MS-SMB2] - v20230227, page 30.
https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMB2/%5bMS-SMB2%5d-230227.pdf

Fixes: 1c1bcf2d3ea0 ("ksmbd: validate smb request protocol id")
Signed-off-by: Li Nan <linan122@huawei.com>
Acked-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index d160363c09eb..e90a1e8c1951 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -158,8 +158,12 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+	__le32 *proto;
 
+	if (conn->request_buf[0] != 0)
+		return false;
+
+	proto = (__le32 *)smb2_get_msg(conn->request_buf);
 	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
 		pr_err_ratelimited("smb2 compression not support yet");
 		return false;
-- 
2.25.1


