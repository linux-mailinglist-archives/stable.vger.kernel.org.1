Return-Path: <stable+bounces-183607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F2BC54F7
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0F4F9404
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD192877DB;
	Wed,  8 Oct 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZrbf5M1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87956286420;
	Wed,  8 Oct 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931555; cv=none; b=lZ2TKCvu4/9XgpMAztX9Q5hBEgyb3K3DEo3BQwCxRr84HZreueXicQgKB05VxDB5adkrq+jMfhKVE4Cb/ouaGMUUHHyjktr2pVrlF2xNoSihaVDlbeciE92cM264L2IQ/NJkWu1Ek/bGt7akp8j8PrMf7IBrbCQZNTnSP0niZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931555; c=relaxed/simple;
	bh=+GHi5WhDcOXlMuzmlmOVyStTbe9T6QIfMAIF7O2fc6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmf0ACZQ4KvtUidltg9+I9kUd4NZx47/O350LJ3PivVjXthzFRAbUze7MrIqiNuunSlQdCu/zjVU/0p6HiyeCGIQyG7+LgEYIJZ3ltypaLOR9Z6+wb/4PfFUE2jWTTJLBnjotOO4Z2lVaGucRyMNLzvjiIzpehs/NdAYDLze0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZrbf5M1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6301DC4CEF4;
	Wed,  8 Oct 2025 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931555;
	bh=+GHi5WhDcOXlMuzmlmOVyStTbe9T6QIfMAIF7O2fc6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZrbf5M1+IVFZ8wqFpQXRIDoAPhw35gN8cL4ZkRmWmZVd13go+ui3d8FHryW1cJ4w
	 v4KN5qC/UZu1ctqhYZkXIJ2DTwMXNcROVmEKvfhMCLgDo7JHSaHJ5vDfq5UND+WtG0
	 3w8gA6+cOqhlbGeQztxU61Q7vBIdeyEPxq/n1+pInBi22NYnzUB95kAxUZsdr97HFJ
	 BgR6Es8ehhB93ZJIJ0zQxcA6EKLkrl2A4C1JhYhCnLSF2vCK30MJDdKDJGWIYmvLTx
	 SFEC/V7YZV5rAfvTW7V/ez47/S0zwoklEKsI7ZarphgpPYLw4CvapmNXORAzeui+KX
	 PgLqrLC8gJsxA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	tianshuo han <hantianshuo233@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/6] nfsd: fix refcount leak in nfsd_set_fh_dentry()
Date: Wed,  8 Oct 2025 09:52:25 -0400
Message-ID: <20251008135230.2629-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008135230.2629-1-cel@kernel.org>
References: <20251008135230.2629-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

nfsd exports a "pseudo root filesystem" which is used by NFSv4 to find
the various exported filesystems using LOOKUP requests from a known root
filehandle.  NFSv3 uses the MOUNT protocol to find those exported
filesystems and so is not given access to the pseudo root filesystem.

If a v3 (or v2) client uses a filehandle from that filesystem,
nfsd_set_fh_dentry() will report an error, but still stores the export
in "struct svc_fh" even though it also drops the reference (exp_put()).
This means that when fh_put() is called an extra reference will be dropped
which can lead to use-after-free and possible denial of service.

Normal NFS usage will not provide a pseudo-root filehandle to a v3
client.  This bug can only be triggered by the client synthesising an
incorrect filehandle.

To fix this we move the assignments to the svc_fh later, after all
possible error cases have been detected.

Reported-and-tested-by: tianshuo han <hantianshuo233@gmail.com>
Fixes: ef7f6c4904d0 ("nfsd: move V4ROOT version check to nfsd_set_fh_dentry()")
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3eb724ec9566..ed85dd43da18 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -269,9 +269,6 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 				dentry);
 	}
 
-	fhp->fh_dentry = dentry;
-	fhp->fh_export = exp;
-
 	switch (fhp->fh_maxsize) {
 	case NFS4_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
@@ -293,6 +290,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			goto out;
 	}
 
+	fhp->fh_dentry = dentry;
+	fhp->fh_export = exp;
+
 	return 0;
 out:
 	exp_put(exp);
-- 
2.51.0


