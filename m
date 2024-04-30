Return-Path: <stable+bounces-42648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17B8B73FB
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BFB212E9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9F12D743;
	Tue, 30 Apr 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zt40RZo1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEF17592;
	Tue, 30 Apr 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476336; cv=none; b=QjU9ajnaIsXs9jIcbgmbrCp9FXzHUAaitYIFWoOahQnsYnX4aF8M6g6VXa/kuDjrIPir2PVuBDejaK8sca0mAr9OYv3NBeLWTRmk8QFKM0p2fdLJO4unTLkI2VkJlm1z74iFr667zpX2hwTbB5wTDIlx9wHyrGN5MsQEimZvsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476336; c=relaxed/simple;
	bh=dqI2zvSSqqW50I06ZRye3rWh3YtCUcL2OJS/6kN1DVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daa8o3PlyWvB+2kuJrywhNSveqBJXCdEc5XZC1lCcJKWD+Qca/JL+whxreUO2HzcHhKJIrNEDPKvfMuWZB3d/5aiXWugt9DGGgFXlF2wkSLhu8CxNREVtGzJyD/+AWKPk0uGXZm8mJQbdXP16etTCyvGLkNgLftotd04LT1IN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zt40RZo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAC2C2BBFC;
	Tue, 30 Apr 2024 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476336;
	bh=dqI2zvSSqqW50I06ZRye3rWh3YtCUcL2OJS/6kN1DVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zt40RZo1ANxvQ7/mwOA4vjfP+/VeCdVka+p+VPS2W3asp88TGWPuhj1dvbErHsoz7
	 HTH55Z6+yFQIBgVm3wdjNwXcIMu+Ku/oCl2BBbSZvlYL6vKE7CHhYvqvELr7kHLbgc
	 +3x4a6t7IaCezeriY1mFUo1ZPihIpd8E/QX3cTL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 084/107] Revert "crypto: api - Disallow identical driver names"
Date: Tue, 30 Apr 2024 12:40:44 +0200
Message-ID: <20240430103047.137040904@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit cf6889bb8b56d15f15d9b8e47ccab7b3b4c74bd6 which is
commit 27016f75f5ed47e2d8e0ca75a8ff1f40bc1a5e27 upstream.

It is reported to cause problems in older kernels due to some crypto
drivers having the same name, so revert it here to fix the problems.

Link: https://lore.kernel.org/r/aceda6e2-cefb-4146-aef8-ff4bafa56e56@roeck-us.net
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ovidiu Panait <ovidiu.panait@windriver.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/algapi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -217,7 +217,6 @@ static struct crypto_larval *__crypto_re
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
-		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}



