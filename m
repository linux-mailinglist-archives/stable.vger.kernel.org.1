Return-Path: <stable+bounces-247278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OU9AgwaBmrGegIAu9opvQ
	(envelope-from <stable+bounces-247278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:53:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60785546119
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 346D53034657
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012033DEE0;
	Thu, 14 May 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG01rLHx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456F1E7C2E
	for <stable@vger.kernel.org>; Thu, 14 May 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784617; cv=none; b=WYjeXqnfmrSdNVG+FN8bga3tU7nEhkZW0PfoZCuERuyMEmbEjCCidU8I0FmobHrva5VHaSAsbz3HNDh/ltHrbC+r5B3qrNoifi5y224TZ1Sz1dFCWWukdpoBj4nBbakqqJqUOBpAjN3vR+mqiDEW9sJog2GjZ6VsyFoFs8Q6lGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784617; c=relaxed/simple;
	bh=kBHq/vtLkiI8Iptxy1KjJ0JkxfILDYG7zLOjqCdHRvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0+SO9GYcf6X+hkPBAislC+FvhmGrT80UOPIBrNOiGX5nqLqRiSkS/jvmrXCuDHCIhOmPcC8RA2YuhpEcuLPu5OvHPQafmOK+36zZP9vMUxflg56fvawKc5z04k5U5twy8BDcGp8n1srSB+SBnkyJAZbvpzGF95hDl8HYQ38NDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG01rLHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1FFC2BCB3;
	Thu, 14 May 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784617;
	bh=kBHq/vtLkiI8Iptxy1KjJ0JkxfILDYG7zLOjqCdHRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG01rLHxGMygb2A6PqI5PkGOkimRzZPl5R5IVU/dtW1k+qK7GZdsnHWRNiv7cvfws
	 rI5ztJypmSKnyxJui/0WqBr3MH5kITAPfsX4SSKmlO9n1ZrZYPVtxKvwE2cn3cAzoX
	 UPtKXIZzorYMnsfpFeQIQwuoAQT9nxpyU12Q74z6r6KmnStpl1iC6uuOKDCgGsKdp/
	 c4hQs2d1WpKe8yI8Sp2ebjv663QO+xWCFV9+AeezfZR3f1lRpi6xlqKSlVGE2zJsdE
	 Czr+sID46E0dPokHnZaEcegYIEUjsp8WCl2qI3AuQdS8dgXK7XV7wGEFN3jVlIgUW4
	 x98MFpq2Vxjcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] spi: microchip-core-qspi: Convert to platform remove callback returning void
Date: Thu, 14 May 2026 14:50:12 -0400
Message-ID: <20260514185014.948789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051251-distaste-stardom-583e@gregkh>
References: <2026051251-distaste-stardom-583e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60785546119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247278-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e4cf312d6db2941b8267de6e094312afc1b523ee ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230303172041.2103336-37-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e6464140d439 ("spi: microchip-core-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 620c5d19031e2..32a0fa4ba50f7 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -567,7 +567,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mchp_coreqspi_remove(struct platform_device *pdev)
+static void mchp_coreqspi_remove(struct platform_device *pdev)
 {
 	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
 	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
@@ -576,8 +576,6 @@ static int mchp_coreqspi_remove(struct platform_device *pdev)
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 	clk_disable_unprepare(qspi->clk);
-
-	return 0;
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {
@@ -592,7 +590,7 @@ static struct platform_driver mchp_coreqspi_driver = {
 		.name = "microchip,coreqspi",
 		.of_match_table = mchp_coreqspi_of_match,
 	},
-	.remove = mchp_coreqspi_remove,
+	.remove_new = mchp_coreqspi_remove,
 };
 module_platform_driver(mchp_coreqspi_driver);
 
-- 
2.53.0


