Return-Path: <stable+bounces-246532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK2MDLp0A2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:43:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90301528015
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DEF30D1B9F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054836C9D0;
	Tue, 12 May 2026 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l683wGWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4152349AF5;
	Tue, 12 May 2026 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609468; cv=none; b=txIxhVojiv0twvAM3aQKruaG7uuvpc4cAMcHdmD3I5/mD5icm29rf31ojGxbGOViX5SP8pK4/ITVaavjqmdqgF6fgSbkOPiA/X40ebPRUOosejNT0WnnCvVlufHyIs44dyguXJ+BPZtW3wUr+2TeGYpqdG56p4gQ0lxWonY92BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609468; c=relaxed/simple;
	bh=gLGqE7RA2QmTj7+C6hYY0ebLwONRJ8OgDjSddVThaVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1Z9S6R1qBXL+1Zt7bIvhmirN/uTC6WW7kWX1eV/LzsRts2psiG6QMDG2whtDEys0Nxj/z/4iqlqEaCgVTj0DqjUSQc2px85Np8jXzDRaYnmLa8cwPaUtZwrNDCrfgQNn/TpB/UQVBiBdv0R0h95AFHQFKKwFS0Dp0rNJijDroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l683wGWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3987FC2BCC7;
	Tue, 12 May 2026 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609468;
	bh=gLGqE7RA2QmTj7+C6hYY0ebLwONRJ8OgDjSddVThaVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l683wGWHkKlrOiPHK6GksxFXNVok2jwFefw6uDxMHFFsnuEBz9QLUKIOH/Z0BUxOj
	 hnjsOvHqzVLO+jxhaEJLXYarhNhsd56Nf6Leu6VMA+duJWhAd0vBDPy/nj3hzyEEgm
	 NpJBxwsTTEEnKOg7ngADlXr4fpLrAx9X3+3AbBEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 7.0 166/307] clk: microchip: mpfs-ccc: fix out of bounds access during output registration
Date: Tue, 12 May 2026 19:39:21 +0200
Message-ID: <20260512173943.625569313@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 90301528015
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246532-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,microchip.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

commit 2f7ae8ab6aa73daaf080d5332110357c29df9c36 upstream.

UBSAN reported an out of bounds access during registration of the last
two outputs. This out of bounds access occurs because space is only
allocated in the hws array for two PLLs and the four output dividers
that each has, but the defined IDs contain two DLLS and their two
outputs each, which are not supported by the driver. The ID order is
PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL output IDs
by two while adding them to the array to avoid the problem.

Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
CC: stable@vger.kernel.org
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/microchip/clk-mpfs-ccc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(str
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     out_hw->id);
 
-		data->hw_data.hws[out_hw->id] = &out_hw->divider.hw;
+		data->hw_data.hws[out_hw->id - 2] = &out_hw->divider.hw;
 	}
 
 	return 0;
@@ -234,6 +234,10 @@ static int mpfs_ccc_probe(struct platfor
 	unsigned int num_clks;
 	int ret;
 
+	/*
+	 * If DLLs get added here, mpfs_ccc_register_outputs() currently packs
+	 * sparse clock IDs in the hws array
+	 */
 	num_clks = ARRAY_SIZE(mpfs_ccc_pll_clks) + ARRAY_SIZE(mpfs_ccc_pll0out_clks) +
 		   ARRAY_SIZE(mpfs_ccc_pll1out_clks);
 



