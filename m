Return-Path: <stable+bounces-250345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMzCKAYPDmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677E598AB3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31749316B7FC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C553328FC;
	Wed, 20 May 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z47oaz/L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7F362136;
	Wed, 20 May 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295171; cv=none; b=kWAeID6VvJwG4nFIjZSAn+VmlbHPigbgqaEChnVrGCBMBDyRj+8oTr0q+4mGUPE9yE5WioBeqJE7FOEyJqQCtLjMtznEu8s21KBSEJwjSMvLlnXsz8mzuFuXk8/CPJwhUr2MSYZv4MH5g9NgoFoG41l/IPGMbsoVuGgNVxDs2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295171; c=relaxed/simple;
	bh=ZSKRSWlQg8i2V+6CNZT6WDgCf4TMnVelzzq560WQIik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn6nQB89I4j+Ptii8p7hKjGGDn8r3dV28FCbYZoyyzqZ/Ywi2FvKPL34EkoZ882beokjuwO1n3WhXMRMwfP7u1JFiCdAoA/62FPzuYqdHPvnvOZw+2T3UL8wApzjXXeoZFdUYy2MAQpvVJ6bg35k6cCTVvRBKT3xmm3LqXWJgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z47oaz/L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B501F000E9;
	Wed, 20 May 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295169;
	bh=LkuTzzNDYjTGeDZL+Keek+7/YFwTjmwecx5wXuGXZT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z47oaz/L8PzykZLhPsJR8wzWwB3rUaMx0zZBKZ/Lmbc2okvKcZSjOinm/79Hqojr/
	 RqYRN6V3f+y0r7gqMwjvJjo4gt9XKAmky82nrUgYMhCvac4chLrKBbJEGD0OMfZy6R
	 5ZiPv0ev796UsJodhEGw7z/nQOBxYHJ/xbJq3IFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0317/1146] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement
Date: Wed, 20 May 2026 18:09:27 +0200
Message-ID: <20260520162155.370379065@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250345-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 2677E598AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 1dafbc552d37d..f63edbe71d542 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1052,6 +1052,11 @@ struct iommu_fault_alloc {
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




