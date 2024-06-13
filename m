Return-Path: <stable+bounces-50544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C085906B2E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BF21F22E7A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD0143753;
	Thu, 13 Jun 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+t5F+fi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030B1422B5;
	Thu, 13 Jun 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278675; cv=none; b=r5DpU73kgmcot4wpzSsgI93ojVfxJ1S1F9j8gQuCwVhJRJJ5b4uU3prC04/8xHwakcTflmCxxvGsw1NYo0SqLIy3ypuAf/lPFwwnuNsmJJpNLzKtZGZkOT5znJiZGExcLwtCXCgdbFykwPRgEOrGOAcNoei3GcjnQqBuJ7lEyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278675; c=relaxed/simple;
	bh=+CRbBlpOurciwZ0nOkuRiKPrsJn86l1ohjkR8WIILm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeRTwAbCgvwc7eZGXabaYqG21Q9TbxT5KfL7PsBwAKVKu+QAEUldvD2TXyPFrAdbm0Tku5yWzx37SimmNw14n+PZvajyGr1oG9pPKQPJVaqRpQoUI5Zur03eklJHUkYUcWtlpU1zLRtNayd9XccG7cCF5QNeO8SJ/DGJWov5vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+t5F+fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9713BC2BBFC;
	Thu, 13 Jun 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278675;
	bh=+CRbBlpOurciwZ0nOkuRiKPrsJn86l1ohjkR8WIILm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+t5F+fifb8nsqUAboiGFbrpi2wfck726NhI1VE38l8U8KmbDGIuvctHfQu4Srr51
	 fNaHVEssBIB4CqiEzUXQbLC9x6FOrbRDMSrwQBbWmXrQdjaRtiATPcnCGC/p4OgmvM
	 1yerOPg6/hubmBO7gbejrZmEm/Zd9w84jX3mum8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/213] crypto: bcm - Fix pointer arithmetic
Date: Thu, 13 Jun 2024 13:31:02 +0200
Message-ID: <20240613113228.537037329@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index bf7ac621c591d..0f6023347cc89 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -506,7 +506,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
-- 
2.43.0




