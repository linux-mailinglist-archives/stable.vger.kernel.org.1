Return-Path: <stable+bounces-265659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZ/HCtqNMWo0mgUAu9opvQ
	(envelope-from <stable+bounces-265659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:54:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EAB6939EE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nTjs5aEr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265659-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265659-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF233011772
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4847A0C4;
	Tue, 16 Jun 2026 17:52:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB794779B1;
	Tue, 16 Jun 2026 17:52:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632329; cv=none; b=s/oWZodUpaBo9/qRN5Xh7LXiYW+yZydXiEMTbnsfotfH5ypTDWI8/pysmty5dkmJbbxu9tE9IDsNUoWM5MhVGoai8uDRbIBZQ+cWsRo0WgudieWdU6fIPvWbHCklpboxMBtrCWiOk8b8yTkKqplEJMcHRXU3my3W8Liwjvcc2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632329; c=relaxed/simple;
	bh=esDB6p56L/baquA6EfvPdK7nZEo7gvf/3OEfHXCD9bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehvYxkvr7HaHanR2dh1zMrNrRH6EgeT6nCiAQoiTiDGxoyJX1qo6yvD54uDfiu8AwNNjOO93NIsDBjUG/DxtTwB1O3ExG3/6o5Lg+4lYz0d5zTTMKogphfkgBLnRYjR5jJZhchdt09tw4GdueYDeBMxYFL5Pj2jJUzfFWbmXURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nTjs5aEr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F5D1F00A3A;
	Tue, 16 Jun 2026 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632325;
	bh=quLLk3Efft6+0rCwGHROI/eBN/pTxXbS2ZMOVw+TfVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTjs5aEr8yrZnZ27qWOMZZc8ivy0IlbhcGkNRUolvDGY3FPv9jAcH0ch3sVWeeuG1
	 zm/xXAgjGiay0zSdxICG3blK2OyqfttNJ69ckgaL7XAK06HC0xDWvEP0BeB/A3/zSq
	 R9The40MXbLWyKNPJwQ54puFbiFsJOUbMffRySSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 389/522] spi: zynq-qspi: Convert to platform remove callback returning void
Date: Tue, 16 Jun 2026 20:28:56 +0530
Message-ID: <20260616145144.001679316@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:u.kleine-koenig@pengutronix.de,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265659-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0EAB6939EE

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-zynq-qspi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -750,7 +750,7 @@ remove_master:
  *
  * Return:	0 on success and error value on failure
  */
-static int zynq_qspi_remove(struct platform_device *pdev)
+static void zynq_qspi_remove(struct platform_device *pdev)
 {
 	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
 
@@ -758,8 +758,6 @@ static int zynq_qspi_remove(struct platf
 
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-
-	return 0;
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
@@ -774,7 +772,7 @@ MODULE_DEVICE_TABLE(of, zynq_qspi_of_mat
  */
 static struct platform_driver zynq_qspi_driver = {
 	.probe = zynq_qspi_probe,
-	.remove = zynq_qspi_remove,
+	.remove_new = zynq_qspi_remove,
 	.driver = {
 		.name = "zynq-qspi",
 		.of_match_table = zynq_qspi_of_match,



