Return-Path: <stable+bounces-235142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIJ3G3mr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC53C2ECF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8EA931EFE6F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AC357A20;
	Wed,  8 Apr 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtW6aVsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B42F39C2;
	Wed,  8 Apr 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674677; cv=none; b=CR7JQep4ZgIu8T2XrU3xiWf9lMw9CkEWEoQaWkvKTxplWGmIUome8YDo2Z+fLgjW2mrQjxhgKuaI9kbrBWXOazTpbREnsJNjiQ6GBmkTS5IRw3jBtkhXirDAaYxkVVAREQ16pkmb0sefw4dBvL5FW7BemVIGSV2HcvjFiyZaV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674677; c=relaxed/simple;
	bh=4izhUSMMit7nd+muM2pQBN9Ak6F1oFdORof1aIkZDMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8AdGAZciqYneqHnrp6rGPGmgQWr4FutWZhnrfbwJbRk7N5TdzVwEv+dCuxnosHTDhEsUENlu9XnluT8CL4WTaD4fZGdYseHQa/eDXOYV9RRMd4KW+LERIxJ09eZI0EegkJFyOJxVcQ3BLmglKX5ZDeDKcUNfNhXzvzsC6FcZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtW6aVsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA0C19421;
	Wed,  8 Apr 2026 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674677;
	bh=4izhUSMMit7nd+muM2pQBN9Ak6F1oFdORof1aIkZDMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtW6aVsMP36n+T3iBsktikXLyzMcqY++p/tB/6s9G0SQXFe5dilLzx6yLLddP0qnX
	 t+2u8iUDGWqL/pWvLuCQwkhzdtbdA4BeX2gPpjplpptbtKSXcYl2UWLIDq9wQ3PpiY
	 bZVqwTNygsdcln9KIzIlHFyZzB3BzrIMEMbFf780=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 191/311] iio: add IIO_DECLARE_QUATERNION() macro
Date: Wed,  8 Apr 2026 20:03:11 +0200
Message-ID: <20260408175946.542171037@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235142-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,baylibre.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: D4FC53C2ECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



