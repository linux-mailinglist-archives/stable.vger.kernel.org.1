Return-Path: <stable+bounces-14605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB3838190
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C621C292BD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E872101D2;
	Tue, 23 Jan 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/e2TRd8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291C2CA2;
	Tue, 23 Jan 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972175; cv=none; b=jSAMr8gbOZTmjkzikxRJHXtSg7kbKPK/xTEyblWtWwwjjd2ANDIiAQV4Z3+zedJKxFRJxsDHEhi/krDnDZRj4Pod4x9gLfI+VR8hxJEqGzgaJYFfWcy331t3VkHMYWXRqEzpuVZ2rMWHgN4XkDdboUoiPym1R3rKRhTJOcHxOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972175; c=relaxed/simple;
	bh=c06Cv6KlTfhiM4lf4CmGTUHqF9GEApgQ9dHAargM0ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxHoSl+oTQ5PN3QXZqKZkKMozMdNTgzYRYEydXa4dlMpMbuqI+2amaadKkF8Zm35IoxDC9PmiuspNKlk/EqU3zsqNF6WCcG6byey7LifpBuOE3apF7T43fIvRU5NXbWkqLZr1OELi/q9zaGnKvGAbnME50IhaqJyQ/Iv1MYITtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/e2TRd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E66C43399;
	Tue, 23 Jan 2024 01:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972175;
	bh=c06Cv6KlTfhiM4lf4CmGTUHqF9GEApgQ9dHAargM0ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/e2TRd8VAJXJM/IFsvBAVZVGp93ve5vEE9wwA9qFEoer/RZf83n31sRwa2lrcXVG
	 IGQXtIsrNO+ARf9kGDSvVCiR/62Df2vWZ1NqGDS3W/xyA1T1Ah33jVsY7Adlqfoc0E
	 S4PBFGmzx96xbnGvjyz7yWctYtlEddaNaWMOuQUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 101/374] crypto: sahara - fix processing requests with cryptlen < sg->length
Date: Mon, 22 Jan 2024 15:55:57 -0800
Message-ID: <20240122235748.122725270@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait@windriver.com>

[ Upstream commit 5b8668ce3452827d27f8c34ff6ba080a8f983ed0 ]

It's not always the case that the entire sg entry needs to be processed.
Currently, when cryptlen is less than sg->legth, "Descriptor length" errors
are encountered.

The error was noticed when testing xts(sahara-ecb-aes) with arbitrary sized
input data. To fix this, take the actual request size into account when
populating the hw links.

Fixes: 5de8875281e1 ("crypto: sahara - Add driver for SAHARA2 accelerator.")
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sahara.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 2b20d1767ef9..caa54d5312e9 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -445,6 +445,7 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	int ret;
 	int i, j;
 	int idx = 0;
+	u32 len;
 
 	memcpy(dev->key_base, ctx->key, ctx->keylen);
 
@@ -495,12 +496,14 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	/* Create input links */
 	dev->hw_desc[idx]->p1 = dev->hw_phys_link[0];
 	sg = dev->in_sg;
+	len = dev->total;
 	for (i = 0; i < dev->nb_in_sg; i++) {
-		dev->hw_link[i]->len = sg->length;
+		dev->hw_link[i]->len = min(len, sg->length);
 		dev->hw_link[i]->p = sg->dma_address;
 		if (i == (dev->nb_in_sg - 1)) {
 			dev->hw_link[i]->next = 0;
 		} else {
+			len -= min(len, sg->length);
 			dev->hw_link[i]->next = dev->hw_phys_link[i + 1];
 			sg = sg_next(sg);
 		}
@@ -509,12 +512,14 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	/* Create output links */
 	dev->hw_desc[idx]->p2 = dev->hw_phys_link[i];
 	sg = dev->out_sg;
+	len = dev->total;
 	for (j = i; j < dev->nb_out_sg + i; j++) {
-		dev->hw_link[j]->len = sg->length;
+		dev->hw_link[j]->len = min(len, sg->length);
 		dev->hw_link[j]->p = sg->dma_address;
 		if (j == (dev->nb_out_sg + i - 1)) {
 			dev->hw_link[j]->next = 0;
 		} else {
+			len -= min(len, sg->length);
 			dev->hw_link[j]->next = dev->hw_phys_link[j + 1];
 			sg = sg_next(sg);
 		}
-- 
2.43.0




