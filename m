Return-Path: <stable+bounces-243446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNdNGmmp+Gm5xgIAu9opvQ
	(envelope-from <stable+bounces-243446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A04BED17
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B2D302DF8A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D93D75D7;
	Mon,  4 May 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ymRgLfLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9183B19D1;
	Mon,  4 May 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903905; cv=none; b=J6W4hbauBjdRF5Rz9CQRdXhOhr+LzcmwL/vQulu9pVUtiHp1Wp43ne+fabwOD+KzcuX3evhoRcsMd/Eec+98M0mr2wPVIQdnVQfeQ40ApwezpcHwMDtInwNJxXeJjkEpvj6xdNZ4Nd7UyYNvYxu3biLN2Kvaz93D+Pftl70ip/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903905; c=relaxed/simple;
	bh=YkP91w8Wdox6Br09cGHLCfAaXOJbKc8Hi1yPRudlmhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHviz8ny/odj+jPy4/N7vip8gaW1/b/LsyV5CwSkaTMW6jju53mmATpKaydAxzbSd74b3M633pYWAqcoOzcnNhxWBkt7AxTyg/nBPscHmvu2WscihWjac9UdPu4n0TXy5FazXqE8qVmRS8N1sVgvFUaPyPzwJzB80JGcbXno4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ymRgLfLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99608C2BCB8;
	Mon,  4 May 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903904;
	bh=YkP91w8Wdox6Br09cGHLCfAaXOJbKc8Hi1yPRudlmhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ymRgLfLB7dTFe6B5sZYX6ezJnG3M1tRFLw9CaRPE6CMoYp6pxZFeAhFICyY8nhZLn
	 JfXXn5B9soJdT86Z6fbskYtNxkgg9qg/Yt0xWtSCX4XAMsbBObqu52KOQIi2Hu3wgB
	 0uG9oN0NwtpdGI01l7dJ5TT+p7DfRWp4qHKRQhV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 107/275] iio: adc: ad7768-1: remove switch to one-shot mode
Date: Mon,  4 May 2026 15:50:47 +0200
Message-ID: <20260504135146.885469257@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E65A04BED17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,baylibre.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Santos <Jonathan.Santos@analog.com>

commit 81fdc3127d013a552465c3bf9829afbed5184406 upstream.

wideband low ripple FIR Filter is not available in one-shot mode. In
order to make direct reads work for all filter options, remove the
switch for one-shot mode and guarantee device is always in continuous
conversion mode.

Fixes: fb1d3b24ebf5 ("iio: adc: ad7768-1: add filter type and oversampling ratio attributes")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7768-1.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -389,17 +389,8 @@ static int ad7768_scan_direct(struct iio
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
-	if (ret < 0)
-		return ret;
-
 	reinit_completion(&st->completion);
 
-	/* One-shot mode requires a SYNC pulse to generate a new sample */
-	ret = ad7768_send_sync_pulse(st);
-	if (ret)
-		return ret;
-
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
@@ -418,14 +409,6 @@ static int ad7768_scan_direct(struct iio
 	if (st->oversampling_ratio == 8)
 		readval >>= 8;
 
-	/*
-	 * Any SPI configuration of the AD7768-1 can only be
-	 * performed in continuous conversion mode.
-	 */
-	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
-	if (ret < 0)
-		return ret;
-
 	return readval;
 }
 
@@ -1025,6 +1008,10 @@ static int ad7768_setup(struct iio_dev *
 			return ret;
 	}
 
+	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
+	if (ret)
+		return ret;
+
 	/* For backwards compatibility, try the adi,sync-in-gpios property */
 	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
 						   GPIOD_OUT_LOW);



