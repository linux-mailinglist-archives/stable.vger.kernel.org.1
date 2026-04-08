Return-Path: <stable+bounces-235199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D5CB/mr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81E3C2FD6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28B23203B91
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E935C1B4;
	Wed,  8 Apr 2026 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eIo7ZRqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C02857C1;
	Wed,  8 Apr 2026 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674825; cv=none; b=jfczCc+9B80KEZfSnksHMACzkeKT7jzCMjFpOI+Z/B7+c1b76rss2VciJwZJSE0FYUjz1NfGRTDc/F72INhav0DefT5lEXgTXBG5P2VdPF/FE6TuAhWRqsuZGIHjnTLHGKvxU8wleTK2naZ4qWH4I6eupH1fZo2Xom2BV1GvGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674825; c=relaxed/simple;
	bh=K+d3sM3ZXbghcGPJnmUC6euMFq8hDUib7ue45uh1/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYuEjPdfRNC5GOjnudooamFjQ2IoNm7EDYv/TV260ngF39RQTYi2BaUy9/284NkR/6S3xgDHqUnWAkNKhxn6+EL4ieQoj6Ey/mMlVpYuJkhrMUwtGFSgPdTCDip8rdku44WeBbIair+zSEZojHvhZ40cEVYwcMsV3xbk0jK+YT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIo7ZRqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7FBC2BC87;
	Wed,  8 Apr 2026 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674825;
	bh=K+d3sM3ZXbghcGPJnmUC6euMFq8hDUib7ue45uh1/dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIo7ZRqJ/Fm4jmXRS7GR/TNIlX5SyH2ItkWVXxUzj5k77uSrWbTWgQ0TBTxi8WI/l
	 x58vvwY6BuI9p18gjl7MaNANHz//oyfBmGlO1Rhw0VnVhEMEGh8qP8L9Imy9MibCgE
	 afwVKDg3P7sZKEDtlW9+yjOGkeGXsJI2pT4f7RdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 215/311] iio: adc: ti-ads7950: normalize return value of gpio_get
Date: Wed,  8 Apr 2026 20:03:35 +0200
Message-ID: <20260408175947.432205119@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-235199-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,oss.qualcomm.com,kernel.org,gmail.com,vger.kernel.org,huawei.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 8B81E3C2FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit e2fa075d5ce1963e7cb7b0ac708ba567e5af66db upstream.

The GPIO get callback is expected to return 0 or 1 (or a negative error
code). Ensure that the value returned by ti_ads7950_get() for output
pins is normalized to the [0, 1] range.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-ads7950.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -433,7 +433,7 @@ static int ti_ads7950_get(struct gpio_ch
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = st->cmd_settings_bitmask & BIT(offset);
+		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
 		goto out;
 	}
 



