Return-Path: <stable+bounces-234648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMSwK1+k1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 301823C1E48
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17C53165705
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C53D6694;
	Wed,  8 Apr 2026 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSRuBiYB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBA331A44;
	Wed,  8 Apr 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673403; cv=none; b=sJjV6aTmJMOmw/uh0ETAObPnY8RKvKz7rqacu5cnkSb8zAOWrSeKCpLg2JZMvEiQwd7IGYCppTMlhO5ruY6HGbShvm1Scl6YltD4Kk8ue30heiYpGfIcni+F0RQpT3kLUfAnqe90OacHj5vTegrbVGKBMGfj+Xs0YPeASqZ7BUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673403; c=relaxed/simple;
	bh=DzPIKzCVvx0DP2OVTtEWOT4fJdk9cYkMz/1x63z94zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVoGTcjhU77S2NEWJPPj6wGhEQDXp8YGSI9ZPaNhH+vwh+UaQ6Q+1ecn9+j6EYmPqo3Jpa8svSPWgbjp2eufu4ksaRvPdNO8RVLaIrqeiOjbot4dVOyFrn83I+xC7zjGYT8tmwwHsLVXdx+zXA0xfx+Tt4/cOeGXMGuvTRAO1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSRuBiYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE45C19421;
	Wed,  8 Apr 2026 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673402;
	bh=DzPIKzCVvx0DP2OVTtEWOT4fJdk9cYkMz/1x63z94zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSRuBiYBjWXBu+90RUI36X9xp1DREdjtY7A6rw9Jm5M/Z4hX6L83+Ovwweyq6cISI
	 ynz0If6YkvjW3rqfUDY0sONP4qT55ppYJojFnkplqKeVfEYy6fc64d5AHA2T87Jy+1
	 zGMBQ8pZbb9yoRWIs3cpqqKJya5MP6x4VXsXuCuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 186/277] iio: imu: adis16550: fix swapped gyro/accel filter functions
Date: Wed,  8 Apr 2026 20:02:51 +0200
Message-ID: <20260408175940.808573475@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234648-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 301823C1E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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



