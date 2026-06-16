Return-Path: <stable+bounces-264942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N9uvNxqDMWoSlQUAu9opvQ
	(envelope-from <stable+bounces-264942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E5692C55
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lQOvOVQ2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264942-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264942-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AF9D3062385
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D04478E55;
	Tue, 16 Jun 2026 16:51:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEB47884C;
	Tue, 16 Jun 2026 16:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628698; cv=none; b=A14ic/O0Q1IJfl56LouYyn6hGzDPA1xAYB0RTNEbyuO1BdLSGfBLzIHz7N4LmtuFTeSrr4dD6ba5nKNMXYUsxkLSwYqaRNM6vdTrYhdWd5AH364boQUxyW3wcraQAM5dXlBTqM/lZhn4vC4DeiZh785CC74jZqDPIHDf4FRQ5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628698; c=relaxed/simple;
	bh=lVzts68X5IynWhb8JCEisDGgbrS+mKHwo0/jDfa+Dwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk+Cy7fqlmCCWqG6es/rCO7nwqZmDHwimXf77WjL6Oiu7Ydui/n7OBrjy62Wgoukq2VWzREdZj0lehqSotCB9v/5jwxqUo8dSsfc4mVOqD8FrbHnlE3gzRiaPiMOKIwiUwv1cYxVImAT4e+P2ud14cFa2namHVqDJrdrgWl7/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQOvOVQ2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C66A1F000E9;
	Tue, 16 Jun 2026 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628697;
	bh=Ji1eK8ee35O/5EIg+sdLrWWNvUCdzL0b3Efr4c3IVy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQOvOVQ22zW5hJ+4Q4Hqb0VaeUDP9jAHX3wwXLoCyGY8Saf3vgwn72GaG3jnOj6Dj
	 YCMGk+TxtlMIpunZRa78jI7G3uKsdRkA8JBr6THHvwo75/J+gVIfavuAo4te5KChd5
	 oIVl6jU8Ez8UJJJkKSP2kmR9V2+95vflFp5CrcW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.6 113/452] iio: gyro: itg3200: fix i2c read into the wrong stack location
Date: Tue, 16 Jun 2026 20:25:40 +0530
Message-ID: <20260616145123.665917091@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264942-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:devnexen@gmail.com,m:andriy.shevchenko@intel.com,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E9E5692C55

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 6bdc3023d62ed5c7d591f0eb27a5adb37fb892ae upstream.

itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
parameter (a pointer), `&buf' is the address of the local pointer
slot on the stack of itg3200_read_all_channels(), not the address
of the caller's scan buffer. The (char *) cast hides the type
mismatch.

i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
= 8 bytes into the parameter's stack slot, which is discarded when
the function returns. The caller's scan buffer in
itg3200_trigger_handler() is never written to, so
iio_push_to_buffers_with_timestamp() pushes uninitialised stack
contents to userspace via /dev/iio:deviceX every scan -- both a
functional bug (no actual gyroscope or temperature data is
delivered through the triggered buffer) and an information leak.

The non-buffered read_raw() path is unaffected: it goes through
itg3200_read_reg_s16() which uses `&out' on a local s16 value,
where that is correct.

Drop the spurious `&' so the i2c read writes into the caller's
buffer.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/itg3200_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -34,7 +34,7 @@ static int itg3200_read_all_channels(str
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
-			.buf = (char *)&buf,
+			.buf = (char *)buf,
 		},
 	};
 



