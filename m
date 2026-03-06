Return-Path: <stable+bounces-223354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCp0INnuqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:12:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395232238C9
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FA93060B35
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A53AEF50;
	Fri,  6 Mar 2026 15:07:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902A3AE70A
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809624; cv=none; b=VRBLDClNTeFPORqR09GdCkLYRYroIJAUf/5eDkuSEXXB1WcllrZoI9UoDgAwgy+UHXFKbKbVvNaTGrou/wjVfxflw0ZnvudXclTTjOHozFbKwpCRhJE/yt4g8wKxEy42GPwS7KfvSDufiqTGlOqtx2k2/MlN/X0xRNIx8qKVdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809624; c=relaxed/simple;
	bh=JESK19ArQ8M9OWPpl9klhDUWVImA0DHPK6UCumfThpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0qE4qhekv5q3dQVb9YUb7/qpizfk7CxtS7dToF7RyIMoNWaXejvgsx1LLl+r7RbJq1mvzL5ipq5IgEWTpQ/WjNBkCS503xpbkp9W72E5mYBQTihK7skSXygYTK4YUx7Yb2vOkxfGIg73a1tiwvy4NuAEJ/dxCl/v84sYP6adg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: wZRNRi0VTym+hKrw3wNTZQ==
X-CSE-MsgGUID: H5eDy2x1QCWoMw3cPoMDeg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Mar 2026 00:07:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0392341C1179;
	Sat,  7 Mar 2026 00:07:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 6.6.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Date: Fri,  6 Mar 2026 15:06:55 +0000
Message-ID: <20260306150656.23781-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 395232238C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223354-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.731];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


