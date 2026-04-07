Return-Path: <stable+bounces-233662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE9LJ3wj1WnK1AcAu9opvQ
	(envelope-from <stable+bounces-233662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:32:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F93B1130
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF4D330F10C6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB23B8BD9;
	Tue,  7 Apr 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kcb6H6/q"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DC3BB9E6
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575600; cv=none; b=lGDcX3QZlI4CdbQslzITmHuP9Pb/cuAk0rfAE/ipHZhUb7AgHq2Me/58j9ogoCQDVnQkGM3vKwZPIvvBzqHI3oPCISbf88nrVsKa+piX3f+2fotJ1pVCZy/FZAipyO06B7Sqo1tCpkI/rbii4zWXsV+i+NmLlhtbWaMFy4IffvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575600; c=relaxed/simple;
	bh=DrSfoqdK7SCezuAXY0xQ03zN5wlgBs5pmwQgjI0SSrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oDtSYhwDcSOVn+brm1jcPAUJuMUEaSxCFOhKiHMiE+gvqZQ0PAL7KO+Z3GZafArOqx3QSk9IWf7ZM77v3D4YQJTExm2TMHJaTqv0HFue9ptpVmNL3CixLvUk59sondkVj+kFtDKdIABaStaGvspr+Bulo7M1XYtlRvh778LZgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kcb6H6/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181FDC116C6;
	Tue,  7 Apr 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775575600;
	bh=DrSfoqdK7SCezuAXY0xQ03zN5wlgBs5pmwQgjI0SSrY=;
	h=Subject:To:Cc:From:Date:From;
	b=kcb6H6/qokrREbDdn2IWa4jp+3wBzoXUep0mqNaAZqr+49CY5h/8LHSbl299uNwVF
	 QSaGWZQiV0Qbkoi9pBwLfvhzatWUmjB+CzxBK+puAitUlLMi5CqKw+uhCPkqfMq+fa
	 hQwEC9K2yEHvMVznsUxginuXO+TfJQbGxPL0fskI=
Subject: FAILED: patch "[PATCH] iio: adc: ti-ads7950: do not clobber gpio state in" failed to apply to 6.12-stable tree
To: dmitry.torokhov@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:22:50 +0200
Message-ID: <2026040750-encore-unreached-66a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233662-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 170F93B1130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d20bbae6e5d408a8a7c2a4344d76dd1ac557a149
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040750-encore-unreached-66a2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d20bbae6e5d408a8a7c2a4344d76dd1ac557a149 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 5 Mar 2026 11:21:53 -0800
Subject: [PATCH] iio: adc: ti-ads7950: do not clobber gpio state in
 ti_ads7950_get()

GPIO state was inadvertently overwritten by the result of spi_sync(),
resulting in ti_ads7950_get() only returning 0 as GPIO state (or error).

Fix this by introducing a separate variable to hold the state.

Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index b8cc39fc39fb..cdc624889559 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -427,13 +427,15 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	bool state;
 	int ret;
 
 	mutex_lock(&st->slock);
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
+		state = st->cmd_settings_bitmask & BIT(offset);
+		ret = 0;
 		goto out;
 	}
 
@@ -444,7 +446,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		goto out;
 
-	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
+	state = (st->single_rx >> 12) & BIT(offset);
 
 	/* Revert back to original settings */
 	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
@@ -456,7 +458,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 out:
 	mutex_unlock(&st->slock);
 
-	return ret;
+	return ret ?: state;
 }
 
 static int ti_ads7950_get_direction(struct gpio_chip *chip,


