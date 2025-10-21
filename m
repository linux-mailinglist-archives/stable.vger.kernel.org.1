Return-Path: <stable+bounces-188360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29953BF7306
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3FD188F527
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3A340A4F;
	Tue, 21 Oct 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3lOkytZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B7340292
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058506; cv=none; b=rXPZ6qvDdYWNsiG3A30cxv+1GDP7jYtC5krAHFdgylbpS/ETbRHsLQOiUprxfWS7HsDEDZCvMV63hegoG1wpYTnoo6fu7TU0ATberv6Vhbum8BIjnksosZlVytGGatGR2b6Y85CbswzWswmPk5nucL6Q9JOtA36y8Y4fUOqMgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058506; c=relaxed/simple;
	bh=DfZMU0R0dRnRuQiWcl7q8VsHGYmCXQ9jXTVQm1yN/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGtGUtEeuNbKN1sjnA9CfoIXwFtjYwx9UvzlLA2Br5sc2U6RAvjrIL8Tt3OfSZ15ZL8QRrrbVEcYExty6+bJmr4gHrr1Gyydrq/izkBr6ctbPG0TBOXcKFaH3XeeGLegm3WUQbcwIRinJkj5qIyUpJ5v1BFOjvKBFn5n/Er1bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3lOkytZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781257bd4e2so550031b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058504; x=1761663304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=U3lOkytZnhJ3xunlZBIjvy3C2PSJcTAcZ6oS+atQJgKbX2eTCVitmX6MdpKdCbGatW
         MYa0EHzhU397hRnxYGmo6mkR478J+ald6CE7/bTss8OnzqI/aV3CQ+sK+esjUzZMZrNy
         cqlKDtHAnohEVGD5h+p8aerW2mruuUEjg8t4GlRrH6Wa2Za53Rd5LiJIs5RW/o+GgKlW
         jXOL9JyEUBilSfUxRs/a8PVCOBkHm+uJ4fzJXXwntc3xLhz5NwmzxEC/8So0k4UVtrRM
         OX56UckZtTDrj+Ye8K4XVMtKQtpYpJd9Nk2t2N9f0s7I/qAV+m1iuMqKPdYtPS1HmEIq
         s2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058504; x=1761663304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=kOAEJBT0SzBUHsxJofQzZprxpqUsjtohY7X4IYLo90+pF5ouF7JwFVTW8BL8B0Uojd
         X9vwEdqfiub86ZHJWkXfcBmBUTAcSgEf/iF+SNORqyVnlAp2w9EzvjzROr9sQl5CUtfU
         A09qcCaZonpe0aTkLuBzPixfzrBtKSJT5VsCFRjWQ5YaJ9ZGK/gRtf/ZEjnQtwtoI8Qt
         ipjOw9HS73pMRqpamYtPa8CTdDEPDpHq9foaJ9qTArW37RQ9jNoobewZqW/AZah8QZ16
         Nzh8JPPihyFFe3iM5Rqt2Q0XtLSUZfkQVkrgPrzkjhcpQwn1dcjN1Y1GTd6NGEyI15b6
         63kA==
X-Forwarded-Encrypted: i=1; AJvYcCWMjn4C9rP05fEuIrjTj0coAl3x4YL6xzrS6KsQe0XQa8RB1QECETOIDGuNIFFHYfE0dIAQTMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUm9IUADer4sgYdObkPWHU4pkKeHE5bgF6r7UYz8+cu/BRp4Zz
	LWKJCs57Kv7JeR+iPTsEq4pjBXVi9NI8EYd7ydW2jTZzyx2Z7nQaNI8J
X-Gm-Gg: ASbGncunmRpadTDXmMjVwEsEJsS0Z4Igt+lNcVcRMVoduvlUBuzfhJBBc5MPKMVHNtR
	+M3+RU+4ho6SVawp38XFg0Wrp7M9y0QPdyur2H0MQb3hKIeKxqGijiYJeP6KkhLXOZ8e/Zo7CaO
	YqtqI549+RPZx/sL6jBWnJnKebhsoaMpq+0WW6vZZpQMCYt2R2ZD3haci+mc2hCyAhw4dOAp7Vz
	KdI3rBYnyiDNKpCiihAXx/Qg7CMTe9p+wMFwG8Q7ffP0N+10tYlvqfLfBODFjRpOp+jizRSrUDa
	iGkWhRomx60CKwcApmkdb7o7r3M8kMEI1+nBzm30o3ykSpuBXwdy5qKbqF63lqpIrU7wEAAZTLW
	H+MGq1ii3cbYFpTwRduA9V8PqpMSsfAvDSmVLdqeuqqZpF+Qgpo5XG4HRaPqQGB0oHSoneldrk8
	dLbdaILmRkLx82Abdafc+2dkMBEYMBI0XD5xX7ROlKiSkBg4lpjoQnpVWzHkr7pOlA1nM2778p
X-Google-Smtp-Source: AGHT+IFGdbtj0ivIPfYSgKjRnJx+JRIuBP/TzlLHzhX/tcb7pAq49jg9nE07bVQ8DwbDuxENZ1F91w==
X-Received: by 2002:a05:6a00:1408:b0:781:229b:cf82 with SMTP id d2e1a72fcca58-7a2572d4b3amr2639509b3a.3.1761058503854;
        Tue, 21 Oct 2025 07:55:03 -0700 (PDT)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1581dsm11484614b3a.12.2025.10.21.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:55:03 -0700 (PDT)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: transport_ipc: validate payload size before reading handle
Date: Tue, 21 Oct 2025 23:54:49 +0900
Message-Id: <20251021145449.473932-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102125-petted-gristle-43a0@gregkh>
References: <2025102125-petted-gristle-43a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_response() dereferences the payload as a 4-byte handle without
verifying that the declared payload size is at least 4 bytes. A malformed
or truncated message from ksmbd.mountd can lead to a 4-byte read past the
declared payload size. Validate the size before dereferencing.

This is a minimal fix to guard the initial handle read.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/transport_ipc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1ce1c..2028de4d3ddf 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,6 +263,10 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
 	unsigned int handle = *(unsigned int *)payload;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
-- 
2.34.1


