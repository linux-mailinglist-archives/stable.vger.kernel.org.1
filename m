Return-Path: <stable+bounces-243154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB+YLOqm+GkExgIAu9opvQ
	(envelope-from <stable+bounces-243154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893244BE61E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CF833014354
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633EF3DE442;
	Mon,  4 May 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyUWC4hU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5D3DE43F;
	Mon,  4 May 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903154; cv=none; b=GX+5ljBdqNcqEwPeiaqWY8dfI8lp0BYDyXb5IweAxWCgdc4+Up2fAQT/xAGBv0uAXjWVZgoYyaucAcb+LmKTr5WwMDYViVUCdAI3k8SAQVJJBgGQqzNOdpdmM3ls0xBOLnoGva6e2ZtReFuRtquSk3cMoExOsK/QySRrJH2dK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903154; c=relaxed/simple;
	bh=Az5TwWGq2ZQsZ0RJWwI968yfWR0tMKPZzPYEWrlK1fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8QTOuBRdxpkiApx+MUKIu2WHOQGRKhA/nY6ByE7yw+g/CCevCE4RA2VmWeZz/EKCugN8tFioiWi4ffVtOiOSr4dY/QCcUsopAfDLCebHyBPqwKIIGQE8V6C6QxMEzrJnlmuTVYhrIgMUO/HYYuIudJqTCC4tKlqRB71kWee/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyUWC4hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9CC2BCB8;
	Mon,  4 May 2026 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903154;
	bh=Az5TwWGq2ZQsZ0RJWwI968yfWR0tMKPZzPYEWrlK1fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyUWC4hUtLJG0NuAGxFU8V8mU/OXD+xg30Md/hgGaR73GDNSXfQMrvhcxPeIJLbYZ
	 5vv3oYuhfh0LO5guw99ZKmhn4k1FyLcikzfk4wZGCVmkU2f5OI5+oEnPbcvmmF8oif
	 xXj6OYWACjc4uzBUrVoKa/QFpFvNl4eeSVv3R5+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7.0 124/307] iio: adc: ad7768-1: fix one-shot mode data acquisition
Date: Mon,  4 May 2026 15:50:09 +0200
Message-ID: <20260504135147.461331879@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 893244BE61E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243154-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[analog.com:query timed out];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[jonathan.cameron.huawei.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,baylibre.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Santos <Jonathan.Santos@analog.com>

commit 8be19e233744961db6069da9c9ab63eb085a0447 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7768-1.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio
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



