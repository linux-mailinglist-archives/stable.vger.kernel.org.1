Return-Path: <stable+bounces-263035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sHRDOBlDLmoIrgQAu9opvQ
	(envelope-from <stable+bounces-263035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3626806E9
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vaK0vjro;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263035-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263035-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67110300B85A
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F72F12AB;
	Sun, 14 Jun 2026 05:58:48 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585D31618B
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416727; cv=none; b=uv9tOyL3NvMwOTlyIJbY1NGAUna2s7YFK5ArLgezNSDJmmCeKN88Bvd5ViRAF1h9irwQlwykJ9VYMakihckQvEYYUpi0k0G/bAgthTzsX+FSOLCZmpvPqTyj4P9jVZ3+hPq1/WjUwPxTkZygPAxFoEin9CGn61nhAOIrzYzydjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416727; c=relaxed/simple;
	bh=OrbITqzXqHCUhLfVP54yuT6cAFFuBxteMBsUdZspGfk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=epIsxib6eY5wy4wXhryQ5yCtJgOzx4E5Q2y7AdRvFXMGXNNhwl+oYWzaU5o59x/FbrjlQzUkDCFLBF8AmgsYy2ZUL1HU3k4ZiQ++wekipTkLv4/B7XJfjp5N0Eyn3iE/zY9CFnIaPjWbL21/y3sAyHAnfiQRtqG9gmt4437uGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vaK0vjro; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE11F000E9;
	Sun, 14 Jun 2026 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416726;
	bh=e22kTv/mo6yBw/gvpn7QWFhxXKsON0gD717qUPH65Dw=;
	h=Subject:To:From:Date;
	b=vaK0vjro8jlSQnkdd6Ouc60jwFu2YhFXUSUozOhzjhpNaiQlGMxr9hNYvQ8/4WL/D
	 fgAL5Pk3aIvWqbatGAOtb6aY03r84mVIYc6RIH13VGmE5wGu+GJcnC/KfwljtmQvD2
	 m6o1CA8efwyLEMuND0qHS0XB04Ul41zqy8gOd44g=
Subject: patch "iio: resolver: ad2s1210: notify trigger and clear state on fault read" added to char-misc-testing
To: sozdayvek@gmail.com,Stable@vger.kernel.org,dlechner@baylibre.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:19 +0200
Message-ID: <2026061419-taking-stimulant-d9cf@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263035-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sozdayvek@gmail.com,m:Stable@vger.kernel.org,m:dlechner@baylibre.com,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,baylibre.com,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D3626806E9


This is a note to let you know that I've just added the patch titled

    iio: resolver: ad2s1210: notify trigger and clear state on fault read

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 70247658d0e783c93b48fcbc3b81d99e992ff478 Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Fri, 15 May 2026 18:31:38 +0500
Subject: iio: resolver: ad2s1210: notify trigger and clear state on fault read
 error

ad2s1210_trigger_handler() walks several scan-mask branches and uses
"goto error_ret" to land on the iio_trigger_notify_done() teardown at
the bottom of the function for every I/O error -- except the
MOD_CONFIG fault-register read, which uses a bare "return ret":

	if (st->fixed_mode == MOD_CONFIG) {
		unsigned int reg_val;

		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
		if (ret < 0)
			return ret;
		...
	}

Two problems on that path:

  - the handler returns a negative errno where the prototype expects
    an irqreturn_t (IRQ_HANDLED / IRQ_NONE), so the caller in the
    IIO core sees a value outside the enum;
  - iio_trigger_notify_done() is skipped, leaving the trigger
    busy-flag set. A single transient SPI/regmap error on the fault
    read then wedges the trigger so subsequent samples are dropped
    until the consumer is detached.

Convert the error path to "goto error_ret" so the failure path goes
through the same notify_done() teardown as every other error in the
handler.

Fixes: f9b9ff95be8c ("iio: resolver: ad2s1210: add support for adi,fixed-mode")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 774728c804c0..1be19fe8aa3f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1334,7 +1334,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			return ret;
+			goto error_ret;
 
 		st->sample.fault = reg_val;
 	}
-- 
2.54.0



