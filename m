Return-Path: <stable+bounces-219001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLlvJXtVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-219001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C37190049
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83C543103970
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9226CE1A;
	Wed, 25 Feb 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLbptksR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF816248886;
	Wed, 25 Feb 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983911; cv=none; b=XSH+pg4PrLDZ5dXh8mx1PrULguxdaWUbkUDk8q2pPoCswG9XehAEFE/Y/N/jRalAFRZIkqrus7I2SgHZ1u6emN53JNfgYHdgN0dHLykLwNNEno7A6WfNAjMhf/qq7p+cHCZOZJ3enQt0vYhBw2dELn+VUBFmMC5oEEIBXA35Ciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983911; c=relaxed/simple;
	bh=VsUfBk/UoikmCiA00wgiyF8n68aHggChgeWQeOw8MMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJPvSj8hlE3suYGvhMWXi8u6FOgzCcoGSi/U1Jm+/9RQfelnLHiuBksCIoIKcKL0/gkC2PxzPlDRP3VqvzcNBRtb0zBZGFscww9ElhDsxhLskhFN5SfVeCHWp1D7yr20A2eTWHXEsEkp93oGzmM3w+UewL/Kxq5y59Th9vMy3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLbptksR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA35C116D0;
	Wed, 25 Feb 2026 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983910;
	bh=VsUfBk/UoikmCiA00wgiyF8n68aHggChgeWQeOw8MMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLbptksR+NI2sLPSbByb/WbEOLdlank4HlE81KMBzLmYuGW1D0HsNKgVtcLQeJvFM
	 96eEke6FVY/sF4cwvTBrsVG0GrRnYfMpJekcCWp/pjRPCUwzbajoF3Trh+u/dbpUdy
	 G5BBKKD+ydlAQDrtGeKeRMJUeAV6UmJ3pc8CEujQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akash Goel <akash.goel@arm.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 177/641] drm/panthor: Fix panthor_gpu_coherency_set()
Date: Tue, 24 Feb 2026 17:18:23 -0800
Message-ID: <20260225012353.320438531@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219001-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email]
X-Rspamd-Queue-Id: 07C37190049
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit 9beb8dca9e749e9983e70b22e9823e6fcd519f91 ]

GPU_COHERENCY_PROTOCOL takes one of GPU_COHERENCY_xx
not BIT(GPU_COHERENCY_xx).

v3:
- New commit

v4:
- Add Steve's R-b

v5:
- No changes

v6:
- No changes

v7:
- No changes

v8:
- No changes

Cc: Akash Goel <akash.goel@arm.com>
Fixes: dd7db8d911a1 ("drm/panthor: Explicitly set the coherency mode")
Reported-by: Steven Price <steven.price@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20251208100841.730527-3-boris.brezillon@collabora.com
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index b92c9e738dbfa..77d0f4ced1206 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -49,7 +49,7 @@ struct panthor_gpu {
 static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 {
 	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
-		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
+		  ptdev->coherent ? GPU_COHERENCY_ACE_LITE : GPU_COHERENCY_NONE);
 }
 
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
-- 
2.51.0




