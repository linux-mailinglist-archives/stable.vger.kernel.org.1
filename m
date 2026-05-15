Return-Path: <stable+bounces-247695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKgwNBoQB2qirAIAu9opvQ
	(envelope-from <stable+bounces-247695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:22:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6D54F63F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC1B730AC727
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658847DF8D;
	Fri, 15 May 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7o46kye"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAC47DF8B
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845597; cv=none; b=CPA0PyEck3BDSLlYIxUcmc+ijbM7onQ/zBDxDguNEjneHAjWBeyf81z05Ic7TH3J7LAwCH3QB0IH49HGPgs/RPyRIG+JqUu1wL45oIWjT2b21zisY06WljHNGB0+aZbqm9OrdBqG3aNpyMH2jgkZTDAw7/65YtUSu+oOpaHado8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845597; c=relaxed/simple;
	bh=rXcxeP+bF7y/WFoLm7I0EmkUZbCTgNBgcu6K29I6YeI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=a1K7PfRJ6rCVUGJ+ZtZ3HZVD6ra+9bHTpJU4Ds+9Lgr/6WD/0Kcra2UExGLywYxG+afi0sjaCM3gRdBj1Evlu9nXkKQZdRc6WxRcI/vu+oExbmuYzwUT6UGxh2CZ6eYqFiFgtsbD2QCcoq2yA0x0hXY+kXwkzY44WGqcESjbCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7o46kye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6417DC2BCB7;
	Fri, 15 May 2026 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845597;
	bh=rXcxeP+bF7y/WFoLm7I0EmkUZbCTgNBgcu6K29I6YeI=;
	h=Subject:To:From:Date:From;
	b=p7o46kye3wRNTUc0Lf8Drkk0g+JsO86RKpXTKuUB5L11kZ0LBrHgOSJahFboakFD1
	 QDBQo8qpA+G+Y3/FTvY+nsuCDvTOu5GCcrMDT+okBElz9q5IZNasYs4TzkF0rj/0Ph
	 zO+9RkSvnGSJx/cV/xk/7T7ca+KPoIHLMK6Xo2B4=
Subject: patch "iio: dac: max5821: fix return value check in powerdown sync" added to char-misc-linus
To: salah.triki@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:59 +0200
Message-ID: <2026051559-paver-cinema-ed1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1B6D54F63F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247695-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: dac: max5821: fix return value check in powerdown sync

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From d0a228d903425e653f18a4341e60c0538afb6d41 Mon Sep 17 00:00:00 2001
From: Salah Triki <salah.triki@gmail.com>
Date: Mon, 27 Apr 2026 22:33:19 +0100
Subject: iio: dac: max5821: fix return value check in powerdown sync

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
---
 drivers/iio/dac/max5821.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..dd4e35460195 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -90,6 +90,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -103,7 +104,13 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
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
-- 
2.54.0



