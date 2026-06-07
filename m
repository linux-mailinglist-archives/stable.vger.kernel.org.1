Return-Path: <stable+bounces-261431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id coYaNo9JJWq4GAIAu9opvQ
	(envelope-from <stable+bounces-261431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758C64FD69
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XboMh6ul;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261431-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261431-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E41F3011C71
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B0A329E6A;
	Sun,  7 Jun 2026 10:35:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83503257855;
	Sun,  7 Jun 2026 10:35:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828529; cv=none; b=j5i2OOyVfpJMz7/yrV/JBtvPhdNkXTygkXJ4OGjy+dU0TyW+xidTwl6NCkWWIiN66DYG77V7Nqm+JENBzcE3vp7LfG4sAtgpAtkI9L8MlPsXB2u4L0jgQGtfX+W/7IDp40AUZuLMIONsofkfr33JssoMtsks4jm6xbIkq9VcQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828529; c=relaxed/simple;
	bh=8v2gXg3Y0OXilEAnQFDteqTd7P/8zSXzwUYcprJgDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTqmrRq7t0xLqXtXlI/6qwAuTgZbypT1+mchivtp91gfjwTcabOo6zOuWQXuyI10r/cCS3h4L7VfmzPEPGexbsuhHhbTGM342YiM5Ud2pCANFa3M9d3FgrX31YvvmVKwcuuMS4/7b2Gz1WtkwiGah9faD4cfFT3WKaPg/mqF7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XboMh6ul; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3451F00893;
	Sun,  7 Jun 2026 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828528;
	bh=QozIm/jpm9jIoiAu2CgBTGnY6Mccq0xJ1c/rej/Ho08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XboMh6ulUZ1yOV+E2dpMiMJb6w+40EVY0gemwmRvwfu3rRVyjf4xtGObLNBIs9xB4
	 8YDqc7TGc39QjA9ZBXy78rDV+jj6dL6suvQUVYcNWFD6biCiM3zo2JRSXbEhaAf9Px
	 3uNUAeuMU6H4H8aliJnD0fD0aX1g8N3j78EcVm/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.18 170/315] iio: Fix iio_multiply_value use in iio_read_channel_processed_scale
Date: Sun,  7 Jun 2026 11:59:17 +0200
Message-ID: <20260607095733.834694113@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-261431-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:clamor95@gmail.com,m:johannes.goede@oss.qualcomm.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4758C64FD69

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Svyatoslav Ryhel <clamor95@gmail.com>

commit bb21ee31f5753a7972148798fd7dfb841dd33bdb upstream.

The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
negative error number on failure, while iio_read_channel_processed_scale
should return an error code or 0. This creates a situation where the
expected result is treated as an error. Fix this by checking the
iio_multiply_value result separately, instead of passing it as a return
value.

Fixes: 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale() precision")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/inkern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de270..9ce20cb05a9b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 		if (ret < 0)
 			return ret;
 
-		return iio_multiply_value(val, scale, ret, pval, pval2);
+		ret = iio_multiply_value(val, scale, ret, pval, pval2);
+		if (ret < 0)
+			return ret;
+
+		return 0;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.54.0




