Return-Path: <stable+bounces-71672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51122966CE8
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 01:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB3284793
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5617C215;
	Fri, 30 Aug 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b="ENT1QPmF"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4217C23D
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060642; cv=none; b=VjZ+QVH++TwFLeVGKNfh7p2giiCAOCUmqXXPkLV0P7/L2R3rHML7tsMS/Oc0jq3N3hC4Jr2vfru+s9XgUzPbwpzGHkdR7a4LJpT0jajFzjurkDOVlGh837kb9anD+TBtjo98gwLZuuX5bx2zQnqPm+/ACVAbkKfeGUutJbKDoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060642; c=relaxed/simple;
	bh=uLrfxgwqjiaYE9ovkvZkzn6Ngud3Ys9StxoJC8XrqLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IH1CNhqQMb1lvMddOYgc0+BXSMSTOb+luhbbna4USxkh/nnHMTS2ltClKQ5VjPcg1iz9L9g0735kv5pyh5tZQI170Iev1g0Bx7eHgkNBf2tDbGAWRpMwtLetWx4lDjtk/DFA4VfQc5jlE9+j5daGQHpPyoFYuZPOxxdf6Yanmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space; spf=pass smtp.mailfrom=ariadne.space; dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b=ENT1QPmF; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariadne.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariadne.space;
	s=sig1; t=1725060639;
	bh=+ZGjzB8myPGZq7UdYHhHF08xgSd8N+m6KXIfvSK4N+k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ENT1QPmFYWW7Jf78k/QToVrvZn08ffbznL+BoGn/c301DXE8VpwLvu8r+n2aRC3yR
	 c/WEY1SBrUm4XSKV6Y8yZXuux1mJI4EtNjuVJErswv1YM1zKJpfUmJXq7iPSS+6tjL
	 iQ97z2DzyCVu4Y0tN77vUK1rwTKYd6iofDfi+Sd7MfZMeWrHLp9pfxeOvBzYcPDxy/
	 sOCNP8pjJ3Q4wT0IHxOngLRbpLbmNcYMsooSB+eBp55V8QgpWvYqutqBrmRxpPtNmI
	 mMDo1faK65Q5ZnCuTf4jP7LOwppELghnH9T9K060DDeY5SVzg3Kftc2G0GRhROleOe
	 rP/+xD3tLuHpQ==
Received: from penelo.taild41b8.ts.net (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 834D5800077;
	Fri, 30 Aug 2024 23:30:38 +0000 (UTC)
From: Ariadne Conill <ariadne@ariadne.space>
To: stable@vger.kernel.org
Cc: ariadne@ariadne.space
Subject: [PATCH] s390/pci: follow alloc_pages in dma_map_ops name change
Date: Fri, 30 Aug 2024 16:30:23 -0700
Message-Id: <20240830233023.20759-1-ariadne@ariadne.space>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zu2-AES-rvln3GqQ7eJpfsnK1BhsuV_3
X-Proofpoint-ORIG-GUID: Zu2-AES-rvln3GqQ7eJpfsnK1BhsuV_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_12,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=478 adultscore=0 phishscore=0 malwarescore=0 clxscore=1030
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408300182

In linux-6.6.y commit 983e6b2636f0099dbac1874c9e885bbe1cf2df05,
alloc_pages was renamed to alloc_pages_op, but this was not changed for
the s390 PCI implementation, most likely due to upstream changes in the
s390 PCI implementation which moved it to using the generic IOMMU
implementation after Linux 6.6 was released.

Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
---
 arch/s390/pci/pci_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 99209085c75b..ce0f2990cb04 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -721,7 +721,7 @@ const struct dma_map_ops s390_pci_dma_ops = {
 	.unmap_page	= s390_dma_unmap_pages,
 	.mmap		= dma_common_mmap,
 	.get_sgtable	= dma_common_get_sgtable,
-	.alloc_pages	= dma_common_alloc_pages,
+	.alloc_pages_op	= dma_common_alloc_pages,
 	.free_pages	= dma_common_free_pages,
 	/* dma_supported is unconditionally true without a callback */
 };
-- 
2.46.0


