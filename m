Return-Path: <stable+bounces-197834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A79C97057
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3545345487
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4883260587;
	Mon,  1 Dec 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkKInLvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EFA184E;
	Mon,  1 Dec 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588658; cv=none; b=g8g1G3OxyDg/7UDkXD1T3Ql9ycFE2aa5FsYEIhNZE5ROJo+NLkO+nmEus9GYPrCjMB/qD740/yFep6tOmakQgVlodGQSJ+NnnK5PozxcV9aNIM3VO9+zm0eDxCKREMgOagu6e4o2UxWk1xKuVV/fDyAZ7guJNeeLDu016srzr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588658; c=relaxed/simple;
	bh=zG4fSS+PbVVIot74iGkdSyYSlvb+fRLNZcKk8GWG9h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKxh9kBHVgGM1jSv40foK0bQOEqYpZDa8KrlU8ihfRKff8cZhzYX/f0HCJ+alQ7Z7R/v1ULM856tN/nMYcg4pyK2oeP5wiyDyjdh9IzmMgPAGqjEgYXsYO4t4m+3qHIHQWwTwWYuTcRXdQozTERqdt4bguSqekFjeGTOXQTXi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QkKInLvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03417C113D0;
	Mon,  1 Dec 2025 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588658;
	bh=zG4fSS+PbVVIot74iGkdSyYSlvb+fRLNZcKk8GWG9h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkKInLvJfb1ckgCXzPwFdhQYN6hXXfRIEn5xA6XoBkRXtgWirmd62GswkqzKZIt6f
	 IsUPNiOOVKGxmg5euoVfLGr6FtAwsvyRXwZB1Rrf1uKJMb2j2MSPW93IENazqXN55J
	 9Ym097pCh+XSyhCZXH261jYxt/MAxpG399cEc47s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Watt <jpewhacker@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 126/187] NFS4: Fix state renewals missing after boot
Date: Mon,  1 Dec 2025 12:23:54 +0100
Message-ID: <20251201112245.780430670@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Watt <jpewhacker@gmail.com>

[ Upstream commit 9bb3baa9d1604cd20f49ae7dac9306b4037a0e7a ]

Since the last renewal time was initialized to 0 and jiffies start
counting at -5 minutes, any clients connected in the first 5 minutes
after a reboot would have their renewal timer set to a very long
interval. If the connection was idle, this would result in the client
state timing out on the server and the next call to the server would
return NFS4ERR_BADSESSION.

Fix this by initializing the last renewal time to the current jiffies
instead of 0.

Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index eeab44727a766..dcef5785c1528 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -221,6 +221,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
+	clp->cl_last_renewal = jiffies;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
-- 
2.51.0




