Return-Path: <stable+bounces-234113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI94LjSb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D63C0460
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42495301EC56
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AE23D9030;
	Wed,  8 Apr 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="10/4xmp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE13D8134;
	Wed,  8 Apr 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672018; cv=none; b=kFEsWI2m1lwZdiCzW0Q6O+/0W4w2XuQqLnYhJReS0GouJA2sdl3wCNPuKF/l7BD7HElENa9OaXSxRG3a6TH9M937uuKKME2R8OExNmPxE5vDmpD8aC0F6eXkowap3NqUoR9THjvPf572oHv4ittu+mI7HOfR6QH143FdAvGkcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672018; c=relaxed/simple;
	bh=isxb2WXsfIC3ysQinBQrAKhFL19tQrqcLo9wNMMxn0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBUmaEZsO7o/uVNwj1owJhpH0/VsL1PNVZDSfzyxhRSPbJkzGt4Cgxflf41soAG4a9kjHcIO3IXcR07V0IrrCZjTQm+0WhsY32Eb8kOU/uZNr0+se7kBr/ZnL9NsedbN+VIBXifjULK9FYhLUQUGRfqLuMH5YPQ+xYA8tBmFB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=10/4xmp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08534C19421;
	Wed,  8 Apr 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672018;
	bh=isxb2WXsfIC3ysQinBQrAKhFL19tQrqcLo9wNMMxn0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=10/4xmp1GNL43KAQPGBDXxZHhJHV0BZrLyPa2SXoZG/ylDbVykyjL4UNthKvLCWgo
	 naZzpmmbO8NfEre3s8FUR5gAkxaL7INlBZlTCLcxOSRtd/OttJ6ERILf3qldB+VEnB
	 XkvcsM56pUnCSzWG9lvXNkEcHwEGvFO3eWZlQnsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/312] dmaengine: xilinx: xilinx_dma: Fix dma_device directions
Date: Wed,  8 Apr 2026 20:00:42 +0200
Message-ID: <20260408175938.436875443@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234113-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,nabladev.com:email]
X-Rspamd-Queue-Id: 628D63C0460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

[ Upstream commit e9cc95397bb7da13fe8a5b53a2f23cfaf9018ade ]

Unlike chan->direction , struct dma_device .directions field is a
bitfield. Turn chan->direction into a bitfield to make it compatible
with struct dma_device .directions .

Fixes: 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
Signed-off-by: Marek Vasut <marex@nabladev.com>
Link: https://patch.msgid.link/20260316221728.160139-1-marex@nabladev.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8402dc3d3a352..ce5f4bedf059d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2860,7 +2860,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		return -EINVAL;
 	}
 
-	xdev->common.directions |= chan->direction;
+	xdev->common.directions |= BIT(chan->direction);
 
 	/* Request the interrupt */
 	chan->irq = of_irq_get(node, chan->tdest);
-- 
2.53.0




