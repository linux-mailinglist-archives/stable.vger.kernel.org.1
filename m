Return-Path: <stable+bounces-221459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKQALhmYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A51CB188
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B485B302E910
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1428466C;
	Sun,  1 Mar 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4BuRBRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22752274B42;
	Sun,  1 Mar 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328318; cv=none; b=InLWthEKfVBEeBjs7CKWrQ7aVNDk1gykfseU2BbvYyylgfxLUfTLLFK45/jjbe91XciHb8R4zMuZPf/SritxLbhtR0Ihv+yDMxOwQK9Tsc5DMV84Po8RZyEUg0a2OxuBypmMUh9SPW4tODysuFsBXBSyUNQubbHCJmQFfklGPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328318; c=relaxed/simple;
	bh=f1ibaOyv4uusuUBy4GY/AWUaF/y2rzQeWxTt83qH2mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPjo6TafR2K9fz5Hyhsy7LvnkNNIxL0kIgBJ0sKbCNgmsX+KxqpiOyVfJznyvOq4CjK0txmHK22xmq8wKM+SuW+5DAk8ECOaI0PnQB6Mox50/KCmdFTh6sOkBSzy5mYRNOKGnDaluYw79RPtM8q5ozRLffXyK7At8wGHXt4LarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4BuRBRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36964C19421;
	Sun,  1 Mar 2026 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328317;
	bh=f1ibaOyv4uusuUBy4GY/AWUaF/y2rzQeWxTt83qH2mg=;
	h=From:To:Cc:Subject:Date:From;
	b=R4BuRBRYUxGeWwIHFUmMojTVTKXKKWz6/zPGi0l5VBHUBxAzYPbhiBAtJZU5olmKs
	 qQJP7seNNmv2zOEwVd3LbWhZVmUOKk8EuLWsaadHc1f/EyJnzdGwJ+UsAYf+JaNk22
	 e4ChTJOfg6fJViZKoJBiXylIDQaIvjzcjatOMPlZrYrm8e4LCJm+jA2MoUmNMbo3GD
	 8XxOCVGQ7Btcdk9VxdAP0uYfGh1Pn5qoWK5V3bSzK2bm2XSMegz5JhTJ49pTyZgSym
	 az+BQhxT2oqJSKjoA01UgdB9bp+ijJdafpBNHt+cwLZMJMvmEJpxCK0vo1ay0dW74o
	 9+zmIY3hrR07Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	marek.vasut+renesas@mailbox.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: FAILED: Patch "clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:15 -0500
Message-ID: <20260301012516.1682320-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221459-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3D9A51CB188
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5ec820fc28d0b8a0f3890d476b1976f20e8343cc Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Thu, 22 Jan 2026 00:26:38 +0100
Subject: [PATCH] clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841

The 9FGV0841 has 8 outputs and registers 8 struct clk_hw, make sure
there are 8 slots for those newly registered clk_hw pointers, else
there is going to be out of bounds write when pointers 4..7 are set
into struct rs9_driver_data .clk_dif[4..7] field.

Since there are other structure members past this struct clk_hw
pointer array, writing to .clk_dif[4..7] fields corrupts both
the struct rs9_driver_data content and data around it, sometimes
without crashing the kernel. However, the kernel does surely
crash when the driver is unbound or during suspend.

Fix this, increase the struct clk_hw pointer array size to the
maximum output count of 9FGV0841, which is the biggest chip that
is supported by this driver.

Cc: stable@vger.kernel.org
Fixes: f0e5e1800204 ("clk: rs9: Add support for 9FGV0841")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/CAMuHMdVyQpOBT+Ho+mXY07fndFN9bKJdaaWGn91WOFnnYErLyg@mail.gmail.com
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-renesas-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 4c3a5e4eb77ac..f94a9c4d0b670 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -64,7 +64,7 @@ struct rs9_driver_data {
 	struct i2c_client	*client;
 	struct regmap		*regmap;
 	const struct rs9_chip_info *chip_info;
-	struct clk_hw		*clk_dif[4];
+	struct clk_hw		*clk_dif[8];
 	u8			pll_amplitude;
 	u8			pll_ssc;
 	u8			clk_dif_sr;
-- 
2.51.0





