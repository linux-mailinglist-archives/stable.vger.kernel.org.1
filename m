Return-Path: <stable+bounces-273950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9uAAtIqVWoukwAAu9opvQ
	(envelope-from <stable+bounces-273950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5374E610
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:13:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FR83AyLz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273950-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493A93006D5E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2B314A84;
	Mon, 13 Jul 2026 18:13:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B213DBA0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966411; cv=none; b=fCbRKTmq9ceYJRxcSE0onIxiou7rZQc3GBTz320fxX9ZOlo6pr2CPPFDm3hS/+ZCYSyaY/etdBtVMvA5xaLjSnZ/P4xwBxenY+kpQi2SEXPCcvWmCemWR0jfpodx6aoshXFU8iusIw/t2TIer6eI7P/CEjGiXoLYFUHzjOacX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966411; c=relaxed/simple;
	bh=s6yg6Id2DxDNmXho1lrHc6YBmSddikKGx3ZIN6EyEXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps30fHvcD6Lzqe3JyMOkrUVnrTEHc9ApuJcZKFAjeNfxn4Dm/AEe83/6ptVDRQn7VNOzEwM9Aky5bzZs0PkJxbrgyD27M2YKDvIfPmoxU9XrvLdxsph8EV9j9aQ6mbwl651XfxXv0uJeq0a713Y/lf4sZNEMLq70VAFubv32yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR83AyLz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E3C1F00A3A;
	Mon, 13 Jul 2026 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966410;
	bh=k8mmaq32H5+jT7Dp8ApIMkini6h8tUrLJqNznUhmrGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR83AyLzwZwR4GNOB8JfE/1Cm879LbBmqGfNbolviv7c14lGEvlvFpxyBsGc4Xq04
	 q/yfDbv40igLOv5R9VG3DMM4her4BHpa9j2PF053WN0O0CKgiYCtPZQmnanbYRCURn
	 iDo9se2pQIDp8CK9IEbekghd1L2y+L9WL0p9dSfQPtV54OveEZtWO2jwd9K+a3Ux1W
	 pttzjLKvxL8KitX9AFyxtsrvPvjUYSkfD2t6xxy8b9cKDe+yjvueA2XJkOhwtBZ311
	 N8tj/wtbey88Rq9i1pBKABYLCt3kM+sNIDsf6NcaIA0mMD3jf1toRoHmWKDAwrZR/5
	 Zb5NDW9QE1Ejw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Moelius <samuel.moelius@trailofbits.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: ad7380: select REGMAP
Date: Mon, 13 Jul 2026 14:13:28 -0400
Message-ID: <20260713181328.1932706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071354-cannabis-broadness-e866@gregkh>
References: <2026071354-cannabis-broadness-e866@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273950-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:samuel.moelius@trailofbits.com,m:andriy.shevchenko@intel.com,m:nuno.sa@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trailofbits.com:email,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16A5374E610

From: Samuel Moelius <samuel.moelius@trailofbits.com>

[ Upstream commit 6697091b386a4e2830bdd38512c87a4befff2b32 ]

The AD7380 driver uses generic regmap types and APIs. However, its
Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config
with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
to build.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 216f3c9ce183e7..57fc8f0de7b0c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -188,6 +188,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
-- 
2.53.0


