Return-Path: <stable+bounces-14132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCD837FA0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B1C29367D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BE6311F;
	Tue, 23 Jan 2024 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NXJ2O28Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC2634F7;
	Tue, 23 Jan 2024 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971249; cv=none; b=Tx12v7F9lHyReQQgswjzLWv+iuDuonIwS6G8VC9NBx/SY8qCcK9ZBGvO8CUrRK3WP8B3bN3SoSlD2ELw3i7nG0RVHg3GNGETOljriwIy8qPC0tuEVeI8YFYAGnRcMTQ5qC8Sk05EThjjpk8c39bZeFYFWdNOxFmXRGjoPu0W2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971249; c=relaxed/simple;
	bh=PhVKNYSgWuRHdh/YRnQ+D5FszZv3GWqOwp/0xMZ7PJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAxPdKqnRXY53ecQfROmKJgu9pEkJeei9BAPdBFr9rbE2xpjQONqQlNDY82glqx+IEmGF1+IkOMf+OA3P+2EI/qZ9kMBKpmnYq3WCOzyaiaUrnkIT844O/yQf08l3Zx82WPDnOrmyjl6asGxkUS1PtOne8TQFhDONQ7Na3QOIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NXJ2O28Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B30C433F1;
	Tue, 23 Jan 2024 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971249;
	bh=PhVKNYSgWuRHdh/YRnQ+D5FszZv3GWqOwp/0xMZ7PJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXJ2O28YckZdZwMUwKCXlMuRMcN0AkLPWaAukFjcvItzJ+mp/TNa1+43FP3Lyc2Cv
	 fKXnLWN88+Bu+/UMm8OZk4VrMvPKzyROCdu/pjg7u55aeEbTadeFoElOsoDO8h85oW
	 pVOL6b74QDCLJFb2tARCuF/vSj0dBn4CI22xxFNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 100/286] crypto: sahara - fix ahash reqsize
Date: Mon, 22 Jan 2024 15:56:46 -0800
Message-ID: <20240122235735.923543375@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

From: Ovidiu Panait <ovidiu.panait@windriver.com>

[ Upstream commit efcb50f41740ac55e6ccc4986c1a7740e21c62b4 ]

Set the reqsize for sha algorithms to sizeof(struct sahara_sha_reqctx), the
extra space is not needed.

Fixes: 5a2bb93f5992 ("crypto: sahara - add support for SHA1/256")
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sahara.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index d6510e169c8e..a97b1dadf6a4 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1162,8 +1162,7 @@ static int sahara_sha_import(struct ahash_request *req, const void *in)
 static int sahara_sha_cra_init(struct crypto_tfm *tfm)
 {
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct sahara_sha_reqctx) +
-				 SHA_BUFFER_LEN + SHA256_BLOCK_SIZE);
+				 sizeof(struct sahara_sha_reqctx));
 
 	return 0;
 }
-- 
2.43.0




