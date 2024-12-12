Return-Path: <stable+bounces-101821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EE9EEEC7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585DE188F82A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF629217F34;
	Thu, 12 Dec 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3KFMR/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0210F2;
	Thu, 12 Dec 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018918; cv=none; b=l6A5W/JfsUBiddJvlECJUlX9cxTy3LmoSyvdCF0prBM/A7dPkzGOQtqaDxusQDGthd1DoN8z5Ta9VrY6rDGTZT+pOzrB+RpovkyIwXIwLYoukFbOvbebS4RYotxNasOzXMstb2Wj5WCDohvEPgkvRlOF+S0ZOHAiTLRFngV20Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018918; c=relaxed/simple;
	bh=CNJmhWXTimY/DMvqrJmXWPvmTEQDfexwtPNFqUjwUJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApCPttKfU961EV98u1jE1PNaAzxnI+/7/wdNU28mjJs0mvxyTDMfOGktehWos4G+NHDyqDhZsjDJFW703RcTrso+vjdFLPCY7HYjCwrbipeh1fS7+9Amys+sQjmuqLnbvH2BrECa9ZfscvspmWPLWdquToWtHSB2uXc/Zr6cOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3KFMR/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876CC4CECE;
	Thu, 12 Dec 2024 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018918;
	bh=CNJmhWXTimY/DMvqrJmXWPvmTEQDfexwtPNFqUjwUJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3KFMR/789UAIZjvcDJzMETfTjb3z857lxTPcHVt8m7gF2J8pSsDSmbkzbkKVIzyq
	 qyk2egsnLFtPAOzSMEHk4kyPShDtGJDhIQB6Eav6XcEVVjT9+DPEacvmT/dAqKc/08
	 hIQ6s9yX8A7/1Qxf7wSkGP5MnJ3ZUQ2Kr7LTBJps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ahsan Atta <ahsan.atta@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/772] crypto: qat - remove faulty arbiter config reset
Date: Thu, 12 Dec 2024 15:50:15 +0100
Message-ID: <20241212144352.826386452@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Ahsan Atta <ahsan.atta@intel.com>

[ Upstream commit 70199359902f1c7187dcb28a1be679a7081de7cc ]

Resetting the service arbiter config can cause potential issues
related to response ordering and ring flow control check in the
event of AER or device hang. This is because it results in changing
the default response ring size from 32 bytes to 16 bytes. The service
arbiter config reset also disables response ring flow control check.
Thus, by removing this reset we can prevent the service arbiter from
being configured inappropriately, which leads to undesired device
behaviour in the event of errors.

Fixes: 7afa232e76ce ("crypto: qat - Intel(R) QAT DH895xcc accelerator")
Signed-off-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_hw_arbiter.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
index 64e4596a24f40..fd39cbcdec039 100644
--- a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
+++ b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
@@ -90,10 +90,6 @@ void adf_exit_arb(struct adf_accel_dev *accel_dev)
 
 	hw_data->get_arb_info(&info);
 
-	/* Reset arbiter configuration */
-	for (i = 0; i < ADF_ARB_NUM; i++)
-		WRITE_CSR_ARB_SARCONFIG(csr, arb_off, i, 0);
-
 	/* Unmap worker threads to service arbiters */
 	for (i = 0; i < hw_data->num_engines; i++)
 		WRITE_CSR_ARB_WT2SAM(csr, arb_off, wt_off, i, 0);
-- 
2.43.0




