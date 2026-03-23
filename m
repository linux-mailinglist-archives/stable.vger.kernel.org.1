Return-Path: <stable+bounces-229767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M1WAVhywWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:03:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB12F959A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9730032D7FB4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568B3B95E3;
	Mon, 23 Mar 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fvp+CXu9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E8258CD9;
	Mon, 23 Mar 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282813; cv=none; b=gyhLFjHd26ktJMqE0DLQg73EVP5sWJcGOoAlBlMKqMlmq6z5J7mNIVZeH4grVIqCMotrqZ2ZQzwpYgwBehtjoFi1XTWvEN+BVLQDyvOjxjJ8M5Zgq0monH20b/Hj+6HD3miHtYkFlTdNRsZV01ZZnX+cSWSjuy1aXlOj6uhozro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282813; c=relaxed/simple;
	bh=KzqajnVNTZy2KFYD/PQxSchJiMcwCyJ7Du2cKEBrO3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWQfrqUZ1z/x1DKZo1VMc9ucAAvRuxmA4YICI0jDDVdVy/hhrFn/JqS/nzamja2rJDRC506RNTG6PikF1g39Hc9Qqip05q8pNHn3cdNjpQOT1/U4jxfEAHoythjpuqkTMFk87PkRqvWv727XV+V9oSvuw/k/bj9bKyU3ZMcIYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fvp+CXu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3856C4CEF7;
	Mon, 23 Mar 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282813;
	bh=KzqajnVNTZy2KFYD/PQxSchJiMcwCyJ7Du2cKEBrO3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fvp+CXu9I64VjfBYPQ7TLkbzy1f5fahET9PC2R6LIbzlmQ6PjTVeO7HHwJOLLDz1S
	 1KhRwQBuGY16FGt711WnZFiTatJTjN46payN2gf2sW7ky/xhoQk0lVr9pYipyRTen8
	 KLcxayDumUasgQK486NJY0D5GDvNPMA33DxNusvE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 296/481] mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()
Date: Mon, 23 Mar 2026 14:44:38 +0100
Message-ID: <20260323134532.327225499@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229767-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6DBB12F959A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2837,7 +2837,7 @@ static int cadence_nand_init(struct cdns
 						  sizeof(*cdns_ctrl->cdma_desc),
 						  &cdns_ctrl->dma_cdma_desc,
 						  GFP_KERNEL);
-	if (!cdns_ctrl->dma_cdma_desc)
+	if (!cdns_ctrl->cdma_desc)
 		return -ENOMEM;
 
 	cdns_ctrl->buf_size = SZ_16K;



