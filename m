Return-Path: <stable+bounces-53414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C601B90D185
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706931F26B44
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27221A08BD;
	Tue, 18 Jun 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ta6rilAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBF158A36;
	Tue, 18 Jun 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716255; cv=none; b=rL6l+vcWE70WUL08A+yZyMnlDoKFdZf/pu3s4DyuhNM08NQ27xmDPDNkbb633EookfsdoiiBBAIDtqYZw+1eYQp0PwnkSBuNFicdGH8ZhI6Mi3Lk5qS3soPTyXZ2AaaBQRBx2EO9ycKN19QGbj5QRApLpVur+NngncQRkiaJTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716255; c=relaxed/simple;
	bh=NM8Na79bQEzKI/Y4HHu9id+8WM55XcDSXaRTz/g0EYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORQbC1+SrDwLaRmagtm+TneDgQ/pzcIU1mU3C+c2bO7LpwIsXrEN19qxsCgpWw6AqFLydZbx1rJWO4UGmVTfrIlG/v/PvEbqb3lgo+7+s31NNZFH+y+GZGZROU7gOoaF6YyNBrw/3adu2G38pyR2NQgw96D838xZWlZj+erDqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ta6rilAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B3C3277B;
	Tue, 18 Jun 2024 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716255;
	bh=NM8Na79bQEzKI/Y4HHu9id+8WM55XcDSXaRTz/g0EYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta6rilAZV5yPOiXTOSFPMQMl9C6mqBkSaVpHhI/s7xktFlz0W3RK8xMG3hn7jyZLs
	 DPds+um5B5REi5s8l8XHD7R0/b9KzPbdaTp2zTsc+70pzJv+u1QRkhD/7G6uRFvm+J
	 ex9wcmlXrgZjgZhwBj4YkBTVl+Xk03/QGUOFvstQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 553/770] nfsd: remove redundant assignment to variable len
Date: Tue, 18 Jun 2024 14:36:46 +0200
Message-ID: <20240618123428.649009225@linuxfoundation.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 842e00ac3aa3b4a4f7f750c8ab54f8578fc875d3 ]

Variable len is being assigned a value zero and this is never
read, it is being re-assigned later. The assignment is redundant
and can be removed.

Cleans up clang scan-build warning:
fs/nfsd/nfsctl.c:636:2: warning: Value stored to 'len' is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf2424..66c352bf61b1d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -633,7 +633,6 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	}
 
 	/* Now write current state into reply buffer */
-	len = 0;
 	sep = "";
 	remaining = SIMPLE_TRANSACTION_LIMIT;
 	for (num=2 ; num <= 4 ; num++) {
-- 
2.43.0




