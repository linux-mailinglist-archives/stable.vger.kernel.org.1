Return-Path: <stable+bounces-48791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF88FEA8B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6921B281BCB
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61E194ADF;
	Thu,  6 Jun 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwbMFDqI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB197530;
	Thu,  6 Jun 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683149; cv=none; b=BjIWCGLNJHSzbxdfOBVnLcQ3Ap/WvmXoIPouKXpW4H+9xfZvktAMBeCJN0x6vuLB+YFsw6+TXkDJtTwXN72Wx6rewsPE3aImr0mvYBkO1o0MIQ3mXqG6pQAWFu1nFkJ/q0+G/oQ6DvuFjKmaYclkYGDKPzI2PpDNFLwRLvTHmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683149; c=relaxed/simple;
	bh=3iZEzyBSqwdr7xvu4YbnagPs4TmPS6ZHfEGdO0VSCTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cek5icafqjDKvFamrAmXWlL/HxN9ybRZ8VxW/LSbPVrk5Fj5hJ9V5yRMEg5afrqoFdKc4nOra4eInd0e4nk+0P2XgoOHLyQTij+vbAWH8tXdf1oS/SSpzEFycauw0ubgwjxvrtyZb2RO1lotMLJvf/P03Y6IuVDdb+EjcCLv0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwbMFDqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1122FC2BD10;
	Thu,  6 Jun 2024 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683149;
	bh=3iZEzyBSqwdr7xvu4YbnagPs4TmPS6ZHfEGdO0VSCTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwbMFDqIjt9X78spkCf3zGphQj78yDv2GS3hMHLAKT8wwoUVUvqkfEkx6btyenrcb
	 5V5zBOE5LI7nWYKnm8cPxDhsEcmeKbVhtqpj0JA34QIDO9QeD4Ay5wyWMzcu2gdQID
	 4yhl1Bx6oVSU38RipGfOFL/WiPPo+ZgONp9aIrpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 094/744] crypto: bcm - Fix pointer arithmetic
Date: Thu,  6 Jun 2024 15:56:06 +0200
Message-ID: <20240606131735.413115193@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit 2b3460cbf454c6b03d7429e9ffc4fe09322eb1a9 ]

In spu2_dump_omd() value of ptr is increased by ciph_key_len
instead of hash_iv_len which could lead to going beyond the
buffer boundaries.
Fix this bug by changing ciph_key_len to hash_iv_len.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/bcm/spu2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/bcm/spu2.c b/drivers/crypto/bcm/spu2.c
index 07989bb8c220a..3fdc64b5a65e7 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -495,7 +495,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
-- 
2.43.0




