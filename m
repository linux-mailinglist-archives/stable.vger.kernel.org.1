Return-Path: <stable+bounces-64082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F9941C0A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F189D285090
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BA189B89;
	Tue, 30 Jul 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmfbfzfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C5189B85;
	Tue, 30 Jul 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358931; cv=none; b=GFoXFF0yz0DCd1t0Ersu3Atj+uO0TExxRGPdajn5n0k6ciaIUVjQlGSezH4zLOcif8p64pfTxSdsN40MejnqMustkeqrNgAR7+oCWDLMwak3GbBZH6CoAEnqjWbdfLZPDvolUf4rglnYEJIDVM/he0xGbeVRvEVNW5JKaCJQ15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358931; c=relaxed/simple;
	bh=uMq9kgTLTixb1wPJQXokD/HjgY+CII1IjBw2/nUiDfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO/VUbocXrv/7xzm3tqeSpIDsKPv1Wc7P/RFKzZSLjL4X+VSXRoeK8H7kpFd/spK6Bd0P9pHkLpAe5ZrTcGSJPfiML9V1VLaArA6E2wUegz14viGiSLFVuY5cDRzN87A8I8ly4yST85tNvSBYL3fsRvMT/nq+L1Jx+KREq+n1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmfbfzfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0428C32782;
	Tue, 30 Jul 2024 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358931;
	bh=uMq9kgTLTixb1wPJQXokD/HjgY+CII1IjBw2/nUiDfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmfbfzfobH/BOSjfAchhJLP8lcH2CBwEekhiqawH4fhTXiNPu+HfRQ9RiKKqIXdbM
	 mEBCEGY4IXp+gOCgD+AGtfbHR269hR1H7yCG+M79Y3F1E5ckPKcsobOLneI0zJ5xQ8
	 577wpGhvFwPKtYhEjYH20/zQdQgyxGilEHyJWmWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Ge <gehao@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 409/809] ASoc: PCM6240: Return directly after a failed devm_kzalloc() in pcmdevice_i2c_probe()
Date: Tue, 30 Jul 2024 17:44:45 +0200
Message-ID: <20240730151740.844621499@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit 3722873d49a1788d5420894d4f6f63e35f5c1f13 ]

The value “-ENOMEM” was assigned to the local variable “ret”
in one if branch after a devm_kzalloc() call failed at the beginning.
This error code will trigger then a pcmdevice_remove() call with a passed
null pointer so that an undesirable dereference will be performed.
Thus return the appropriate error code directly.

Fixes: 1324eafd37aa ("ASoc: PCM6240: Create PCM6240 Family driver code")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Link: https://patch.msgid.link/20240617020954.17252-1-hao.ge@linux.dev
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm6240.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 86e126783a1df..8f7057e689fbf 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -2087,10 +2087,8 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 #endif
 
 	pcm_dev = devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
-	if (!pcm_dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!pcm_dev)
+		return -ENOMEM;
 
 	pcm_dev->chip_id = (id != NULL) ? id->driver_data : 0;
 
-- 
2.43.0




