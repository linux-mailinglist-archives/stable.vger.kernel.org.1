Return-Path: <stable+bounces-168461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7193B234F3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF19616733B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463402FD1A4;
	Tue, 12 Aug 2025 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usW+XVvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEF13AA2F;
	Tue, 12 Aug 2025 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024249; cv=none; b=JDrfHBmdI8ln/BO1AOkeeZpQ4iiIgEPc3hRMRjz9LSltvjX0XJ4425JEZTo87Ovcp6fefay3dqlN6NsEBSV7vNzZhKaYre4gwopGn/9PRmwa8GG5m6Re6CxmrrVYKWEtgXvq1uMAnTx/IYHnxxohxvaWk9MANee4P3w2YrQW98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024249; c=relaxed/simple;
	bh=MDgXqq3TfH3t5m9y5xEOcpjpe/OEHwce4CZL+8PaqP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwNwuUVCtoXq4gfOsVathoAPLp8+HFwXLJcmPaRmy2v0m/ZXad3un7XE+XNBO28I7FtZagUMaLyLBCXI1Rcbt78eIHPyr4pr1t/UZF96sciIppWdFQGqv37xeLklqT1XcGa2vV7etkv8UIQIBEhXnb4tBpFxkvOBdZHo9FY60PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usW+XVvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B98C4CEF0;
	Tue, 12 Aug 2025 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024248;
	bh=MDgXqq3TfH3t5m9y5xEOcpjpe/OEHwce4CZL+8PaqP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usW+XVvvEd7sRq7h+KK06FhjsT0u8ujR4AW66+hEZOenkWwZ8AjwTH9wYlbYlYmj/
	 KrBt4u9n/rou3jJPZxOCtGlsZ6rSHkFcmFzfVuIflyCuTUUNXSriDlvE42mGhP1dHs
	 KB6Mz/HdYqVv8gFTWK9KL2NGfKbny33Hw86Rks7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 310/627] crypto: qat - fix state restore for banks with exceptions
Date: Tue, 12 Aug 2025 19:30:05 +0200
Message-ID: <20250812173431.098616912@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>

[ Upstream commit 254923ca8715f623704378266815b6d14eb26194 ]

Change the logic in the restore function to properly handle bank
exceptions.

The check for exceptions in the saved state should be performed before
conducting any other ringstat register checks.
If a bank was saved with an exception, the ringstat will have the
appropriate rp_halt/rp_exception bits set, causing the driver to exit
the restore process with an error. Instead, the restore routine should
first check the ringexpstat register, and if any exception was raised,
it should stop further checks and return without any error. In other
words, if a ring pair is in an exception state at the source, it should
be restored the same way at the destination but without raising an error.

Even though this approach might lead to losing the exception state
during migration, the driver will log the exception from the saved state
during the restore process.

Signed-off-by: Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>
Fixes: bbfdde7d195f ("crypto: qat - add bank save and restore flows")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 0406cb09c5bb..14d0fdd66a4b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -581,6 +581,28 @@ static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
 	ops->write_csr_int_srcsel_w_val(base, bank, state->iaintflagsrcsel0);
 	ops->write_csr_exp_int_en(base, bank, state->ringexpintenable);
 	ops->write_csr_int_col_ctl(base, bank, state->iaintcolctl);
+
+	/*
+	 * Verify whether any exceptions were raised during the bank save process.
+	 * If exceptions occurred, the status and exception registers cannot
+	 * be directly restored. Consequently, further restoration is not
+	 * feasible, and the current state of the ring should be maintained.
+	 */
+	val = state->ringexpstat;
+	if (val) {
+		pr_info("QAT: Bank %u state not fully restored due to exception in saved state (%#x)\n",
+			bank, val);
+		return 0;
+	}
+
+	/* Ensure that the restoration process completed without exceptions */
+	tmp_val = ops->read_csr_exp_stat(base, bank);
+	if (tmp_val) {
+		pr_err("QAT: Bank %u restored with exception: %#x\n",
+		       bank, tmp_val);
+		return -EFAULT;
+	}
+
 	ops->write_csr_ring_srv_arb_en(base, bank, state->ringsrvarben);
 
 	/* Check that all ring statuses match the saved state. */
@@ -614,13 +636,6 @@ static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
 	if (ret)
 		return ret;
 
-	tmp_val = ops->read_csr_exp_stat(base, bank);
-	val = state->ringexpstat;
-	if (tmp_val && !val) {
-		pr_err("QAT: Bank was restored with exception: 0x%x\n", val);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.39.5




