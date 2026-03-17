Return-Path: <stable+bounces-226836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CdTFH+PuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:29:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 100762AFAF7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBFD304CA77
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3041280A21;
	Tue, 17 Mar 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFa+jE1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84080346797;
	Tue, 17 Mar 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768404; cv=none; b=fqaSdb36pn9caeDEqNaWz1xoQbEb24o/BnqzEisErUffxcXCSrLKgVm5wanQxjjQnkBmfoHrGMm4tmsa/9zcd33RWLLP07fA3nqWjxDxY+qK8NFUrfisSAGHkxytsN0oSEVsM78bvgvHktGD2VvtnLQfW5OV3dC0vzihrZQrIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768404; c=relaxed/simple;
	bh=TjiWg/aDvSpQHeQjrR5MFe+20aXbmewHHvxK6oSnFEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGNFkBGUV+xhzreWMtIn5ZiuiLXfdXCNMMxDQCLri/zZCbETfuct6kRDiHqZ90vAZXGLanvDHEWkLTMQPE0S91/+xV/VXyEnDbhUu3+1QfRefxoKzkxr50Kdy+2qnrNiDcifBjrivoKRpu+sjuq+EzpgwHlo4icMKFFDPwYrSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFa+jE1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B151BC2BCAF;
	Tue, 17 Mar 2026 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768404;
	bh=TjiWg/aDvSpQHeQjrR5MFe+20aXbmewHHvxK6oSnFEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFa+jE1pXvo46FC3Lv7BNsYrgyc3yTwlotzTCXFWs8XefLUK+oIZV6Pa5ftL6lifI
	 uXYNIIPa6U0F/XsdNezVmiqM1Z/cm9itbF5E/y2keXa6m3W/yuk/cWJ0m/fR4fzf2S
	 vk/ShFvpqU7dzXfIZCq6CiSxF6b/754A0zsKdt+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Radu Sabau <radu.sabau@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 301/333] iio: imu: adis: Fix NULL pointer dereference in adis_init
Date: Tue, 17 Mar 2026 17:35:30 +0100
Message-ID: <20260317163010.554717061@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226836-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 100762AFAF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Sabau <radu.sabau@analog.com>

commit 9990cd4f8827bd1ae3fb6eb7407630d8d463c430 upstream.

The adis_init() function dereferences adis->ops to check if the
individual function pointers (write, read, reset) are NULL, but does
not first check if adis->ops itself is NULL.

Drivers like adis16480, adis16490, adis16545 and others do not set
custom ops and rely on adis_init() assigning the defaults. Since struct
adis is zero-initialized by devm_iio_device_alloc(), adis->ops is NULL
when adis_init() is called, causing a NULL pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    pc : adis_init+0xc0/0x118
    Call trace:
     adis_init+0xc0/0x118
     adis16480_probe+0xe0/0x670

Fix this by checking if adis->ops is NULL before dereferencing it,
falling through to assign the default ops in that case.

Fixes: 3b29bcee8f6f ("iio: imu: adis: Add custom ops struct")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index d160147cce0b..a2bc1d14ed91 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -526,7 +526,7 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
-	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
+	if (!adis->ops)
 		adis->ops = &adis_default_ops;
 	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
 		return -EINVAL;
-- 
2.53.0




