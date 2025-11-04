Return-Path: <stable+bounces-192399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D2C3172D
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85693A5616
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9132B9AD;
	Tue,  4 Nov 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBTZRDMd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B489328B5C
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265402; cv=none; b=OgGy/48RefKGvMgE3Nbm4QhHf2zxC0487SWBugk3iUikrGmrxiZDYEBV2fWmf/v5AICVdyoL9tSw+quC0ZpjkSkU/cN6oqv5DXrfb6nDrzzkhjwUrGRegXwuTEKQfYy9/24eBGTgSwe+mqVIL2+S8rbIIUmlRhcyv+Mk0ZZ1klQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265402; c=relaxed/simple;
	bh=0nrrlREagafRXQeDgB+zbKiCfD15/eLfwA/KcOk41RA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NSVa0i2TfcvwcUAf5xAcz9OceZmusYNfG3TtgcusVm37ZW49qMV70JHe3gzl9zatvmQ9LVaFgCVUJASSlyedOkzciATmB6kwUQzF2Pmk7qR2+0WMjzyT6ALNJbvxFhCl3nV3Pxl4QbDCPBNmigA+3wHOb7GWwTEzDSsaeMwhsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBTZRDMd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso805806a91.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265399; x=1762870199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=DBTZRDMd/Y1cLDhMVubeKWzu5QL9sv1Gv34/0gEsvYIc+YgUTP/qQEirdXxQBcZcOl
         jZlvulT0dE+HRwAuREY26tPhW/17qiAx7LRWLQ5cqDi3LIr/OuwJvqSpBsBFyKpII0OG
         eqgbzBhY1/101ZP8LBGZHf5I8bzGynVf5aAjVehjHLGfFiaKlMNBL5q5FLq1Nznp24DD
         1xLlUd4jo4/voqP3MabLML+LmOs79/XKHylhaz7TM1bZg8LCnRWsZElUgRblZ5cZgJ0Q
         Gx9cc1bYYyWs2Wm/WdHBNqDta8q6jJRMetXFQbwQnwr/XcL+OEe5u6729e7FpS6wQ5uv
         ztjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265399; x=1762870199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=t7H50NOq3W+sPsSvQdgInBoSUosvTkSoGqO3UOoXuJCM+nvpbDJQbd6N+FZu5ZFgV0
         s+YZca6CK/k1z18CW0RqRLD85kH2QfOJbgT58EGzFm95mRJhSZnC2Ti1x7oHF4uaVe7B
         zvoid2udFrvGRP1OZUPqb6YwXe7F+BFVtF6ca9V6ta7IrzJc8bQgkhuN9A1GE7PAfRo9
         xa+b2n8gl0pu7WRa6U2fiinnuUvpqb6Jc+J7bIou7zLIEmOC9qGVNgETHu9emsveZbhW
         4GbYkEy4HOxAsIdQ1iKvAoFVvP4vUo4FmjgrxkqpjufL+xEYQgvCKG5mMbF9NP+yWzPe
         D9yg==
X-Forwarded-Encrypted: i=1; AJvYcCWI9zKSzdFwk6Rilj6ZjP+QztA3Ql1nu376olRX5Yif9XeWoHlY4GSiL7IbBpYEzP/LYI3HRc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqgQUZABavfKeqvBomDtJHH0jGFttLlchoQkTjOUAOmVklxWq
	Ycxjwkd7Ne2r/kMu9aBFImauwfWEFsYaalKC+9n9yUWV00g15htWZX5m
X-Gm-Gg: ASbGncv1jOpREhVO3keJWoHEnwLIzWL9xCAtb4e4Jx4raNoYMwMeQP9h4RP1YnAd2ov
	uBylx66QMNvPBlkRimr7JNBQ0YnsA7omn6ehLNUTMIuG46M8C5I54B4ncO8zAZjO5Cn4SwEFy0E
	rJsdmAP4Wzpt99SMOTFl+yg8h7a30tgiEBmfXQ/RIEKVH4mGSaCLg8MQd19nPaQ9mgq5mK0CH12
	3gab2DgYmQIjo2FA2Htt3x8EhtDX8Vw08wR4DL8i6hbmx80BnBEb2NqQ9dsu4mKeMhn29dkq5wR
	Njha65X883bKABdn7DgSeCeD38TxILjq2EpLzKIuorybFqe+iyY6kpMdrs7pYqrU5mINI84RXhA
	VdOcR97IIgkvjFaRImwoh5t0xYEo0sTLyWbuJf3hcLKTMGayUefSafNg7pcalvZc1MVEpec6rGe
	PUEdYMy91z/yYin6XjAdCFM+Bo+BdDN6OdPV3SyZuFYcGzPC/yywnILDxuQTkYTg==
X-Google-Smtp-Source: AGHT+IGFhxmLkXlhhlWheM/7TdpX80dwQJuiUq5HlMxy2XqFboHcIAQldpj0JK42rgrkK9m5OdoCDw==
X-Received: by 2002:a17:90b:3b8f:b0:340:b8f2:24fa with SMTP id 98e67ed59e1d1-340b8f22da7mr9416806a91.2.1762265399208;
        Tue, 04 Nov 2025 06:09:59 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586cec1sm3084146b3a.38.2025.11.04.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:09:58 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: harm0niakwer@gmail.com
Cc: Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 23:09:46 +0900
Message-Id: <20251104140946.345094-1-pioooooooooip@gmail.com>
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


