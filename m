Return-Path: <stable+bounces-251467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPSJOPoaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:35:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B7599CD0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5393409224
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C9372B58;
	Wed, 20 May 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgYzjIWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447822046BA;
	Wed, 20 May 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298058; cv=none; b=mSrzKmclwpeF5oasXPnib+dc/Mr87l3iGnFt14C+4hf694Ij40B4BQr0c/5d9paNmK5vpqoJAcRoORsqvtYlTjVDY8hQlp4XniWrs9ulQzKDXf2As6wdR2SVP0GTE+0WsHJINQ2fdLGuhO95ZBZHJIoggLw+/F/9I9k6OT4fuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298058; c=relaxed/simple;
	bh=Px/9ee1mHIBAVy6H3fWjPFR9GdjPtUq09GZ2Pv1fw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+IyqgSuFvKIPX/srGkM8JGmlqd7CUl1nDfDTwYbAP/yYLl+ntlAmUogQm8OM4TasI4K/NPwxoFcunaj4iPFssAFJNJTGjGaRPmQDPuDYsTF24sd3Ghwm72cA5C/Kglj70s0QGDgsXWaQX03fKVzhQKd8kkCdJsKm4N/z/e87Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgYzjIWu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA951F00893;
	Wed, 20 May 2026 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298057;
	bh=O0mCNPghJcL9lbP6lX0gc+R9XJaIFNqOJ7Z1Qdso9jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OgYzjIWui3JS2uiL5xZT1xxTrm9yVicqgS4MT12FzzMvVSApgKsZK3/olY3yG5u16
	 0+UF7aLlxplN7aMZYog1P2zd5tKvf4FiD+kCOUrzHnEyTM8lIGXWFNCRFGXp+fP7Np
	 FLEPatTRU+YZPXDmqe0RegiYpHU8GiHbX6E+WaZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Chen <vincent.chen@sifive.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 224/957] iommu/riscv: Add missing GENERIC_MSI_IRQ
Date: Wed, 20 May 2026 18:11:47 +0200
Message-ID: <20260520162139.399870166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251467-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rivosinc.com:email]
X-Rspamd-Queue-Id: 159B7599CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit c70d20b25ca30d68b377b9363a2adca6eb2538e3 ]

The commit below added MSI related calls to the driver that depends on
GENERIC_MSI_IRQ. It is possible to build RISC-V without this selected.

This is also necessary to make the driver COMPILE_TEST.

Fixes: d5f88acdd6ff ("iommu/riscv: Add support for platform msi")
Tested-by: Vincent Chen <vincent.chen@sifive.com>
Tested-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index c071816f59a67..fb8e217edc3d3 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -4,6 +4,7 @@
 config RISCV_IOMMU
 	bool "RISC-V IOMMU Support"
 	depends on RISCV && 64BIT
+	depends on GENERIC_MSI_IRQ
 	default y
 	select IOMMU_API
 	help
-- 
2.53.0




