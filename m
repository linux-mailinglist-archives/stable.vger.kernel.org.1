Return-Path: <stable+bounces-169820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59CB2872F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839B41CC6EF2
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7218257ACA;
	Fri, 15 Aug 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxJyC1Hv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B223D7CF
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289668; cv=none; b=YHvh9nrfaQVCTAAj4mJ9nVBHZBCQ6qbK+MyUKixvw9MacN72PVlrjoL9fzUTfXh9uf9byWNWOgsmbMq5JsBMVdYSgofmhH2iO4d/8H/evVPYeIBF8NpvXRJhASgGgXXcMk+rMa8Ce3KIeJTAnmxPNB0ZN3JgDLqJKPGnD1IRd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289668; c=relaxed/simple;
	bh=hqxvUpI/+YKpTZ9+4IISvtm2vyPkBuyUCRJwGEsJ1LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twBI/a6UMldJ5xF3McHpMWtzcD3AxsRDzln9jXotYEMopjw/qc9tTb1TN8HggUgzGcpYQZZDVQwZPeJxLvvuO6TY1EzKPrsXWEzyIv/MVXuNSmLHblUXF884a+RfaSTRDFxa4tgKmbxAWkubYpM//TOfuI0Giu6N0als8ZVeMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxJyC1Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D8C4CEEB;
	Fri, 15 Aug 2025 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755289668;
	bh=hqxvUpI/+YKpTZ9+4IISvtm2vyPkBuyUCRJwGEsJ1LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxJyC1HvMgO7xmSJofcce5hgSnrBQCbJ7IkAe0ICNXgQmjypkZwWoaJ8M7PXWIWN4
	 oHxkuNowAdeGE6coGQboP2qtdaUzd0xyu2Lkfigr6f2jO+gu8NAwo69Rv3PEXQWgC2
	 H9zPTnhgtPsZrYxDBtxy1mxku38Jbtapie9iDuvMokW+PRfcvFUvglAE1JKtXxI76l
	 nNBzfU4FCZW+7G2RNN4GRqg/ey+9a+AxliMfV1sTuXDtywESfva6LTifis4PDZrsig
	 BLqrYo2kYXeroniofcd59knfc97C5zYZIr6pK74ZpP/hRtE3UKztOokl+lf0t85I2T
	 5EXhRKeu3wXCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	lei lu <llfamsec@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
Date: Fri, 15 Aug 2025 16:27:45 -0400
Message-ID: <20250815202745.212176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081525-comprised-nastily-418e@gregkh>
References: <2025081525-comprised-nastily-418e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 908e4ead7f757504d8b345452730636e298cbf68 ]

Lei Lu recently reported that nfsd4_setclientid_confirm() did not check
the return value from get_client_locked(). a SETCLIENTID_CONFIRM could
race with a confirmed client expiring and fail to get a reference. That
could later lead to a UAF.

Fix this by getting a reference early in the case where there is an
extant confirmed client. If that fails then treat it as if there were no
confirmed client found at all.

In the case where the unconfirmed client is expiring, just fail and
return the result from get_client_locked().

Reported-by: lei lu <llfamsec@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/CAEBF3_b=UvqzNKdnfD_52L05Mqrqui9vZ2eFamgAbV0WG+FNWQ@mail.gmail.com/
Fixes: d20c11d86d8f ("nfsd: Protect session creation and client confirm using client_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a3f8660803c7..f915fef7ca6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3956,10 +3956,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	status = nfs_ok;
 	if (conf) { /* case 1: callback update */
-		old = unconf;
-		unhash_client_locked(old);
-		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else { /* case 3: normal case; new or rebooted client */
+		if (get_client_locked(conf) == nfs_ok) {
+			old = unconf;
+			unhash_client_locked(old);
+			nfsd4_change_callback(conf, &unconf->cl_cb_conn);
+		} else {
+			conf = NULL;
+		}
+	}
+
+	if (!conf) { /* case 3: normal case; new or rebooted client */
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
@@ -3975,10 +3981,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 				goto out;
 			}
 		}
+		status = get_client_locked(unconf);
+		if (status != nfs_ok) {
+			old = NULL;
+			goto out;
+		}
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
-	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
 	nfsd4_probe_callback(conf);
 	spin_lock(&nn->client_lock);
-- 
2.50.1


