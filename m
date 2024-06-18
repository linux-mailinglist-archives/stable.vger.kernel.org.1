Return-Path: <stable+bounces-53413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECD90D184
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC10285C9E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006B1A0B09;
	Tue, 18 Jun 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XE086Lkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA92157A61;
	Tue, 18 Jun 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716252; cv=none; b=j9JOuAmmGt1GIYTXRE0mBYo7m4w1EMFEGjfNuaWHzzGMJJmwcsF6rkCpsNe6WsH3Y3RCggumlzIjZdmT+r/q0gdynEIVK/S9F0CThAajGFNKJGtKf2pcZ0Oq+7YvEcitm5YGqMyySaWbkg+iK8fraS578kLg0HYMma/cgE7o+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716252; c=relaxed/simple;
	bh=3OZvWrdwKkGPvpstoN7UaZ1KQ7Omxgk2GoIH5pZ3NvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw4aqgbQHqsOtaqz2J2Oy8Y/Wnq3psByZaZMIa8XoWKg/9O2kDtZJHtEA6c7Id4Sv6jAg8UOreFJkiEggB3+MVysTe+uz08+j6cLh9nh1TIWR8owkgP/JUgLGGLjJmBJ2T/EehNw1bUrMIu2ba991tfX3R1xCGIsAWGB89gls1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XE086Lkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F0C3277B;
	Tue, 18 Jun 2024 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716252;
	bh=3OZvWrdwKkGPvpstoN7UaZ1KQ7Omxgk2GoIH5pZ3NvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XE086LkhnnI4bvBpj7THjWVcRvgJCtUXLQS7HzabxpcxFyLQRE5309wBXuUmrPxv5
	 znCBvlLv2sd0erP97B4sCe2rogNqTUaz8L0+WYB9+OTUWELqE6Vc46zL4gqxZfXPcb
	 sayYyf1V/S6e9h70yL/5lRojY3Ztkxk/rCY7Ewis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Jiaming <jiaming@nfschina.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 552/770] NFSD: Fix space and spelling mistake
Date: Tue, 18 Jun 2024 14:36:45 +0200
Message-ID: <20240618123428.611888004@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Jiaming <jiaming@nfschina.com>

[ Upstream commit f532c9ff103897be0e2a787c0876683c3dc39ed3 ]

Add a blank space after ','.
Change 'succesful' to 'successful'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index adbac1e77e9e2..cb4a037266709 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -828,7 +828,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr,S_IFCHR, rdev, &resfh);
+				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
 		break;
 
 	case NF4SOCK:
@@ -2703,7 +2703,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->opdesc->op_flags & OP_MODIFIES_SOMETHING) {
 			/*
 			 * Don't execute this op if we couldn't encode a
-			 * succesful reply:
+			 * successful reply:
 			 */
 			u32 plen = op->opdesc->op_rsize_bop(rqstp, op);
 			/*
-- 
2.43.0




