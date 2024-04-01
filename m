Return-Path: <stable+bounces-34984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DCD8941CB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274DFB20324
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30A482DF;
	Mon,  1 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="leOFHSmB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8F47A76;
	Mon,  1 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989957; cv=none; b=qOHz5FK7BctiWTzbESWmxKNrSUWxrGk9W55cGb7EG7Fwq+oLGlVck94rithc4Hn403E21/Qw93ttAfvcf8VtRZt08tDD2fB9YRB36UQPttPBar61xQ2lxKdgG7ZGbolR9oWUDuZtpsl7oc5JeZuI7xCLh9ihxtdx77fURxwJlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989957; c=relaxed/simple;
	bh=M8KAPMPjvKJfL6rSeF6EG2GoPUQe9YtuzEIAoCOTEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baS8T3KQODHUAE6tdUtEAa+cOM4tmAmUjIvr7CzxLcQcbEG9wxb4LHahHy//zN4re/ovrxQ9DCdsGnyMZeFDoC0vPukDmj/3xS0xRiEDY2bSD+qYkqkjvoHp8tVpJSnq4XEmQUCb+XkGleDavxTxc0clDpLgzt8/7uLF0CrTR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=leOFHSmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC2C433F1;
	Mon,  1 Apr 2024 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989956;
	bh=M8KAPMPjvKJfL6rSeF6EG2GoPUQe9YtuzEIAoCOTEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leOFHSmB8uLxI6aqn4dSVrYgfo91Y6UwKi1SiPHZcYVqFR9sUVuSreyWKqRC2QABo
	 kYzifonWhulMg6CPZEaLZ8BxAxnLH7Dan404+MhP7kiuQeGxR9b0uEwR9cdbijiJlR
	 MkjoecIkd+5hfGEH2sEL3zlHzTM3I+teq5WCbMJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.6 203/396] crypto: rk3288 - Fix use after free in unprepare
Date: Mon,  1 Apr 2024 17:44:12 +0200
Message-ID: <20240401152553.982947306@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit c0afb6b88fbbc177fa322a835f874be217bffe45 upstream.

The unprepare call must be carried out before the finalize call
as the latter can free the request.

Fixes: c66c17a0f69b ("crypto: rk3288 - Remove prepare/unprepare request")
Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 1b13b4aa16ec..a235e6c300f1 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -332,12 +332,12 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 theend:
 	pm_runtime_put_autosuspend(rkc->dev);
 
+	rk_hash_unprepare(engine, breq);
+
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
 
-	rk_hash_unprepare(engine, breq);
-
 	return 0;
 }
 
-- 
2.44.0




