Return-Path: <stable+bounces-210740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDQMDyTGcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:27:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919E56BEB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25618987D74
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0794413242;
	Wed, 21 Jan 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfrJ/YL9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E840410D37
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998050; cv=none; b=ZddW6CiOMJFVHSN3Uu2hX18Ti5s6gsY6NEjRNWkntgF1ITT4ekippNlC0Q/CijGygXWOYWbpZouDAQFRCG3xii5qM5bTW2Xce8Vg19QORhIvvru7nQKcO5SPTjnbdaVFwLr7oWUrcX8HQUkKBsGPVDnPlvSRyEdBJVbgUeqlpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998050; c=relaxed/simple;
	bh=bEfow8NEF0uOGPh/bPakUtYFCs/iMZu6Z6wQWaeOiNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7BxJ+ELAQCgjZBeB/xyR63AdhdQ9k7WT+W8+nmjZbIWvxQHJFyupyWR/tWmMGOS/wfJ0V5ztd+Cyt5+qFOBjTCq8e9RhRwAv3g9x2JwYRJWzWAmz5uorLudFqCFLoxV9Z7q2ySg3kXfBxUvqiQKarLIp6diTsATMsHpeYOVBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfrJ/YL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BF9C116D0;
	Wed, 21 Jan 2026 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768998050;
	bh=bEfow8NEF0uOGPh/bPakUtYFCs/iMZu6Z6wQWaeOiNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfrJ/YL95LaCDhDuaTEBE29y+G79wYNPfJRRGmHFent5vTY9kxoRn9mwXG1jpYiQR
	 NWgHdt1mouaRCmHZN2otSnUO4JoofOmU9eK13yLtAFTELnbyJCd66eP8WeOJTb3ou5
	 5PYjaEyFtOrWwYXJu29m1SFVSsJ2VE9LqrmaLCSV1Xj4Xxs3cDjOcydKdd2i1RsU6d
	 yQR5OoW05GbgxIkupV4ESuSaBctgfwDzfxuefrBj9yneW0kyTPSLrdmbVaCsPNe8ua
	 6hVAHWJr9lF0MuCWb1JwoY5otANTZTjoQWo/EUZN++m3YfdmL8V/jTJO87CjartNht
	 0o2rXGO1xnILQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
Date: Wed, 21 Jan 2026 07:20:47 -0500
Message-ID: <20260121122047.1526648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012005-grid-smell-308a@gregkh>
References: <2026012005-grid-smell-308a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210740-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,st.com:email]
X-Rspamd-Queue-Id: 9919E56BEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit b1b590a590af13ded598e70f0b72bc1e515787a1 ]

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org      # 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251117161258.10679-12-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/stm32-dmamux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 8d77e2a7939a0..3a6907fbb5a3e 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -142,7 +142,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
-		goto error;
+		goto err_put_dma_spec_np;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -162,6 +162,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	return mux;
 
+err_put_dma_spec_np:
+	of_node_put(dma_spec->np);
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 
-- 
2.51.0


