Return-Path: <stable+bounces-223352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JiEE5DtqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:06:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD922375A
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CD16303DA1F
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113A3B52F5;
	Fri,  6 Mar 2026 15:06:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B583B3C10
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809595; cv=none; b=k2f1icTvpNTQoqlZ+fyfJ6kZ4OZ22ywv3uNWeF6sL4Ci37pmo0qBZr3tBbePi3jVRRO/RhdR0MPVycq+jTUQKgKkgUopv4+5M+4MbLCy+YHUiGTUloVK9bWeoKHv3Xq/ZNJ5sJ+GiOARk3jDXOWCHvqsDtzsMF587SV6eTqHjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809595; c=relaxed/simple;
	bh=JESK19ArQ8M9OWPpl9klhDUWVImA0DHPK6UCumfThpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVE7D8xIwiA+zDAM4rt6FpKEfjMC5Zw59W36FqVuGyNX8k/fXT4O8jUhtRJCQHIXUNOrCHwLPbNwXP4kV1RyCOSbHw9/+E4zFi5fLlljMwqbzmGpOwU2trS799/PvslYUDJt1LLeRFZm3mqdzE9wjTR5xfBq0Rk7M+YgzHJuttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 9xYd+yenS7So118XqJfySA==
X-CSE-MsgGUID: rz/rZnL/Qaepzp/21pLYag==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 00:06:33 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9DE1A400B9C3;
	Sat,  7 Mar 2026 00:06:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 6.12.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Date: Fri,  6 Mar 2026 15:06:19 +0000
Message-ID: <20260306150621.23751-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2FD922375A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223352-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.725];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


