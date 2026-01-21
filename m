Return-Path: <stable+bounces-210742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPB/AkLGcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:27:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F956C19
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFFF2544AE4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715323AE9B;
	Wed, 21 Jan 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXETBy0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928C3D1CAD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998289; cv=none; b=g3kcSEjPJDFbp0nC5bsmm3tow7TU20zJ8k0HFLfP0CgfUpBXjhr/P98H+6QKSGa6EOOPVDXYVe2aZY93bznEltpNZfRHbO4xnm140DmJkRZ8SheFx1ukzcP3TTvx9yeaC+l4YeW0V5fbKxFtOAjFRj4dJzg90w5G7zcuckT+1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998289; c=relaxed/simple;
	bh=L2AVLASPJyakhrB0lSH0VZEBc13+BX1TNzQHJOozbtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFN5fFLbBl0AUuJybbOkJClvp/fqamm1oUJl+sxG6vCJ0BJ5Ky5ZAmvxNanNRlxHJWXUcJDBKM8BWNxjBZelWk1DHJjSZJpLSAJWB7+gT5OnSU5D+D07FSfUd0fho1Dqp+Xh7eeaoiID3XShuCouuZH1xWo1hBg8RUAaRcDwy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXETBy0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A59CC116D0;
	Wed, 21 Jan 2026 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768998288;
	bh=L2AVLASPJyakhrB0lSH0VZEBc13+BX1TNzQHJOozbtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXETBy0+vHT6PYjq8h7MQ53nlwFR//YcuXui4sJZpImDBGL10w2XS+tPJa0LudH2F
	 nRzoXFVIB9SL+ddyPpf+J8TFL5CPjEaVBdZNv3aCqFhWhWs1esaC1G1A4aOqnZI5rV
	 YMPRxIPohtAz5WE0RI2QC4/zYunB8mAmxniemRzOHSREn6DZCKLFfmUXTQwXSVioQQ
	 3vBd9dp15bpx17KZxgAm2ELLhyRuwv3xO8oYrsw6TiFilurhkAv1b+V3f2dYOlhSjK
	 KFdRDmK/nAmSLY+c4qqPp5EcS76gJD5tgNY2b9pW3lXVtBM+QNPDQWGVo7Fz6eye8e
	 s8ZpDbmo2Iz6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
Date: Wed, 21 Jan 2026 07:24:45 -0500
Message-ID: <20260121122445.1527855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012006-swipe-grumbling-dc05@gregkh>
References: <2026012006-swipe-grumbling-dc05@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210742-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,st.com:email]
X-Rspamd-Queue-Id: 943F956C19
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
index ee3cbbf510065..d6163c5ab206b 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -140,7 +140,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
-		goto error;
+		goto err_put_dma_spec_np;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -160,6 +160,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	return mux;
 
+err_put_dma_spec_np:
+	of_node_put(dma_spec->np);
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 
-- 
2.51.0


