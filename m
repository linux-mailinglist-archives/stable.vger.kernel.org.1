Return-Path: <stable+bounces-113080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA80A28FD6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5379188261F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDD155A21;
	Wed,  5 Feb 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guPqHz5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB9522A;
	Wed,  5 Feb 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765756; cv=none; b=O5Upb8hPrbM24hiS/RjH5tsVDc3c8IPmXuaid4NZfq6X3IGEke48TOCxM1nv4OlomT5XM+mWl2k5xIgdv33DtnOcp931P2zc7qwR5Y2iLgHpk5ORIzVPvdRc3UTd2+tleGwx0CyDH9UWkE7Zq72S/i5JgKipaP3AtHWLWgD25Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765756; c=relaxed/simple;
	bh=ZNUqXUi8bTOz805HsipqFnhBMTtloF1GkLLJTM8KB44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEbGxm0McdzVNw9a65nTXsEqJNDjwi6eTRe/lhc9XJe4yY8SsZ2PdXJLI3xytIYCh+tTATyoETDDEKUP82lQIcbqUOUTQVrQ/V5S8SUeS9swWKjy7kAfk4sD73AvdQAO9B1NG+5mrfVT0oBH4EhhUtupDdbyudPJG+fP6ADdeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guPqHz5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DEDC4CED1;
	Wed,  5 Feb 2025 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765755;
	bh=ZNUqXUi8bTOz805HsipqFnhBMTtloF1GkLLJTM8KB44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guPqHz5wSY9ssUpxuCrLmk+DrUt/4XAraztMIgMFN+6dlF7PFd9VizhyRbka3AHcq
	 6XxmcNHWEHwkirNIuH1TmrFWcxkwM3OiF3C/D+uZv/opK86svR9Qd7Sqw3o+eeiwpz
	 TgsNdCB0/kKnwFLW45vd5eNr5Chgl4qakKvlrHa0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 249/590] crypto: caam - use JobRs space to access page 0 regs
Date: Wed,  5 Feb 2025 14:40:04 +0100
Message-ID: <20250205134504.807387205@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Jain <gaurav.jain@nxp.com>

[ Upstream commit 73a7496c218b7ca19ba276f54758e7f0adf269c5 ]

On iMX8DXL/QM/QXP(SECO) & iMX8ULP(ELE) SoCs, access to controller
region(CAAM page 0) is not permitted from non secure world.
use JobR's register space to access page 0 registers.

Fixes: 6a83830f649a ("crypto: caam - warn if blob_gen key is insecure")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/blob_gen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 87781c1534ee5..079a22cc9f02b 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2024 NXP
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -104,7 +105,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 	}
 
 	ctrlpriv = dev_get_drvdata(jrdev->parent);
-	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->ctrl->perfmon.status));
+	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->jr[0]->perfmon.status));
 	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
 		dev_warn(jrdev,
 			 "using insecure test key, enable HAB to use unique device key!\n");
-- 
2.39.5




