Return-Path: <stable+bounces-261808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /7KZJt9OJWrKGgIAu9opvQ
	(envelope-from <stable+bounces-261808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E06502DD
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:58:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=X6LKU4qq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261808-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261808-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D58323004CA1
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CC3264F2;
	Sun,  7 Jun 2026 10:58:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021212CDA5;
	Sun,  7 Jun 2026 10:58:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829914; cv=none; b=Rmvi88VVa0cYXKu+FxoncDI4cejJWY70rPZORAE4Hceu/+KClKYb0Rd5Vf0dUi9Z9Dtuf9khb50aXcEHGTraNICw7pU22bM2i81X0pAcv35akv7ebb9yFrPYV4v2uMHA2/CGLi3Af9PAo4O9Dhtb9cS8TsuAkRWXEwAGDyQWaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829914; c=relaxed/simple;
	bh=9RIWgkOhIK6Wui6/0T8k5XIpH7iBmI24/TiXrfesEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKTyJqKbkwqX99r9M7DeA5gOpEhuph43ckdJUBtUOAdb6qKVpFtulv4YXNrV6pKKNc8J8Y556HuX0ieHbYnomuc2/YuvwC7erthLZzMwHL4Utx2JHePnPVK7eYRTHGNCVxg7ZnyIB6V8LB10C6BNIskT8TBeYG9qYtHEzjb9eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6LKU4qq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9671F00893;
	Sun,  7 Jun 2026 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829912;
	bh=uAB6eM4/33hidlQQIon4ESlj3IiamC0CJTSZJA6m+yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6LKU4qqJm1MlqU99EMHFV+/fZxAQEHbb8xzWSb1jl2hXrqabGtCv19QIEqovol9u
	 oGg1xBFmnGppFd7j2T5h351SBEZjjzNygG9C5T6CxhKi0rYHm/BveoY3ef3rwBvufg
	 m4yz5wVNfOC9cUqn/T8C8TqFkEGOO46w5rGLQH0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 289/315] Bluetooth: hci_qca: Migrate to serdev specific shutdown function
Date: Sun,  7 Jun 2026 12:01:16 +0200
Message-ID: <20260607095738.208478629@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-261808-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B7E06502DD

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2567,11 +2567,10 @@ static void qca_serdev_remove(struct ser
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
@@ -2793,11 +2792,11 @@ static void hciqca_coredump(struct devic
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



