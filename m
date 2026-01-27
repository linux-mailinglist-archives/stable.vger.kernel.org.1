Return-Path: <stable+bounces-211774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCwMBkK5eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FF94B42
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84AAD3019160
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702335505F;
	Tue, 27 Jan 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JSl89M5P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B716355024
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519421; cv=none; b=NorpgqVWpB3vULcu21u9ch7u9O/GPynYLhfDLgyytY45GIVIXQZYcK+YXBJtg8+ghq1E77jsjHh08yS/4A3U05S1lFv62/iPZG+5AOGk3SCXJumjkWnEiTw1PhxbDmVcROvTEMilMs75QbfbJUaQLsc33JlZCz3WJZDQRaXF0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519421; c=relaxed/simple;
	bh=b2VWY0NiHyJWpmV7ZLrwLClpwtM9A2J8MOx9P+B/5ZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R39cdiy+bYDw7KfGacQO//ZBR0NXX+eVVJrOw3AFAxxLJuLjYtbrK/S2ySRvuGrVYDCHp23XF2F/dd4xe7i+KK7UB2ZpJhUxD1NKWNBpDxk+kl8oMHvVIB3l3dAujavRfdq/6r73lQwndbZkpHblNrTa6LfpQHOJnk5d+cTyCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JSl89M5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF5C116C6;
	Tue, 27 Jan 2026 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519421;
	bh=b2VWY0NiHyJWpmV7ZLrwLClpwtM9A2J8MOx9P+B/5ZM=;
	h=Subject:To:Cc:From:Date:From;
	b=JSl89M5PH7yWZ5wJFCetct6g0USY/GlJZR0Z5MHO/ZTn18wu0YicFdOEXgpN6sKS0
	 NUHuJkDM3aEMEz7nv3saFgmw9vOmYUnI9LEiEFK4tX9cbsbtuVBV1WV3AXar2ZsR8z
	 PnLkGner9zIwDUVvqBbngi8n/Ez+PQSmtI6y0QUs=
Subject: FAILED: patch "[PATCH] iio: chemical: scd4x: fix reported channel endianness" failed to apply to 6.1-stable tree
To: fiona.klute@gmx.de,Jonathan.Cameron@huawei.com,dlechner@baylibre.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:10:13 +0100
Message-ID: <2026012713-ethically-lily-296c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-211774-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,huawei.com,baylibre.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,huawei.com:email,gregkh:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: 8D9FF94B42
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 81d5a5366d3c20203fb9d7345e1aa46d668445a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012713-ethically-lily-296c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81d5a5366d3c20203fb9d7345e1aa46d668445a2 Mon Sep 17 00:00:00 2001
From: Fiona Klute <fiona.klute@gmx.de>
Date: Sat, 13 Dec 2025 17:32:26 +0100
Subject: [PATCH] iio: chemical: scd4x: fix reported channel endianness

The driver converts values read from the sensor from BE to CPU
endianness in scd4x_read_meas(). The result is then pushed into the
buffer in scd4x_trigger_handler(), so on LE architectures parsing the
buffer using the reported BE type gave wrong results.

scd4x_read_raw() which provides sysfs *_raw values is not affected, it
used the values returned by scd4x_read_meas() without further
conversion.

Fixes: 49d22b695cbb6 ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 8859f89fb2a9..0fd839176e26 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -584,7 +584,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -599,7 +599,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -612,7 +612,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 };


