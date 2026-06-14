Return-Path: <stable+bounces-263048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qOHUAohELmqergQAu9opvQ
	(envelope-from <stable+bounces-263048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:04:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E468072D
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:04:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Hb/9uA7x";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263048-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263048-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FEBC3003D3B
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5302DC764;
	Sun, 14 Jun 2026 06:04:52 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC228B4FA
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:04:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417092; cv=none; b=sBu0lG0MGLubkhn/HnnzRKYAmoympMHbtATRySQrDQwdbfGsWOXyp9ZpfeR5roNDwisram/dawzNJa2Wap3L/3qlYJME1kQaHMMz63Ve2LQag8FMet7Hgc66lJE3ZoH6ZXATjq3Xzos+68L8WdaanFLgPXiP3p/SmbNP1Cic2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417092; c=relaxed/simple;
	bh=6DPex9KK2Cf5yygErYB1M2DKTiqubZhw+YE/Ha+unBI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=kPuAEjfW4MA/aQWGzQwWIIgus1XcTcLed3nJRGGTeOLrNTLjO+AOSlPcv/hCTdyrrDfkWUhrQ1nLAJ+T4NQQRZKSZFK6qWKdK3kq3oUdzlsL1ICZMYqyyXmeAJsQOpFvBIM9he8RL/o8G+XVeI45RCsC/tW2z1snDsGHnLnGizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hb/9uA7x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DAD1F000E9;
	Sun, 14 Jun 2026 06:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417090;
	bh=SDymjCF1aObKjhG8f+4uW5twTFkLXn6DNSSJIDmkQZA=;
	h=Subject:To:From:Date;
	b=Hb/9uA7xKPhmoMXWArxbtpEGSeYacOmDRey/Kw/9abPYjg4rXgqG+druQlEAsQyhy
	 fPRNMA/TTJPdQ2RJ/vnnpI3EECUKl88rUYYu+kWkLC37qhdoQZLqy2q6TIQCD8/+eV
	 CsxIma+upSCASAHnOUdEqa3iTmH1u5zIRZSF9648=
Subject: patch "iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths" added to char-misc-next
To: sozdayvek@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:32 +0200
Message-ID: <2026061432-moisten-unguarded-5cf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sozdayvek@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D55E468072D


This is a note to let you know that I've just added the patch titled

    iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From be843b0579f872ec7590d825e2c9a656d4790c4b Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Thu, 14 May 2026 19:37:10 +0500
Subject: iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths

vl53l0x_trigger_handler() returns directly on the I2C read failure
paths without calling iio_trigger_notify_done() or vl53l0x_clear_irq().

A single transient i2c_smbus_read_i2c_block_data() failure (negative
errno or a short read) therefore leaves two pieces of state behind:

  - iio_trigger_notify_done() never decrements the trigger's use_count,
    so iio_trigger_poll_nested() silently drops further dispatches
    (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
    guard);
  - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
    chip keeps the DRDY interrupt asserted.

The sensor's buffer mode stays wedged from then on, recoverable only
by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
exactly the same case correctly by jumping to a "notify_and_clear_irq"
label that always calls both helpers; mirror that here.

The bogus negative-int return value cast to irqreturn_t also goes
away as a side effect.

Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47fa8..6c6e6dab045f 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					VL_REG_RESULT_RANGE_STATUS,
 					sizeof(buffer), buffer);
-	if (ret < 0)
-		return ret;
-	else if (ret != 12)
-		return -EREMOTEIO;
+	if (ret != 12)
+		goto done;
 
 	scan.chan = get_unaligned_be16(&buffer[10]);
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 	vl53l0x_clear_irq(data);
 
-- 
2.54.0



