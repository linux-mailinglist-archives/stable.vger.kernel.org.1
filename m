Return-Path: <stable+bounces-234424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKMHNfed1mkEGwgAu9opvQ
	(envelope-from <stable+bounces-234424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:27:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACE3C0BDD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EB4D30041DA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04D3ACF13;
	Wed,  8 Apr 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3zGThf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E13ACEFB;
	Wed,  8 Apr 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672822; cv=none; b=e2urBNqHrsyzYdukW7Txg1Q78XuulcAm7UUw50/2E2zGHKG8a3gXCPCWLIw3pavPhfgKTVAdoPYgZzq7kr8HauY88H9mdE4a0NVsUJHnSveFe2iGtiOCzlPcfBb8uu60lVFWg1mExxcUVKha0EkkCqfN/mBje/bBb8D+CaAm9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672822; c=relaxed/simple;
	bh=fB3RwcYHzR2Bz87UR45wxmjVCK8K4fq/zUJ6PsjiS2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahO5U4NtLkfwTUdgALKC3rmHtgxCvGczkMFs8v/8NGCYqyEZukrXN/vkEvoDGAc2oH9IMu0uKLiQWY3w1mriEE/DuiKw8f30cVxYL1fqw2haAmJgQICrd9HP+FTVKhmzMqoCtzUIcsjx1YqNR4tLXVzkaoGsXVLixSZAa5lXXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3zGThf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74FDC19421;
	Wed,  8 Apr 2026 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672822;
	bh=fB3RwcYHzR2Bz87UR45wxmjVCK8K4fq/zUJ6PsjiS2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3zGThf9tstTFt0wTbY05tk9zfu6CBigr8khWzftdVYrzCgunKZeE9Xv+ZSj4E+qN
	 kDsBImjh3JCa3oYUoAdJCJqk8P4omm4ovWBls/hX8/VZayaz2S2Kibk+WhZ+WaZTUx
	 QsBTh1Mln3PcB4v6mLnmqoIeF+he5xLp+NFfnWsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Zou <joy.zou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 155/160] dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
Date: Wed,  8 Apr 2026 20:04:02 +0200
Message-ID: <20260408175918.988700416@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234424-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9CACE3C0BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joy Zou <joy.zou@nxp.com>

[ Upstream commit 90d21f6e57a898ef02810404dd3866acaf707ebf ]

Introduce a scope guard to automatically unlock the mutex within
fsl_edma3_xlate() to simplify the code.

Prepare to add source ID checks in the future.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240701070232.2519179-2-joy.zou@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 2e7b5cf72e51 ("dmaengine: fsl-edma: fix channel parameter config for fixed channel requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/fsl-edma-main.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -142,7 +142,7 @@ static struct dma_chan *fsl_edma3_xlate(
 
 	b_chmux = !!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHMUX);
 
-	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	guard(mutex)(&fsl_edma->fsl_edma_mutex);
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
 					device_node) {
 
@@ -166,18 +166,15 @@ static struct dma_chan *fsl_edma3_xlate(
 		if (!b_chmux && i == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			chan->device->privatecnt++;
-			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		} else if (b_chmux && !fsl_chan->srcid) {
 			/* if controller support channel mux, choose a free channel */
 			chan = dma_get_slave_channel(chan);
 			chan->device->privatecnt++;
 			fsl_chan->srcid = dma_spec->args[0];
-			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		}
 	}
-	mutex_unlock(&fsl_edma->fsl_edma_mutex);
 	return NULL;
 }
 



