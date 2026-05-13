Return-Path: <stable+bounces-246980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMceKSG7BGrFNQIAu9opvQ
	(envelope-from <stable+bounces-246980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196315386CF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E615F310C812
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EB4DC536;
	Wed, 13 May 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C97xEnMk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33C4DC530
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694304; cv=none; b=pE3ls1myGrbih5vm0HHMmFrZPR8FKsmNXyrXQUhCYmVa8/WCi3UjLlOmhOqv7/53H+6Lu5kYWex86l9qS4Fg3J7pnyl+u/1JTpFR4hejRXZ4Z924SJpDwU9lFbuyY12Oy0+Fstj3sTCjZNqz5epQW5jDTJAi/hZdirchJ60JGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694304; c=relaxed/simple;
	bh=ECnJbX+H8F148r4xsz1ZZRBCcmTDERFUeqU3pwUH0vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om9/HPZWi4ubVRP9D7O9bNpqzPVt3GYmeD1xF8fCv8nbwz7TUQ9VYHMzcPPQf1iNDrEBtfZjWqaM5w2wrSNR6WEkGtimPgKgx13zIUWOjur+KOs2CqYxTfRcQYzaaaDfY41McN0yAQxL816U1HOtPp8uDOUxxt0vIMbZrHgfm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C97xEnMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF40FC19425;
	Wed, 13 May 2026 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694303;
	bh=ECnJbX+H8F148r4xsz1ZZRBCcmTDERFUeqU3pwUH0vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C97xEnMkFIhK7CgK9OlqOlt7iDNpKpb0Jl5x+rNPxHx4Qm1519vs8+Nt5/bAli0YW
	 iuOttrYVHws68o42OPnb9S6Lvphzbf+wp3XllmnECBEqMJMh3A5PaRDePUeRj9vcM4
	 OcnnpHHOj+DLB5uTC/BfJJh2i6Xkpq4X1h9DuinQJNbXfYmVkwxOpepMPYqlGIr8MW
	 vrVMjYERJYGaoWWzO2/1yTraYvc8aHdnXNz1K8ad2aF+V/POGEIk7MrAYX59bANxj4
	 udE/2taIxN4PrKMgCAkvndE0Bh3mLc8/Ijkf7LAiErakWhL3dplnzdfutUbpzSXlLR
	 qAci/uXSABjWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] spi: sun4i: Convert to platform remove callback returning void
Date: Wed, 13 May 2026 13:44:59 -0400
Message-ID: <20260513174501.3896424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051252-unproven-faculty-80e7@gregkh>
References: <2026051252-unproven-faculty-80e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 196315386CF
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
	TAGGED_FROM(0.00)[bounces-246980-lists,stable=lfdr.de];
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

[ Upstream commit b7b949458ac391963e56ae354b73fee63016dcee ]

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
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Link: https://lore.kernel.org/r/20230303172041.2103336-75-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 42108a2f03e0 ("spi: sun4i: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun4i.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 6937f5c4d868f..b7ce4ff91193d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -519,11 +519,9 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun4i_spi_remove(struct platform_device *pdev)
+static void sun4i_spi_remove(struct platform_device *pdev)
 {
 	pm_runtime_force_suspend(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id sun4i_spi_match[] = {
@@ -539,7 +537,7 @@ static const struct dev_pm_ops sun4i_spi_pm_ops = {
 
 static struct platform_driver sun4i_spi_driver = {
 	.probe	= sun4i_spi_probe,
-	.remove	= sun4i_spi_remove,
+	.remove_new = sun4i_spi_remove,
 	.driver	= {
 		.name		= "sun4i-spi",
 		.of_match_table	= sun4i_spi_match,
-- 
2.53.0


