Return-Path: <stable+bounces-228267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI4EIr5MwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:22:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED52F4519
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F5231FBDB7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9583AEF5C;
	Mon, 23 Mar 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="epJyLne1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB993AE184;
	Mon, 23 Mar 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274633; cv=none; b=INkVcevvZ0oO1o9YiXwf4XoCZG4dC4OyHqtcoQrUCwj6npQieJTmLUbu0hcWtoptJSwZPJtkrsBjoGqEsUWeNyKiBQ1jvtrpNhmro0FKXVUIJxB1Ke/Ihvid3SJH4Bvy1sFJrID0izQNKZupiyp1kJ3npSdAw1J09x+2Iy94PEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274633; c=relaxed/simple;
	bh=qu7hbqV7WGlMQvIYlauLHl5Lyv5CU1GO2p9cjxLIKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLuAEVAwFDfReKO4d8F1iFMim+IipRNXV0Kj4MPmSgoZIL0IVjhSIrq89bnWbeBHoBtbbFznpw3amtws0W5Bp2918nLDpkjXSE/olrvTLXJyWYYWuqjfsN17/f1hdy88XSe9+w9MJrQNPbkVuccvr9sdlWi1SAAC3+YX4sEq+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=epJyLne1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D676CC4CEF7;
	Mon, 23 Mar 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274633;
	bh=qu7hbqV7WGlMQvIYlauLHl5Lyv5CU1GO2p9cjxLIKCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epJyLne1y9zfDngH6/9XOJI+9BhqwW6IX6iHT4uUTlQjze3Itsa2AmnCaQ6al0LVe
	 h10pwvs1m+uYzTB/aUNINXG6BSeSiyjk8SBuKJ7nVrQ97NWUhkMZlSQDkUAyFPtNm+
	 erhM73dk2bevsG7an2NynhM3yBB03Axe0iwhYOa0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.18 059/212] mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()
Date: Mon, 23 Mar 2026 14:44:40 +0100
Message-ID: <20260323134505.640042200@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228267-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,bootlin.com:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: DCED52F4519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

commit 0410e1a4c545c769c59c6eda897ad5d574d0c865 upstream.

Fix wrong variable used for error checking after dma_alloc_coherent()
call. The function checks cdns_ctrl->dma_cdma_desc instead of
cdns_ctrl->cdma_desc, which could lead to incorrect error handling.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2878,7 +2878,7 @@ static int cadence_nand_init(struct cdns
 						  sizeof(*cdns_ctrl->cdma_desc),
 						  &cdns_ctrl->dma_cdma_desc,
 						  GFP_KERNEL);
-	if (!cdns_ctrl->dma_cdma_desc)
+	if (!cdns_ctrl->cdma_desc)
 		return -ENOMEM;
 
 	cdns_ctrl->buf_size = SZ_16K;



