Return-Path: <stable+bounces-265399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6fbHNGmJMWrvlwUAu9opvQ
	(envelope-from <stable+bounces-265399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:35:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B069349B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dpnjiONy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265399-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265399-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74DD331C85F6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F053CC303;
	Tue, 16 Jun 2026 17:30:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550530C360;
	Tue, 16 Jun 2026 17:30:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631003; cv=none; b=X/yMywJAdRYEpc+ZTKmbXtRWiCsSzT0L0IAKFPqWnO2d8CcDlL+0wM/8n8FYKHmcpDUV5TMEQm1sUKS9ufhB1882RotQOK5k+5BQCU8URIC97PbrPgE7LhGUIq+fbwZsnnhRm4PXQRSQxVHtgJzGZLx8yqjPr6sIY/Rod2i6Ieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631003; c=relaxed/simple;
	bh=3pM8XmGMqa6NeVQwijn1lIyJiRZa4hHWeUnhDO0dwDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRLLIYYcLe37PBsiHJ+opiAnRTFucbQiC8et7UqNtMwk/ArmnFAU0F9uRT9ycDeyHCdVuv0Gpt1xyVbmzsJ7dXJ7Cs7Ze00DA33Z2WFcoz7rADdfNb/HghEBQ+1wkXczcB9oJ2xK5uPTDAKoChYrZup6eRdszPJQXNqpDot8dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dpnjiONy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1441F1F000E9;
	Tue, 16 Jun 2026 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631001;
	bh=hIg7h0LPyPWKJpNeC0v/CAFImPtzny3a52AnjhtWIDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpnjiONyMuzS1TrMwrDfxVSUieEb4mSbVt7fTn+TfoYSbVy0x5At43vwCs5XxZmz2
	 Qn806Jm30KbEeWMJej9pXH5rpJ9m+2o00vgJ/geW+jkU/AQpBrdcRrRZmuOVyXM7kx
	 5Z7V1ggYXZ89s58nPaR6/0IjTKb5CORvr1KSoTC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salah Triki <salah.triki@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.1 104/522] iio: dac: max5821: fix return value check in powerdown sync
Date: Tue, 16 Jun 2026 20:24:11 +0530
Message-ID: <20260616145130.799062085@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-265399-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:salah.triki@gmail.com,m:andriy.shevchenko@intel.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:salahtriki@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 495B069349B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salah Triki <salah.triki@gmail.com>

commit d0a228d903425e653f18a4341e60c0538afb6d41 upstream.

The function max5821_sync_powerdown_mode() returned the result of
i2c_master_send() directly. If a partial transfer occurred, it would
be incorrectly treated as a success by the caller.

While the caller currently handles the positive return value of 2 as
success, this patch refactors the function to return 0 on full success
and -EIO on short writes. This ensures robust error handling for
incomplete transfers and improves code maintainability by using
sizeof(outbuf).

Fixes: 472988972737 ("iio: add support of the max5821")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/max5821.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -91,6 +91,7 @@ static int max5821_sync_powerdown_mode(s
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -104,7 +105,13 @@ static int max5821_sync_powerdown_mode(s
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(outbuf))
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,



