Return-Path: <stable+bounces-155543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF3AE425E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF967A28D1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8599253B66;
	Mon, 23 Jun 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCwqQ1Qo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DF253B47;
	Mon, 23 Jun 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684702; cv=none; b=BJXb/pu2w9CAzGMKJRKwx3J6rJgc0ks1MsfNr4GmsU3XdNoGEEfBlxs9WIRNlf+AVnk7zhkCQF4umdULJZxh2Akcr5Ni6b6eNVqQna42pzgB+AYsLo1f8J5tPiw1z7WABj/O7kski5j+zU+2rFJPiIrD5NoX88afyL1OPpoTlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684702; c=relaxed/simple;
	bh=2w06eDY9E5UFerd2aWKpyTpA2SZnofjWkp7veMzdDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew42t4AjtbGUAUIjjlyh5ppuU5Hb2nl+p9u9flh3ko7GziiTQZUDc9WgILdM9scmfdii1IqhGMMXuzoJa44G7o8qkRQ922umZinumlRBc9cip8NW0Z2jf60PkvSnpm62v5wNRWJ9gE0IcFtxFdJT0fp+s20DjT6xDGnWA0XTBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCwqQ1Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1972FC4CEEA;
	Mon, 23 Jun 2025 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684702;
	bh=2w06eDY9E5UFerd2aWKpyTpA2SZnofjWkp7veMzdDDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCwqQ1QoxEt0y1UZXiMgN2kTRdyjyL+BN7qI3OMhW/XeB9Tfirv0IY9j7D8q5qsJg
	 FYBYnF8Ny5f3RUdLwi3BdinBkwe0HT30rHBYc7Si7A0a6uhW0p/LRWdMbbO3q4ibBs
	 ni9XBp+muKjcN3O52XGl/+bzU1zi1A3sPoj1/Kdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 012/222] crypto: marvell/cesa - Handle zero-length skcipher requests
Date: Mon, 23 Jun 2025 15:05:47 +0200
Message-ID: <20250623130612.265916816@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 8a4e047c6cc07676f637608a9dd675349b5de0a7 ]

Do not access random memory for zero-length skcipher requests.
Just return 0.

Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/cipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/marvell/cipher.c b/drivers/crypto/marvell/cipher.c
index c7d433d1cd99d..f92f86c94bff7 100644
--- a/drivers/crypto/marvell/cipher.c
+++ b/drivers/crypto/marvell/cipher.c
@@ -447,6 +447,9 @@ static int mv_cesa_skcipher_queue_req(struct skcipher_request *req,
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
 	struct mv_cesa_engine *engine;
 
+	if (!req->cryptlen)
+		return 0;
+
 	ret = mv_cesa_skcipher_req_init(req, tmpl);
 	if (ret)
 		return ret;
-- 
2.39.5




