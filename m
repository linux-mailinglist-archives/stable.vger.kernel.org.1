Return-Path: <stable+bounces-202448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D32CC2B22
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E8F8300887A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5A364EA2;
	Tue, 16 Dec 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cc5oa1tg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38648364E9C;
	Tue, 16 Dec 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887932; cv=none; b=Xp0IPpYURd1n0fyf6H+qXWztL4AE7T24rsK1NIKVvzhdMhlx4ABqt+PLGetkuCIiI5XD0/RtPPrRlDgLKAF71srCBauSvYnG449u1LKc47LHZpaZKrnHsiXgxMUN7Znz3OLt3rMIGRkvubGgGq9bdL+v2vq7s3JmWcJBoSmSG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887932; c=relaxed/simple;
	bh=1kpP5EZZ8u3f/1oif/fBBKuhKoYc4Rc/uL7Fa+4BUR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCqgjB/Atn8iwOJT+Y0YzCClXYOepYqqACbigrPi4FgoO2qjllRD+3BwypRoYke5ZIziKqXeog9wtaNgGF3yV0K1nNusFEv3olFTY9TzIznrsnoG8YN7qRj61XH4Lh04SSsLERanhdQ+pIJTOp2iCcL6JTmiHGgxH96NTFbkDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cc5oa1tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0782C4CEF5;
	Tue, 16 Dec 2025 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887932;
	bh=1kpP5EZZ8u3f/1oif/fBBKuhKoYc4Rc/uL7Fa+4BUR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc5oa1tgYjekrjVgfp9nRLzfYEBhupZ30XKisupQoCtpt2rhlqH121OTGVmN8hj0x
	 vZrZFEg4fuYQujmcaCr6QQ2Y0kQvo+pCIc2UbGVN67aLvwkIKSkMtdfPwzo6DW8PIa
	 XoxA4zNkoThhmPVzagpvW+HOmu6EITserthvQVyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	T Pratham <t-pratham@ti.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 380/614] crypto: ahash - Zero positive err value in ahash_update_finish
Date: Tue, 16 Dec 2025 12:12:27 +0100
Message-ID: <20251216111415.130258057@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit ebbdf6466b30e3b37f3b360826efd21f0633fb9e ]

The partial block length returned by a block-only driver should
not be passed up to the caller since ahash itself deals with the
partial block data.

Set err to zero in ahash_update_finish if it was positive.

Reported-by: T Pratham <t-pratham@ti.com>
Tested-by: T Pratham <t-pratham@ti.com>
Fixes: 9d7a0ab1c753 ("crypto: ahash - Handle partial blocks in API")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/ahash.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index 819b484a1a003..66492ae75fcfb 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -423,7 +423,11 @@ static int ahash_update_finish(struct ahash_request *req, int err)
 
 	req->nbytes += nonzero - blen;
 
-	blen = err < 0 ? 0 : err + nonzero;
+	blen = 0;
+	if (err >= 0) {
+		blen = err + nonzero;
+		err = 0;
+	}
 	if (ahash_request_isvirt(req))
 		memcpy(buf, req->svirt + req->nbytes - blen, blen);
 	else
-- 
2.51.0




