Return-Path: <stable+bounces-131913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C176A820A7
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2ED4261D3
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C6253B68;
	Wed,  9 Apr 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="lgUUBH8u"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2BEEB3;
	Wed,  9 Apr 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189504; cv=none; b=ouzTkZobbLhpaFc+EcwS1W6qv7IDHOtAizxLywMzZvJqqMVZCsK3h8B+AeraNl4t9VzI0ruVMIfWaFsor73/O6xxz+DNC+/TEmH8bWxVc24OidqCjwmUW5dXz/kICSN7eO5PZU40csj5f2N4ahwAZZP139nswSSAUmZJWg38zQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189504; c=relaxed/simple;
	bh=LfGGWscpWjpk4r75z8rb8VP4CkBkJKW3KI5JnogjoTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsVwwHCKvXQ/TnD86mDzeRkSl9tVkZ1FdJLtn6xMph6NEIqCP36UMw+CWTa92wdZ5RumN7PgvLcyhX9MmFrlsuEW3ys8QqyJl5YzZsdCSGInZEPoYgL12o8sLu0mc3+kjHV7SqgAPAJzHG0hCAKgzK5HjJyRGi5FgDz7D+RZXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=lgUUBH8u; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1744189490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cw1uRMQ6Z/5Pev4RbNkDZSZZOleAQKkhNDYJmq+et6g=;
	b=lgUUBH8uQyshbvMPtnEnd1CSqfRRyQykjLy8dLLkHmYJPwDbrUUMNxPF0B+F7FHZ+L+pdT
	vK4i/tH4bclai6zbSsUQ8RDksUVRXzhQR1AZXDuhRH7CAU+ZgckkuxXjvys7s+wk5cbPYR
	vbWkFvsxOKl+j7jaj3D5ueg7frUE2+0=
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: Prevent integer overflow in calculation of deadtime
Date: Wed,  9 Apr 2025 12:04:49 +0300
Message-ID: <20250409090450.7952-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user can set any value for 'deadtime'. This affects the arithmetic
expression 'req->deadtime * SMB_ECHO_INTERVAL', which is subject to
overflow. The added check makes the server behavior more predictable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/smb/server/transport_ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 3f185ae60dc5..2a3e2b0ce557 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -310,7 +310,11 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	server_conf.signing = req->signing;
 	server_conf.tcp_port = req->tcp_port;
 	server_conf.ipc_timeout = req->ipc_timeout * HZ;
-	server_conf.deadtime = req->deadtime * SMB_ECHO_INTERVAL;
+	if (check_mul_overflow(req->deadtime, SMB_ECHO_INTERVAL,
+					&server_conf.deadtime)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	server_conf.share_fake_fscaps = req->share_fake_fscaps;
 	ksmbd_init_domain(req->sub_auth);
 
@@ -337,6 +341,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
+out:
 	if (ret) {
 		pr_err("Server configuration error: %s %s %s\n",
 		       req->netbios_name, req->server_string,
-- 
2.43.0


