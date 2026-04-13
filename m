Return-Path: <stable+bounces-237268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI5ULD4h3WneaAkAu9opvQ
	(envelope-from <stable+bounces-237268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569F3F07A7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61AD730A3682
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EC31714F;
	Mon, 13 Apr 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnumTe56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE93168EE;
	Mon, 13 Apr 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099019; cv=none; b=ke9oyqBNwKqjGH7+AP5pq6eR0ssrL3HRp1plra+w94mKmfckqfU4JPldFrs/q2k24d9UTCC2lYuAUdympmz/JIqQ6HlNryKHyexlGbJ9BQJEEMqGaEKSEAPB4GiWGXlYS13IesfGW06jj4saoxEwGgTKyEDfUUirRzMVYbFn9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099019; c=relaxed/simple;
	bh=njE6ZKdmwRz9nxt73l8IXdFuQIz03Dfp2VGMp6zsH78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKvD0dlAk1yOqedmWtFl9TnIV3Ml5A+dJRaJBdXu37beZTFRwPi3xZCHM8gf3e2HmKOjgIzKDeXGgqAporR52ix1b98ApsnLconMz3YIHMb31G7YbDLQVS26ZGZIzB+CVlf5Hwepybf+aMlkjWo3Y5ma/gEp3lsSKUkutJJ7hII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnumTe56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0863C2BCAF;
	Mon, 13 Apr 2026 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099019;
	bh=njE6ZKdmwRz9nxt73l8IXdFuQIz03Dfp2VGMp6zsH78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnumTe56mZDIkXyZxRRyKtnJ1VhaLNZz6MHTkxVc45KRNivgH+c7eeNsouAx2ZM/0
	 vBJS2rGrgQWgPgIff1HeRf/rVZinykEjDkk9wnqHel55+xlRvUw0reVT6vgJ7Ztu5a
	 gAF/8NLeu7d+U5suVhnbhnp8ziRXa0d39yTkGbWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 146/491] mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()
Date: Mon, 13 Apr 2026 17:56:31 +0200
Message-ID: <20260413155824.500482320@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237268-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: 9569F3F07A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2840,7 +2840,7 @@ static int cadence_nand_init(struct cdns
 						  sizeof(*cdns_ctrl->cdma_desc),
 						  &cdns_ctrl->dma_cdma_desc,
 						  GFP_KERNEL);
-	if (!cdns_ctrl->dma_cdma_desc)
+	if (!cdns_ctrl->cdma_desc)
 		return -ENOMEM;
 
 	cdns_ctrl->buf_size = SZ_16K;



