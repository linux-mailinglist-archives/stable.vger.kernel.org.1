Return-Path: <stable+bounces-251176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HdWJsEVDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-251176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEA599479
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE51E31EC5B2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148263DCD9A;
	Wed, 20 May 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QuYhAjpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C73264EB;
	Wed, 20 May 2026 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297297; cv=none; b=jcMdT9NYBw8zg2vYODsNl3SOfv8lNttOY3aixwMarPTEkM9LgLIQzVg5fE5bDwa5vkLO7IQ9B9zYj9rY1/+gXgQRqxPw0m+7dfVoUhGl/D1622otg0hDGIXXWYlY2RpnNE/5+aRiwWQLeHRpA2n6oErvL0uBN9OVIpL1SogxPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297297; c=relaxed/simple;
	bh=D9RySgZvD/HVXFzlfjWG0TmbBTUqTVkSmuS3q1PXFtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqrlAWXhWV4pgXi1rtZo8+txDJYoABL7HA6f88zlQYT7pxKgR7JpqdlbVIUn4pmR2+SkMFHt8vtm8P2CYewEuzduoVHIdO1KLU3rg4bA3JW8kmJ5BMy9zvnTMMAihlv14Vu9wtC6vbQhZ3TRPbc2XuehswTAa0ou1CVLGCZb+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QuYhAjpF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8241F000E9;
	Wed, 20 May 2026 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297296;
	bh=tlMj+JAE8qPcEDDBtDUMY9hCKSTvdCIhz0rgE2X8IHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QuYhAjpFOVUWKATG5FGlbNbDLV53Jd4hHELp5srDEXULpqeAMOqTSQQX5m7WiKqhR
	 juujxb/9TakttHUI2xhxHaGjMcnxnstzN2vjwP5CPWjQiiGDMOOtJnHdYg1bXOMaOU
	 64cD6YpsHbGZ2XGBgFbHHsD/8FwRQeQ9pjaaoOQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 7.0 1124/1146] iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
Date: Wed, 20 May 2026 18:22:54 +0200
Message-ID: <20260520162213.682564750@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251176-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1DEEA599479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicolinc@nvidia.com>

commit 5474e6e17a262db45c60575c73f70210f5c7001f upstream.

In __iommu_group_set_domain_internal(), concurrent domain attachments are
rejected when any device in the group is recovering. This is necessary to
fence concurrent attachments to a multi-device group where devices might
share the same RID due to PCI DMA alias quirks, but triggers the WARN_ON in
__iommu_group_set_domain_nofail().

Other IOMMU_SET_DOMAIN_MUST_SUCCEED callers in detach/teardown paths, such
as __iommu_group_set_core_domain and __iommu_release_dma_ownership, should
not be rejected, as the domain would be freed anyway in these nofail paths
while group->domain is still pointing to it. So pci_dev_reset_iommu_done()
could trigger a UAF when re-attaching group->domain.

Honor the IOMMU_SET_DOMAIN_MUST_SUCCEED flag, allowing the callers through
the group->recovery_cnt fence, so as to update the group->domain pointer.
Instead add a gdev->blocked check in the device iteration loop, to prevent
any concurrent per-device detachment.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260407194644.171304-1-nicolinc%40nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2472,9 +2472,10 @@ static int __iommu_group_set_domain_inte
 
 	/*
 	 * This is a concurrent attach during device recovery. Reject it until
-	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
+	 * pci_dev_reset_iommu_done() attaches the device to group->domain, if
+	 * IOMMU_SET_DOMAIN_MUST_SUCCEED is not set.
 	 */
-	if (group->recovery_cnt)
+	if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEED))
 		return -EBUSY;
 
 	/*
@@ -2485,6 +2486,13 @@ static int __iommu_group_set_domain_inte
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
+		/*
+		 * Device under recovery is attached to group->blocking_domain.
+		 * Don't change that. pci_dev_reset_iommu_done() will re-attach
+		 * its domain to the updated group->domain, after the recovery.
+		 */
+		if (gdev->blocked)
+			continue;
 		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
 						group->domain, flags);
 		if (ret) {



