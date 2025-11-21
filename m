Return-Path: <stable+bounces-195527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12546C792D0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47AB834FFDD
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ACA275B18;
	Fri, 21 Nov 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FK/LI64i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50726E717;
	Fri, 21 Nov 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730925; cv=none; b=XxyG/EgfmUyc5HKnXUbZ6PqYtiAs52r5UQ+HPBJRlMlYF/KxNglVjGEjc/bizgn/o961skFD2i/dEx09aypq6g6KYLy9xkUaQLdqFydWcNPD7p7etIDzE2cwo9NxFSHYe2+ZkQt9HynaUzTu+/GAgt8JdizvBcpgVBaey9dBovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730925; c=relaxed/simple;
	bh=okE+cX0AgDbW/Ayb7YVJMv9yqU5qL9Mj4GGmMCUkpo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3pUqSXgWql3z3nMLmKcxlNY76fGtDxkAvD/1QZSD8S05moybf5x1jM41saeGpVMEh4NRAPUoNXPbGDbvT6Ovmgi60VzV8pilYLvOuTjhb8i2VIVcPzzQGRusPE6k01p3Xrd5V+WEJlXsmM1HFKL0M8vL+xWP6nutC9KKMzktCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FK/LI64i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C61C4CEF1;
	Fri, 21 Nov 2025 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763730925;
	bh=okE+cX0AgDbW/Ayb7YVJMv9yqU5qL9Mj4GGmMCUkpo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FK/LI64igTII6eV/lkC1ai3FJNVGb1knikPWaLd1gnPptskoSsFFrbzokBXtVaYt9
	 +4sQVUm8+yAkT6bbTwK8cpFxbkNCzTPX/ACm5oG3rEP0OgLVY/iPxWlIrfQ5lTBvZY
	 pKXF0/BKD9uYHxFI++QdKym/7Yl7lmg0Q+6HhYyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Watt <jpewhacker@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 029/247] NFS4: Fix state renewals missing after boot
Date: Fri, 21 Nov 2025 14:09:36 +0100
Message-ID: <20251121130155.650591569@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
References: <20251121130154.587656062@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
index 6fddf43d729c8..5998d6bd8a4f4 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -222,6 +222,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
+	clp->cl_last_renewal = jiffies;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
-- 
2.51.0




