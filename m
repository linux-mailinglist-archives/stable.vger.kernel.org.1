Return-Path: <stable+bounces-236491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK1vGI0Z3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9133EEFCA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BD53066A16
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC632F8BC3;
	Mon, 13 Apr 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVdeH/lV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6F24DCF6;
	Mon, 13 Apr 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097041; cv=none; b=JVs3YHRnkIbLIlc2MDyBvXKIKBo5l0Ekc7X4fmvz0RHffuBopDRlW/v75GeouTFpdzgkQ7Gd4LZaauAoieTe7iHQx/Ep89yhGTttau8VjOrVyBTeLgbH7gI0UxnWKIFvfxRlKIc8JUl7uLcrAtFNkvaMCtp0DqRppgTxz9xWHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097041; c=relaxed/simple;
	bh=/09lUdNprfmJe8zTH7KeC2MmiWCajmKx7onT3jMR07w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/qxFHTavXjHvEOq/ndt2016wuQM4ytNEVHNC18Ler1xQtX4KjrvYQCb48ydRb9aSQzjQGl/KrqRTTQ+1PawpYdi3PHOrD+v+sukljDMqUGBVdPyjlEjy/zp6e7y+LW8uG19F180uVZc2bJfWqdjPTobQFgpmsqlSO4IzD7sp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVdeH/lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA3AC2BCAF;
	Mon, 13 Apr 2026 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097041;
	bh=/09lUdNprfmJe8zTH7KeC2MmiWCajmKx7onT3jMR07w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVdeH/lVSLcVrttEAb6FPhmpqw/tYRmAd9+GYn1Bhr4ydpT4MlTrUKWL3PqoJMHcu
	 PN7lNuz1FcmDgVezdNEbzHnR5jkHNjmiKuv8x/2HRmlU+gMgRmkdyAhGzEbZdnvopj
	 0ocYSv1RaRFsdO22uILKD0X0laQkVHNmTvWEcw4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 39/55] wifi: brcmsmac: Fix dma_free_coherent() size
Date: Mon, 13 Apr 2026 18:01:13 +0200
Message-ID: <20260413155726.297082057@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-236491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,broadcom.com:email]
X-Rspamd-Queue-Id: ED9133EEFCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit 12cd7632757a54ce586e36040210b1a738a0fc53 upstream.

dma_alloc_consistent() may change the size to align it. The new size is
saved in alloced.

Change the free size to match the allocation size.

Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260218130741.46566-3-fourier.thomas@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -483,7 +483,7 @@ static void *dma_ringalloc(struct dma_in
 	if (((desc_strtaddr + size - 1) & boundary) != (desc_strtaddr
 							& boundary)) {
 		*alignbits = dma_align_sizetobits(size);
-		dma_free_coherent(di->dmadev, size, va, *descpa);
+		dma_free_coherent(di->dmadev, *alloced, va, *descpa);
 		va = dma_alloc_consistent(di, size, *alignbits,
 			alloced, descpa);
 	}



