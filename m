Return-Path: <stable+bounces-37033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC489C2F8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DFE282470
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40D3139CEC;
	Mon,  8 Apr 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LlxlOAq3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5B139CF7;
	Mon,  8 Apr 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583059; cv=none; b=q+bPw2d3aXLcagEqcNNN1Mj6PzUHXPhQ64YCUmYos1QrGAs25T7f8CsSmmfgXkqnoO5RTyOwIphNpvrIEzC9DIJdpfy0NrJ1MLiboJZGa6Ync7h79T9tV33RyIHFoxHxHYFCV7MxqdhNSWrXJBe4Bn4kg/dppxUw66+owlBPz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583059; c=relaxed/simple;
	bh=CDij+jEw6vY7pZEN6qSExXwnGZq81g9COgYOjwq5WsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlH+ydiKTOJWVMWVR1Lg1JoIBivqtr6uhi577YMBlVXY0aIeId4wZES1TrehvWVwkdX3DmAyJZr8j8OYfCi4r1zTCeB/ulSjlAJq3wqfA9V2kgC315WYtYgQKuL6+IaowfWCNmrGFsfpDnoYy8Cu44uPQ0jCvwXWvEWdfjxrD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LlxlOAq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A95C433C7;
	Mon,  8 Apr 2024 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583059;
	bh=CDij+jEw6vY7pZEN6qSExXwnGZq81g9COgYOjwq5WsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlxlOAq3aKfkLpEjYb1+y9bekZYvQuRx9CczPodtpkkHuaMvgNcCdaWjbwT/9bFCP
	 yNsMGmOeJMlVTwYNkVV5d4z9p2DkBixZhBGSepeecWtnevYrRbdFWMTovpIvrAS1xy
	 nYt0pPJir4fLyBay9fk3rrSyPT/UqyYpluR97lDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.king@canonical.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 203/690] NFSD: Initialize pointer ni with NULL and not plain integer 0
Date: Mon,  8 Apr 2024 14:51:09 +0200
Message-ID: <20240408125406.887437177@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 8e70bf27fd20cc17e87150327a640e546bfbee64 ]

Pointer ni is being initialized with plain integer zero. Fix
this by initializing with NULL.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 2 +-
 fs/nfsd/nfs4state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f5ac637b6e83d..bc7ae9a8604ec 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1184,7 +1184,7 @@ extern void nfs_sb_deactive(struct super_block *sb);
 static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
 {
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 	DEFINE_WAIT(wait);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 26c4212bcfcde..e14b38d6751d8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5573,7 +5573,7 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
 static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 {
 	bool do_wakeup = false;
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 
 	spin_lock(&nn->nfsd_ssc_lock);
-- 
2.43.0




