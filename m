Return-Path: <stable+bounces-218637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNkaMCxUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7718FBEF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B4531A0BAE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86313256C6C;
	Wed, 25 Feb 2026 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKy2hKO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A0248881;
	Wed, 25 Feb 2026 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983487; cv=none; b=lMOcFavCWWhuPZHOQH0ttU/tThafP6Mn51wpTNQ4phtOsH7XQZ35QyZ+Oh2pgX89vvnjY8rsfIwCjFPAWttJH/6HjSp7H+jnoxxRE2o8ydCEgowFvij7nL99K4ZDr/NRp+dC2BeRXRXKCVuk2rcpzkeLGtKtsZ67iufmtsDdSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983487; c=relaxed/simple;
	bh=AKVO/4gVHTMjI5iUJ15tgM7ij4Y9vnvM3PcAoc3AhT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYs2+ZTIS4GFPjotiR4/88pfqiWOb79OvkfmE25qq58TN4sAIPKI5FD052qmM9nXR8rr16+b4xwslh2NNTkSQg5VpscvlvkjpY702fULRPXrOTgb9b9kQkCOC2JDAeqLBAycmPrs2PYYZ+HVbaxA2PsoWWPKySH75WHKjwC9aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKy2hKO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4075C116D0;
	Wed, 25 Feb 2026 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983486;
	bh=AKVO/4gVHTMjI5iUJ15tgM7ij4Y9vnvM3PcAoc3AhT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKy2hKO84znq2hPU7K0qwzIZEONP5Ri34801tlVVZtRjSCVnoTDdbDMR1/thYMyBg
	 oYqmiwXl+V3meypxA+hQeSzLcAwXQ1GwilScOs29fLA+88tPY1nyTltDgOpA5gJ0jb
	 kR0xgDwBC3IvQW/9kaA3Yk/WxJ1cQlpLDMFFNoCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 599/781] iio: sca3000: Fix a resource leak in sca3000_probe()
Date: Tue, 24 Feb 2026 17:21:48 -0800
Message-ID: <20260225012414.488646798@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-218637-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 50D7718FBEF
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 62b44ebc1f2c71db3ca2d4737c52e433f6f03038 ]

spi->irq from request_threaded_irq() not released when
iio_device_register() fails. Add an return value check and jump to a
common error handler when iio_device_register() fails.

Fixes: 9a4936dc89a3 ("staging:iio:accel:sca3000 Tidy up probe order to avoid a race.")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/sca3000.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bfa8a3f5a92f4..9ef4d6e274669 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1489,7 +1489,11 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_irq;
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
+	return 0;
 
 error_free_irq:
 	if (spi->irq)
-- 
2.51.0




