Return-Path: <stable+bounces-262113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /I13MbQdJ2qAsAIAu9opvQ
	(envelope-from <stable+bounces-262113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:53:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866B65A2CE
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=p88VSrN4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262113-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262113-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 889EC304045A
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152023E717D;
	Mon,  8 Jun 2026 19:48:38 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CA3E1D1B
	for <Stable@vger.kernel.org>; Mon,  8 Jun 2026 19:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948117; cv=none; b=QCUzW1kJ36fPPwMw43+azdeNYYibKmKyrcSkuRxgz8hRldVTSGRHL7HGNJTML+hkSUbhT0T4puxH1oAZjvySRCSYZuMxsqw4r/M54t/qItnJeFU0+dX9bdFJtNszcfGAZSgwtFo5++WkUJ9CdHum8l3wwpDaVYkSgJmLhRzzBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948117; c=relaxed/simple;
	bh=juX4Yl9k+TZUqIuZpkbMBRPd7OhlkWVjnGomziN0g+E=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LQ2D8Kq9jQ1src8YD3WGb5umHQPNwFKM0yLM8GiTJFHDeWFlN676LM6BCTBLWAg++x6QBLuQ4oc+qVSLhbYmopvtNAPPgUJK7z23GnALyOTHeKTM6SI5FqaYd99U0LZtDqcJ1slULBwim8+MoF7VBV5ZURcgE00Qj5VWDGHScbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p88VSrN4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97241F00893;
	Mon,  8 Jun 2026 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780948116;
	bh=x6KMKl5v5Q9o4O5yEwua/Hp70jB7vixjdWNYmuMzxpw=;
	h=Subject:To:From:Date;
	b=p88VSrN4QjMU5eufxjh5j3lfji5+p8JijG0bH3SoVOSBJinQAeHI5KZ6YjLEkLtEQ
	 d6cJgrIZoljk3z1BWvN7uxjg7TzDN+qv6kBQ4nQo/FSkXNXlf0NNfU23vAxc0lnQty
	 8DDtq63mHbpXQTw0Dq+FZ0oDLUzEFsN6FEeHyecI=
Subject: patch "iio: temperature: ltc2983: Fix reinit_completion() called after" added to char-misc-testing
To: liviu.stan@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:31:07 +0200
Message-ID: <2026060807-desolate-rebalance-2ed8@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262113-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:liviu.stan@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5866B65A2CE


This is a note to let you know that I've just added the patch titled

    iio: temperature: ltc2983: Fix reinit_completion() called after

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 5cb9fdb446bfc3ae0524496f53fb68e67051701b Mon Sep 17 00:00:00 2001
From: Liviu Stan <liviu.stan@analog.com>
Date: Mon, 25 May 2026 19:39:29 +0300
Subject: iio: temperature: ltc2983: Fix reinit_completion() called after
 conversion start

reinit_completion() was called after regmap_write() initiated the hardware
conversion, creating a race window where the interrupt could fire and call
complete() before reinit_completion() reset the completion.

Move reinit_completion() before the regmap_write() to close the race.
ltc2983_eeprom_cmd() already does it in the correct order.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/temperature/ltc2983.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 1f835e326b93..2bc5cd46a72f 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1177,12 +1177,11 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
 	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
 		sensor->chan, start_conversion);
+	reinit_completion(&st->completion);
 	/* start conversion */
 	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
 	if (ret)
 		return ret;
-
-	reinit_completion(&st->completion);
 	/*
 	 * wait for conversion to complete.
 	 * 300 ms should be more than enough to complete the conversion.
-- 
2.54.0



