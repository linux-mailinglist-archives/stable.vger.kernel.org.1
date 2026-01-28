Return-Path: <stable+bounces-212564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DeTEnc7emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9978A5EC5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF5C3219265
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DA301465;
	Wed, 28 Jan 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHkD8MZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FE2874FE;
	Wed, 28 Jan 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615941; cv=none; b=u0H7dmC/1sxgzhBADM5R1hMU6YkC9Y2Zb2lIaftqn1SeyP9LOhHiDLEiS2Rapk9gHvaJ6rEtu0MJIGvjZsPHumtlZeZ9mlCX6VFjWlU0lADlk+kxz8mCAviLecPNs9NAR69wRXeCTLuaYT0XXrI4d2xxYu64NWqBMDJOVFVWH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615941; c=relaxed/simple;
	bh=TA1NU9j6d4yTgnuSVOfCxq+TL9rc1n0PWAXCRRxnxxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXak+m1mzgk402BfQYyLmqfBEdaKj32zFc5dw1Ws/ngz96nipJK8+mFLZ6qKOLHNGpH7NN3gWLL3OyoflEs+QtUfgH/C1kh4A5DCfhQ5CAzgcfaHFg1815l97hwP2cfbDJDRdYpSREeM8Z0crZ6M5js7bhhDmZZWBxBc1vih/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHkD8MZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBDAC4CEF1;
	Wed, 28 Jan 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615941;
	bh=TA1NU9j6d4yTgnuSVOfCxq+TL9rc1n0PWAXCRRxnxxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHkD8MZqdl66OonOlM9M3tNXPjGVMKUNcveYeg92ls0seBMpihxR3NPypx95aAQ6i
	 uMQQ15IdtfdZRCrmyvGc1A+QqQrm7eT+gedzJy6+bvu5BtDWpgisPUevxv72i5YAft
	 sswmZqmoTquYjZwqTe8iemtkxQZkRwRD2QBWV7tI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Tomas Melin <tomas.melin@vaisala.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 159/227] iio: adc: ad9467: fix ad9434 vref mask
Date: Wed, 28 Jan 2026 16:23:24 +0100
Message-ID: <20260128145350.174288293@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212564-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,analog.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email,vaisala.com:email]
X-Rspamd-Queue-Id: B9978A5EC5
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Melin <tomas.melin@vaisala.com>

commit 92452b1760ff2d1d411414965d4d06f75e1bda9a upstream.

The mask setting is 5 bits wide for the ad9434
(ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
from ad9265 were copied by mistake when support for the device was added
to the driver.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad9467.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -95,7 +95,7 @@
 
 #define CHIPID_AD9434			0x6A
 #define AD9434_DEF_OUTPUT_MODE		0x00
-#define AD9434_REG_VREF_MASK		0xC0
+#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC



