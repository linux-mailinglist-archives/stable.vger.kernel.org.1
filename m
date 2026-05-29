Return-Path: <stable+bounces-256635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFvfMz+ZGWqGxwgAu9opvQ
	(envelope-from <stable+bounces-256635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:48:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC13603105
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0232930FD5CA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501733B6D9;
	Fri, 29 May 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqiaS2gU"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2522425B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062187; cv=none; b=KB9/dTY+C96oTeIFp0CBVrtQq+vwPAth8IEYwb8HAAOMOGkbkudvQ7uRuOPU4XoiELV3dJbuB9m5XP2DBjfQu451YFjXibTK/aFCGhTzCjWCzjgjxIaTT8I+uexAtQJT9dATfJnFYU8xvshvBH4+lP6Diwa2+0sNKfNPt321njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062187; c=relaxed/simple;
	bh=w/XDoJD9UW2X/ZMFzoYwJZ7NELGaSy7SAIfzA4Zj1uQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=s5cf4QI42VZ/RbnxezbzDXFF2+SLEFbFZPl9GBYRYKDjoXkmsqlfWAttB8yaUWYA9XE+jZ7W29UegI1G9yaQUKDgYF+jJgcjU0I1xgWb7euZTp7le9Uv0DmmV6FDsC7D1Zp43G7sUiuQfvi/lOvp8UEu6iuuf5XhqEt59XAz/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqiaS2gU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780062173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9NP0pxuD7iebhIQJui2i7alD2QVqysKVjU+6FBbyOhY=;
	b=fqiaS2gUMo750SRQLJ3LCnbHmuk8YvQJmFHpdOHYOgKjkyo7UIx4tnHH2ap4lSAg1/BCRn
	Yx3y9UiTqwNHH8iTEd0xVBhrF6cYxfEkOibUgABZKV7VKE114bbEOcbbotVp+PlAKo5r69
	/WteLMKuXe8Ie67PaeYnHBU0vlx6sIk=
Date: Fri, 29 May 2026 13:42:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
TLS-Required: No
Subject: [PATCH] HID: hid-goodix-spi: validate report size to prevent stack
 buffer overflow
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256635-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianchu.chen@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 4FC13603105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tianchu Chen <flynnnchen@tencent.com>

goodix_hid_set_raw_report() builds a protocol frame in a 128-byte stack
buffer (tmp_buf), writing an 11-12 byte header followed by the
caller-supplied report data.  The HID core caps report size at
HID_MAX_BUFFER_SIZE (16384) by default, while the driver does not set
hid_ll_driver.max_buffer_size and performs no bounds checking before
copying the payload:

    memcpy(tmp_buf + tx_len, buf, len);

A hidraw SET_REPORT ioctl with a report larger than ~116 bytes
overflows the stack buffer.

Add a size check after constructing the header, rejecting reports that
would exceed the buffer capacity.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/hid/hid-goodix-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 80c0288a3..288cb827e 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_devic=
e *hid,
 	memcpy(tmp_buf + tx_len, args, args_len);
 	tx_len +=3D args_len;
=20
+=09if (tx_len + len > sizeof(tmp_buf))
+		return -EINVAL;
+
 	memcpy(tmp_buf + tx_len, buf, len);
 	tx_len +=3D len;
=20
--=20
2.51.0

