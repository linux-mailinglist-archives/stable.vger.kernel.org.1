Return-Path: <stable+bounces-259822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hcyDzrbHmp0WQAAu9opvQ
	(envelope-from <stable+bounces-259822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC762E81C
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kKaipM2H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259822-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-259822-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E71D30941F8
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2293E0C42;
	Tue,  2 Jun 2026 13:28:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA03E5EFA;
	Tue,  2 Jun 2026 13:28:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406926; cv=none; b=ah7NZcltZJpQoJMNxQaJDIPLyDnofQWDpDiYDgfvoYxQ4+/R1lj8+cWynMw5xqfmFD7nPygs3oBhoihWsyMsANfo483LPJQguTYZTP/0SePAGp4RWwT2gFBg1SJamqbwwFE3vpIKHoylEkNbiUG2XriRIqT8hz9kebGEbngYDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406926; c=relaxed/simple;
	bh=iMNe4mkmJ5TZaA4toPowsDiOO+8246clif64nTzPRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdeWnvNVT/JAHZqgZ7nCFWdk/O1997RPd8uw1N50mg/x03bXvf+MbhopMljaJhfG2hprKOBHCAmgofy89oU9zYChQEi7Llr2KhbXlcd+pKCYPgMmTLu52HI9K+121AgJ3CHglYNx8UzBQNTjxgzE2j5CRi23TijkKugvpDjUdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKaipM2H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11A1F00893;
	Tue,  2 Jun 2026 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406925;
	bh=+F8HoWQaPzi0AigpwIwaQzaOHhIjhtSUzJ3u8Xw8cto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKaipM2Hrb+3Era4zpjZm1d4ziDA9WBPmfxfFWdih3cxJPCqppK9bxhzlbEWAiZqF
	 +9AOE2s7U40ftdN8QIDowPOLP1ueF4Mse2R+T1jGUxNpfhCgq0QhjmOO62/erB9+Gx
	 hLqS1bXSU2K4GSPh05CHdPJVWYxj+dqZdpIQRd/CZQNkxv5lQlkcem9SpAZURa+f52
	 ZtKFoQ5p5R3oEL1zE/CEclLEaZP8aVNjEShQaXozLpwaBcFpCUcxCUph2GOl7j3Q+j
	 Y5RkwnZiQlfAraqx4uC8dXYFsVC/oy8aVg5uc9xYacZF9i9t2jGdmhg591+CYscweA
	 vGfyDATco7vmA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/17] i3c: renesas: Restore STDBR and EXTBR registers on resume
Date: Tue,  2 Jun 2026 16:28:09 +0300
Message-ID: <20260602132824.3541151-3-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259822-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:tommaso.merciai.xr@bp.renesas.com,m:alexandre.belloni@bootlin.com,m:Frank.Li@nxp.com,m:p.zabel@pengutronix.de,m:claudiu.beznea@kernel.org,m:claudiu.beznea@tuxon.dev,m:linux-i3c@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:stable@vger.kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,renesas.com:email,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46FC762E81C

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving state where power to the most
SoC componentes (including I3C) is lost.

The STDBR and EXTBR are configured in initialization phase though the
struct i3c_master_controller_ops::bus_init. Set them on resume function
as well to keep the same state of the controller after a suspend with
power loss and a similar initialization sequence as in bus_init.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 6e7ece2e0b4e..88a16efe096d 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -260,6 +260,7 @@ struct renesas_i3c {
 	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	u32 extbr;
 	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
@@ -607,10 +608,9 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 
 	/* Extended Bit Rate setting */
-	renesas_writel(i3c->regs, EXTBR, EXTBR_EBRLO(od_low_ticks) |
-					   EXTBR_EBRHO(od_high_ticks) |
-					   EXTBR_EBRLP(pp_low_ticks) |
-					   EXTBR_EBRHP(pp_high_ticks));
+	i3c->extbr = EXTBR_EBRLO(od_low_ticks) | EXTBR_EBRHO(od_high_ticks) |
+		     EXTBR_EBRLP(pp_low_ticks) | EXTBR_EBRHP(pp_high_ticks);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
 	i3c->refclk_div = cks;
@@ -1468,6 +1468,8 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 		goto err_tresetn;
 
 	/* Re-store I3C registers value. */
+	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 	renesas_writel(i3c->regs, REFCKCTL,
 		       REFCKCTL_IREFCKS(i3c->refclk_div));
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
-- 
2.43.0


