Return-Path: <stable+bounces-246518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCDKAittA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:10:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA581526F5F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D057230492A9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AAF373BF4;
	Tue, 12 May 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBlmkfvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5E368972;
	Tue, 12 May 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609432; cv=none; b=pWneiAT4/+YmEXtk+g1jYPjA7SQEiDN2VgbrGkP+vtk4xHKDajyDC8wmGbLLkEzqOHhfSSn5kpPSRB/wo1/U58f4x/wJSnJKLiNH4dbqe5u5zo14tzHjBsGEpctrrmcJYR6qPHkin7bPvWQl6rZamcNjRKg21A6EDFNUqJruxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609432; c=relaxed/simple;
	bh=d5NaTR9EGGwb/O/gOdxzxOVXYSvFu3Rj+PyjBdnMREQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5VZzU6rMNGoflzOn9J6ZVldfmsC9ajoods15rjY1POK5DXLBKZxCuoqCxSsICUyKmIii5jAhb/l7DgdokPH+AqLn9ANObd9ZlSrHgAYI5+cITp2Lx8mQXvbVOXjhsqraINoXgpLZ7NIZssCzhoWAHzoWgW/+/F9Aa9apcLIkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBlmkfvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BFBC2BCB0;
	Tue, 12 May 2026 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609432;
	bh=d5NaTR9EGGwb/O/gOdxzxOVXYSvFu3Rj+PyjBdnMREQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBlmkfvJT3tz+TH3Rs8gGENrnG62nYamE/ScRrG44cdJQQmV5pvHQSWFd9AKV6n6C
	 nBf71h5OB9VArSvS5XdM7s0HiW326XEXDORQ4W2d5Fef9Vml4EkH8ubuQoMqaNPayL
	 owbc4ejiKK+BQ6J3RQf+vxYYbXBpWFIo91+D8lP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 7.0 192/307] iommu/vt-d: Block PASID attachment to nested domain with dirty tracking
Date: Tue, 12 May 2026 19:39:47 +0200
Message-ID: <20260512173944.169445752@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CA581526F5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246518-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

commit cc5bd898ff70710ffc41cd8e5c2741cb64750047 upstream.

Kernel lacks dirty tracking support on nested domain attached to PASID,
fails the attachment early if nesting parent domain is dirty tracking
configured, otherwise dirty pages would be lost.

Cc: stable@vger.kernel.org
Fixes: 67f6f56b5912 ("iommu/vt-d: Add set_dev_pasid callback for nested domain")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20260330101108.12594-2-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Fixes: 67f6f56b5912 ("iommu/vt-d: Add set_dev_pasid callback for nested  domain")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/nested.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(st
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(st
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	if (s2_domain->dirty_ops)
+		return -EINVAL;
+
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	ret = paging_domain_compatible(s2_domain, dev);
 	if (ret)
 		return ret;
 



