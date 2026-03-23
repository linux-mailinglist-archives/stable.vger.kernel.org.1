Return-Path: <stable+bounces-229738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP8xHZ1swWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:38:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98E2F8852
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 189AB314A3B3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1203BE64D;
	Mon, 23 Mar 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfblRFDJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144C3BE63F;
	Mon, 23 Mar 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282735; cv=none; b=XBs5q6gSFd+9fNfGUyzHhbkodluIni7CuCRb+twbKb3D1bKPN5ayGlG4Gxxgr13bT3i1Fv8NJGVm5cQLpmI0WTOz49o7hBMBtJDBf0oxMc+nFAMVWWuBQd8Gnl2WIQ5or1kZ7LcbVBoPc259qkHlNy1x0tLG+4+NeEINTOr65aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282735; c=relaxed/simple;
	bh=G+/NpwCzktAm77zb4tkBaG0Q5sfhWsb46XBIK8RXy0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhmxRcpnnSdS59fcTf14Zfeg94JSuOZmRgC57cJHD36g/2muAi0HNhiVXLo1+ENV1Ak1FtyKNbLqFRiI+6Aq0AxFm8i4/CspPTEs3QCzTkT6sD0CKPa3rtgchXY63dL0RyLF2beV4kxJ0OCJprTwanO6Z3+na+I+x4PnGp8E2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfblRFDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBC7C2BC9E;
	Mon, 23 Mar 2026 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282734;
	bh=G+/NpwCzktAm77zb4tkBaG0Q5sfhWsb46XBIK8RXy0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfblRFDJNmsNj7TH7k0UZyIExAIBGoKgFRFENbKVTfuSyGXEb/6/6ML93RQ7Ts8e0
	 pj3l3zF7ziPCtcIbBjWFAF3Q/nybOWf3FpUh58KIfjH9NvlJoVz64BgRZVdOlDMvnW
	 xveoJ/O0fBXkZs5KjptHrKslTxzYnC12RQH0vqpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 265/481] iio: dac: ds4424: reject -128 RAW value
Date: Mon, 23 Mar 2026 14:44:07 +0100
Message-ID: <20260323134531.601218908@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229738-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DB98E2F8852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



