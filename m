Return-Path: <stable+bounces-261826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PTXYBn5VJWptHAIAu9opvQ
	(envelope-from <stable+bounces-261826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:26:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F726506BF
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GAdeFBJJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261826-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261826-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18509309EF9A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87DA331214;
	Sun,  7 Jun 2026 10:59:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322EA334681;
	Sun,  7 Jun 2026 10:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829999; cv=none; b=FBUiuofffTnNKUYsbQUrh5A/vTsjP87slCh9QVoo5tieuZU/mdL7KRG3p23FPk1b3qH1iswru1Cxu56LyzoPGV0vhBZOrmp27ZtW5eMJsbnMyVz//SAGE340R24u0XmIlJQtQ0H2GD6B5syYnt47pTtF5AGMhY/m2Jp/o0kmFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829999; c=relaxed/simple;
	bh=AudwLTs1u3pPe1fjL+Kr7KQahWZV9uE2l1RB2idEy0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGNryow27wV+BrYBfkXZZpdWK7JUIaudxGAKfNitbMpMwaLa7vOPq3kM+4I/wYqi4nbz7gwb5JTi8qLQ+60NxXsNwssxWEuk42NEd8E1CBTnf2aVF6GspKPrxjgkc8/LaWSMyVya8YtWlIm0575ZYasy7Xb44N/JKFt/Vh4u3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GAdeFBJJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615061F00898;
	Sun,  7 Jun 2026 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829990;
	bh=L0rRBV8DcHLHraFVrE3icZGQsVpuxAMMhTDY6ofF1bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAdeFBJJQp6OBWCqhldfumnmW8bUDjTBRLHaDbr71W/Gh5NI1PLw/BghszxjWCG0I
	 rjK4Oa3Az/3tObUl3anSNv44XOQ3jVBSQQ7LE3fNHrTbIAf1NpttV4upgMPbdr0vMm
	 3nZM/mv1h/FccFBGXhNGDX1qyco8AWZkiqIefhSM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 271/307] Bluetooth: hci_qca: Migrate to serdev specific shutdown function
Date: Sun,  7 Jun 2026 12:01:08 +0200
Message-ID: <20260607095737.664302624@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:u.kleine-koenig@baylibre.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261826-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F726506BF

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 12a6a5726c515455935982429ac35dee2307233d ]

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/261a3384e25c4837d4efee87958805f15d7d4e3c.1765526117.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 375ba7484132 ("Bluetooth: hci_qca: Convert timeout from jiffies to ms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_qca.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2516,11 +2516,10 @@ static void qca_serdev_remove(struct ser
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
-static void qca_serdev_shutdown(struct device *dev)
+static void qca_serdev_shutdown(struct serdev_device *serdev)
 {
 	int ret;
 	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
-	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
@@ -2741,11 +2740,11 @@ static void hciqca_coredump(struct devic
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
 	.remove = qca_serdev_remove,
+	.shutdown = qca_serdev_shutdown,
 	.driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
-		.shutdown = qca_serdev_shutdown,
 		.pm = &qca_pm_ops,
 #ifdef CONFIG_DEV_COREDUMP
 		.coredump = hciqca_coredump,



