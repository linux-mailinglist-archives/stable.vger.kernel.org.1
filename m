Return-Path: <stable+bounces-192401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA265C31718
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9284F131E
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448332D446;
	Tue,  4 Nov 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0zv/SB0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF0325725
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265511; cv=none; b=ajjBxTbl8Vj4cOqNvAe68tou0XDDOCt2ZZXeF8aDB+6c8Vt6BxVfkSYp/rDHpNvqRjq+scP/0umsdLSZgseiHF1Jpl4CS9B7/vGpxWA+8PV2qBG78Pxku5Cx9Lo+HyP10gXO/9tiMHfLtWQneCoJoR0A2f1TJm8RgyAH/coExH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265511; c=relaxed/simple;
	bh=0nrrlREagafRXQeDgB+zbKiCfD15/eLfwA/KcOk41RA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AwV/srE3EitroKjHwKD67XUQTln7BXYOm54WJKeh/Cu/Zrn+jZlvOFCjwykA/HaAwfyf6Y4E37wiK6qBVw23pHFKsQf/4SYQzm/LFWS/ied2Krtv7dIKkoWixumxYqVkwYoi7U9rXdK01lzFg54c+yIX8MKBHsVsdelXtTpNB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0zv/SB0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so192937a12.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 06:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265510; x=1762870310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=m0zv/SB0YsJgHxp4U28GVAJhFFkkHEM5OdTHmGgDW+zPubpPQFcQ7opwzfkFOxTSrf
         pAPOK7fdSvDScjfND/Ty1UHPCRJSt4unD/XL09pJqX0BRjRDpVy6ZynbAsghxu8kinK+
         OKrhInOTkE8XvBdfdEM1Yv1AqbotbRiLA+SCaTymmwHQDJQeqxOOCsppCn5Y0jnjdy6K
         hF7eM2k1bfO6L5nBjnSqY35cX4/xr4lEOSiV/zffg8iKh9f3H7BZLL1kjsnqMBKM1H/R
         CUj4xpXJK/dx5reSjeIdxIduDvnpwwvVl//OkVf0sfE6nhZnwYIbKz0/vmF5maFo6z8A
         7EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265510; x=1762870310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=LJc62CNTYufbGK3hAkiajg6CZ7MRX5iVMOVEe5O0WK/EOS41b8fZd1sNH2pKLv/B29
         QLK/IaXOYpYZseQtrt6WILDXufSpXbUu70JlXwMpbE5149W0Watzt0+8JIrgouXdgjpT
         4A1YVwJsTOy7mX20GSoAsc3Zs4NR8AnFasXkNxTH00iw6q3azh6JLg0xnO89idi1frzS
         VFmZw1hN+bZPapJVrXh8VABE0CsvAUi6TDr09oe0DRXkkbUox4Y2oxAq5e0pM57UgCr9
         u/V561iO4xYrNwevfLk1YsHonZYKrtUaFQvqHS9EGxHVACKkggoy8uKBkH5lS1xI64Lm
         dfcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3EzyGjn/FQwKFLLkd3U8b8JM8dgN4SwQ6mWdoYuAUnOhgU6hbzsYJeVKK218N16PuEP9HGZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQawFeUanj6rj+lKy8+1QPpMxTuzkewR17/wkvlMFdb8N8kr+
	XBIu7YbbVtW0GF2ksM28ksXa28IZnKgVGFkPNJWl7fKU5VxSEAKrKdBQ
X-Gm-Gg: ASbGncsDbf3EbsVu5lWOtaDzmK+R0KrlqBZuD2Y2E847noc9ydOu10TQ7g5ULo4aXiT
	HMEsKeqirTFtQ5nA+ySNbztvDgjfcmp7l31Bl23gc9zFKysAP2MQkx7kC43NblLWNNkk9OzbgQL
	/rNx7juqNQY0KCqc1YZafjCajrlzJ8uCWo6dfHwvOEI+rGCNAIlXoJrSaBli7SRNWK72EE7Hgei
	xfp1E2vT/t2Vstq/C0rlp7WaF0Ub1RE603C1RvqbZpzn7es8+eeeokOs6Ip/YXLliEyJDdXzDzq
	maJ1b2ckOTfgsMxqYD5w2ePcDmiUv1YcFy6HUbT0BNn6fT9ZUVC4OEqIp9EZYpD0Dm87kyJS5Ap
	q+0KEOqczLaZ0Btk6j4cc8sBRvgW6kRI/ELqRWnIk/QicPnpAq6pf7qw/hoRruQbFhPAybjNQH/
	GrpsJqrYN8wRSJNkzI4OYjSlihidkbfYegVDKcqPENm6Il0cWQsvzKQvRAC5pENA==
X-Google-Smtp-Source: AGHT+IEMx8Yp09ZrTc40LnNUiZ1qVgOEAwqsmLfj6KQWju08Lm+i1YxMqiAlBHljSeTI0aH+JLesRw==
X-Received: by 2002:a17:903:32c4:b0:295:70b1:edd6 with SMTP id d9443c01a7336-29570b1f3a9mr76178275ad.3.1762265509740;
        Tue, 04 Nov 2025 06:11:49 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a375b0sm28370615ad.61.2025.11.04.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:11:49 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: harm0niakwer@gmail.com
Cc: Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 23:11:37 +0900
Message-Id: <20251104141137.345157-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails at the send path, we only set
STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
in this tree). Repeating this path leaks kernel memory and can lead to
OOM (DoS) when encryption is required.

Reproduced on: Linux v6.18-rc2 (self-built test kernel)

Fix by freeing the transform buffer and forcing plaintext error reply.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/server.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 40420544c..15dd13e76 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -244,8 +244,14 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);
-		if (rc < 0)
+		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			work->encrypted = false;
+			if (work->tr_buf) {
+				kvfree(work->tr_buf);
+				work->tr_buf = NULL;
+			}
+		}
 	}
 	if (work->sess)
 		ksmbd_user_session_put(work->sess);
-- 
2.34.1


