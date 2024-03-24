Return-Path: <stable+bounces-31865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87B889927
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E5629EC4C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34493A5104;
	Mon, 25 Mar 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+iNkSKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E53178223;
	Sun, 24 Mar 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323533; cv=none; b=sSOl7cQgS1S3Uv5kbzW05Co0viK85UVlPHjnfZlF3YtXMEYrMz4MAaoS4I9bLqApMoWOuCxt74aZJCwgPmCzoClIQetUJdzl5CbrxXFDrccKzmilYND29yskCLeNYHl+2C2aAwalouOvn5jKv1yczSjq5EfICwn5WddrrmWBH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323533; c=relaxed/simple;
	bh=WcWIkH5q7zZPWwW1JMd5ars6aARZtyMpPCQlr0PEIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPtvVrSZVj74dk8MhhTxtdZ8XswzortPLTk+6I5Mud2RM1x+oLm3kwo2qdjrIAbF7L5zJpt2oKmEQrr9uGYp3GK1xeAAiWJ5hft3C9bFAWtRDCI/BhV5SSexZzQhe3DmyrrwDzYUVUtdEOM0lw15EOPw4QQhuFm4z6LaDCWFL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+iNkSKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F0C43399;
	Sun, 24 Mar 2024 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323533;
	bh=WcWIkH5q7zZPWwW1JMd5ars6aARZtyMpPCQlr0PEIBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+iNkSKBWBH222XtPivUk1kSfw/bX8m+I5ZFfNBKHvdUW2r6RwaJld337QAdr7zd2
	 Jj31UBqcPTU8t4sURS6zfyUto7+Q70N8Mf+IbYJAFuzWUN8/n96DDlxFeBMnpvSNta
	 pGrivHIcHqlAbczDj1Ro4F7aUQ9b89oqeKMJRSg2SaSHgaEh766L2IIwOUt1F2SCuJ
	 xdadEbeuaW4zQbq1zywCNFhq7WhFGbFTxaob6y+2mjS8ID6r5Y7UPuTH00K9gA8pv+
	 H1bBfIswEKNDFj7R2yFqeZYz9oJYiuLqem2pHVyhXZrWyS6f0LaInYh/twwWT27eyc
	 7l9Xc6soDknSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 241/317] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 19:33:41 -0400
Message-ID: <20240324233458.1352854-242-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit 6969d0a2ba1adc9ba6a49b9805f24080896c255c ]

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mutex before destroying.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20231214173614.2820929-2-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 80d937454aeef..f7d9795ce5e1f 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -397,6 +397,7 @@ static int aw2013_probe(struct i2c_client *client)
 	regulator_disable(chip->vcc_regulator);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.43.0


