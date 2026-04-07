Return-Path: <stable+bounces-233663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ9HCsMl1WnK1AcAu9opvQ
	(envelope-from <stable+bounces-233663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F733B130B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E412309F105
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB9361668;
	Tue,  7 Apr 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YONT/1pq"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04B3B95F6
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575604; cv=none; b=upjaIrI3tyTWa+aHLf1JFrhfbtn6dOcDF7rHZ4HPhiFxiEz+gInsZusyaTzxcr0ThUdRwMCJeYlT0+9yqA8ea8NQrVWsYRGYWMzJc/SQdTpvwQQNXta/VnbFxt8X4PpvMSrj5h6kPrvouq8VbF3vNHoRmoJLx8EdE/3kFyfbKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575604; c=relaxed/simple;
	bh=NOakeI8PbDnRhsJB8Z40t3QdORPTl3wa/jM6qMO57wo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OCGu8WSNLwe9899vR+0Bv76N1OpWhmqFdyNtv+e+BrcemDzp91Qr9i5ymHlrh9scsrHfvoMW0T/zAAkxH/MXC1lxSKMbN1A97WQLqrt9R+k/22z5l+mO3HqxM3wlgFN8pxeVmZstGTOfqPrztSy6Qt5vSTtiTrtrTuUW36zoXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YONT/1pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB3C116C6;
	Tue,  7 Apr 2026 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775575603;
	bh=NOakeI8PbDnRhsJB8Z40t3QdORPTl3wa/jM6qMO57wo=;
	h=Subject:To:Cc:From:Date:From;
	b=YONT/1pqylTopR3Fbzy1V3pgW9YnhT5fi8VuqmQt9lTd09dkDnUrsrmfm2Cp1brqy
	 DFEjFMjp1O41/iZDAm6fhxTaAHED2wPkyvWL1+L/fZtEv8Agn0JIBw6kc9pELxNByD
	 HXew/sqKuAozBjkYJTH3UfLPkcpVr95LyBL3uS7E=
Subject: FAILED: patch "[PATCH] iio: adc: ti-ads7950: do not clobber gpio state in" failed to apply to 5.15-stable tree
To: dmitry.torokhov@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:22:51 +0200
Message-ID: <2026040751-drew-mauve-fa4b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233663-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 29F733B130B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d20bbae6e5d408a8a7c2a4344d76dd1ac557a149
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040751-drew-mauve-fa4b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


