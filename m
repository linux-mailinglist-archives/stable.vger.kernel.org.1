Return-Path: <stable+bounces-53402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A45790D17A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D6C1F24052
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3131A08B3;
	Tue, 18 Jun 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0BZp/dzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23E13C695;
	Tue, 18 Jun 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716219; cv=none; b=Yp1soaSZ/UDQ0VS8y5gvhw77BwnS4Gv7RW3WNXflOQ6j96YyZrmegb1k3hvQxfHyaFRp9ScrOmKqtlvPBrydRw5YuFlvBilSO2A/L8dmwEuucqTcJKHn1RADgx1QtTz6MK+5jdCVzMrUCIF9I/DLXcbSGZ+XbZHX6qoHvyzEg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716219; c=relaxed/simple;
	bh=XPqQ/EwyklC+Qxzp69a6vqLg5ZW7rlxEL0pfQgqpvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4oe6w5AXYOp3XsEJ52twTGwoNou8qt/CI3pDtwmiM620hwByhiCEN4QbfE5IGi67+HtcS/diuTmbZx9cPoPzfht3oDImcUmTsXhSUKWT9lOPsjLAnZ1SSc2tVtpxLjPrW9X0mY+BNP/ZTATeetan1PbvJReP36t+d/vVhklSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0BZp/dzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8440DC3277B;
	Tue, 18 Jun 2024 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716218;
	bh=XPqQ/EwyklC+Qxzp69a6vqLg5ZW7rlxEL0pfQgqpvMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0BZp/dzxYM/YSqHb9x0nx57+EjIZJ40b7u7u/unmMgKOa5Fk7WLsLYEsQKu+Yv8ZT
	 1VxiQ9Ub/NrRTcLGP2Ev/RRUIF8AvLdXeFvFQKaYEClpUS7TW5ybLUFCMjgo9aGeuC
	 hDNOMRK43ASG9PEElAdJVAkbhbtaW3Yqid1MvtB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 572/770] NFSD: Remove lockdep assertion from unhash_and_release_locked()
Date: Tue, 18 Jun 2024 14:37:05 +0200
Message-ID: <20240618123429.375283059@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit f53cef15dddec7203df702cdc62e554190385450 ]

IIUC, holding the hash bucket lock is needed only in
nfsd_file_unhash, and there is already a lockdep assertion there.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2d013a88e3565..6a01de8677959 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -299,8 +299,6 @@ nfsd_file_unhash(struct nfsd_file *nf)
 static bool
 nfsd_file_unhash_and_release_locked(struct nfsd_file *nf, struct list_head *dispose)
 {
-	lockdep_assert_held(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
-
 	trace_nfsd_file_unhash_and_release_locked(nf);
 	if (!nfsd_file_unhash(nf))
 		return false;
-- 
2.43.0




