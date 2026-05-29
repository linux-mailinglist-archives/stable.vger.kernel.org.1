Return-Path: <stable+bounces-256736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIWROFTpGWpazwgAu9opvQ
	(envelope-from <stable+bounces-256736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:30:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99279607E42
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D23530EA75A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9C3AD539;
	Fri, 29 May 2026 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwJLeXZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1688390C94
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082634; cv=none; b=cvHqoxTqh3uW7vNy0w2jgEZjggCaqBGrBgOfmSFFsRGDOS/SqOmoB3bOmS52P7TsaiXTM264TIu+PVn7JayWd4HL+IbPBoolGAn3z8NT55g+F1fB6QvIcJJqRgLOc2vHfWEz1hbvsfRRYZzNtHNErhhT6UR25QkDXpfrGsT8/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082634; c=relaxed/simple;
	bh=dPPhH3cDAwr8Rr+OV0IEM4VGGStaGwTu36JQNms8Gxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZN4dUUWW0OQ/CaI4P4Glv/7Up9f1pKY2yxOXEkIEmn5+N3eHg+Af57PuCtwg3Ym7dpCorGmf+3CnKQ60GXuxZNsRwplFn6FAQqXWLdWCYH29XENlCU0ypO+f2cYVhNZc/v9m2jO4cv4mJAyKJsOXwwS8RuRKya9xTPcT6BzdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwJLeXZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8C1F00899;
	Fri, 29 May 2026 19:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780082633;
	bh=ZDKK2/NNJyv0QIRgZCuI1LP+g8mJW7jD9bgX/vdlWk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwJLeXZvmJZHCQvlVC2u0B+vU5LAyM9TOy7UPhvB5T+8TOjbnAVNnmMft4E1/NtO+
	 u07Lb1jKeKD9gdGEp+Gt6uMiEy2NGnBiHsYZ9GmC8+iQqr87+BSuyMSG4pp2Ja1TjR
	 MeFWjbETIJc2z4JxV5ZZfK1bV55x+ZA8rBteMvy/sjzUoOfV0KXKbNbB1ZPMncd/5Z
	 CmH0JfHVFp5oxgUT/YrVreOHZoNZdjgp1j/FRrBonnoqQNI0rM8cNyjS6utGBUfLrm
	 vYtI6oUtka8lEucqSJQZgrlU/BSLJ9H0K7E5/22BaeXNRCm/iKqGuBUf3o9FC5sk0F
	 vPRLsK5AGg3kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] Bluetooth: hci_qca: Migrate to serdev specific shutdown function
Date: Fri, 29 May 2026 15:23:49 -0400
Message-ID: <20260529192351.1696591-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529192351.1696591-1-sashal@kernel.org>
References: <2026052858-skies-gills-0f98@gregkh>
 <20260529192351.1696591-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256736-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,baylibre.com:email]
X-Rspamd-Queue-Id: 99279607E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 12a6a5726c515455935982429ac35dee2307233d ]

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/261a3384e25c4837d4efee87958805f15d7d4e3c.1765526117.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 375ba7484132 ("Bluetooth: hci_qca: Convert timeout from jiffies to ms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c0cc04995fc2f..ab6bfc1d71978 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2567,11 +2567,10 @@ static void qca_serdev_remove(struct serdev_device *serdev)
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
@@ -2793,11 +2792,11 @@ static void hciqca_coredump(struct device *dev)
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
-- 
2.53.0


