Return-Path: <stable+bounces-93861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197FD9D1A7A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 22:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC02D1F2275A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4FC1C1AD0;
	Mon, 18 Nov 2024 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wen97wS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701B1E9087;
	Mon, 18 Nov 2024 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964850; cv=none; b=qvAL8y1HxS5K9oz8qm+Cg+Hq3TE6AtpYG4iXZO9iOabL0fHJSsg22ozO1K7Cq+hC0CcWd7HxyqW5unZwAdKw5PUntmhri/gCqooJP8DXjsArBuScM9eDZnaFQqm6HoRkZv1Bk/EzpzrnFqek5XUKNqd57sW8Kd1AVbpX+RbunN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964850; c=relaxed/simple;
	bh=yCznjqq+MJmj5zm8CN6rZgNRFsI5NdBXJfIMezKrz7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NONUNcKBFuOyvrWjd9hhu51Kuv7pisf9mDh7wQ61xLt/cxGTpI7f/9LCV1jk2OXf5YnBrN4MYzm3ssOuNcj2N4WCgypghISipTW++Ax2ogiwLUTa6Tuzyhjjb+evHT0a7xnm9vUHl+tzJLV3ApdwtrCIdWGP0IhD0vq5+8SnY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wen97wS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A76C4CED6;
	Mon, 18 Nov 2024 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964850;
	bh=yCznjqq+MJmj5zm8CN6rZgNRFsI5NdBXJfIMezKrz7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wen97wS/QJnGfQTEwr4EwisNfZW29GHzPnYoIfW25qJfXtocYXtvAi9vVqKmG38Cf
	 9nErJn386HwruQ12aNQ5pcLaz2ynw61Hrowkp/l2lTWZ9xcmvucZBr0J3wyvkmb+tK
	 d2BJ07q6DbTdKWAE4aEC8LbTVAl34ScSYG2Es31LlD6ECz4Kwc5O7tMrDAmwjT+afA
	 6N1X3+OBNPJUFxrHmWlnsQ5kd/NlhhosFrEHRRJMXbPlPphzqFJJni+r2O6ng0s0MF
	 jU6RJ2QKdwOxsLPDPbfVd4XANQGgDZlN4mEOyOwDs+/KZVa644/wiijeIQBaGSZexU
	 rNFUM+VhTSeaQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5.15.y 12/18] sunrpc: remove ->pg_stats from svc_program
Date: Mon, 18 Nov 2024 16:20:29 -0500
Message-ID: <20241118212035.3848-18-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 3f6ef182f144dcc9a4d942f97b6a8ed969f13c95 ]

Now that this isn't used anywhere, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f5d6924905bf..74d21d2c5396 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -136,7 +136,6 @@ struct svc_program		nfsd_program = {
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
 	.pg_authenticate	= &svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ff8235e6acc3..57e0d9b7553b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -409,7 +409,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	int			(*pg_authenticate)(struct svc_rqst *);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.45.2


