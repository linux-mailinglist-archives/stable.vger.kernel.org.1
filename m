Return-Path: <stable+bounces-116880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD68A3A978
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A24816A2DE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E52144D7;
	Tue, 18 Feb 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odgzPJA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB572144C9;
	Tue, 18 Feb 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910439; cv=none; b=uyinVsH2/LKBJ0hYHbqNaWVrvG/nelesRLNU+4oY3brWEaJ/yu+Vi/3pC1wNGqYOGHg9u+5QPyIvIyupAvBurS48aL+EfrecUyekbog5eF7gXWe/zE/2YCeB97S6Sccf+TMwIDI+2nFxyz+HkdXQhFoislVR2JYxMtg+uA6RHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910439; c=relaxed/simple;
	bh=M0IrEwfhk3Ww4fkOJEqrwcuhSN2tamd0Xb8zp06AIgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqeiK/Pc9vm7p/B9h1aXCRXp4IpPZvYLWXK0HrOmXAm+KMUYVIySV0Rhh2v1mu4p5LT8cSECZiecBnLzfPfZt9pPCeqaK2JgwieTi8KptpHiotS2+MSv5wLjwCW0Qt/P+83+elBvD+Md0jIqOYGuIA+H8/HqWSn5iEcl2Ya4xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odgzPJA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA1C4CEE2;
	Tue, 18 Feb 2025 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910438;
	bh=M0IrEwfhk3Ww4fkOJEqrwcuhSN2tamd0Xb8zp06AIgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odgzPJA4hOn4TeEDrEys2logFdXZGa0Y2cgk11TPkdsFzYboiVlJPHaqRXvkMZ/ia
	 wdTixwikhXfGxxineqcjJrOCG7/TDyfuf8E2vITdZyWqwJeveGs4xXBvilr7q8Q2bx
	 owcVRcI542xo2Ql4e0UEelcCgXZBJPzZK5Ucu3PGmADI/zcoAp6oZNwb4ngNm03/MF
	 SORyR1Z1X6Zi+Q2X4ZFUcni61aTqCbglZkGVVlbeHj5j2fNAjLcoDIUIWt3GN78Czd
	 H77+tsBzDVw8n9EL1GEVIIgR4r6gLTcTLMuYySDEmAohdhA3YAd0h6BD7Xe/POJ6+p
	 nRMZcJg4jQKHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 27/31] Xen/swiotlb: mark xen_swiotlb_fixup() __init
Date: Tue, 18 Feb 2025 15:26:13 -0500
Message-Id: <20250218202619.3592630-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Jan Beulich <jbeulich@suse.com>

[ Upstream commit 75ad02318af2e4ae669e26a79f001bd5e1f97472 ]

It's sole user (pci_xen_swiotlb_init()) is __init, too.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Message-ID: <e1198286-99ec-41c1-b5ad-e04e285836c9@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a337edcf8faf7..5efc53475f039 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -111,7 +111,7 @@ static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
-- 
2.39.5


