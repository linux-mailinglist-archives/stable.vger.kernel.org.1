Return-Path: <stable+bounces-234615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKvMG/if1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D03C106D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EE9C301CC64
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DE3624B0;
	Wed,  8 Apr 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifp1gQvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691C331A44;
	Wed,  8 Apr 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673318; cv=none; b=l8ibsPmvXtTtguUd6Mt1ZNfgodYPI2RFeESts2k8Dmx2U/zwIDlyfmq301xIeh751RS2QrXpop8+V8nfACxdAZnoBAAihQXn8GwtGSF6hDcq6sI+NYJgSeXrQQPSFB0rRHPigeJ1mzyu1cHPozKBBVJpYCcg8wOlXbengvrz5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673318; c=relaxed/simple;
	bh=sTjnLvwRp+RL8INqBgO9Rp8928g6r66VSFPFhKfK00A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZjyUa6plqD/K/1/8bqZ4nGa2FshOzPCONQKaNCrYMHDSE8v1BBEC7x8BbuaQdal/+ZcyHTgmNbS6IUbOek/tP2r3N5cgZ1h9i4pvngJ/PwDFlOboiaoPfNsIPuw1ZummUTnKY1MSyXckzxmdmd64sVk/kbXLtRXBPRgtvYEBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifp1gQvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A4C19421;
	Wed,  8 Apr 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673318;
	bh=sTjnLvwRp+RL8INqBgO9Rp8928g6r66VSFPFhKfK00A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifp1gQvJM65fmLaBQfZPNsWh6oA5DppbJDtbYW12fWvUs1S18DIzaeqg29RBCaCL/
	 BOU9E3TvIQLbXseBdDjjK6KHaxkcizTlzlZLFsyD5DwMoy774Og9AgWPfeYM0SQyJC
	 EEa2uM4/96T4iWHqffmZSzE2Pc1Ue+Fkh+IlcubQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 153/277] iio: add IIO_DECLARE_QUATERNION() macro
Date: Wed,  8 Apr 2026 20:02:18 +0200
Message-ID: <20260408175939.585329955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234615-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,baylibre.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB2D03C106D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

commit 56bd57e7b161f75535df91b229b0b2c64c6e5581 upstream.

Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
field in an IIO buffer struct that contains a quaternion vector.

Quaternions are currently the only IIO data type that uses the .repeat
feature of struct iio_scan_type. This has an implicit rule that the
element in the buffer must be aligned to the entire size of the repeated
element. This macro will make that requirement explicit. Since this is
the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
of something more generic.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/iio/iio.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -816,6 +816,18 @@ static inline void *iio_device_get_drvda
 #define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
 	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
 
+/**
+ * IIO_DECLARE_QUATERNION() - Declare a quaternion element
+ * @type: element type of the individual vectors
+ * @name: identifier name
+ *
+ * Quaternions are a vector composed of 4 elements (W, X, Y, Z). Use this macro
+ * to declare a quaternion element in a struct to ensure proper alignment in
+ * an IIO buffer.
+ */
+#define IIO_DECLARE_QUATERNION(type, name) \
+	type name[4] __aligned(sizeof(type) * 4)
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */



