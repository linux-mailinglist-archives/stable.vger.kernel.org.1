Return-Path: <stable+bounces-64044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE8941BDB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22D3283F67
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B018990A;
	Tue, 30 Jul 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aeQVXb0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21117D8BB;
	Tue, 30 Jul 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358799; cv=none; b=X5YmeFTe79zeTTixusTDT+avGB7cixx50TKa7+npPz9IRigqBsWpxHso6SvzaDzRGx27IkZIOfYSqlsizXPooA98wxgWPaQU01OkHzBfyLD5fb5YVcRAh5QvFrF0P/Amd0K61nn76+AhXQMd5PCucxNwWjOonNUHk3sAlsRa08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358799; c=relaxed/simple;
	bh=QEMzg5YWeTsP2g9Z1+mS8/TsHkbNzxZipzWNb8FDM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuHufH/QdNOjMQQWxCCV9dWX6tIESQIqB/7+rT3nRKYL0/axIedQ0rDHCodlXZWn2m6p1nDJtSYnFoDxowZxVEANkpFqFuWeJHK+uc3otNeIy2ppnLuMtFrir9qJtomEkYuOxzhUEfTMbd32pL0kr2GhJWx+ggKDykruqAPUKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aeQVXb0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F343C32782;
	Tue, 30 Jul 2024 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358799;
	bh=QEMzg5YWeTsP2g9Z1+mS8/TsHkbNzxZipzWNb8FDM9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeQVXb0w7AmCVKW7drEcJv/MUdvpx1c6JwbC39aU2mrhrFcaz65Ei+ZdngMtjLSs5
	 CFEEDe7M9MYsk31NK5iyaWZ9wqXyU1xB1NRd68UJX5FW/W9a3bh5mbSkpJrByrVNaw
	 DyLtH0VeMp8/9TZWhkNC6ebQu1EMn55GLqQY0vyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 391/809] crypto: atmel-sha204a - fix negated return value
Date: Tue, 30 Jul 2024 17:44:27 +0200
Message-ID: <20240730151740.124244982@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lothar Rubusch <l.rubusch@gmail.com>

[ Upstream commit aabbf2135f9a9526991f17cb0c78cf1ec878f1c2 ]

Fix negated variable return value.

Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-crypto/34cd4179-090e-479d-b459-8d0d35dd327d@moroto.mountain/
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 24ffdf5050235..2034f60315183 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -106,7 +106,7 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 
 	if (cmd.data[0] == 0xff) {
 		dev_err(&client->dev, "failed, device not ready\n");
-		return -ret;
+		return -EINVAL;
 	}
 
 	memcpy(otp, cmd.data+1, 4);
-- 
2.43.0




