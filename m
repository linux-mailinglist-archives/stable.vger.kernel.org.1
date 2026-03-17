Return-Path: <stable+bounces-226826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFU6OOGVuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666702B0607
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278FC300E39A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BB2D739D;
	Tue, 17 Mar 2026 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UD1ZAsyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469921D5B0;
	Tue, 17 Mar 2026 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768360; cv=none; b=dgnRzSTXNIekp2TvUSfz6gvTJmJba3hWj3i6mhEQaUdUQTUjGLKJGnY129OafEnOGF95d+DNsLFBx2fEm6aVuWjwXN76W9wh6B2HDr6bK9pvsMFAjVtY4RMeI7zL5vf2fWMXLsjiFK/ksD1wg9VX7GzqwAn/aVemIiNL7d3sqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768360; c=relaxed/simple;
	bh=pSGFpIDUGMHtuW57cBh6sW49ibSI4YtIHlsV2uRixzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM7OwBaJv4huL48FD4DfTfRhHZuHGvtu3nrgFc7v+xhmxtO9Jv4bY9w5g+q8yERLEg6eie5RBh585qrtq26zSNZFVNZp5wGS8+ZyYPp+VE6BoUBITSEPXR6UNrCaPeLRDSOgr8ty2SUqzN4fgIREWtCF+N8QYEm2TE2mEMaxsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UD1ZAsyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A59C19424;
	Tue, 17 Mar 2026 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768359;
	bh=pSGFpIDUGMHtuW57cBh6sW49ibSI4YtIHlsV2uRixzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UD1ZAsyCzwIgdhJD0Unq93NywTOu1KMtUqtzX4P1MRWELu3R5PMvisaIIZwu+WMNQ
	 nU/5ay3UbotJPvSbJQdiQZgUsHzJtEhfRcPzWqZ6XsPO9CpM19yhGsNIG/9v6LKPO6
	 9XGao0YtxHHz+f5Jw+vIajKiXVxLUUhpxk6aZjUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 292/333] iio: dac: ds4424: reject -128 RAW value
Date: Tue, 17 Mar 2026 17:35:21 +0100
Message-ID: <20260317163010.222848434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226826-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 666702B0607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 5187e03b817c26c1c3bcb2645a612ea935c4be89 upstream.

The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
in hardware (7-bit magnitude).

Previously, passing -128 resulted in a truncated value that programmed
0mA (magnitude 0) instead of the expected maximum negative current,
effectively failing silently.

Reject -128 to avoid producing the wrong current.

Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ds4424.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -141,7 +141,7 @@ static int ds4424_write_raw(struct iio_d
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < S8_MIN || val > S8_MAX)
+		if (val <= S8_MIN || val > S8_MAX)
 			return -EINVAL;
 
 		if (val > 0) {



