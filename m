Return-Path: <stable+bounces-212569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OIhD0c0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:07:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2EA51F1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC39B3047DFE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E32FF178;
	Wed, 28 Jan 2026 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OOdlz/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A461D6AA;
	Wed, 28 Jan 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615958; cv=none; b=Sj2q4Sse3/dcM/b14GleC2npn+DM8XFA8dR02/FI2Fb/NTzpjsU1JKWJv5nd7hxyDdDp63JySzsvXGKzvmAPO8in6uzditiMVDchXCQaXi04D+p4RaT8YBnoStWzytPFh3lb3n4ryNI0tNZGtarFAzvY8jgFeS1IcTdfUsTy/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615958; c=relaxed/simple;
	bh=To0/PcCE7ai5CZr7QEFT4B3r3v7OQv6j/Yr9cEiMcc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cckGpPhCdQfSG6PfLs00RNwhEZa06m6n6NVMthh3UDiQIaftTA+MkfeF440mhsna0ljQaH7ml0Fqy/x+64ORC0LEWSiFnvppgMySdUpX8/NaPvSIbkTmpq5yfLW/T0ti+HTEIi20wN0EiN/cBSklY5jVSAeL34g8SFVqSAtnPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OOdlz/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47246C4CEF1;
	Wed, 28 Jan 2026 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615957;
	bh=To0/PcCE7ai5CZr7QEFT4B3r3v7OQv6j/Yr9cEiMcc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OOdlz/a4lwefXsGIA9BK4T96nWq1DL4b67G3M15isGUMNyPaqrv68HXEng2DMXIz
	 RomXjLaFdVuHDjWaFsWcuctAjfW7zY8s44l3P7ayxGhIpOU/NSe+PURlbwa4UmpDKd
	 gDqSGB1EKKCUQpOjIbaVIKZUzAgUWX3D/revvhZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fiona Klute <fiona.klute@gmx.de>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 163/227] iio: chemical: scd4x: fix reported channel endianness
Date: Wed, 28 Jan 2026 16:23:28 +0100
Message-ID: <20260128145350.318497224@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212569-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,baylibre.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,gmx.de:email,huawei.com:email]
X-Rspamd-Queue-Id: 9DC2EA51F1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fiona Klute <fiona.klute@gmx.de>

commit 81d5a5366d3c20203fb9d7345e1aa46d668445a2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/scd4x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -584,7 +584,7 @@ static const struct iio_chan_spec scd4x_
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -599,7 +599,7 @@ static const struct iio_chan_spec scd4x_
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -612,7 +612,7 @@ static const struct iio_chan_spec scd4x_
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 };



