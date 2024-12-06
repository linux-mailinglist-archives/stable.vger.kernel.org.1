Return-Path: <stable+bounces-99625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA399E7294
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9F11888163
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCE1FCD11;
	Fri,  6 Dec 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQ/+DLF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A151FCCFB;
	Fri,  6 Dec 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497809; cv=none; b=uU8Rdph4g6L/+JJW0wFT7cSb/D/VdB+yXsaGfeyC1OFekSxqRNYGfUnCbaC382y1sEsiL7ynngxZfhcyGAJkNeXZHBsb1jWI/7mRXgWTXNeoAaiGQ+Jzf8N+6xepIJTebUZR99aD7u/UvJrSOfZpRMOJ1Ds3BUHprsK79SSZHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497809; c=relaxed/simple;
	bh=6w/6WdKk/P0Q4yj7PSi8ln4onD98AHoC/+pCBqO3j6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJeR36jgId+WUpMnghz62UBV0KkqAXwbX/v+okjnVE0QxIt7FsmBk55ZFYrepXJjK0sFeGgSpVo6aYHCpT2idFczafyKoTpkXSFM6ClS6n3H8EjFg2g1ny6RveYt68SO661KT0ZXzs5xsdckwy3CodLJ0u0qaHyTkPh30P2YTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQ/+DLF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DE8C4CEE2;
	Fri,  6 Dec 2024 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497809;
	bh=6w/6WdKk/P0Q4yj7PSi8ln4onD98AHoC/+pCBqO3j6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQ/+DLF7fCB7qJHiQ31evGna3lFf9f7+W2pX+EDD0jBiDKcawI4+RFoVhUHDLxsw6
	 NjSbjCyw/7wiRwDkAmS7F3UHg5WeD7qUhrNVWjK+dJGA4eQjSWKcX8eG+vXKRNgIEm
	 W1hPylkRr70zFBgHIbNDxF8yXZvRpUCUmqy5qYUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 382/676] NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
Date: Fri,  6 Dec 2024 15:33:21 +0100
Message-ID: <20241206143708.267723422@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit f64ea4af43161bb86ffc77e6aeb5bcf5c3229df0 ]

It's only current caller already length-checks the string, but let's
be safe.

Fixes: 0964a3d3f1aa ("[PATCH] knfsd: nfsd4 reboot dirname fix")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 4395577825a7f..892fecce18b80 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -658,7 +658,8 @@ nfs4_reset_recoverydir(char *recdir)
 		return status;
 	status = -ENOTDIR;
 	if (d_is_dir(path.dentry)) {
-		strcpy(user_recovery_dirname, recdir);
+		strscpy(user_recovery_dirname, recdir,
+			sizeof(user_recovery_dirname));
 		status = 0;
 	}
 	path_put(&path);
-- 
2.43.0




