Return-Path: <stable+bounces-218383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3IAVdTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B5318F7CC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C918C30BD880
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BC24677D;
	Wed, 25 Feb 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbqbCHzZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0A1D5ABA;
	Wed, 25 Feb 2026 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983196; cv=none; b=RkUyulnSxXRCoP/ee/ulrT7j7IZPg+W1vNZcX7hjIpFXMqS8pKT1/RHQ+6kUS1nuBbN1sC2ZYLXFNT+WQWy63oucN950rhTwreHMtVE3bQ5n+hP80FsxvO26Bqa7hORa5WI9/hzN/wq297aLwRxO0rjEQ/nbCWlT+5x9JdM5Rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983196; c=relaxed/simple;
	bh=Wer5fbjrJemGTZbBlj1lBB81gELNZGweG1cz0Mu5Lgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6TYl8z0GybjA79jFRzNlkH9uUnknIpnxnkvMe1ORF1XCtPN7O5gsP/1zlb53MxtErcpFBg9ejEoMauWeoZkCTOgBGpXHBdy/aGOV2HWZL9uwVXUpx5EeQ/RP+C+Yp0SUX6ktoAOJFYBPIQ33Lh4diujtFdPNDlDe6saKbUs0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbqbCHzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5516C116D0;
	Wed, 25 Feb 2026 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983195;
	bh=Wer5fbjrJemGTZbBlj1lBB81gELNZGweG1cz0Mu5Lgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbqbCHzZ0aYtkrjwiHtjaVE1eECX0QAojtqyDoomP51XjzSvo2aQcOe9Ig2Q1jxXh
	 piDY+3dvBnLKbURb+ekwhqJT1od63YNFollSDFDC3Iye2rMqK9M7wR5AFoIlB5oXVP
	 tfspP7Tao1gvbJBZfGLXAMjmICq1dJ5oryQWDkDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Wei Wang <wei.w.wang@hotmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 343/781] iommupt: Do not set C-bit on MMIO backed PTEs
Date: Tue, 24 Feb 2026 17:17:32 -0800
Message-ID: <20260225012408.106090222@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nvidia.com,hotmail.com,intel.com,amd.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218383-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 33B5318F7CC
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <wei.w.wang@hotmail.com>

[ Upstream commit e2692c4eeaa4bd945b7bae156b4cac55d6a0c730 ]

AMD Secure Memory Encryption (SME) marks individual memory pages as
encrypted by setting the C-bit in page table entries. According to the
AMD APM,any pages corresponding to MMIO addresses must be configured
with the C-bit clear.

The current *_iommu_set_prot() implementation sets the C-bit on all PTEs
in the IOMMU page tables. This is incorrect for PTEs backed by MMIO, and
can break PCIe peer-to-peer communication when IOVA is used. Fix this by
avoiding the C-bit for MMIO-backed mappings.

For amdv2 IOMMU page tables, there is a usage scenario for GVA->GPA
mappings, and for the trusted MMIO in the TEE-IO case, the C-bit will need
to be added to GPA. However, SNP guests do not yet support vIOMMU, and the
trusted MMIO support is not ready in upstream. Adding the C-bit for trusted
MMIO can be considered once those features land.

Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table format")
Fixes: aef5de756ea8 ("iommupt: Add the x86 64 bit page table format")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/generic_pt/fmt/amdv1.h  | 3 ++-
 drivers/iommu/generic_pt/fmt/x86_64.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index aa8e1a8ec95fd..3b2c41d9654d7 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -354,7 +354,8 @@ static inline int amdv1pt_iommu_set_prot(struct pt_common *common,
 	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
 	 * control this. For now if the tables use sme_set then so do the ptes.
 	 */
-	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES) &&
+	    !(iommu_prot & IOMMU_MMIO))
 		pte = __sme_set(pte);
 
 	attrs->descriptor_bits = pte;
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
index 210748d9d6e8a..ed9a47cbb6e02 100644
--- a/drivers/iommu/generic_pt/fmt/x86_64.h
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -227,7 +227,8 @@ static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
 	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
 	 * control this. For now if the tables use sme_set then so do the ptes.
 	 */
-	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES) &&
+	    !(iommu_prot & IOMMU_MMIO))
 		pte = __sme_set(pte);
 
 	attrs->descriptor_bits = pte;
-- 
2.51.0




