Return-Path: <stable+bounces-42707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27C8B743B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EB4B20E24
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B612CD8A;
	Tue, 30 Apr 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sqK4R1GU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915A17592;
	Tue, 30 Apr 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476525; cv=none; b=OetdJ11FG1ihKGmhrPtkKyjIPxanavJvALqED4ytcYyWimRf/vipGvIvL/24e4IGzfbjhPq0cR/E7CA3A0xl+ymx5LmdRAjd0MBZPdCvBFaJvfm3XNJmURiSTOiMkJYEdO3hYV1DglMXrx3/vn0zeLQeQcByNQUE8ZgmkHcfBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476525; c=relaxed/simple;
	bh=B7ftpd5mSWQI0x1LgfRj6NvZrOmEc/xeXZE21DnmMhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBlukju5vgZKPlmecMuegrbbWtp6ju8gnyWbu+ZeWGXk43TNvPyn86cutk21v8QQ9gfz6MmEWQ324l5trcKBlUq9iGqpJhcvoKteXwTcokWnupl3TpDfQSMjVFub6FNk+/cQwyrWVFdD7UG6UDLdn+iR/v95pUGVn4Zbbs6Ht0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqK4R1GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4016C4AF18;
	Tue, 30 Apr 2024 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476525;
	bh=B7ftpd5mSWQI0x1LgfRj6NvZrOmEc/xeXZE21DnmMhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqK4R1GUKRnbGxQSlzeP3w3JpdOFFnOap8KA5rXEPq32F+8ti+RU7PUwOhWPXYXdy
	 8fALFJWrMIKTyo3gcgEgIOF8SN/Q/AbF3nWwfCEX3xnjCeME/n/6OlfmgHRzIud1ei
	 WeHLphOpG7gzaTI4GeoBSESsqLQkLCHPqFYZWHo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 060/110] Revert "crypto: api - Disallow identical driver names"
Date: Tue, 30 Apr 2024 12:40:29 +0200
Message-ID: <20240430103049.339445274@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 680eb0a99336f7b21ff149bc57579d059421c5de which is
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
@@ -290,7 +290,6 @@ static struct crypto_larval *__crypto_re
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
-		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}



