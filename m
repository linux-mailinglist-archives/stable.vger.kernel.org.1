Return-Path: <stable+bounces-210735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPRtEy/BcGmKZgAAu9opvQ
	(envelope-from <stable+bounces-210735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:06:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB5567AB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AC50502B0F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9841322D;
	Wed, 21 Jan 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alcLsWX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDE3382EB
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997064; cv=none; b=chrjT3/pkmvIl8HZbCgROcZIUKt4dwnEAnTDEQXrkAJtGo0tm8N+MZrkPHtcCdGh1AS8VxcJsj97EaQOMEZv00PcsGG7rCnpbwXvv6itXuSHrLQkd5KOa4D9lA6iM6c+SStN9xoNesFsoFSym+eB44iQbCRNz5ct4v+q7n8N3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997064; c=relaxed/simple;
	bh=8jPEwfXYvgIH64HKSVjzmBZDZaf1ffvUL4dvGXFY4E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAc0F8vJcHZMwIiLZMINV2GfO7g6bKoMmvzUP+TojYpJOY5bJGikGSVegyl1d24z/Zke5CuHXMWIeU2SoZyuvU4oAlKCplS2ZRAJ7wKjAn0hX40EnN1sUEvJrjAPEDaywps8gmBCpl0Knz5A4KSW165mcke8Uk5jUWrkM0u6ziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alcLsWX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA54C116D0;
	Wed, 21 Jan 2026 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768997063;
	bh=8jPEwfXYvgIH64HKSVjzmBZDZaf1ffvUL4dvGXFY4E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alcLsWX8U8VQatvRBqzvb9Et8Biazlt7Y9Mk+YC/R5UmSbkVuNE8sdzen1W9i0HHc
	 3uGnaZRF3OHjwox2huTxRdXWMayyHJi9OrdbjvPZcb3SUPbsXx4Z5f2huYhxs7aSfy
	 sxaM5b4e1Z/WbrK2bo4jigXKvFp+ti0AnimPWaGEkKLB5tREAHVjgwWGEVOTNOdnt9
	 kUlP8LAYKyvHL6VoY/ifKN09JQaNiG/wKnOWWbTmDT/oJMyPUtCa/ch64M/sgKEyFs
	 w6+LkROqnJKmiSvlihDFUEui6YasIUtZiBVJQwiMmtiAyNEKtSHVyv8y3rl/dwz6kv
	 cO2b1WWpd5yPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhen Ni <zhen.ni@easystack.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources failure
Date: Wed, 21 Jan 2026 07:04:21 -0500
Message-ID: <20260121120421.1504853-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012042-outlet-negotiate-95fe@gregkh>
References: <2026012042-outlet-negotiate-95fe@gregkh>
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
	R_SPF_SOFTFAIL(0.00)[~all];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210735-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,easystack.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: DDDB5567AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhen Ni <zhen.ni@easystack.cn>

[ Upstream commit b18cd8b210417f90537d914ffb96e390c85a7379 ]

When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
the error paths only free IRQs and destroy the TCD pool, but forget to
call clk_disable_unprepare(). This causes the channel clock to remain
enabled, leaking power and resources.

Fix it by disabling the channel clock in the error unwind path.

Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20251014090522.827726-1-zhen.ni@easystack.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Different error handling scheme ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-edma-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855d..5fe99fd8f437f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -819,6 +819,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 
 		if (ret) {
 			dma_pool_destroy(fsl_chan->tcd_pool);
+			clk_disable_unprepare(fsl_chan->clk);
 			return ret;
 		}
 	}
-- 
2.51.0


