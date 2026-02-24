Return-Path: <stable+bounces-217895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCdGOQ9ynWmAQAQAu9opvQ
	(envelope-from <stable+bounces-217895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 10:40:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09D184CA3
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C29A317EF53
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEB36CDE6;
	Tue, 24 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aixx+ocT"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF236C5A6;
	Tue, 24 Feb 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925795; cv=none; b=Qv31RYM1t6ryZ0zBYWmeQgitkOZckSUPx8y7NvfITSsz37JEUGTj7lwXoiqJkwHT5ytzyoHWi6N1491O+hoaqi/J8WCzu3sB3iKuUJfTeTsPu0ANvdiXmXoPxpAkx0Ny6JNkhHBI4bMXsGSLD3fNZyxXBnvobnoxxG361xZ8L7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925795; c=relaxed/simple;
	bh=iSe8V6XyfiQWAbZuq2LAZaMK748jdNxnXDIx3HLR36s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u3yfUEZo14Ke3z3UO59e7SEdgng585Mdrgr3j9FvHWfMYcyQ3nf9pQRTY+f72W0u1bdFtdQZzeCnnhlOKGQu/B4qR3WV09y34rBG2YWuTUAcWe7LFWbMTdVS9DRf4d2GNO1E2i7uRDUKri744JCfskXX45+/sBX0cq96szvQgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aixx+ocT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771925791; x=1803461791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSe8V6XyfiQWAbZuq2LAZaMK748jdNxnXDIx3HLR36s=;
  b=aixx+ocTr9Ar9FLaVtdj5Wddp5Q346yvRzCU3RjCa6+SQat9lkpzvdJS
   7NWZmDmciofNknsn0r2YGPoYmXNxP/hASZZLz2w8tMN5cFeX0WTvwsy0W
   SFF3WtaRvtp3CctqmxUj8MQq/cmvJG2zC/Dhcez/yZx9ssTN54pddSAwR
   hooXwgpiEQhKwiPYHtYCh9e0zdzI8101qiw9kP3JdWwUD5Sc3XAubhXk9
   HBZZnUZ/5judnu7rYWK1Ub0mAM81AIVFxEalsTEFtCNOx5riP9nV9i3fE
   mhVBWng8kptC5ux0R6R4QWz84udgQUxjHimxaTz++EaNvlpBtgp419jpB
   w==;
X-CSE-ConnectionGUID: q+wjTlEOTWe2iGgzOhxVFA==
X-CSE-MsgGUID: D/CSFvWoRlePx4NNJMu55w==
X-IronPort-AV: E=Sophos;i="6.21,308,1763449200"; 
   d="scan'208";a="221050262"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:36:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 02:35:55 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Feb 2026 02:35:53 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-clk@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, <stable@vger.kernel.org>,
	"Daire McNamara" <daire.mcnamara@microchip.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] clk: microchip: mpfs-ccc: fix out of bounds access during output registration
Date: Tue, 24 Feb 2026 09:35:25 +0000
Message-ID: <20260224-briskly-scholar-294d13464721@wendy>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=iSe8V6XyfiQWAbZuq2LAZaMK748jdNxnXDIx3HLR36s=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDJlzC+4f9/1tcWCXxMfJZysO3ll1oPXkIYntIsnzWC6mmj2f JJWX1FHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJZHszMlz89CPnlFGJB1NfW8x3xq 27liqId/Smnt0Qax2tOdXT/gQjQ3uvyN/n4aZ3XZs7P+0uKTfZpxO/883EpsT5jLys87nf8wIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217895-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[conor.dooley@microchip.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 4B09D184CA3
X-Rspamd-Action: no action

UBSAN reported an out of bounds access during registration of the last
two outputs. This out of bounds access occurs because space is only
allocated in the hws array for two PLLs and the four output dividers
that each has, but the defined IDs contain two DLLS and their two
outputs each, which are not supported by the driver. The ID order is
PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL output IDs
by two while adding them to the array to avoid the problem.

Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 3a3ea2d142f8a..54cfbb8be8ab5 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     out_hw->id);
 
-		data->hw_data.hws[out_hw->id] = &out_hw->divider.hw;
+		data->hw_data.hws[out_hw->id - 2] = &out_hw->divider.hw;
 	}
 
 	return 0;
-- 
2.51.0


