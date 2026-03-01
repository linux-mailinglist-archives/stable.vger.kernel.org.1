Return-Path: <stable+bounces-221944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO+cCl+eo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:03:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9031CCBA1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DD73326CBC
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386E2C21F2;
	Sun,  1 Mar 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ7VIynN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10819D07A
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329521; cv=none; b=HReIOQQt5SyeK3lAkT4CSQW6gDJwX9pKN53mF2XdGgNeioF33etLtPVmqAnNUUQQNPRJloGbdlDchJxPDfDSwOmX5ujGEImZDEEAv7qNytila7GDpXLywCj7oucwBsLgIWmRvIzxWgZaZ9ila0jKbQCbUBkHDVFIImHd/rSpifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329521; c=relaxed/simple;
	bh=n+/nQGD9ODs1+LImW5f6+WtyZz61xcL9SGXk7Aqsp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdHdB/tq55U3OWsGeBeOFnEZAHVyH/lfIVsgdz+/26uf8sgPbUYXS/zDVfSsKUoyVv58Dmfdemk/2hp/+nMVsnjso88LvPgNz8+DNDLOBeFNto6GDRqzrkBuWbDvcM1Rwx4O3cURHDs/B0MlN/cSNSQL8F1+tuceXBtE+knVquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ7VIynN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E897C19421;
	Sun,  1 Mar 2026 01:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329521;
	bh=n+/nQGD9ODs1+LImW5f6+WtyZz61xcL9SGXk7Aqsp+g=;
	h=From:To:Cc:Subject:Date:From;
	b=BJ7VIynNH+E7LW3BsnOdP1KYGXBfw1xXETNI8C3iGylnrGZW9sd3HNOKb4ax9ni1R
	 JPvjw/3+/DRZKXbDUNxmYt+3TJ/jREscULtUgqTCjU4CH6L+lqwVZAD9S/vfI1tvSp
	 gBnepwQZh7NFgQ2BaDk3xWoBtYY50pjSp+wBvysesQ1E0LH/xSgK4tcVz1CaHz8+rR
	 untJjb9cSMI/S7p9ucM5mWXb9nP9JUSyrVKmshID6a8TtdnTKZuG8HHHq0HZX05BOy
	 bM0XzLHybpiKHf7RhllBxzR6X/HUo/RvTM4hix9gHfX8JGitfQ14bAIu8eeWv4yZkI
	 h4AqKohGZzcFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	andrea.scian@dave.eu
Cc: stable@kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org
Subject: FAILED: Patch "mtd: rawnand: pl353: Fix software ECC support" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:19 -0500
Message-ID: <20260301014519.1707904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221944-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,dave.eu:email]
X-Rspamd-Queue-Id: 9E9031CCBA1
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 89b831ebdaca0df4ca3b226f7e7a1d1db1629060 Mon Sep 17 00:00:00 2001
From: Andrea Scian <andrea.scian@dave.eu>
Date: Wed, 4 Feb 2026 18:41:44 +0100
Subject: [PATCH] mtd: rawnand: pl353: Fix software ECC support

We need to set also write_page_raw in ecc structure to allow
choosing SW ECC instead of HW one, otherwise write operation fail.

Fixes: 08d8c62164a322 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
Cc: stable@kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 11bd90e3f18cb..7f012b7c3eaec 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -976,6 +976,7 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 		fallthrough;
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
+		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		ret = pl35x_nand_init_hw_ecc_controller(nfc, chip);
-- 
2.51.0





