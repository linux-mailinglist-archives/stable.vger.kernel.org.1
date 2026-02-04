Return-Path: <stable+bounces-213387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG8fIK9Vg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:20:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A9E6FAA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0242C3069AC1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAEB40FDB2;
	Wed,  4 Feb 2026 14:17:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F340FDB0
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214621; cv=none; b=f2cf+aFS/FRa6qd5st5buDue/ZFf4u+kj2VbSHLXLEFo/90B4TeDb1a3Dk1d6bL3Xr5QTcH147O9Uc4c9IBaBQKS8vQOTv0y+ufRFojp7N0KDGIMMwBxpGsQ6DW7+s4gQOCbtshrdx5pjzUQB+yPPRYlxTFl0odPeWNBvfQ6W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214621; c=relaxed/simple;
	bh=2tfIF2QRzY+YjUMu1szlWjAHE9E91jnRWA4UksvPcTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXyOADg8jkASnJqCGMBaunBlKhzwh1t3GlHIbHVIU/wokjsX2ZIcUjYYUW18IfhKCVUIsGdTU/YY5T2SZ1Od81IBz+tmLXBsBlm8XsTFWxWxMKafWEVFVikzre5HEqMFh2kjgogruC4hn7vS44m6yXw5PfwWj88b0S+R2MQqexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qh-HN; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FE-18;
	Wed, 04 Feb 2026 15:00:46 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dfU-2VRA;
	Wed, 04 Feb 2026 15:00:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v5 01/13] iio: dac: ds4424: reject -128 RAW value
Date: Wed,  4 Feb 2026 15:00:33 +0100
Message-ID: <20260204140045.390677-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204140045.390677-1-o.rempel@pengutronix.de>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213387-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: E42A9E6FAA
X-Rspamd-Action: no action

The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
in hardware (7-bit magnitude).

Previously, passing -128 resulted in a truncated value that programmed
0mA (magnitude 0) instead of the expected maximum negative current,
effectively failing silently.

Reject -128 to avoid producing the wrong current.

Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- no changes
changes v4:
- Restore v1 implementation: Keep this patch as a minimal fix suitable
  for stable backports
- Move the refactoring (bitwise operations and GENMASK usage) to a
  separate follow-up patch.
changes v3:
- (Merged into refactoring patch in v3, now split again)
---
 drivers/iio/dac/ds4424.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a8198ba4f98a..059acca45f64 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -141,7 +141,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < S8_MIN || val > S8_MAX)
+		if (val <= S8_MIN || val > S8_MAX)
 			return -EINVAL;
 
 		if (val > 0) {
-- 
2.47.3


