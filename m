Return-Path: <stable+bounces-256984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPXzKeIRG2qC+wgAu9opvQ
	(envelope-from <stable+bounces-256984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE160E47F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAF53035834
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD234104B;
	Sat, 30 May 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWGbNHj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6D13A244;
	Sat, 30 May 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158428; cv=none; b=lMSp7CN0y5h/Bw5wdr4+2SEgI/QsCifh8EC1Y3CC0HLyacAEV/niFRr9fz8YxlITVMojPqCvv3r5sCAlMAkywJe/jMOfyQYdm4S0iOZ/zjm9k1OF1PVMQP25bstFVEhQn9qbT7b8Fq8wMfXGlkxrhP3vQBsUmUjxUjObSfOO2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158428; c=relaxed/simple;
	bh=V+1s4OxJVugEJ+lpZo6dzTTFDcxqq7RZHr+WE9T4ZuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeoFamKr3zmG3am6NpLb4+25RSmMlQ96+6F400K2X7SOHwIwrHLXBaQn3EHSC35xQB2CUxXKYX27irwTHI6MUV4ue4odsynLRJDM4uPPJB8iuOWk4pomqED6bcFS3eT+INJfn27HOFyriUuIcb/gzq5zxIG2a1e3Rw5mTsamIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWGbNHj7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543B81F00893;
	Sat, 30 May 2026 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158427;
	bh=tzgSO1haU2BoclN6nKGDPv7i2qdNbvkAt44fVpka+P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AWGbNHj7O5vj+vQeBLfgu1e9cr8Mr7z9dsHeoudO+dM7gxEYXXEcAxkyiMWlJpq5a
	 zw80Xi/JiybWdhitINywJwc7xgKg3anwZeDRTsYXEVn7MyIYL6WFzh9zMeoEeoIlPf
	 vSMQo7ui1ZAJuISdq1nLqOzWaVQRiLhlSZ6H792k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/969] gpio: tegra: fix irq_release_resources calling enable instead of disable
Date: Sat, 30 May 2026 17:52:54 +0200
Message-ID: <20260530160301.782680161@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256984-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 27AE160E47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit 1561d96f5f55c1bca9ff047ace5813f4f244eea6 ]

tegra_gpio_irq_release_resources() erroneously calls tegra_gpio_enable()
instead of tegra_gpio_disable(). When IRQ resources are released, the
GPIO configuration bit (CNF) should be cleared to deconfigure the pin as
a GPIO. Leaving it enabled wastes power and can cause unexpected behavior
if the pin is later reused for an alternate function via pinctrl.

Fixes: 66fecef5bde0 ("gpio: tegra: Convert to gpio_irq_chip")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Link: https://patch.msgid.link/20260407210247.1737938-1-samasth.norway.ananda@oracle.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 5b265a6fd3c18..49ff77c3ad198 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -597,7 +597,7 @@ static void tegra_gpio_irq_release_resources(struct irq_data *d)
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 
 	gpiochip_relres_irq(chip, d->hwirq);
-	tegra_gpio_enable(tgi, d->hwirq);
+	tegra_gpio_disable(tgi, d->hwirq);
 }
 
 static void tegra_gpio_irq_print_chip(struct irq_data *d, struct seq_file *s)
-- 
2.53.0




