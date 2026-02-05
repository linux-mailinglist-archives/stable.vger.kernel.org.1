Return-Path: <stable+bounces-214517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNJHDsXNhGk65gMAu9opvQ
	(envelope-from <stable+bounces-214517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:05:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D947F5A3D
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE20F3066BD5
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10C43C05F;
	Thu,  5 Feb 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0PpFXgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB3298CAB;
	Thu,  5 Feb 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310757; cv=none; b=XtdUyYhTdMWEcrrpOHZnAafRUz5KkkKshg+eLkeaPQJYiZjQw8Iepn+MFJCl2stlFuyVxwBelYfDhPzokg16wR6iIcyG8kTjM05YlWz4Nf6cR1mBtug0ylRAPRXo2xEpedZsxwcwMys6JQEWUFl27ULJJBHNQj1xuOMHw/jxWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310757; c=relaxed/simple;
	bh=mP8yGokYfLGhlSi6K4RLbVXmFt5viXyUB2cY2x1bWKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SClVEkhhnO78FEEg12iIHlH8fdR1m/HEe07f5a1jextPTRvqbHTIqruCMzrjwLETlSFbsZMgtU7ukgkkFJYBtZJvVjg3/jcAKDemAbCNDF5Mpt7ptsthH62gumkmchxln+grU1di20BRUgO5TCrUn94yXFSHGp0ADXcoZ4fZNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0PpFXgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13BC1C4CEF7;
	Thu,  5 Feb 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770310757;
	bh=mP8yGokYfLGhlSi6K4RLbVXmFt5viXyUB2cY2x1bWKg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=t0PpFXgghQDjNX0R/y5eKrLm4YNU1iHeCTD4gUyf8vfNJLdSXjALqcTXOyvQV6yfJ
	 tC+LlfLi1eLmgm6w7kuU7u6Pbz/uPdhL4EOci1Te0LjbBTYHnh0N6OJXfXAdXYTQKH
	 H7qsJ93VqfxRmHM/ksgIEpys2/1gSu4Us4VVLFKDaeA38fSiM8MuyuJYJZR9PX+WoX
	 GKnk9W2EpFYwgFBkdWczl3PLW6em7mEMis7WoSBrsKzNzJx3Uq0ilUctwohROl6xeJ
	 L5u71DhysmjqKnz/R5bVEJP5gyWtuk8Z/vF6goasFq1XB/FwWtC0aGWQHArC/0bPRR
	 T03JYr2FyHFGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC8ECD988;
	Thu,  5 Feb 2026 16:59:16 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 05 Feb 2026 17:59:14 +0100
Subject: [PATCH v3] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-inv-icm45600-fix-int1-drive-bit-v3-1-9c60c354dadb@tdk.com>
X-B4-Tracking: v=1; b=H4sIAGHMhGkC/5XNwQ6CMBAE0F8xPbumXSglnvwP46G2q2wMYErTa
 Aj/7sLFqx5nMnkzq4kS06SOu1klKjzxOEio9jsVOj/cCThKVqix0agt8FCAQ1/bRmu48UuKbCA
 mLgRXzuCiQfIVYYioRHkmktX2cL5I7njKY3pvh8Ws7e92MWDAoXdtiNoZq085Pg5h7NUqF/xTQ
 9EsOZm35I2tv9qyLB+o1hhNGgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770310755; l=2533;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=QGN91Pwgl8UMh04RqyiuclAgzRVc3mqHRx1WHkaYI5A=;
 b=/jwqFXltzDkd5c6YB8QcLqBmbzGhn2UTjgkWON97MSMAKH/RrTfWV2Lf7evT6QNJHnt2wcPAi
 js3C85/eo8KBWy8ZcU+SZo6bQ3xemS+oC246eqOjGHm/ljSDhcceTPq
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
	TAGGED_FROM(0.00)[bounces-214517-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
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
X-Rspamd-Queue-Id: 1D947F5A3D
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Drive bit must be set for open-drain mode and be cleared for push-pull
mode.

Referring to datasheet DS-000576_ICM-45605.pdf section 17.23
INT1_CONFIG2.

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Add precisions in datasheet reference
- Add missing reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20260205-inv-icm45600-fix-int1-drive-bit-v2-1-5e72608ea154@tdk.com

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



