Return-Path: <stable+bounces-261425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3UVOFxJJWqhGAIAu9opvQ
	(envelope-from <stable+bounces-261425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BE64FD2C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rGCePoRP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261425-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261425-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D83CE30041C4
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58A3195FD;
	Sun,  7 Jun 2026 10:35:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BA2C1595;
	Sun,  7 Jun 2026 10:35:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828506; cv=none; b=RfbApf+pnaWNRO/Awmqv5iArOD7LBsBVC3eHHkjdcy7LiiKNbjT/BXrJcJdHlcn1tzgpU7KSQCgG2G0/eiVIYE4Wuf7yn77LxQ2WJvNPXIcQzol8ZqA0nruJoDMr0oRx8okfzCjpOOXXu7uF/JD/4Y+MZS3fY54Nr9sEpOnof8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828506; c=relaxed/simple;
	bh=qhuxHwAjKZBvGf0hHpaa3c8W9W95WSBaNUvPY/WObjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWxbTrv5PvI/IxYkadSlNoYkFpCk08ByvUQ5ABuEcsLGe7f1rXuznfAn1TKD8LLZWvqRB0uhTPQnJHjBjunj0KtfGruOzP2TebdLbmamMX4vfPdw1nBVlWhazqPYyxvHxlkTdGuzweKAHaE4FtSdUfSJ1R+OyXlUMpXmeqglK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rGCePoRP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723C41F00893;
	Sun,  7 Jun 2026 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828505;
	bh=TH5dmCGQ7huZB02NgR7IR3ga7IViVztpl7JJTNQX4rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rGCePoRPLf97Y4byfmNFMKi/jarqqpbu3HpZlKxOTgdybEOzh68QzXZKgtMFtjTRL
	 aiWNLOTA6z8bHqQFugacHo4Bskw1/s+frcWmOFuXeX92wD/Pncb9Tf65NJXvvkSTiy
	 G6jbLPXEfYnlCR8esFZ/SrPsrrNZrV9xSfu4rRYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7.0 189/332] iio: gyro: adis16260: fix division by zero in write_raw
Date: Sun,  7 Jun 2026 11:59:18 +0200
Message-ID: <20260607095735.007620001@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261425-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:antoniu.miclaus@analog.com,m:nuno.sa@analog.com,m:Stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,analog.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 709BE64FD2C

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 761e8b489e6cf166c574034b70637f8a7eadd0ee upstream.

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero to the sampling_frequency sysfs
attribute triggers a division by zero in the kernel.

Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/adis16260.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -287,6 +287,9 @@ static int adis16260_write_raw(struct ii
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else



