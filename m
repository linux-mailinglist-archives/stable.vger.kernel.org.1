Return-Path: <stable+bounces-246190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJEhL0dvA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A0527549
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEED3236D8B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8533ADBA;
	Tue, 12 May 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NkGYEdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30E3EDE43;
	Tue, 12 May 2026 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608589; cv=none; b=fdvIOmOdKjRrFtNG3PLBnuzZK9DLWPtaxx2usdP60qqsegt1EYIgiYng9BEFHiNH+tChNXyb1OP0xzECsTieurjGDMFRKnD0hhyHcJroVovS5j222Bt4zXtku1PAktk4kW1cSUpUaqjLSrDn5VSNjqf35W68OXDAtNG8x2ihzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608589; c=relaxed/simple;
	bh=xHxW3ktpLm0gxa5dLtuRU3hJsy9ehiHpB07zZTKzqFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAtUzUGnIPAvsfh3mG3znAsAQLKFMpqt1SoJH7JA8KryLypLfcHJ6VGni/fVWWHNLsM4wB0nM9KaFKVBIPN18jvRItKP/aaUPb989KdmA+lcEbGqSFyIZNM5TEe1a2lRS3SSUiTpJtmtFuhZwGIRHoeE29/OqP6/3HOouP04erU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NkGYEdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DD6C2BCC7;
	Tue, 12 May 2026 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608589;
	bh=xHxW3ktpLm0gxa5dLtuRU3hJsy9ehiHpB07zZTKzqFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2NkGYEdYAqkSZCk3XoLja4S6rIMcJxC9gEqjx+XbpSGFrdo2M+29seITBZVnzdZqz
	 QeTQSvZ834zHNIWrbLV4is1GNAE0++Y2EJUXxp8JeZO45CF2qeSycrzVU6AZQ6/wEA
	 9/Sa9ofyerk05p+ptTo4gfQoQGjNTVMJrlcvh6ck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 6.18 139/270] clk: microchip: mpfs-ccc: fix out of bounds access during output registration
Date: Tue, 12 May 2026 19:39:00 +0200
Message-ID: <20260512173941.378101122@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3A1A0527549
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
	TAGGED_FROM(0.00)[bounces-246190-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 



