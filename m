Return-Path: <stable+bounces-232609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLyUMKhazGk9SgYAu9opvQ
	(envelope-from <stable+bounces-232609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:37:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F8372DF5
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F2483031BE1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DF3A962E;
	Tue, 31 Mar 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoWqBQx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BF3090E8
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000228; cv=none; b=bRuape0E9xS7sTv11EshpBAjVwjgyYjApgCBv3fim+gP9OLx+eQ56lI6EwJ86yfqbSJjf7mQUx9VettDha+3mxSal8L4N1T74zKpQay/4vb02tzQXmvR3dMBsTe57LzRe6HLr/Eiujj0v9kXmdfpaKtqp4uLfgXnHDBe47pZKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000228; c=relaxed/simple;
	bh=COrtWAc4i3TuwWC69qZpa09I52km+udbrBxHx2fujfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDwg3yQEgjxOW64q8zXdltfeqzbZhZGw0IJskLOSQEd+Ea8C1yoElSG+BQnlTIQFuuhjrFPZmcGI9jM4EtnwLRlkYycNww3gwK/1PpyURhCfqanBQ07yVB43dwAlRdR1n3PRMWYsyvDqzMZqhN27686YGQHsDiSb7xi9V1Q+0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoWqBQx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9895BC19423;
	Tue, 31 Mar 2026 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775000228;
	bh=COrtWAc4i3TuwWC69qZpa09I52km+udbrBxHx2fujfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoWqBQx/mE8gYxQNLWcs2XHyHbkvUU2aRjXbXFtxil1XCu1h1rzhxnOnxftsxbYho
	 YeBkC4mWXr69NUpdfQGyGMur5lnU86QwjTVul2cdowvPIHDpP/4+61mymzc0nV+zl1
	 RndL4FfyPEPkT/3sxGY0ySgI2HfjyKd+mJOpZsAz6aZceL9Fb/eHR+kTU+OUadE5gD
	 6McJQOUXKYyZAiS6TtmeIIojiodP1HmnvLAa6Ixf3xQpQzebyABDhq6l2VsN3YjrEN
	 eKYLoEVE36R+yxjqAVezm/D7CcwUoQjSM0N2k4PpP8tvlRfZk8zlOvp5YeuykUqV2Y
	 elylSZTBURezA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joy Zou <joy.zou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
Date: Tue, 31 Mar 2026 19:37:04 -0400
Message-ID: <20260331233706.3629169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033014-jitters-makeshift-a3d2@gregkh>
References: <2026033014-jitters-makeshift-a3d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232609-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 643F8372DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/dma/fsl-edma-main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 34b194759d218..0e6207382cde1 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -142,7 +142,7 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 
 	b_chmux = !!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHMUX);
 
-	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	guard(mutex)(&fsl_edma->fsl_edma_mutex);
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
 					device_node) {
 
@@ -166,18 +166,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
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
 
-- 
2.53.0


