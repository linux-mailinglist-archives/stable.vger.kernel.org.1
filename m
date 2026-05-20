Return-Path: <stable+bounces-251498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CqQG+jxDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:39:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8159438D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9442E30EE5C2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645C3C870E;
	Wed, 20 May 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3+U+U5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F413D6CB5;
	Wed, 20 May 2026 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298137; cv=none; b=lGhyWwRxh7JDLPWWP1VGN35GydEwC4gPwLPzA8GwjMtCWne4nU8BBGQCO3xAkb99V7VAcmp4cdQHuI6egDgqvRqVU8KHNBITD0+7JqovlDOkBBqu8i53NhgT2VRbtcfFdhheGD40T9qn07ZINXP5fxD0/BY8Z/X4vFGTNm6P+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298137; c=relaxed/simple;
	bh=zgekUuNlWhbbEvof3bSZ7fn/lRNoZrWpILPziuXNqLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukw6yQOPnO2xTi86RJzqvDui78dUEmeRP4yS0aCRiYJuLcz++Vi+WuB9VQGT387uZ1VDGWwiM3JziEsU1BA3/BbQjOQ2DayEVyHlnOnUrcwaX8+QOHoX4zTrhfrd9aF+BGBVh5ZiKIjYBwtJARXnXh0EuIR3wky+K/e9+PR6pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3+U+U5A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04621F000E9;
	Wed, 20 May 2026 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298136;
	bh=ir8P2r9ninLPX6RdnWzsHPGeYdCgDVJJJoQYKvwCJrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3+U+U5AUnVIvRajveCupvmj4VOTmso2cNJDQgao+AXvrKBkNu4dMdMQtmKrRLIPZ
	 XFfdtTzp9Nd4G5OFV3aP04Hvos7j7y3Fw8i7y/Au2E8hfE8lebqJb9EcjIzPBut7Ky
	 4mLU+Lm+1ydkAwnSGzTd0z7+HepwYxQ6SLCUTx6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 295/957] iommu/riscv: Remove overflows on the invalidation path
Date: Wed, 20 May 2026 18:12:58 +0200
Message-ID: <20260520162140.933183040@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251498-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: EFD8159438D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 40a13b49957937427bc23e78eb50679df4396a47 ]

Since RISC-V supports a sign extended page table it should support
a gather->end of ULONG_MAX, but if this happens it will infinite loop
because of the overflow.

Also avoid overflow computing the length by moving the +1 to the other
side of the <

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/riscv/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 1e8007a153c32..de286563bd44e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -931,8 +931,6 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_bond *bond;
 	struct riscv_iommu_device *iommu, *prev;
 	struct riscv_iommu_command cmd;
-	unsigned long len = end - start + 1;
-	unsigned long iova;
 
 	/*
 	 * For each IOMMU linked with this protection domain (via bonds->dev),
@@ -975,11 +973,14 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 
 		riscv_iommu_cmd_inval_vma(&cmd);
 		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
-		if (len && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
-			for (iova = start; iova < end; iova += PAGE_SIZE) {
+		if (end - start < RISCV_IOMMU_IOTLB_INVAL_LIMIT - 1) {
+			unsigned long iova = start;
+
+			do {
 				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
 				riscv_iommu_cmd_send(iommu, &cmd);
-			}
+			} while (!check_add_overflow(iova, PAGE_SIZE, &iova) &&
+				 iova < end);
 		} else {
 			riscv_iommu_cmd_send(iommu, &cmd);
 		}
-- 
2.53.0




