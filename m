Return-Path: <stable+bounces-211147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ga7J4UgcWmodQAAu9opvQ
	(envelope-from <stable+bounces-211147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF275B902
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0518A7053F8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A73AA1A0;
	Wed, 21 Jan 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5WsiK6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A33B52F1;
	Wed, 21 Jan 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020598; cv=none; b=kKZ2XZe5LNxZdrQzweDdcC2dL24wcIzzRaB0W7JYc/XRFbg7pyxnVu++vzP3nvmRwZFg0V2/kr3hoWSsb0dhhyiUN8UYcLsDf1YjD1LCVohaz1xfU2QitmCUzieF5R0IGEQbnzYRJx8aQsSO6z0nGfrXwl7kF5GCY2jK/FQhCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020598; c=relaxed/simple;
	bh=0NP5CzxPVcVP8eiY6hhzs/iv4/+52VK3dYJZGirmhys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKSzhLbenMz9qLBRPqFA7GP7YCDjCFJP84IUaglK1t2NxivVBjAVo/WzcOZpji8iMIMP5/su327QqR5SkBBx54LeDe0k5Dkk8VQI5d5JvvLQeOzN6kVAxXZ+QhnThXBrGNLyAQHOO3vok+bx4C96fF8uILk3l2XbWjfWreQmmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5WsiK6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E74C4AF0C;
	Wed, 21 Jan 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020598;
	bh=0NP5CzxPVcVP8eiY6hhzs/iv4/+52VK3dYJZGirmhys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5WsiK6o+Mk1zIZVoRru/KEMqc3UkcCA0jZ2VYS3QNrWeh2R/62EPP/r+CWz4lguq
	 3fp3f8zTFT6Wz6TWfKJMaiuc2ekfYNIYVB0Llmy4BLm4eDenuC3bTGlTJULFoeSOx4
	 gzbywAdphFjomqovIqQ/zgUuhRNII+HrWpm61yRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Johan Hovold <johan@kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 180/198] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
Date: Wed, 21 Jan 2026 19:16:48 +0100
Message-ID: <20260121181425.028605101@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211147-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,st.com:email]
X-Rspamd-Queue-Id: 3AF275B902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit b1b590a590af13ded598e70f0b72bc1e515787a1 upstream.

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org      # 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251117161258.10679-12-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32/stm32-dmamux.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -143,7 +143,7 @@ static void *stm32_dmamux_route_allocate
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
-		goto error;
+		goto err_put_dma_spec_np;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -165,6 +165,8 @@ static void *stm32_dmamux_route_allocate
 
 	return mux;
 
+err_put_dma_spec_np:
+	of_node_put(dma_spec->np);
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 



