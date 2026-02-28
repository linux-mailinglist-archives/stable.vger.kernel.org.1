Return-Path: <stable+bounces-220813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MERiM3hWo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:56:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B81C8A1D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DDD349366F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E04128AC;
	Sat, 28 Feb 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBqX4Tl8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAC4128A3;
	Sat, 28 Feb 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300699; cv=none; b=PMbtX8oCQrgH9cGbqAaXS9cRwuqtYS2UsXIN4xzrm/oht2sXIeyktv4LPvhhYoZ6eXiIZct8nxqj5rnVA9AS2kF1JuJFPrDtw2bsXgJRiZFKq26oLV5O0KSgcuLf/7O4BqnVkQjizf+Jwozv5D7hy2zu6FEWT/jhHgHfXhXFwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300699; c=relaxed/simple;
	bh=zmUkgrODlewI86AyQNZRMWa4ZdLSddABDb6WSKeLnjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scD2tbW8ghd1nXscLpV1YuoCQzfUIpchg3HOaHZ29ffrQYS8Z4Y0b+jDhMfIwpRfYMggGX303+tTu89nSj0sjS0+OtGcWaI3pHpfy8z1M58WJqxZcOCJyy+JUf5lKBRZDGkejDU4X0U67rSlVyS5t8hzP5JKPznqFilKAnF6djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBqX4Tl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8525C19425;
	Sat, 28 Feb 2026 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300698;
	bh=zmUkgrODlewI86AyQNZRMWa4ZdLSddABDb6WSKeLnjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBqX4Tl8glZmHrPvOFi3zqTZG9iJMGN/55gRjedHGIuEHXyv9wwALwzRBSDhh0XlX
	 nOMjrdO+iSB0cm2uzXzwr++Hbvs/FD/dPgR4vI8QWcpclvRct8dWI3HdLKGsQTVUn0
	 WMGNXvqHHLuv1vqc1946FHknxp1vnnXFxOHws0c6H2CyGMSPvDj2Ij7zv9SpzLgF4R
	 gt6iuqwuv2mtRrQu89t3UbMothsAwHQ36IrYF57JH6qDDjLYcROH89SsyVSbCxZJuX
	 Aj821CXQwF921Wgh2qGowgatDZGacayGHmMIE716yD/J21jjjccRDzkxFkWHzO4kPa
	 nreSVwiLkfghw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 734/844] iommupt: Always add IOVA range to iotlb_gather in gather_range_pages()
Date: Sat, 28 Feb 2026 12:30:47 -0500
Message-ID: <20260228173244.1509663-735-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220813-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 318B81C8A1D
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com>

[ Upstream commit b48ca920613858b477f75946907e72c74570af05 ]

Add current (iova, len) to the iotlb gather, regardless of the setting
of PT_FEAT_FLUSH_RANGE or PT_FEAT_FLUSH_RANGE_NO_GAPS.

In gather_range_pages(), the current IOVA range is only added to
iotlb_gather when PT_FEAT_FLUSH_RANGE is set. Yet a virtual IOMMU with
NpCache uses only PT_FEAT_FLUSH_RANGE_NO_GAPS. In that case, iotlb_gather
will stay empty (start=ULONG_MAX, end=0) after initialization, and the
current (iova, len) will not be added to the iotlb_gather, causing
subsequent iommu_iotlb_sync() to perform IOTLB invalidation with wrong
parameters (e.g., amd_iommu_iotlb_sync() computes size from
gather->end - gather->start + 1, leading to an invalid range).

The disjoint check and sync for PT_FEAT_FLUSH_RANGE_NO_GAPS remain
unchanged: when the new range is disjoint from the existing gather,
we still sync first and then add the new range, so semantics for
NO_GAPS are preserved.

Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/generic_pt/iommu_pt.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index d575f3ba9d341..3e33fe64feab2 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -58,10 +58,9 @@ static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
 		 * Note that the sync frees the gather's free list, so we must
 		 * not have any pages on that list that are covered by iova/len
 		 */
-	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
-		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
 	}
 
+	iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
 	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
 }
 
-- 
2.51.0


