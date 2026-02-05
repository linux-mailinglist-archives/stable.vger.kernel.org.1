Return-Path: <stable+bounces-214514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OnyJ53GhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:34:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D70CF54AC
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A18304FC0E
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED6439004;
	Thu,  5 Feb 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNVQAxVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD923D3488;
	Thu,  5 Feb 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309046; cv=none; b=LCbaEovneVmg50rlNMF7Xc+xLD8TLWIAxNKKNv9dp+23pNCKUJZSsllEOgpD0XfsUq0BzmDSSUw7+9CTHmVE4o8/oiVM5c0RUPmsQhA7NLkipQFYOhkXtWdBaP1WrHRw3PK1kHx4qpLYP7diOS5dTsHXItT9zdYapjHhDg5B7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309046; c=relaxed/simple;
	bh=tjWEc+QIvDHg5HmIeJfrMw+WnRjBnZr25Lm4qlf17Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UeWTIvqioFCmdCsShZvR04gr4ujN4p0tkY6KefFQD524u6OqM/HjRvfNUxgsZ4Oq2o5f/A/E8gPEjOOkQCMqa9Hb8UdKxk8ttxZ4aY70+CuqsZLwpm08UKg3XBvpn5g1iB8+klmq//R9R1STSj87AkM1cua50mKW++sDyWGcLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNVQAxVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29B33C4CEF7;
	Thu,  5 Feb 2026 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770309046;
	bh=tjWEc+QIvDHg5HmIeJfrMw+WnRjBnZr25Lm4qlf17Rw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qNVQAxVNEdduJ7Bf8AYB4iVLOuJeOW/QuRYCjTOdUCaHlNQzQBywKeKJFBt6gaH7T
	 AV0Cc+PX6/Eso1TlhFjogToYXa8gsNlZlYyWYMptg/5QdUM+3q9s1hQh3bhUAxM2u0
	 s87Ps86AqhB1vzN6iYsx9Ak7VHb1COa+aqqHG4Y6Lllcibh1IXLn7chJZdy8iS4MtP
	 nIE8NWzR8TMCLWupVdSTWac9+ugpd8XLJyNPauWivebhfWqDSixlU2gOqq0LcAsDGQ
	 XuBLl/A/0eUpdoL+VG08MkW3WAFBISGd5R/lJY2us0T0TluKapTdjYhf2x/lx3hHye
	 sJ+/Ya0oWINqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15847ECD989;
	Thu,  5 Feb 2026 16:30:46 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 05 Feb 2026 17:30:42 +0100
Subject: [PATCH v2] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-inv-icm45600-fix-int1-drive-bit-v2-1-5e72608ea154@tdk.com>
X-B4-Tracking: v=1; b=H4sIALHFhGkC/42NQQrCMBBFr1Jm7chktI248h7SRUxGO0hbSUJQS
 u9u7Alcvsfn/QWSRJUE52aBKEWTzlMF3jXgBzc9BDVUBibuiKlFnQqqH49tR4R3fVeRDYaoRfC
 mGW0wLO4g7ANDrbyi1NX2cO0rD5ryHD/bYTE/+3+7GDRo2dmTD2RNS5ccnns/j9Cv6/oFpZEfh
 swAAAA=
X-Change-ID: 20260205-inv-icm45600-fix-int1-drive-bit-7d12ea3e2cd2
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770309045; l=2273;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=nOUJSmgm+rwCHt6TbRBvlTujMXE5wlAxMkqMG1Zhi8g=;
 b=6soWHK27tMui4BudiatfCAUTsLTVV+cgKhFrD9V/2pTHxunNaPuoag+7YDiCCz2FlSTTHaULq
 bnuKoNEGQ+ZDzxJZ5WeSjlA2Q7IJXqAeHorsSPcEfA2s1Xdloc685av
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214514-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D70CF54AC
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Drive bit must be set for open-drain mode and be cleared for push-pull
mode.

Referring to datasheet DS-000576_ICM-45605.pdf section 17.23.

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Add datasheet precision where to find the bits
- Link to v1: https://lore.kernel.org/r/20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com
---
 drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
index c5b5446f6c3b43150512bcc4357cee385080b634..1c796d4b2a4038203f734f80d7bf7bad138c3497 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -205,7 +205,7 @@ struct inv_icm45600_sensor_state {
 #define INV_ICM45600_SPI_SLEW_RATE_38NS			0
 
 #define INV_ICM45600_REG_INT1_CONFIG2			0x0018
-#define INV_ICM45600_INT1_CONFIG2_PUSH_PULL		BIT(2)
+#define INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN		BIT(2)
 #define INV_ICM45600_INT1_CONFIG2_LATCHED		BIT(1)
 #define INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH		BIT(0)
 #define INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW		0x00
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..b028044d609a41f6d4b747383323130ded0d2e79 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -637,8 +637,8 @@ static int inv_icm45600_irq_init(struct inv_icm45600_state *st, int irq,
 		break;
 	}
 
-	if (!open_drain)
-		val |= INV_ICM45600_INT1_CONFIG2_PUSH_PULL;
+	if (open_drain)
+		val |= INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN;
 
 	ret = regmap_write(st->map, INV_ICM45600_REG_INT1_CONFIG2, val);
 	if (ret)

---
base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
change-id: 20260205-inv-icm45600-fix-int1-drive-bit-7d12ea3e2cd2

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



