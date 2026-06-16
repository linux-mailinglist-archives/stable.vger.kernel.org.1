Return-Path: <stable+bounces-266259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JzvuBcuZMWrOnwUAu9opvQ
	(envelope-from <stable+bounces-266259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:45:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776669471A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NW5Zbv03;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266259-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266259-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09713025D19
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C947CC80;
	Tue, 16 Jun 2026 18:44:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577346AF17;
	Tue, 16 Jun 2026 18:44:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635490; cv=none; b=fwvNnk7zrudfsjTV08Krnahb3iWY13wBKnSPRgcY83agIc+fWFBvyFavbw8vTVVJVsFtFYvO89RrKdKJmXOvOa/l0hJXseHeg+7Gk6BMIX7Fh0mTWubUqJ9AuLYbfRIzS1nsKQLD49lwG3Mzr4DRsboMmn7RTcv4ekWj+bDBmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635490; c=relaxed/simple;
	bh=bIVn07w4yYn2uWIaiCs9TyV059TxsM2eu6Bz185zQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obQRYvqMF9xKLP2Jh5OWFguazoOjAlyvUhAgBoAzSsLqQifPbigYLBnEuSwsYJaTtpjxhN96+P0GY8cY1Fh6CMvzcnJabmVI06ZhJW7fjSousoWh4rOcUTDlEiTn4UuJthbzeEnd0mFLifCELDuAy7F0oOXi/isOj0zrOegklj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NW5Zbv03; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B41F000E9;
	Tue, 16 Jun 2026 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635487;
	bh=Gpw7o2hVUAQTFsQfEJPJahpDXeOk5JVbfDMWWGZRoZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NW5Zbv03fX2oAoN1skrS4H52J1QiMPSIdTHHnFsdPmq/KUU4jHEs7I79h02xwP/po
	 0QWpI2SmjVuHZXfdSaOsx6xG8dXZufM8cUOFGMXjrwEJ3zDHwzoKvZEi7SJXngCY0D
	 uaXGUIqQDqbCrybhlixZTqF+j3IEZBnGdORM9kWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salah Triki <salah.triki@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5.10 059/342] iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
Date: Tue, 16 Jun 2026 20:25:55 +0530
Message-ID: <20260616145051.008789792@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266259-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,analog.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:salah.triki@gmail.com,m:joshua.crofts1@gmail.com,m:m32285159@gmail.com,m:nuno.sa@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:salahtriki@gmail.com,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6776669471A

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salah Triki <salah.triki@gmail.com>

commit 422b5bbf333f75fb486855ad0eedc23cf21f3277 upstream.

The driver proceeds to the reception phase even if the preceding
transmission fails.

This uses a goto error label for an early bail out and ensures the mutex is
properly unlocked in case of failure.

Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/viperboard_adc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct ii
 			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
 			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
-			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			mutex_unlock(&vb->lock);
 			error = -EREMOTEIO;
+			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,



