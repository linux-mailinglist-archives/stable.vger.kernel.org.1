Return-Path: <stable+bounces-248236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD5dCrBKB2rqwgIAu9opvQ
	(envelope-from <stable+bounces-248236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:32:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10155366A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 719C031D54FF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB6430569C;
	Fri, 15 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gymcvn/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBE30568A;
	Fri, 15 May 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861219; cv=none; b=DtCaEf/vLmkC5vsTBAxLdhd59P9ZT/W+Anic8h5xPlQhBp/hfKef5GbLL0zxCNDuuYjplPMS5BlSlzfp3XeYYwiY9AVeXTYgUQEgnrGoxVvhJlabZnoisTyslCH/dBf1R/AOjr+xgYDqXfoUjSHpBPkoxPe6qPnZFp8wlG5Z4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861219; c=relaxed/simple;
	bh=7yGZ7wOUW+2lwqs55o8o3m1WvjJBtYUwiEiK8M/oGhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNxTQP4Qpa02inm1Ct1/cA8MYqo9lyBBEpj7/pTnWOwC/9lk7TuhhtS1IocXT9q1Y79Q7EFig/RhT0x+aorIEcrgQso4EBlDjQ1NAHtnfrx84EyZ9zqFDRiLBobUAjty0qQ10tQzYdlGnVbMSB3Oy3HPbntx5kgVPjYw/TKNV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gymcvn/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F8EC2BCB0;
	Fri, 15 May 2026 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861218;
	bh=7yGZ7wOUW+2lwqs55o8o3m1WvjJBtYUwiEiK8M/oGhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gymcvn/Bthdpd1JEd4B1rnGfwwTiVqQbdXIHVus1Z2NcxuJpWh9gG10caRVW1AcW0
	 AuItTH6+UeK0lCKqeJTr0KLcWuxmHimUhH7hTB6a+1xRUWvj8uhLPsQiPMUMyURZ4r
	 gGLpR45172DZdEapW+mKYhsNk0ZgYUvQUrSmJSfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 6.6 242/474] clk: microchip: mpfs-ccc: fix out of bounds access during output registration
Date: Fri, 15 May 2026 17:45:51 +0200
Message-ID: <20260515154720.238333039@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CF10155366A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-248236-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 



