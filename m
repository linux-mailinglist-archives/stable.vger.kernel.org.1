Return-Path: <stable+bounces-212609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABvHJ4E6emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E98A5D37
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5F063042BEC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7184302779;
	Wed, 28 Jan 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbmaJRc9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB601285C8D;
	Wed, 28 Jan 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616093; cv=none; b=jEWVBxYlTSvUpV/kEgureA7G/KiKzijbTBOSAkMpCgnfZ2N4j+2bRuLPi82onyP/IB6fB+tl8TgyC7BVu7qaV+sCCIUiexlCJB7BteJCLrQ7OiuqIxs5+QTVr3lLwgFSgkmN5KABdHgK5GXD2PRdBGks5mNtKx550v0HGSa6HjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616093; c=relaxed/simple;
	bh=GqLwU8ZREyD7WldLDotDn3+J/czQXJU80cQ3e4PorK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU+uZ1wBU12dR06/lbXljquGWznZ6D67y9vtkdoei/2c5lrc665wl0g9ZMjFT6e1AmTY55zjJfQPU3dgneucjRyw5sTHezFWkx1J8P6rAGEMvdClEjP9Q/eE0uwu7Nx2gURJ8Ch7GFx3m6jPfxuiYAZf4I27Or6L2meEgNOXrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbmaJRc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D85C4CEF1;
	Wed, 28 Jan 2026 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616093;
	bh=GqLwU8ZREyD7WldLDotDn3+J/czQXJU80cQ3e4PorK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbmaJRc9gLs3UCJMS43uICMdhTwO62ZdidWfmM/2eoxYXKm1i4lDyQpyALrN0ilpK
	 W473QV5n4mNc/2uLv1gal48EFnQ2A53Z46ADSD/fDdRVXF+wxoL18+6a2DUn/uDSFX
	 J2GFfDsGIjHQlK9ftok95sE3v29d9q3QIPvAF2CY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18 172/227] iommu/io-pgtable-arm: fix size_t signedness bug in unmap path
Date: Wed, 28 Jan 2026 16:23:37 +0100
Message-ID: <20260128145350.639954084@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,nvidia.com,oss.qualcomm.com,amd.com];
	TAGGED_FROM(0.00)[bounces-212609-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,nvidia.com:email,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2E98A5D37
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

commit 374e7af67d9d9d6103c2cfc8eb32abfecf3a2fd8 upstream.

__arm_lpae_unmap() returns size_t but was returning -ENOENT (negative
error code) when encountering an unmapped PTE. Since size_t is unsigned,
-ENOENT (typically -2) becomes a huge positive value (0xFFFFFFFFFFFFFFFE
on 64-bit systems).

This corrupted value propagates through the call chain:
  __arm_lpae_unmap() returns -ENOENT as size_t
  -> arm_lpae_unmap_pages() returns it
  -> __iommu_unmap() adds it to iova address
  -> iommu_pgsize() triggers BUG_ON due to corrupted iova

This can cause IOVA address overflow in __iommu_unmap() loop and
trigger BUG_ON in iommu_pgsize() from invalid address alignment.

Fix by returning 0 instead of -ENOENT. The WARN_ON already signals
the error condition, and returning 0 (meaning "nothing unmapped")
is the correct semantic for size_t return type. This matches the
behavior of other io-pgtable implementations (io-pgtable-arm-v7s,
io-pgtable-dart) which return 0 on error conditions.

Fixes: 3318f7b5cefb ("iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()")
Cc: stable@vger.kernel.org
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/io-pgtable-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -639,7 +639,7 @@ static size_t __arm_lpae_unmap(struct ar
 	pte = READ_ONCE(*ptep);
 	if (!pte) {
 		WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN));
-		return -ENOENT;
+		return 0;
 	}
 
 	/* If the size matches this level, we're in the right place */



