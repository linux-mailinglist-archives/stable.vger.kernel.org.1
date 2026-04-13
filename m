Return-Path: <stable+bounces-237301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPjeNR8j3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-237301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A33F0D4B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C4C63041D23
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F3B317153;
	Mon, 13 Apr 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHqJoruK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B53161AB;
	Mon, 13 Apr 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099104; cv=none; b=PsxyugMnsdg+tFCYq3J+SUU+AaVle/0I5rtM2fMTTuEqjkpkRO1AQCZWBmfQ5W2s8huEGPwB2OtEjv9vJi6MrThRbTkuhr03iA9mr8jamgr74lWpjmKnlHahwhgCm2G50xhCpRii359s+aXCgRinp74MBTpaaCvcK5cNZfp6Kok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099104; c=relaxed/simple;
	bh=8DM0Xx67CiAZO/CnjX5BwvuGOTDI8pVg7WVGOqy08FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZQ1jYTeQNP68RUejJMMssT13VE3SARSPY/QxdfQhdS1RxQ/KmESC2Ij9kG+DU/hgeci+MPNdmC4hmoqCewoMkiVMdP0U1uFbPCyeEC0x/yoBbaErpC4JoD9fLt+6oQIW/9fCcmZRPG8KK/T4iLHT0g0wC9PAfdniBIO8cWQJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHqJoruK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7C3C2BCAF;
	Mon, 13 Apr 2026 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099104;
	bh=8DM0Xx67CiAZO/CnjX5BwvuGOTDI8pVg7WVGOqy08FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHqJoruKTVd30VrgIPhmA24NRjmWGBCtTpNmidVggoV07aWDkMaxsyOL+jhOiJM2T
	 i6YRuV3ouwwFQKfXJ6e5gdFpUh1sgh0qWCWqkx7EPRw+QOvBuvBGwtqSYITUWN7fW8
	 uH0TNooczStuOncm5vEE5WxW4+8YSfdmcjLRqYiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 180/491] drm/msm: Fix dma_free_attrs() buffer size
Date: Mon, 13 Apr 2026 17:57:05 +0200
Message-ID: <20260413155825.793766085@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237301-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E90A33F0D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gpummu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -72,7 +72,7 @@ static void msm_gpummu_destroy(struct ms
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
 
-	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
+	dma_free_attrs(mmu->dev, TABLE_SIZE + 32, gpummu->table, gpummu->pt_base,
 		DMA_ATTR_FORCE_CONTIGUOUS);
 
 	kfree(gpummu);



