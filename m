Return-Path: <stable+bounces-213820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEoZOmpkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3262E869E
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1ED0302BF41
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03015426D23;
	Wed,  4 Feb 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i33wk7Zy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB945426D20;
	Wed,  4 Feb 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217619; cv=none; b=QlcGS2UDUYlwA04vhY0795LedISbHSVbRCD/srXNjErL5rv0WjS0pI8D7pTfmZzc/tJhvFeISEfHwxtRz5ZsHRcQpCZzYnHz27uuC037aJDKW+0slp6LSTAILbcjz2HX54iPloxJFw1H1aAjZxDrP4aE8gKdeYzPi+eZf1/sVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217619; c=relaxed/simple;
	bh=ued0TuUYExteTPrk9juRNEZlXl2vbNM4c9ke55SowwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAibb4q11gw2zsABsaR/7GjBteBLKE6fEJM9ngkehPad49dN4WtNA4Y65NbO/kU4cX/ib6BvdmMoYsE8IS7qoQnx2EK6Ow+ewg4CGHNscW+x262iZUWWKAvYvJi1Ov5Hk3+tPJQf1Xno3ygLFSGHnC9JPoJeduqLEw+Vsko+DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i33wk7Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B08C4CEF7;
	Wed,  4 Feb 2026 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217619;
	bh=ued0TuUYExteTPrk9juRNEZlXl2vbNM4c9ke55SowwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i33wk7Zyy21VMWQj3aDS/pulfWkqvOtyvO0WOePbppjBwhiiQGroaYIXhio7/2Mjl
	 cR+BoLJ6MRfRS/s7ePeqZqMdSQjgLsQ7oHeTRw2A+DAiiPplSc92QMjiSfGpN59xS1
	 dVo7e5Ld0wji6N1ZGaE71ickvbI6O4g3gBlCL44s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 069/280] dmaengine: dw: dmamux: fix OF node leak on route allocation failure
Date: Wed,  4 Feb 2026 15:37:23 +0100
Message-ID: <20260204143912.139050429@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213820-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A3262E869E
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ec25e60f9f95464aa11411db31d0906b3fb7b9f2 upstream.

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Cc: stable@vger.kernel.org	# 5.19
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20251117161258.10679-6-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/dw/rzn1-dmamux.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -88,7 +88,7 @@ static void *rzn1_dmamux_route_allocate(
 
 	if (test_and_set_bit(map->req_idx, dmamux->used_chans)) {
 		ret = -EBUSY;
-		goto free_map;
+		goto put_dma_spec_np;
 	}
 
 	mask = BIT(map->req_idx);
@@ -101,6 +101,8 @@ static void *rzn1_dmamux_route_allocate(
 
 clear_bitmap:
 	clear_bit(map->req_idx, dmamux->used_chans);
+put_dma_spec_np:
+	of_node_put(dma_spec->np);
 free_map:
 	kfree(map);
 put_device:



