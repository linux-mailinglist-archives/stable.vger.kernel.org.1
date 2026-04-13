Return-Path: <stable+bounces-236261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPyEKEcX3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 599EC3EE951
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5412730CF86A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A02749E6;
	Mon, 13 Apr 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLhtG/p7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDA24DCF6;
	Mon, 13 Apr 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096457; cv=none; b=dC1wmO5/YGuVsURIUfo26s+gRlqY/ZB7igIEXHY7y3J0mvccTSrGgC0qmBD9G9EqBI6LIu+zKKIsPONjJUdTJSEXX6fOu93flL4KyhqXAo/gSuMjfIQ6BIBieBxEz3+7NASuyUNNPOc6wBugjSrGyQdy8GsWEGxhcHmGRkT10d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096457; c=relaxed/simple;
	bh=N2yf5YF4QISnOLAAH88fIJTUux5kcNB8eZiJTEHoh4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZpB/p5aqA0XK9dl+RQNZu70LcV5tszwwwM3a54Kqn/i9nhZqEJjDx/G0InuCj5E5ShjTmRvnmothjHle4wvtPLyi6XR7WJq92fbU8+n3IvhEpvG5EvcXPBCjVzH5CL0y0Q6nZnDEopZTEdI05ROujDFN68578fmAhKGH2TNwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLhtG/p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8FC2BCB0;
	Mon, 13 Apr 2026 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096457;
	bh=N2yf5YF4QISnOLAAH88fIJTUux5kcNB8eZiJTEHoh4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLhtG/p7QPMmJWuc9FsgqY6iZOocLQYNCv8UJ/P/Pty8HbvO1uBDhXQna4cBPR81y
	 SJDIBR0BymAHiRu/XZ3nqsVErAtz8ar88SrBLKuokRRFSOYDW73aEsTqnaPew10u1W
	 ERdembC0nNIPWmGFcJOo1QCkSoQJl9i8m4f+kg48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Pighin <anthony.pighin@nokia.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.18 19/83] i2c: imx: zero-initialize dma_slave_config for eDMA
Date: Mon, 13 Apr 2026 17:59:47 +0200
Message-ID: <20260413155731.742435084@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236261-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia.com:email]
X-Rspamd-Queue-Id: 599EC3EE951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Pighin <anthony.pighin@nokia.com>

commit 39ed7d89b973329cc5c764b65ba6302b17b1907e upstream.

commit 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers
in cyclic transactions") causes fsl_edma_fill_tcd() to read
dst_port_window_size and src_port_window_size when building transfer
control descriptors.

Initialize the structure so unset fields are explicitly zero.

Fixes: 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers in cyclic transactions")
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260331182632.888110-1-anthony.pighin@nokia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -401,7 +401,7 @@ static void i2c_imx_reset_regs(struct im
 static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx, dma_addr_t phy_addr)
 {
 	struct imx_i2c_dma *dma;
-	struct dma_slave_config dma_sconfig;
+	struct dma_slave_config dma_sconfig = {};
 	struct device *dev = i2c_imx->adapter.dev.parent;
 	int ret;
 



