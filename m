Return-Path: <stable+bounces-195115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C6EC6A8D0
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E02932B789
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F8393DED;
	Tue, 18 Nov 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OeXqGBIh"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A9377E8E;
	Tue, 18 Nov 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482417; cv=none; b=QC4rX1xRSwZUk5mj59kKoKieIV++pDm7d30tMzGYhNWTfVruuObq9UEb+Go8gPT+DGHGsswXKkDaQkw4PAKf2g3/NUDCXhkSGHzLc4IInawpFwyq/zCopExYj+ZGJvTc+yyikjNNkncAslxmX87eW1/7lS2W/P1/2ZTAFuux5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482417; c=relaxed/simple;
	bh=R2ZCVf/VJ+iRyopKoIirxw/rsKraQlQIQ1btffSMMzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m29UI/hEoP11AonCrzlT13qntrhPvOjalO+eK05T7IeNdS5pl8FNOhKPN2JRrJR3mJ7Djj2G3tacFbLXX1C13tgS/tlcAnWY6SHZBGAxEYAIsWgZ0xNXG9SE+jPL1eAiS9xobJZfda0eb8tA3UnMoRr67HNbXxTxDM1hoGmoQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OeXqGBIh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF80F4E41760;
	Tue, 18 Nov 2025 16:13:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DCD5606FE;
	Tue, 18 Nov 2025 16:13:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6932E103713BD;
	Tue, 18 Nov 2025 17:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763482412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uxcBfrkPXkUZDJCua6/YvADKTChGewQXWcqnNL7MEe0=;
	b=OeXqGBIhdZxNA+eW+OsW2L1uhucZhCjnINSU7YwZNw2ln4iR58nCairvraJpTmV/z66+4k
	Rq8NJZXtzfuUgVrOETVeEf7YQbI4X+0PbsjtQGChRpnLisyeroJ//t5cIS8g8mBVe5usO2
	v/t8D+ZzxSe6z74Ga9V2hRERQUXgzmWX+D/vOIeEXTDxZhMGQjZEGA3KrKjkF563NESI2Z
	js+X0Pt4GHIQ5ozzCMzJaJVkGeq/jXAlbEwaFao7nPzzrT3WZL5djG097DjHaSIP/GfM3y
	tytFShOLkCxL8CXJ0MHBYAMaT22DGLcTtIIu6zu0G9vXlg/fwoK+c4xjtiAEKA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 18 Nov 2025 17:13:24 +0100
Subject: [PATCH net v5 3/5] net: dsa: microchip: Don't free uninitialized
 ksz_irq
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-ksz-fix-v5-3-8e9c7f56618d@bootlin.com>
References: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
In-Reply-To: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If something goes wrong at setup, ksz_irq_free() can be called on
uninitialized ksz_irq (for example when ksz_ptp_irq_setup() fails). It
leads to freeing uninitialized IRQ numbers and/or domains.

Use dsa_switch_for_each_user_port_continue_reverse() in the error path
to iterate only over the fully initialized ports.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b17d29dda612ce00ce2e52fbe16c54bd6516c417..49827ac770e6fcc9e4a1a11e8814cdd90b17473e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3080,7 +3080,7 @@ static int ksz_setup(struct dsa_switch *ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
 	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 out_girq:
 	if (dev->irq > 0)

-- 
2.51.1


