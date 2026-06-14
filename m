Return-Path: <stable+bounces-263031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1UwL/1CLmrzrQQAu9opvQ
	(envelope-from <stable+bounces-263031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2220C6806D8
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tD7EVDg8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263031-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263031-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B88300C837
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670D2F12AB;
	Sun, 14 Jun 2026 05:58:17 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B2247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416697; cv=none; b=cW6d1wO3I/KLLjKqem0mHnCqiSbmB3AZIbbjsfluRL7zWIxAWgXToWz2yO3tDSPNhaJA8YNxPHqTKe4p5iXmt3mdnfsjyDLlQD+qHZMxDFPQuGlN8z0wVzIbLV2KOho3ln5L1TQyIW+2+kI7/CX80fog1Os/W9KX+RWwolYpxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416697; c=relaxed/simple;
	bh=TMpdAV35MZkiZegHnUGOg35OOF+7mtE2IHk3xbECTro=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=qmlV3Z7U0kCbQTj3zKYheVZ2D/vXWpIAxdFPZYDTPV5pW18O+uqxo/qnCcrciPMzamQN2d5uwXLI0qBn3SNNIwx9nhO6WcEtvbtj4bu0GepCOO6iMWInIYmSQb1au9run2GIH/Kd80YZSRt2lmv1o8rren9cI4dpRcUncOGg9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tD7EVDg8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC21F000E9;
	Sun, 14 Jun 2026 05:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416696;
	bh=sofgPu6UVYSUNB3gG/HhnE9cABL7H8cKsYR63vW0v74=;
	h=Subject:To:From:Date;
	b=tD7EVDg8vRXQWHsZvqev5uh7QNkDTyBbRWIrO5hFQBGmRZSqJ2L0Tk7JoTEZvg7JG
	 4iwJMyPzucpmH+PWSKqJ7baA2vTl2pGxLnriABgC/wtdci4y95NknotQL6O1WTYCwH
	 1Q87/bG4NeH/hKQC0kGYru+FSULNk4Hw8CDRgnHw=
Subject: patch "iio: adc: ad4062: add GPIOLIB dependency" added to char-misc-testing
To: arnd@arndb.de,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:15 +0200
Message-ID: <2026061415-bacon-thirty-8021@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263031-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2220C6806D8


This is a note to let you know that I've just added the patch titled

    iio: adc: ad4062: add GPIOLIB dependency

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From a5b7991d5a737df71a5e4230554481255af64ed4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 May 2026 11:07:53 +0200
Subject: iio: adc: ad4062: add GPIOLIB dependency

The ad4062 driver gained support for the gpiochip and now fails
to build when GPIOLIB is disabled:

390-linux-ld: drivers/iio/adc/ad4062.o: in function `ad4062_gpio_get':
drivers/iio/adc/ad4062.c:1383:(.text+0x3dc): undefined reference to `gpiochip_get_data`

Add a Kconfig dependency for this.

Fixes: da1d3596b1e4 ("iio: adc: ad4062: Add GPIO Controller support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..2dcb9980d7c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -78,6 +78,7 @@ config AD4030
 config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
+	depends on GPIOLIB
 	select REGMAP_I3C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.54.0



