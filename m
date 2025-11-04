Return-Path: <stable+bounces-192403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA8CC31761
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF40188A1F9
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29532C33E;
	Tue,  4 Nov 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imm7HD1R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6932C942
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265547; cv=none; b=GdHpEZdHsEIx76vWD/mfcB7b7RrTeVWWo5U/nsdoYkREPPZQGmFDD9K6RUZ1qZIetLFH+ArpnBxKV4tazykReFEqWE25ZhGJcnVf2Ubeh1kXwytMfRUwp37Fxa2uhuhRjH6h293WGkYNW6SWwpMQ2OuZoM0VqMeRErtXoAmSjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265547; c=relaxed/simple;
	bh=0nrrlREagafRXQeDgB+zbKiCfD15/eLfwA/KcOk41RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv9ecTehjMqLYlx8SmFsjFgCTsKZB893JZVvS4+b9ZBod0lK6ecer3+jC4d9/JypxylAr+rGj5wrwP1bEOSuikpsJ5ngxkqk5QDHH6ioGjScpgFq6t3+1MJV3cI5/QwrK4PhQWMMY/UNAO3H2GI8W8dDMotw8mCyLRJ0Z418Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imm7HD1R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294e5852bf6so8578825ad.2
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265546; x=1762870346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=imm7HD1RNd6jMNZCzpRX7BzlrZbNqUjvsp1l3W8QzrPX4q3dh8vszmrDZW389KPT5g
         Ng7BCF7jeA8gul+hQRDjs5UBYwwXf1LcBAdhsNRDKLe69zeVswZ+xvufRnhCLavXbVWg
         P6EC6qepEglAMefMYKwaiJEcqcUC4HFxAXqBTYC/l3HIGICMWmY/siWuq0Cs/dZ90x6e
         FlywCoOaB4Md6nEMpEENe/dNGrGQ/Z0vpYfpktRsyEmbdcNgEZE2YePcEW4o3rdKYD7N
         lZMlbVruGTUXfdXdw8oks3+TYHsO+8ukWDTB1lO+HZhvqTf4UObTndUdfJNT/nM8fogM
         Apaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265546; x=1762870346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=GQx8V4fbAqJJWBF+Ym4/58GX8OGCnSB9qoAotH6SpV02vMI22jFgv157wUtBHRyvA4
         2dJ9tu7ew6Xmj69DvdtKHIzyoZv6yQ+vPYzK2KCSauUVfoUbCgsMoWvF44P913tULQr7
         rl9t/62ATGKoYT2nHNLDcM1b36G6/IWa4iQXBuBY8isxh46jPDgC8v6v6Afb2AjOqSiQ
         uTzGlUekdFXAJ2GL5fCxCNuJgNym+4vCimukvJm3UpBE7bQrxaJMPd2C6wGcKLq6lGmO
         UnKzNtafbwADxAY6OCqoK52E0kMVq+zj3kGAFn288ssAAfiqXvK2ZxLE395yyI5v36dr
         QrLw==
X-Forwarded-Encrypted: i=1; AJvYcCW1IYYF+f9S2x4xbV8+EnMgKluHOk6vFGT4s9DcPRz4AIl1Sc803NkqAhtSD0jj94BaCjzBWrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8G224wo7TsLTrRRAp7TLWE4nw5tcu9UK9pPXCGvRqW9M2Rpq
	le1XSJtVeKVIOvVCSnBe0n+JDMJIYpvbG592HhLhX1WkhoM/DMPRzbjY
X-Gm-Gg: ASbGncvGMa1pNYmcBUwohDDJbXkg/k4MuimshMaPy4n7+Aj5QcIPz0TgqgscJJyynMC
	+ceooS/G+l08S1ggxqRX46W7YtcKfwNaCiDqnSIH1GsAmE8h1X9Z0K+wzsr3jldFB5pn30wl6IG
	fxlDaB+onbm6BQfEYKExRLvOeoKJ1E0rTTjKt8ev8GsjxmrjbksjfbCvd3ODzwBF5qc5UAQcUKb
	PJt//qQrykyqDmJqRurowWl66FQmvfMSTfibQVUyCHKhR1iU2Jtuz4NNZJ3qyC2b+IxB8uapgVQ
	zQRf6N2qxLco5mki6MN37Gwx7rDBhfy9NgS02z+r3gcO/SapdRbycgOzzg3vFawRykqHysQF8Lp
	9syWytGIJXR73DUmAR9I7a0+qrdq5T50OXXLtjgnigUxTdQUEN2naN0wYW7WHHrbvkTgO2CNCMB
	WfMbNJp5rPWowXoDtsyc1yDSY9a/4W1roCznXhvveudHXw6axkmGj60K8sHP2zpw==
X-Google-Smtp-Source: AGHT+IHAugMJ2nxjbD5sdy8UKfYjv2iz1PHt/Er2Dg2Libs5zWlSaypUfNKo7evt+LepO6KkcCxWDA==
X-Received: by 2002:a17:902:c651:b0:266:914a:2e7a with SMTP id d9443c01a7336-2951a491ecamr80222935ad.6.1762265545624;
        Tue, 04 Nov 2025 06:12:25 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60ef0sm28866755ad.83.2025.11.04.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:12:25 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 23:12:14 +0900
Message-Id: <20251104141214.345175-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110432-maimed-polio-c7b4@gregkh>
References: <2025110432-maimed-polio-c7b4@gregkh>
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


