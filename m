Return-Path: <stable+bounces-230912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B1FItYmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF93522E9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D830130154A9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B6374E47;
	Sun, 29 Mar 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jveCrPkp"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CE37474A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790342; cv=none; b=iAu7TOOkgo3JnioipxArDwWIr6Sc5Hh5pHeAB2zol8LGLCMhEG92htStW6oRsXAAEgt75mHZgbTbDMRhI+yRC88+3ZtRi2Fl48zyFRrzBn+ZcQ9b/RGiFwXXS5VUy5PaifSUBOTO6QdS26ctwfpuPa5+C9BC9De1aV3BQjtDye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790342; c=relaxed/simple;
	bh=WyXnAGfYagksp99f2WveiXwKEGuaeDdEEvw86S7JTsI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=dRdJ0TW3di0UbaI+0VI3OBE9yBn2OGuqV6HXxmVtf8YoWWT4H/Bt8ak/DG0pGEZkFeBrQ6tXqY3BmmA9/bf5HSuP7iP9NbjUrpwFiJyyrj8SF3m0SE4k4X4+HkeXpwCY5sXsF8PpQSJBHoD3/vchyJN99cW4f213Krcqtyryp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jveCrPkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4E1C116C6;
	Sun, 29 Mar 2026 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790342;
	bh=WyXnAGfYagksp99f2WveiXwKEGuaeDdEEvw86S7JTsI=;
	h=Subject:To:From:Date:From;
	b=jveCrPkp9yfMstN1E5Y+4XhXhgKvKLvJ3OYpFTxAyC8O4GSIAaEV3VStjjH00eT1D
	 lCvu6mNKTWdN5/HEDNXow3DuPRslXAV3+wwfat4MF/lw1uPsNBIuxAbS8nLtY9E33/
	 2mnUyq4OIoLzJms3d4UzlRl6fwCAhBIwn3rsUokM=
Subject: patch "iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD" added to char-misc-linus
To: ustc.gu@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:14 +0200
Message-ID: <2026032914-verse-vista-7aaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230912-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0DBF93522E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 36f6d4db3c5cb0f58fb02b1f54f9e86522d2f918 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 3 Mar 2026 00:00:04 +0800
Subject: iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD

As there is no threaded handler, replace devm_request_threaded_irq()
with devm_request_irq(), and as the handler calls iio_trigger_poll()
which may not be called from a threaded handler replace IRQF_ONESHOT
with IRQF_NO_THREAD.

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1119.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 4454f28b2b58..7f771c7023b8 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -735,10 +735,8 @@ static int ads1119_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "Failed to setup IIO buffer\n");
 
 	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						ads1119_irq_handler,
-						NULL, IRQF_ONESHOT,
-						"ads1119", indio_dev);
+		ret = devm_request_irq(dev, client->irq, ads1119_irq_handler,
+				       IRQF_NO_THREAD, "ads1119", indio_dev);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to allocate irq\n");
-- 
2.53.0



