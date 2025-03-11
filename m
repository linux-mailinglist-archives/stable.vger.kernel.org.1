Return-Path: <stable+bounces-123374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61156A5C536
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1436189AD1D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F025E824;
	Tue, 11 Mar 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ch0tHcBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD325DCE5;
	Tue, 11 Mar 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705769; cv=none; b=sVhraeI6s6Fv72QshY9GFFy3Tdq3bl1aMq42ehk5WmLwfoJKxcI4r4tRpg8FuY1946PI8j1frkY9tu+Tb2XLdpd8g/YNeU0Z+B3d88/yWNlMCUyE7c0A44f98Uax+uzpvaL2ll3XrokfMrDBx/LwHlU4/5Puxpq6OdPkffpNjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705769; c=relaxed/simple;
	bh=BvsPHebU+gy9wpFBjVwe/93ayejVX6BgqGgkMC2RsZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKdu+Jbl7btdJA+quSs8Vw+NXMjAExQnCJ/9FwoonbXZFkViW4VEpLhQ24CqOW9YlKBXpgQJ8VBbMN/l9Stwo2uMeWnxxAe5rcL0FW8ij8nMxjgwiiH0a47DXHUy3qZnJvuWq4cJHzu7wXnTQGYn83XDzD12vvsockFsxvHMKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ch0tHcBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3BCC4CEE9;
	Tue, 11 Mar 2025 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705769;
	bh=BvsPHebU+gy9wpFBjVwe/93ayejVX6BgqGgkMC2RsZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ch0tHcBZfdtUnzDAFC0jLMs24ynO9YxeAZiEEn9+YUdJNVhK0d/KGI9ZLQreeUR+X
	 7eOicg+6GVNOADccebFBnk2VE8dh/8ENpCqpsJWOkYlWbgP6GzHtnBLbyMQC2OouqO
	 rHwbp/x+uc+2gzke/Mq3bQbW2XAYL5FmLlcBfiRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 149/328] crypto: qce - unregister previously registered algos in error path
Date: Tue, 11 Mar 2025 15:58:39 +0100
Message-ID: <20250311145720.828059675@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

commit e80cf84b608725303113d6fe98bb727bf7b7a40d upstream.

If we encounter an error when registering alorithms with the crypto
framework, we just bail out and don't unregister the ones we
successfully registered in prior iterations of the loop.

Add code that goes back over the algos and unregisters them before
returning an error from qce_register_algs().

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/qce/core.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -40,16 +40,19 @@ static void qce_unregister_algs(struct q
 static int qce_register_algs(struct qce_device *qce)
 {
 	const struct qce_algo_ops *ops;
-	int i, ret = -ENODEV;
+	int i, j, ret = -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
 		ops = qce_ops[i];
 		ret = ops->register_algs(qce);
-		if (ret)
-			break;
+		if (ret) {
+			for (j = i - 1; j >= 0; j--)
+				ops->unregister_algs(qce);
+			return ret;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qce_handle_request(struct crypto_async_request *async_req)



