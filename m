Return-Path: <stable+bounces-260500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QB3xK56GIWpwIAEAu9opvQ
	(envelope-from <stable+bounces-260500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:07:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20AD640ABC
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I3T6SXkB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260500-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260500-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434D63046EB2
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB047ECCB;
	Thu,  4 Jun 2026 13:50:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1624014A1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581054; cv=none; b=Y2aDSr6jL+95w/aMWYt4VG5l+ww1Z3zC7xl4QSpGBNt+HP7qTdq6jxyn+LUPD8GsvNk/+YFQdb/Raa9XLV3T61/MAnWid1z7ddtuvYPkbg6gmErMLVAOGDj71HEo3Rd+9fd9mpQL7GUtaGAzycjqRosFCb7XqZDUoHHEQ0DDjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581054; c=relaxed/simple;
	bh=/jdjsxvL4aeTdyRjLTf+GIij/Stt3VATxC7ctZWpQBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXrD0fJIIB4OxhJswCyFCC2oRK3SKhPXitSYrr8A4EztqelRyOJv7SD+PauTVkp1PkmtVjgj8Sujk3AWlWaly/5CG7pNjcO1oKqnxuhOjxFg64SwCxkWq5UU2Ht8j3Gwn9fDzk1OTMPDrfWqIu2wNKe0bH8xMLJi/4wzf0/vbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3T6SXkB; arc=none smtp.client-ip=209.85.208.179
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso6635341fa.2
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581051; x=1781185851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLp8sJf8fzDOqqtj5uwx1QYbggbPxRQslMsoXQj9LcU=;
        b=I3T6SXkBJtSDYCdxjpb+Efp2vUCoJIT7QLEqybbV7u83QzaoUjvsvRm1lw95ZTi5um
         AwdYaiQLVY1h1yfr/3nU/164ZeRq5Y6XFOgh71ydAvBYiupcXizwDrISC/DvRYXoHafs
         NhYlDlyJdOCbQlqufrLPp+Zl1xFijRGF/A8HwpQ2SJDuxPrieS5/VBEfCIk6EisflSHv
         /gDUVv3wMk/FFa0i+t85HhgAhGNKvUWQM+uyFfHf7R99HdLDsqTVu1OdKxHUpGmPjMOt
         mNMttCjZpU70WimMKmHPGsmBlNy6yey3olFwZuy9rwi7LqxkCfuZLeeZYqtRYeA8Mdgs
         jhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581051; x=1781185851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLp8sJf8fzDOqqtj5uwx1QYbggbPxRQslMsoXQj9LcU=;
        b=SZE1F2tDj4rNDKQ8OcBcy1uSLlEJIADWQE4FCj68yNlaTqkaTg1qrAx4i0QCQi8/SI
         NO+Og+4Gx4Dtv3qxHAlU73SRDkhKBS5TZEdQ7hLzuyQzzHEbwfHi2ETMKsuLeQafxnnI
         3sOb349yStbvpuZ15wm0Ade6+GoWWWNBfPkZe4GCAiXPu5QasIH8bffBja4GdWXWtLMO
         XaQjJ7xS2lFcPhj7bwpBR1V3gpMtDV2bWN0pJ01btu36DG7o5zUgLCKz1M7Gt/5mXQK5
         C04agTTP11PIYTl1zHIZBIfL8rBl1DoxCsU5k3Aa6uVm5S/P/fAgaB4296tudMP8RimO
         31Hg==
X-Gm-Message-State: AOJu0YyjChm9T85hUCO6YRRrrm1YaLC/2bQwm+ydLbwknkpQJgXPl+WG
	e/iwze6WDCTmHjdBqkz/fu6Ny6teQDLi+yprbXZykpfwmKaHTZFpr5mGfWVCv7W+
X-Gm-Gg: Acq92OEd+5BHsOodL9IB4tVFWTKzI/WOBR3+10Iuen3dSmvJAVZM9akZPYXqPO/cB6w
	9Tj+8poCgN4+IH2zG6qmta5Mui6FJK6cUAOHVc22V2Ba6iHqeOI9gza2JETT08Fu840BElr0spT
	yQhEfQ/EhkY2g6wknEpDtmEbQTqKSbLGeTZW+jhxWBty17WUIRfqjiYZcUj+4lQ3YyAPnnbyBCC
	wKg1Xl211Xtgnxxi8yoJNoHjHtL1uTTq2ky/7/xyj/7WPP24kjGT3bNmvDc4xeBTNMEZ+9rRH/L
	bdNl5MkBDpYH1mXffhMPTXavlhA98T9HTAgILfSe4EvaVHZLBY1PKsmPj/eAA/L/tWJz1ED5cBL
	rBnuhoeXCLw91rGuKs2bH9bgB9u/OvZk8Km2cFYRbFUpB3Lc28koBo94OmTAKp35VChD9OfED+P
	4aXi/cyo4Z6rpOXDpkqROwsQR0Az8LmcQs33eoY1EOFtQh2UZuQg==
X-Received: by 2002:a05:651c:2226:b0:38d:e220:8daa with SMTP id 38308e7fff4ca-396af063d37mr26758341fa.3.1780581050660;
        Thu, 04 Jun 2026 06:50:50 -0700 (PDT)
Received: from dschervov-lin.yandex.net ([2a02:6bf:8009:1404:e250:47f1:a6b5:92c5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2e9a9esm16038051fa.36.2026.06.04.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:50:50 -0700 (PDT)
From: Dmitrii Chervov <fary.ru@gmail.com>
To: stable@vger.kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH 6.12] iommu: Skip PASID validation for devices without PASID capability
Date: Thu,  4 Jun 2026 16:47:53 +0300
Message-ID: <20260604134753.57739-1-fary.ru@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260500-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[faryru@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faryru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,suse.de:email,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D20AD640ABC

From: Tushar Dave <tdave@nvidia.com>

[ Upstream commit b3f6fcd8404f9f92262303369bb877ec5d188a81 ]

Generally PASID support requires ACS settings that usually create
single device groups, but there are some niche cases where we can get
multi-device groups and still have working PASID support. The primary
issue is that PCI switches are not required to treat PASID tagged TLPs
specially so appropriate ACS settings are required to route all TLPs to
the host bridge if PASID is going to work properly.

pci_enable_pasid() does check that each device that will use PASID has
the proper ACS settings to achieve this routing.

However, no-PASID devices can be combined with PASID capable devices
within the same topology using non-uniform ACS settings. In this case
the no-PASID devices may not have strict route to host ACS flags and
end up being grouped with the PASID devices.

This configuration fails to allow use of the PASID within the iommu
core code which wrongly checks if the no-PASID device supports PASID.

Fix this by ignoring no-PASID devices during the PASID validation. They
will never issue a PASID TLP anyhow so they can be ignored.

Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Dave <tdave@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20250520011937.3230557-1-tdave@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

[ Refactored to apply cleanly without support attaching PASID to the blocked domain ]
Signed-off-by: Dmitrii Chervov <fary.ru@gmail.com>
---
My greeting to you LTS maintainers! This is my first kernel patch.
I did a manual backport because cherry-pick failed (6.12 LTS did not have
this series: https://lore.kernel.org/all/20241204122928.11987-1-yi.l.liu@intel.com/).
This patch is tremendously helpful for Nvidia Grace servers. Without it
their GPU direct technology did not work.

 kdrivers/iommu/iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ad55649e2d0..62e1d6372503 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3341,9 +3341,11 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
-		if (ret)
-			goto err_revert;
+		if (device->dev->iommu->max_pasids > 0) {
+			ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+			if (ret)
+				goto err_revert;
+		}
 	}
 
 	return 0;
@@ -3355,7 +3357,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 
 		if (device == last_gdev)
 			break;
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0)
+			ops->remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3368,8 +3371,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	const struct iommu_ops *ops;
 
 	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0) {
+			ops = dev_iommu_ops(device->dev);
+			ops->remove_dev_pasid(device->dev, pasid, domain);
+		}
 	}
 }
 
@@ -3403,7 +3408,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		if (pasid >= device->dev->iommu->max_pasids) {
+		/*
+		 * Skip PASID validation for devices without PASID support
+		 * (max_pasids = 0). These devices cannot issue transactions
+		 * with PASID, so they don't affect group's PASID usage.
+		 */
+		if ((device->dev->iommu->max_pasids > 0) &&
+		    (pasid >= device->dev->iommu->max_pasids)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-- 
2.43.0


