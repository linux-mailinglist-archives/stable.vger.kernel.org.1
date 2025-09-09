Return-Path: <stable+bounces-178999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67499B49E17
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBEF7A8951
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331E1F2382;
	Tue,  9 Sep 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpRe1q74"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D901E9906
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378209; cv=none; b=QAWEloryn6k6YCwyfMY5RyPX0hva5+AAjjMevBEEZiLq++Xuh+o3DV8yANQjYM6wtNXXYgZWQ0RKBH6CS6u7Mu0nFv38n4Gmh3Bs3BcmNm1vpiGIjxc5rlZJgjjCeOHxLB9gJClkfNhiQkhTB85G0c/gKsNMAY0u6FuGb6qWii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378209; c=relaxed/simple;
	bh=NJNSX96DyIuj9CqZ9DrZ5syL+e6CqxUZLB21bxPwZkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVxUqfMRpVh1SCmd63RKS0FQP3SMJvZGisViAheBdFS/cq5JLxOt4PVsMqamza21P1l+rTDZ/FnBpGwEqJxhzTQ+dLIKVJhSykIuNb+lo4/Be4QmIp19fJE3Y4VZ4rVBoKz9qjeB7bxBz2dhLsxqdfbXNc1SYqZklVlbhqk4nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpRe1q74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF5EC4CEF7;
	Tue,  9 Sep 2025 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378209;
	bh=NJNSX96DyIuj9CqZ9DrZ5syL+e6CqxUZLB21bxPwZkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpRe1q74uwRO88Ki25nMZb9Qr0/C3HUEsWVpK8RSoP4bI4yu4pskuLijcA2KR0Ya0
	 YdRdvuJ8TZDuHUw8jM2UIxzWK1ryNTem2FjjlDlUuJnXhQj64xj/oxLIH1DVRP1VY0
	 PesyF5sxOaoYt41JbsgQQLHFJf7SQAUZJg7+kDjVeMBSLpGbbaMdOiR0M2pJyS69Vu
	 FNR/tFlB8ZbS4+TXuIKSNaUxviRBKCRH+A+UIIXyMdsKUftRkXbodW41F/lC9n4d5M
	 IvGSxjASMy+yb58Uf2opJ+6SSP7g0iqiYY+4yvsb7N2vOlO3JMkY6E32WV6Zh34XlK
	 /OiFuNE8i/iwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
Date: Mon,  8 Sep 2025 20:36:44 -0400
Message-ID: <20250909003644.2495376-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909003644.2495376-1-sashal@kernel.org>
References: <2025040835-legroom-backshift-766c@gregkh>
 <20250909003644.2495376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d7d8e3169b56e7696559a2427c922c0d55debcec ]

If fh_fill_pre_attrs() returns a non-zero status, the error flow
takes it through out_unlock, which then overwrites the returned
status code with

	err = nfserrno(host_err);

Fixes: a332018a91c4 ("nfsd: handle failure to collect pre/post-op attrs more sanely")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Slightly different error mapping ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 58580eb6cf929..5ee7149ceaa5a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1970,11 +1970,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 			err = nfserr_file_open;
 		else
 			err = nfserr_acces;
-	} else {
-		err = nfserrno(host_err);
 	}
 out:
-	return err;
+	return err != nfs_ok ? err : nfserrno(host_err);
 out_unlock:
 	inode_unlock(dirp);
 	goto out_drop_write;
-- 
2.51.0


