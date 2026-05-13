Return-Path: <stable+bounces-247024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG3eDkLSBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF853A039
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDC7A303B15E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37A3AC0F0;
	Wed, 13 May 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxQ5PlkI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE43B0AD0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700864; cv=none; b=SOlKT2FgutjryybJR/cnrrevnAVoj5mjnR+sqgLbvHFjjmVN9e35AOb/+oRTAglwp0FypgwyWoqpyRD34gPLbx0SZa8YKX4/kMjxRZHRSjC1GSZWBsOx/8yh/8wMQ9rjuW6ktSwv89IvawMjNxRjFclx6eqchPFtHyNt2XOSHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700864; c=relaxed/simple;
	bh=yfkzFe5fuyhZJIFnMvfkcCOhn5p37FjhE7s7f0iarog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImrP+YVlmxJxFn3+RVlE7b/9vYIdXquWoMX7YjHk18gyP3f2q+WcvCkxf84yCeN8pqtKt6w/ULrqn+Hf4XuEhbqT5+fYZnEutfkTl6onfblEjhv4qnwHDMgrYlIcUDrck6qeTY/nMu4j3MbztPZ0Fv+LHdWa36+5Yy7+NbEyPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxQ5PlkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D693DC19425;
	Wed, 13 May 2026 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700863;
	bh=yfkzFe5fuyhZJIFnMvfkcCOhn5p37FjhE7s7f0iarog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxQ5PlkI20BKbnODfDHISSoQcL8+jij//Y3qtiBYRLWa6Rn0y5iz7qkgtIf15np9/
	 54yg31bQ2UISmGpLxD+fQTB9KuKEQRh4ksv9BbpxyxaZf6vMv9EPp+70AaeRhGxe07
	 1v9gkABV6v7OelE3N+JeENNMnpKDTIZ+fr9lE1Ljy8add6T5fY62755Hi8VHn/0AU5
	 LcH9XkRzj6C871/Ag6tCKIWH7shVGDA91uj4XkkmBwY+OtrpNxE5izZSnc09Jwh8FF
	 WT6cEtJ613CR6EadicyRtAhd9oo12TJBScq1AzCCwFhvpUxacp4mMqYrXhHywQZr6K
	 P1JUeSJR5ZUHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] spi: zynq-qspi: Convert to platform remove callback returning void
Date: Wed, 13 May 2026 15:34:16 -0400
Message-ID: <20260513193420.3938432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-regain-crablike-8461@gregkh>
References: <2026051203-regain-crablike-8461@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9CF853A039
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247024-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit ae9084b6458d34ebf3e377d0407ebe513e41ac71 ]

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
Link: https://lore.kernel.org/r/20230303172041.2103336-87-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c9c012706c9f ("spi: zynq-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 77ea6b5223483..6f248520c6381 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -750,7 +750,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  *
  * Return:	0 on success and error value on failure
  */
-static int zynq_qspi_remove(struct platform_device *pdev)
+static void zynq_qspi_remove(struct platform_device *pdev)
 {
 	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
 
@@ -758,8 +758,6 @@ static int zynq_qspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-
-	return 0;
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
@@ -774,7 +772,7 @@ MODULE_DEVICE_TABLE(of, zynq_qspi_of_match);
  */
 static struct platform_driver zynq_qspi_driver = {
 	.probe = zynq_qspi_probe,
-	.remove = zynq_qspi_remove,
+	.remove_new = zynq_qspi_remove,
 	.driver = {
 		.name = "zynq-qspi",
 		.of_match_table = zynq_qspi_of_match,
-- 
2.53.0


