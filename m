Return-Path: <stable+bounces-227113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGKMO7vXumkXcgIAu9opvQ
	(envelope-from <stable+bounces-227113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:50:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC92BF9D8
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A18B30E8512
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04F3FADE5;
	Wed, 18 Mar 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn6tRDQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CF3FA5F9
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850000; cv=none; b=If09UaypKKCGMj9tY6JHexA12csisEOJQDqk34enIzLk4KjA4Ojoyd8bBcoejQpUnYTgRr8GJwO5JJuYKg6GLA2BFj0oVXOAsWG2ueHi7ORZUrs9YApVanljMP+3p6CMxTiv5zhU8fCF2SRLgEPiH0Fw+cyB+thoq8XVMnW4SDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850000; c=relaxed/simple;
	bh=Vpo9SlsFf86LagbElYRen4KlfDA5etZ8gG0OeqXd9hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlFdOMK1hO6gNg6S4W43qBeUbvmoMjrE44B6lGoWxxgPONdpldF29uTEc0+EJvwPKkNlBWs7qS6zS7aDUfL6ApG+vUJsnZrbsbHXPPHH/cgNkuQpwEVxpHbjLgfGN9rxlfQeaX6kUYxYPKy/zJrBo2PuzBMXVUYTCwJtorjG68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn6tRDQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648E5C2BC87;
	Wed, 18 Mar 2026 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849999;
	bh=Vpo9SlsFf86LagbElYRen4KlfDA5etZ8gG0OeqXd9hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sn6tRDQfzX2R9DPq7Wop320p18ubF42gws7r0Gs/nIA4wZs/9B79zQXg420pbBCBJ
	 AuizkbYVOrJiE4SSRb9lVCkRiJ1YCRCoHIBR600oIlDDtSMo2hptvAQtWNubsZoai+
	 DHwSeZZFHL1F7L8U1Zq3EWuiqTud0iJLURatinA5XxTKGPafm+8OOA7qt74JiOvkqr
	 rLsYnI3mZTrf0BfIyZeCRmSGV7HwRrrPE7j9oIOl4R8gTtLKExGCJl1qduq7okXpl9
	 VmcN9eabwyEs8PTB6jiJNeA1afEy0gUteq5f/6Z/JXHfNo9YtcRljxUe0OUi/m/e3B
	 /hH3QmJxYp4MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/msm: Fix dma_free_attrs() buffer size
Date: Wed, 18 Mar 2026 12:06:37 -0400
Message-ID: <20260318160637.905031-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031712-blouse-army-648c@gregkh>
References: <2026031712-blouse-army-648c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227113-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 4ADC92BF9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit e4eb6e4dd6348dd00e19c2275e3fbaed304ca3bd ]

The gpummu->table buffer is alloc'd with size TABLE_SIZE + 32 in
a2xx_gpummu_new() but freed with size TABLE_SIZE in
a2xx_gpummu_destroy().

Change the free size to match the allocation.

Fixes: c2052a4e5c99 ("drm/msm: implement a2xx mmu")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/707340/
Message-ID: <20260226095714.12126-2-fourier.thomas@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gpummu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 379496186c7ff..69df19ef25afa 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -72,7 +72,7 @@ static void msm_gpummu_destroy(struct msm_mmu *mmu)
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
 
-	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
+	dma_free_attrs(mmu->dev, TABLE_SIZE + 32, gpummu->table, gpummu->pt_base,
 		DMA_ATTR_FORCE_CONTIGUOUS);
 
 	kfree(gpummu);
-- 
2.51.0


