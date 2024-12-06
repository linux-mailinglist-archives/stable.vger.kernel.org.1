Return-Path: <stable+bounces-99312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE59E7125
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388041884917
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D97149C69;
	Fri,  6 Dec 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHKh8gsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D721494B2;
	Fri,  6 Dec 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496735; cv=none; b=ZHXdpCQ+Gm1ryyqHoOwjyaA4rN2PKGUctbLmRK6baXJ/ujHVA+FBe9uVVQvipstAT7EB+KtLK3B1GbOWdOUi2phya6tvg44XixR7BdkYhBirDuz4UJyLtSWIgy7f4JHq1CNkXAniBCXlWUoPaC7/FR3LMQXDnrEie+zSfTm7iFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496735; c=relaxed/simple;
	bh=zKlJCFMTlR+HWCnwf1rj3adk33EcHpxTdYosMQRqICk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSayktIkCsiV6kK41NW4M9CYZdRIZJVxBNOs4HREznvyj4j+8VzxRgPTp5DlOPklARDYRU2f1wRgME3NLscSt83iys1OvUz4mjM+CpvUNm6ktR+6iN8klGoE6k9EZENhfeFngMkSMO36+DU+7/y5AzGJVkipORDqtDPAqnhsFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHKh8gsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B2C4CED1;
	Fri,  6 Dec 2024 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496734;
	bh=zKlJCFMTlR+HWCnwf1rj3adk33EcHpxTdYosMQRqICk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHKh8gsMkwhmY6WwkYXMvIx3Gcl58Bm56HN31F3Y5qWblEIfymahzxzq3F3Tq7SD8
	 fjxmqJ+4g2z4z0Z5sTtXVRJGmW6GUcYa7LZ6IWgU3qcRVFMEFdUGFlyPzsYOqUg8rH
	 nNsYiOP7orv+39LO5ovlumDxrJ1kiDXPIXTH+uI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Everest K.C." <everestkc@everestkc.com.np>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 088/676] crypto: cavium - Fix the if condition to exit loop after timeout
Date: Fri,  6 Dec 2024 15:28:27 +0100
Message-ID: <20241206143656.797303565@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Everest K.C <everestkc@everestkc.com.np>

[ Upstream commit 53d91ca76b6c426c546542a44c78507b42008c9e ]

The while loop breaks in the first run because of incorrect
if condition. It also causes the statements after the if to
appear dead.
Fix this by changing the condition from if(timeout--) to
if(!timeout--).

This bug was reported by Coverity Scan.
Report:
CID 1600859: (#1 of 1): Logically dead code (DEADCODE)
dead_error_line: Execution cannot reach this statement: udelay(30UL);

Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engine")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 6872ac3440010..ec17beee24c07 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -44,7 +44,7 @@ static void cpt_disable_cores(struct cpt_device *cpt, u64 coremask,
 		dev_err(dev, "Cores still busy %llx", coremask);
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
@@ -394,7 +394,7 @@ static void cpt_disable_all_cores(struct cpt_device *cpt)
 		dev_err(dev, "Cores still busy");
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
-- 
2.43.0




