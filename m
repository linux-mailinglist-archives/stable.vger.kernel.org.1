Return-Path: <stable+bounces-230891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gn7CyIkyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:07:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CA352149
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24B6630104B8
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968135F5F5;
	Sun, 29 Mar 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RL0WSnl1"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085E293B5F
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789660; cv=none; b=BHDjoaqzif1OtE+14p/WNJVZ+HtuaCeq2Jyk4mA5PyGNBNSy0mcItg6KFq2gvw4k+H/OFOqLdYGnMDwcwRhGqoXb7ZPzI3lCKC/aC9qQ2xqfbesrZs/oNkPTfzIDyRTsswo25hWVtDqFzQP50Nz52xa46gKnVEY9vpqq3PVdjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789660; c=relaxed/simple;
	bh=sVMhl+b+FrU7DCg3Tm59PumN+PWCOtpqMEgb4kpC6dc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=iFpqw+TViI//2uGVAMw8NVq5fJfDmLAD13o0L+P5wRB3E9T4PoVbHA4SaaUccrFJWCxxp4ycNi3e5y107sMItezFJTgcJXpaSVwikPf5gPLU0CFU1t1CvfE43W/eeGlMbhcCsOU7JJ//YwJ20fm5VqdpgD96V6tA+rthGNMsEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RL0WSnl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0442C116C6;
	Sun, 29 Mar 2026 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774789660;
	bh=sVMhl+b+FrU7DCg3Tm59PumN+PWCOtpqMEgb4kpC6dc=;
	h=Subject:To:From:Date:From;
	b=RL0WSnl1LyV0ragMeSJXTeAwnF7COoM9h0x6scU1WJDxjsqPMmilLVQcUcZwrEkHT
	 lxdRt4gHpOeQ17K0xX4/F9GzzO9NE4nopowGAj7KJeR1VKC5rcG6FDE1Hd+8Silmn7
	 FCCtULfAVBDnzBq4fRMqKqqZa7ct7SVTlqbzFB5o=
Subject: patch "iio: adc: ad7768-1: fix one-shot mode data acquisition" added to char-misc-next
To: Jonathan.Santos@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:43:47 +0200
Message-ID: <2026032947-pediatric-enslave-e8a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230891-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 611CA352149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7768-1: fix one-shot mode data acquisition

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 8be19e233744961db6069da9c9ab63eb085a0447 Mon Sep 17 00:00:00 2001
From: Jonathan Santos <Jonathan.Santos@analog.com>
Date: Mon, 23 Feb 2026 08:59:26 -0300
Subject: iio: adc: ad7768-1: fix one-shot mode data acquisition

According to the datasheet, one-shot mode requires a SYNC_IN pulse to
trigger a new sample conversion. In the current implementation, No sync
pulse was sent after switching to one-shot mode and reinit_completion()
was called before mode switching, creating a race condition where spurious
interrupts during mode change could trigger completion prematurely.

Fix by sending a sync pulse after configuring one-shot mode and
reinit_completion() to ensure it only waits for the actual conversion
completion.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..4cb63ab4768a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	reinit_completion(&st->completion);
-
 	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
 	if (ret < 0)
 		return ret;
 
+	reinit_completion(&st->completion);
+
+	/* One-shot mode requires a SYNC pulse to generate a new sample */
+	ret = ad7768_send_sync_pulse(st);
+	if (ret)
+		return ret;
+
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
-- 
2.53.0



