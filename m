Return-Path: <stable+bounces-235176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKnKgir1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A73C2DC0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72FD31FE6F0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F73D411F;
	Wed,  8 Apr 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAuzzZ/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57C3176E4;
	Wed,  8 Apr 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674765; cv=none; b=tWw/uZWNTlheS+QkU2eRIvkVJHjwy/zdtO7t6n5a+yfDp56NJCQlyTakK7NQhov4FqbmkBe+c+w2uH+ViqXGi3et8IgEiF5zo/9wYmMvdDMh64TMeIOxwkU4SUa2X2wgS+BgOps+mBe1UQPNzMy43waLCk/pB7QlqT+AhLPr0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674765; c=relaxed/simple;
	bh=aj/DozRDyJFM5gQs+/5JwqhQqMRv03Qn/1kU2PO47y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCQ6vYkUOn77rbhz09ZtVrivDexTd3XTXl2AJwN0B7LLSz3zn2R8DXXIXioJ1AI5qZ9TgzQIa+dD28H3ZILv5AVWws9DgcMSKNJbekjDcxg/+bOPZWKSwSp8LyB4yYzARkb+LGSURSKOkgiDXAm9/gbFXJ9ZI5wL68UytxErxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAuzzZ/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803CC19421;
	Wed,  8 Apr 2026 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674765;
	bh=aj/DozRDyJFM5gQs+/5JwqhQqMRv03Qn/1kU2PO47y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAuzzZ/ZbLXy0m3HYtBexWZGmPwjTapwO/Ya86uqV/AlClcwz5yZL7zrUxEzEYMZ3
	 pN76vAj8BhY7UUvvgRSQX8/jIOphVYSOT+kpP17q3JJ5OOsiCg4PMS2S0WLaGcqjJ0
	 IXsBRx0oZsbmxz7XqWcqwgqA80PY/OW/F0phaKDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 225/311] iio: imu: adis16550: fix swapped gyro/accel filter functions
Date: Wed,  8 Apr 2026 20:03:45 +0200
Message-ID: <20260408175947.801899524@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235176-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 3D5A73C2DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit ea7e2e43d768102e2601dbbda42041c78d7a99f9 upstream.

The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
other's filter functions in both read_raw and write_raw. Swap them so
each channel type uses its correct filter accessor.

Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Robert Budai <robert.budai@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/adis16550.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -643,12 +643,12 @@ static int adis16550_read_raw(struct iio
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			ret = adis16550_get_accl_filter_freq(st, val);
+			ret = adis16550_get_gyro_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
 		case IIO_ACCEL:
-			ret = adis16550_get_gyro_filter_freq(st, val);
+			ret = adis16550_get_accl_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
@@ -681,9 +681,9 @@ static int adis16550_write_raw(struct ii
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			return adis16550_set_accl_filter_freq(st, val);
-		case IIO_ACCEL:
 			return adis16550_set_gyro_filter_freq(st, val);
+		case IIO_ACCEL:
+			return adis16550_set_accl_filter_freq(st, val);
 		default:
 			return -EINVAL;
 		}



