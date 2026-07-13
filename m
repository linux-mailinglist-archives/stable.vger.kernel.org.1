Return-Path: <stable+bounces-273947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qc2QHYsrVWpXkwAAu9opvQ
	(envelope-from <stable+bounces-273947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7874E66B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BafQ5NYE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273947-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273947-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B56330DE38F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12333BBBD;
	Mon, 13 Jul 2026 18:13:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445982745E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:13:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966400; cv=none; b=WBcMguKY71YkC6AV8V4Yc1mDHhoYqeOUEVFlYVFWcB7r9dR2bVr74tt8yuKrRgbUAWO4hMyOUb+ciX4HD1D/J51hEIuqsVrIhahxMAg6UyK0MtofMxT2mIlHze+KNZgo1/t1MLJzc6UKID4cnuZPeI11h+vKNxdGRB5ZR+lbA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966400; c=relaxed/simple;
	bh=nvgz8S/G4xOdrauZEYeH2t5Dk7LmnQ1Ehp6VPAXOSwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXUHIs+cMu4wf3J0VuuI2V9vW0GBK0nEeUyub9PRT9L+ewkWvktJGKZ1SZqzj8H8r2sBjZsleOWMZe1LDaZwJqG1qTfezWC77oEUgPkXnLZvUSl+HmyTx2FwfD1pQVzKMfnpO5Wsqd4OxQ6wsausuwvbg/Ay8+xNOk43hdUCnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BafQ5NYE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA58A1F000E9;
	Mon, 13 Jul 2026 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966399;
	bh=vSteEKYmc5eOugLiHW+eDmg4kcFWdCcEVkfvQGQ+QvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BafQ5NYEce1A+qePeXhjNshpk6k0Fz/et3UvNIVBdpTO81awDHVDS1kQIX+qLAfiy
	 uGTVsK2r30NQvJjPuwjB/l6HSt/u5EoyyF5M3v1tT+SSf7/s0cuUPysT4zVaygqoRJ
	 sx+p+xZ7L/mKzpqlQ5L6Bzt3ApVKHIWqr6pMAtu2+qZQS463oAmqUxNO+n7mBmvFOQ
	 D/AZXJjl5z8r674NhBhCGmb9RsDd9utI9VfYqhbtl1wbgY0wnbsNqVq7cRvA24j98s
	 Bvvo5avAH7Yb1OyYDkirjLpi/vqvbMoNNiIwcQBdGJvnyAuUaVOD9cSnG/gyj7hxMR
	 8jYMWAO2zsIEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Mon, 13 Jul 2026 14:13:17 -0400
Message-ID: <20260713181317.1932155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-clavicle-famine-67e0@gregkh>
References: <2026071352-clavicle-famine-67e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273947-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4C7874E66B

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 6e1b9bff1202da55c464e36bd34a2b6863d7fe30 ]

devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
through devm_request_irq() on the non-FIFO path, but it does not add
IRQF_NO_THREAD to the IRQ flags.

When the kernel is booted with forced IRQ threading, the parent IRQ can
otherwise be threaded by the IRQ core and the subsequent IIO trigger
child IRQ is then dispatched from irq/... thread context instead of
hardirq context. Because iio_trigger_generic_data_rdy_poll()
immediately drives iio_trigger_poll(), this violates the hardirq-only
IIO trigger helper contract and can push downstream trigger consumers
through the wrong execution context.

Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
non-FIFO request_irq() path, while preserving the current trigger
polarity and IRQF_NO_AUTOEN behavior.

Fixes: fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/adis_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index f890bf842db86b..7e18b31f9d7770 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -79,7 +79,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       adis->irq_flag,
+			       adis->irq_flag | IRQF_NO_THREAD,
 			       indio_dev->name,
 			       adis->trig);
 	if (ret)
-- 
2.53.0


