Return-Path: <stable+bounces-197514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C64C8F77C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C343C3515A5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F126281;
	Thu, 27 Nov 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgPoocH7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E82D0C94
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260000; cv=none; b=ZFYlFTwe6/IrpZiOLY8jKYMFcjixZGLbgepLvLwl9/Ac4flkof8u4xmw5+Oh83Ix+q39F5MffnCQNCmShOT84qvXfEeBO8SeC2Lm4oq6tvqsPoFSKVv2AFIvX/2MJt9huUfd86iayf1ng/Y7AfAOw6Fhc4leE4aausXliMNBeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260000; c=relaxed/simple;
	bh=0Po3kuMxw9NSurS8GIK4ciWsHDkIjRfT1l+sH9pfasI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDqGANU+5FusRWzuwpjHKcAzrS8K1OQTST5Ekf11XVCWDEm/XWTu8BOInPZuGx/npa0N5oUQFbitJmObs/FRBx1BCKyfJbMKj2TUQTEH9IwjIfgYm2fCSv/AAEnoE2p+tp7Frl5wTIoTkgpWQUhojM1ACFofi1Es7Jbue429aHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgPoocH7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37ba5af5951so10231901fa.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259997; x=1764864797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/Z+H09K8YYLfwSDwuJjkjBRQpHLPc95WVX/pq1mF2o=;
        b=hgPoocH765OAsSRmFqaw+mZH831cFxH4EP/vpQD6V5BJli43Rk8nsvR3UzONz7+Gw6
         NsORo/eD8bAqrihaKV8PVcCwfTbAr/itE0IUjFoxFlzF6oeBWgd6CfAHOwsBm/ohuyhb
         e7ZopfRic0ghSTKr7BVr9m+JeawUrpR5YyUFk7tLg+YMlWFs4hqWA67ISrYXrBq/RaiH
         ehBS7osPHU3MJXs7Rzo4c+64MWDCM26JC5mYJK4Pf0m1Avzn2M4LCSVQwBulTHjZBw6h
         LjCD21ELh5+I8G98Tdv3nm9mIEMlZyVfZcMB2WPKtfXBON5kiUE8wk6zuQvNiEytWJgC
         pGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259997; x=1764864797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/Z+H09K8YYLfwSDwuJjkjBRQpHLPc95WVX/pq1mF2o=;
        b=tGc9cneWeBGVEs7yZyOvh7tB6lXDoLWSuPWRgXgxsrFnUDXpweyRQ8zlnwW+UuJBAl
         zQxZ5kdleFpymOohoQ6f0rB0+0ikoV+t7hWnwIpWSBb3RnY3/Np6b2Bsgibl1kBFaD4R
         JrNgAFuwlzwpjZJwr6if09LgS1fyCKDYdyUq0Mo9JV03z1zVOOs+q0I+Ia7i+WJWu7Q/
         IdqwLsQUrFiThAE6iAEzTlAbWGp2E+hetHZrDs6yS8gpLiro2DisqQxqPqgttrc17POG
         QNqPgUawcYo6dDQRV16AMscgQG7GhaPXMYLXz3JgUKzpGEI/e4vpc01oYBJIuE3zYTSi
         Kirg==
X-Gm-Message-State: AOJu0YyUKJnCKTJi8FrP5bqomJ+hmbJDbJ+6VdgmCnEBSyyPhe6ai38Q
	nyNdMznAmCIW7SsviYBEHdawPJY/ZP8ETAPNw2JQik9QlzbNwUraWOqcAjdjQ9pQx6frrQ==
X-Gm-Gg: ASbGncvw8AZX35ITF35/LwLvmklSkePMNIX3reNv94yBiYhrTxCo1XibecXayGjLWSu
	ZXDtLHgNa1+erVKzfZZrmCYpvAb50/2DeTO1vNVDYRFEyXYEdYm7z+CDD+UlATnlot3rQpeljPB
	L2/8q2r3ABbOzUrtSzCpdV9qr86OsAgvcc4goGzPwN8eSUvNmH5ruCSKYrfciQnpuxidG5XAQzt
	gvYqHofnjlMaWx+jCgJD1P7Ve2EbRfzK3haCW4pfkm7WRWQpNEgSzvC9vgAG0jmVS9BGHU6kYAK
	bJniN6i63XpEMGNOZmITYvQzO5BnXjmnut6AjMaseywTq9OyebA0RZciNi9otC5ZTE4kCxfo0mv
	TS1abXzAfWUw7h2ktNF5tY3f+eHLKolVmLOAtzB3uNleU6XxIqOBfOSHuZ1pQpFNcbAVRA5u/oi
	6FAJFQ0g6GTS4JKL+JcQ==
X-Google-Smtp-Source: AGHT+IHlqZKW3RGfD9KM7kg5E7xEkc/mxYEEWgQnVCRsAYnmr0KWZSxRe6UKez63lOWwqeEbjWWSwQ==
X-Received: by 2002:a05:651c:4399:10b0:37b:a395:fd8b with SMTP id 38308e7fff4ca-37cd91641f1mr65655311fa.1.1764259996764;
        Thu, 27 Nov 2025 08:13:16 -0800 (PST)
Received: from cherrypc.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236e6e5fsm4648561fa.18.2025.11.27.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:13:16 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Sean Heelan <seanheelan@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 6.1] ksmbd: fix use-after-free in session logoff
Date: Thu, 27 Nov 2025 19:13:33 +0300
Message-ID: <20251127161335.6272-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Heelan <seanheelan@gmail.com>

commit 2fc9feff45d92a92cd5f96487655d5be23fb7e2b upstream.

The sess->user object can currently be in use by another thread, for
example if another connection has sent a session setup request to
bind to the session being free'd. The handler for that connection could
be in the smb2_sess_setup function which makes use of sess->user.

Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
v2: Fix duplicate From: header
Backport fix for CVE-2025-37899
 fs/smb/server/smb2pdu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d2dca5d2f17c..f72ef3fe4968 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2252,10 +2252,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	if (sess->user) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 
 	rsp->StructureSize = cpu_to_le16(4);
-- 
2.39.2


