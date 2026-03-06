Return-Path: <stable+bounces-223356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EOGJDXuqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:09:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45822381E
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0043306B0A3
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA553B4E80;
	Fri,  6 Mar 2026 15:07:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680143AE70A
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809644; cv=none; b=u8iqVBiaNcwylOgxP2tW5WrBs6Pvj80x8QlSspHqQrxNiW9tpPSe+tx32AnYS+zlfwW4U4736+Scs/pirllGFhOesZWx2svwYX9w9k2kxHmbKS+OmPSTgxcRO6Z9XVwww8n3nUou8veyhmZGvfFM7p0pOScBCu9ToL6FJSZ9B8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809644; c=relaxed/simple;
	bh=JESK19ArQ8M9OWPpl9klhDUWVImA0DHPK6UCumfThpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vv95lHlVMM6gJ3OTn2mmz+0aDlp4yLIM+4knYSy5SRK7fumyIvslNRU/GHtE86r3TPWF+hU/xFn+IWfkQ1eH+V0J9JCCTNx8zerqgmn/r86TWWneD+HeDidyloM04J3SBiNWIAkHsjLS6xHk9SEVqywKvSVjPcngZD/D1+dLDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: XYcPPLw6SeyUcwCjHjxKpw==
X-CSE-MsgGUID: 3qqJA0jYTNCFqI2qnVoDag==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 00:07:22 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BC25940061A7;
	Sat,  7 Mar 2026 00:07:21 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 6.1.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Date: Fri,  6 Mar 2026 15:07:17 +0000
Message-ID: <20260306150718.23811-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F45822381E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223356-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.735];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,renesas.com:mid]
X-Rspamd-Action: no action

Backport upstream commit 14eb64db8ff0 ("net: stmmac: remove support
for lpi_intr_o"), to fix Ethernet interrupt storms on the Renesas RZ/V2H
and RZ/V2N platforms.

The stmmac lpi_intr_o sideband signal is synchronous to the PHY RX clock,
which can be stopped by the link partner while the interrupt is still
asserted, causing an interrupt storm. Since the lpi_intr_o interrupt
serves no useful purpose and it causes issues, it was removed in mainline.

Russell King (Oracle) (1):
  net: stmmac: remove support for lpi_intr_o

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
 include/linux/stmmac.h                        |  1 -
 7 files changed, 59 deletions(-)

-- 
2.34.1


