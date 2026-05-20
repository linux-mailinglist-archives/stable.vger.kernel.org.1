Return-Path: <stable+bounces-251507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCuYGVf4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228059557D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FB083178CFE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDE369999;
	Wed, 20 May 2026 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4PaLTYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0436F421;
	Wed, 20 May 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298161; cv=none; b=NFc5cit3iWT5QAMnakrq+Wj1cFewPU+hQI2uIKHsLe6HtrgsN9xlWs+GsH3hEcFNnkRmcPFCSjhHSAKkdq6d8PviOZ1TDnXSNg/Ax92615ZeW0EAJLTCKA21Pp1miBYbLNFxL9DsU5hwbg9iwX7IhVlS6ZWR0TIe+iiz1bo1La4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298161; c=relaxed/simple;
	bh=48zJNBYg8jL2nPmcR6lSl80SHgQSANhpTkAryZVrbxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpH2l5sRxc0he1SHZlS4QaF+dHucsy3ekMBPBebRsUOqYgLvOaogV12D8Zxk/Koh4jPANbkS/VNsm8qc8i1gE3KXqluIhWaqrnw7BPgraANGBZsAd3HkHCHcsjN5foRMQiAh6AepI5FxnUNZPuXOM086FVCl27Fxs9+7hDvq18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4PaLTYq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689641F000E9;
	Wed, 20 May 2026 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298159;
	bh=JH5NsFzosLLWGHVQrd8l+6c13rFGsaEgI5s8lDM/xYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4PaLTYqIcUKV9eErT9xJxO0/D194qdfau70AGGV804MKfWu1ZDuF1aa1wmcklg5y
	 HA4lu0ERqhsfsQsh6S58eohddPV3yuMh3F6Z6jpFWx0o540fk4sZ4gz65m+hoFGGcF
	 7LQsBail660DGgmv+q4HxSHL2rbpzKLCckZ7MMKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 303/957] crypto: qat - use swab32 macro
Date: Wed, 20 May 2026 18:13:06 +0200
Message-ID: <20260520162141.103628548@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251507-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 6228059557D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 35ecb77ae0749a2f1b04872c9978d9d7ddbbeb79 ]

Replace __builtin_bswap32() with swab32 in icp_qat_hw_20_comp.h to fix
the following build errors on architectures without native byte-swap
support:

   alpha-linux-ld: drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.o: in function `adf_gen4_build_decomp_block':
   drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h:141:(.text+0xeec): undefined reference to `__bswapsi2'
   alpha-linux-ld: drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h:141:(.text+0xef8): undefined reference to `__bswapsi2'
   alpha-linux-ld: drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.o: in function `adf_gen4_build_comp_block':
   drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h:57:(.text+0xf64): undefined reference to `__bswapsi2'
   alpha-linux-ld: drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h:57:(.text+0xf7c): undefined reference to `__bswapsi2'

Fixes: 5b14b2b307e4 ("crypto: qat - enable deflate for QAT GEN4")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603290259.Ig9kDOmI-lkp@intel.com/
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h
index 7ea8962272f2f..d28732225c9e0 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h
@@ -3,6 +3,8 @@
 #ifndef _ICP_QAT_HW_20_COMP_H_
 #define _ICP_QAT_HW_20_COMP_H_
 
+#include <linux/swab.h>
+
 #include "icp_qat_hw_20_comp_defs.h"
 #include "icp_qat_fw.h"
 
@@ -54,7 +56,7 @@ ICP_QAT_FW_COMP_20_BUILD_CONFIG_LOWER(struct icp_qat_hw_comp_20_config_csr_lower
 	QAT_FIELD_SET(val32, csr.abd, ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_BITPOS,
 		      ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_MASK);
 
-	return __builtin_bswap32(val32);
+	return swab32(val32);
 }
 
 struct icp_qat_hw_comp_20_config_csr_upper {
@@ -106,7 +108,7 @@ ICP_QAT_FW_COMP_20_BUILD_CONFIG_UPPER(struct icp_qat_hw_comp_20_config_csr_upper
 		      ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_BITPOS,
 		      ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_MASK);
 
-	return __builtin_bswap32(val32);
+	return swab32(val32);
 }
 
 struct icp_qat_hw_decomp_20_config_csr_lower {
@@ -138,7 +140,7 @@ ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(struct icp_qat_hw_decomp_20_config_csr_l
 		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_BITPOS,
 		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_MASK);
 
-	return __builtin_bswap32(val32);
+	return swab32(val32);
 }
 
 struct icp_qat_hw_decomp_20_config_csr_upper {
@@ -158,7 +160,7 @@ ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_UPPER(struct icp_qat_hw_decomp_20_config_csr_u
 		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_BITPOS,
 		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_MASK);
 
-	return __builtin_bswap32(val32);
+	return swab32(val32);
 }
 
 #endif
-- 
2.53.0




