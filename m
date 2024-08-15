Return-Path: <stable+bounces-68907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D723F953490
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8757B2845ED
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A431A76B5;
	Thu, 15 Aug 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sqeLqaDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22D19DF6A;
	Thu, 15 Aug 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732044; cv=none; b=RookYr3ctuqbayI4r6lVMB5Su5X0M5l5AfgeoJYdH/1DQ5zchmGh9B4kE7Sro+xdn0H9SW/cF5FiqQr0Ka/f2H5gjVcuv6hD/YiGnEKvVFft2OHyhyu3OjtRBYYFcOOyLejnDGvrfIz+ludhD+WkhuAe/ZscOEh/odGg67HG1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732044; c=relaxed/simple;
	bh=FgcTwjVLA917bG0WE5CkEo10Yt5O/3MifG+4FCyjWb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+4l46cA0Ra83zdIBHNU6NdcFkrl++YTyf1eAVrYLG6FhINHy0Gmsf8ISDwUWcN3tRETAbT35jO+Vvy4Hc/pdzfhe+Ad1HRYklTDr+cvQbz07q8sHY6TYVieywTGKr115fLFQKRReNTuxaR2QW3P9jSDX/K2AU/208IZAHiYV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqeLqaDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDB5C32786;
	Thu, 15 Aug 2024 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732044;
	bh=FgcTwjVLA917bG0WE5CkEo10Yt5O/3MifG+4FCyjWb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqeLqaDzQDjpn1MoYzmropc9F6ry0NTg6J0X2XQz6tK4K1bQ82D+dKYA6ocO5hI/I
	 XEIWeYybMMnI8camYTjfkvrOgV2SXpri85auHcNIPshem1NfLjvG91ue/ogs4MQcGM
	 037A/KhbwCrNVG7XfsbVpw3zZb0zuI8HokTn01Tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 058/352] gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey
Date: Thu, 15 Aug 2024 15:22:04 +0200
Message-ID: <20240815131921.483633410@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream commit a3123341dc358952ce2bf8067fbdfb7eaadf71bb ]

If we fail to call crypto_sync_skcipher_setkey, we should free the
memory allocation for cipher, replace err_return with err_free_cipher
to free the memory of cipher.

Fixes: 4891f2d008e4 ("gss_krb5: import functionality to derive keys into the kernel")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 726c076950c04..fc4639687c0fd 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -161,7 +161,7 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	if (IS_ERR(cipher))
 		goto err_return;
 	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
-		goto err_return;
+		goto err_free_cipher;
 
 	/* allocate and set up buffers */
 
-- 
2.43.0




