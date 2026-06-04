Return-Path: <stable+bounces-260524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MpH7A2yWIWrIJQEAu9opvQ
	(envelope-from <stable+bounces-260524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD96414D8
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:14:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W2mJ4b1s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260524-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260524-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC125316966A
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE813254BD;
	Thu,  4 Jun 2026 15:02:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6ED31E83E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:02:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585334; cv=none; b=lDXgy4kHvLaQO3qVu8AHG6MZYVA1Qg1b5hnUdNobjx5fSsh4G0r34XN1CCTBQ2lkXrLPaMuvaiLKgTV//51wl5M+/JAGHR0pvBdcFxaF+DpIjn25ojjwLjTPqi9r3HjlK8/gzUHw7Qst+nLon6tA9mrpUI0qi4Q0t8+EUkCxi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585334; c=relaxed/simple;
	bh=1e2GJFeqdg/CIB55MHDX+2o/LWIyElc6EdYijmBzUn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QO0H2APpWobAHJqa1ROKsiF6SHSBpT6YizdkCfAEXYsKqKzG3eW3QKoTFXBQ2F9MWhvtILAUi6N5ytPp+G2jngZX8yHHyqh+JAfSjxwSrA/X2mA1wtCxb/I7crtHdvzGKqivGumKDdkaVmGYKwq9sQnHaw549ePWdbn0jOQUEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2mJ4b1s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73F31F00893;
	Thu,  4 Jun 2026 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585328;
	bh=gg+6qdiyjUFOwJv1uo5I7LvR2s8Vby78Q/pP4F+Mz5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2mJ4b1s++GbZ79H9fqISh9cyzLJfRUffOwls91Te6solnsFDLqSOcH9Rcn/AY0YL
	 j3Ru2gtsQT7wpTGsvNsXwUHW1Mkl7AgAGh0t7aVGSbH4sDli2XSIK6JewM5Np932BV
	 Vm7CTMdMNoFg8taIRPS+Xz9avBtH+n67VI1VwZbOQpuM45OwkMC6vaZ071xuGdRB0f
	 0c4Omyly55cJ5jJ7H4yo1ajzreAwq7uKC5fEeeYIVrxZ6ksXxqkmNzEhvLliRPtrAS
	 xFHEjZOkgGuXAdOGJowR/JfNOcR1ENrYi6RlY1NVK0rauMJe1Re06A7O8uwh8TPXtl
	 syAxE9kKRPE7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: dac: ad5686: acquire lock when doing powerdown control
Date: Thu,  4 Jun 2026 11:02:04 -0400
Message-ID: <20260604150204.3692750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060458-baked-charter-80ae@gregkh>
References: <2026060458-baked-charter-80ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260524-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rodrigo.alencar@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78AD96414D8

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

[ Upstream commit 5237c3175cae5ab05f18878cec3301a04403859e ]

Protect access of pwr_down_mode and pwr_down_mask fields with existing
mutex lock. Each channel exposes their own attributes for controlling
powerdown modes and powerdown state. This fixes potential race conditions
as those the write functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5686.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index be705f8148cc39..b6e239821980bf 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,6 +30,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
 }
 
@@ -39,6 +41,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -57,6 +61,8 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
@@ -77,6 +83,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else
-- 
2.53.0


