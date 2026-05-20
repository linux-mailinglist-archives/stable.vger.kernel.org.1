Return-Path: <stable+bounces-251441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HQxMub8DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23534596296
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73ED0321B646
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA88369999;
	Wed, 20 May 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zO+TfGR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C437754D;
	Wed, 20 May 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297989; cv=none; b=Rhl1O6nClIbg/pyZxhbvzw4YanW30lg23SLnM4OeVZ9w4P9G/Yx0Q8nHYCOGTBTPhT23bnUQx2dWQuTv3cimB/iCN57n5QmpH1wZdj2yZikqIOB4kc4AqQlLS1imvK7VxcDhN8DQZfcvS/mDc4nQxwDZOgpxNm47BJduANOwxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297989; c=relaxed/simple;
	bh=nBOkaoH6Sr0/HMQ1iztS1PnSx5puUYBzWisrhRg3/tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R50G/9OreUabg8uzU9efxB58Us9gt88sdfOftNk0pyIjVntTSrsQ8LvIdrlbjiRfatSIjUi3H4Y06iF1vyeSUllqwW6KOQN1OkoS2setvmC2B0iVJ5wvcJR9CrHuF4lySlXXzhHTjNMfy9srH4vNQGQsaBrSjzWwKYrMV+f9A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zO+TfGR9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AEF1F000E9;
	Wed, 20 May 2026 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297988;
	bh=hT/g/aFk9k61bpkmFDcPDyk0PRfFb+4QC9OyBHMDT2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zO+TfGR9bHVHrr2rpXgyBcBYocWHhtAx9CjlqfaEg3qJgsDQzTRLuowi9Pa4LZkMn
	 k3cpuNur9Z7rtbA9Pkts3Kpgexpi6EfZyCOAZyR0pabTiiEH1wEn73sgHFFsq2UYgk
	 3ktKbGnQCJejej4HiPPhdBZhE9hhgYxlN0DKXMw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 240/957] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement
Date: Wed, 20 May 2026 18:12:03 +0200
Message-ID: <20260520162139.747317625@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251441-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 23534596296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 9dcef98dbee35b8ae784df04c041efffdd42a69c ]

>From hardware implementation perspective, a guest tegra241-cmdqv hardware
is different than the host hardware:
 - Host HW is backed by a VINTF (HYP_OWN=1)
 - Guest HW is backed by a VINTF (HYP_OWN=0)

The kernel driver has an implementation requirement of the HYP_OWN bit in
the VM. So, VMM must follow that to allow the same copy of Linux to work.

Add this requirement to the uAPI, which is currently missing.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/iommufd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2eb..bdd20666d1eb1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1003,6 +1003,11 @@ struct iommu_fault_alloc {
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise, VCMDQs will not work)
+	 * - Kernel will allocate a VINTF (HYP_OWN=0) to back this VIOMMU. So,
+	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
+	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
 };
 
-- 
2.53.0




