Return-Path: <stable+bounces-220807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEzGAVBWo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:55:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DE1C89F9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C178F33E858A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D70E411604;
	Sat, 28 Feb 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM73i+I5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B7494A0E;
	Sat, 28 Feb 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300693; cv=none; b=eE15PdVniMU21aQuECUWrfb86YGJjI4sr7mSsGDwpUFvuJ2oO00IBeb8YoTt0GeDBxd8MOpn5MDCKnnv9RuCEOPCezjUWtB5pGTvz8FUni9DodlUBy6H1YtWlTFLn21pOMgMRx7fRTB0zpCMOqb0jcQJ9OseqrbN4oXR+X5KrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300693; c=relaxed/simple;
	bh=Mu0YetehpSMSEnsfyji6J7/9tlJ/cVtHgFo5QB5cRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izYEfXMAp1Y4/bu2OPlXQsG5ZS4B/e1i+P+bqvM9/M11C83/nMWgkodWIGhMD3Wu2VEMoqkdZ+t/GHXV+5ref2wQHtl0L0M+uFGM8EGEBX9Z8L6YwAQlS9tXv79i3EeA1ZTk3OiMqTqD85d+o7u41kDxpiTqYfYu1G5ZKYLb+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM73i+I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A9CC19424;
	Sat, 28 Feb 2026 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300692;
	bh=Mu0YetehpSMSEnsfyji6J7/9tlJ/cVtHgFo5QB5cRj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM73i+I5iGFEhJf2UGlNArUWyhZZDmU7okKhp1j9z2Dfp4kmv520HOEFX98Vqyft/
	 azWMhdxV59BOaqKnQyR0eRjx0KF5RT4y7OsG4MlCHusy4mIs+i4o3tTDBRv1WnnNmT
	 /tYOg8yyR2o1GYsMIjiIJ+BcCdoX+ESY6OUt4rS9Nlb4AT9owPDDr+xgDL/gLFgoUK
	 E71nBhzqFMFVpJbgSLGmJ0F0+UmEIm304pb6MbsUt1UzP+hGli1BEU4DygBvUofgoL
	 gVrjq7+inC1wrzcA05pPRyM/mpVF99DgH838ldjghVxDowTF9tBF6RSQDYUHTkZWnl
	 17YBmMIQmnsQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 728/844] clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841
Date: Sat, 28 Feb 2026 12:30:41 -0500
Message-ID: <20260228173244.1509663-729-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	TAGGED_FROM(0.00)[bounces-220807-lists,stable=lfdr.de];
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
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:email,glider.be:email]
X-Rspamd-Queue-Id: 681DE1C89F9
X-Rspamd-Action: no action

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 5ec820fc28d0b8a0f3890d476b1976f20e8343cc ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


