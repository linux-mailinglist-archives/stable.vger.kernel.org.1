Return-Path: <stable+bounces-104062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B599F0EBD
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729DB283BBE
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C61E4938;
	Fri, 13 Dec 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNBEPMTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2871E491B;
	Fri, 13 Dec 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099045; cv=none; b=iWDVlBCI4pmWlTE8WuEp/YnefCrJL86q149aXtMx4SLartn6TRb1GR+lp1HA6QI5O9vLFvtaJaDzRUl+j1MRPlgPasQprpx0JZKjU/Vtokg3zjPKoG8bMzYG7Tn2GH5qtXux8N57Aet7rMEQLf4ILBLdjbsP13lq+1X05mb5R48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099045; c=relaxed/simple;
	bh=YvT3kQdh8SBRzE9lxGFmwR+bojOwb2BgMgjEDii8YTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bpmfmV1BJxdAjcnJf/38RG5lsCrkNCjf5juKi32kxPoDAg6iGKM2wvNTAIWHzugeRxHvORs/d+oaG1pZih1HmrkOqNqu9Gl9yp97+Gjtq2UpDmb5/PF7prYmTVSsg/hyVCAooIkoJZlW4MKflHGmJv48eLc1wo0xPx/AB9qrvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNBEPMTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DE4C4CEDD;
	Fri, 13 Dec 2024 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734099044;
	bh=YvT3kQdh8SBRzE9lxGFmwR+bojOwb2BgMgjEDii8YTs=;
	h=From:To:Cc:Subject:Date:From;
	b=XNBEPMTcIvYXX6WOKgjtrngudlh9kPXr8+/IZii0IZOccudBS4W1S2WY73BNvGmTR
	 DgRSEYvSYxyuvKHuUDisdgtminYOvsvUGmz6BwlHA8zFT32CDLOI63UjRCrvGhx77E
	 VQjpv+YrhZ0EF1RuzE1kY1i9mJlnCeet1WZ1y6GG22fk63hdxJ717JSfFY9674ywFz
	 I84WYk/f14hH3UnkN8GeN0YSaE+r0TiKxMAEAE3On4xcfQwUrRdM3cTa/uTF0gocpq
	 G0zJVa4f72MTZhh1l2CxJNiartGYGDHPwnq4Eor67lLzFSepM+2MynJU90nUgpa+UN
	 e2OgOsvfGtXJQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tM6NO-003SPI-Hm;
	Fri, 13 Dec 2024 14:10:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Kettenis <mark.kettenis@xs4all.nl>,
	Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3: Work around insecure GIC integrations
Date: Fri, 13 Dec 2024 14:10:37 +0000
Message-Id: <20241213141037.3995049-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, tglx@linutronix.de, mark.kettenis@xs4all.nl, wenst@chromium.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

It appears that the relatively popular RK3399 SoC has been put together
using a large amount of illicit substances, as experiments reveal
that its integration of GIC500 exposes the *secure* programming
interface to non-secure.

This has some pretty bad effects on the way priorities are handled,
and results in a dead machine if booting with pseudo-NMI enabled
(irqchip.gicv3_pseudo_nmi=1) if the kernel contains 18fdb6348c480
("arm64: irqchip/gic-v3: Select priorities at boot time"), which
relies on the priorities being programmed using the NS view.

Let's restore some sanity by going one step further and disable
security altogether in this case. This is not any worse, and
puts us in a mode where priorities actually make some sense.

Huge thanks to Mark Kettenis who initially identified this issue
on OpenBSD, and to Chen-Yu Tsai who reported the problem in
Linux.

Fixes: 18fdb6348c480 ("arm64: irqchip/gic-v3: Select priorities at boot time")
Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34db379d066a5..79d8cc80693c3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -161,7 +161,22 @@ static bool cpus_have_group0 __ro_after_init;
 
 static void __init gic_prio_init(void)
 {
-	cpus_have_security_disabled = gic_dist_security_disabled();
+	bool ds;
+
+	ds = gic_dist_security_disabled();
+	if (!ds) {
+		u32 val;
+
+		val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
+		val |= GICD_CTLR_DS;
+		writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+
+		ds = gic_dist_security_disabled();
+		if (ds)
+			pr_warn("Broken GIC integration, security disabled");
+	}
+
+	cpus_have_security_disabled = ds;
 	cpus_have_group0 = gic_has_group0();
 
 	/*
-- 
2.39.2


