Return-Path: <stable+bounces-230917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCTXIuomyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330035230C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1531330156D3
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDE35DA78;
	Sun, 29 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnOuLh96"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF44280A5A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790359; cv=none; b=s5DPjjlnjPsX1W+vV+5tjooMB8394RtYXkvHgjwOYWtg8s3ww9MH5SGiI3tLfM75YmX676bAfL/1E+kp3yZxMzj51vR2xeYzQVU0pn9XnTJQ7vdrFD9DPYejJySSKra8BRjkBJ+OuBSV7C0jAMb7uyt4anVKjfqpwtCSZwnXj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790359; c=relaxed/simple;
	bh=RURITcbB0Bsp29w9Zpav/L7+4gCjI+guK61mbHSYQF8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eps5pMVcH1cOacm3dnNDse9QzqvFIAsejA91fNEtmBTAB/VGaiq3c5w52PNqGfK7CReeuFm5Qyh9Dge9l69xlK1w8jaCOZcPXbDIlnrBsUT4JBW2l7TBM3txe5upA3RKb8bUBqnn5jpJ28ARx/tnIsvriF8jvpT+HFuRSwd+b/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnOuLh96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F74FC116C6;
	Sun, 29 Mar 2026 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790359;
	bh=RURITcbB0Bsp29w9Zpav/L7+4gCjI+guK61mbHSYQF8=;
	h=Subject:To:From:Date:From;
	b=fnOuLh96X6ZxokZFK+qNZb+BHfRDwUvVWgCDh0sIbVaHP6x4VU4lcRc5Sz4/sQHso
	 0LhcKWHwR1hpS1JuwmOQ0EtVP0i7rVVbZcVN+VNz0SsDVSag7mYYcnLqGzC76U2HuF
	 R36jrbqwcu6NiLDhBXucu5XNESpmg+/Cza2XI3Zc=
Subject: patch "iio: adc: aspeed: clear reference voltage bits before configuring" added to char-misc-linus
To: billy_tsai@aspeedtech.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:16 +0200
Message-ID: <2026032916-referable-gloating-e23c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230917-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aspeedtech.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3330035230C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: aspeed: clear reference voltage bits before configuring

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 7cf2f6ed8e7a3bf481ef70b6b4a2edb8abfa5c57 Mon Sep 17 00:00:00 2001
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 3 Mar 2026 10:38:26 +0800
Subject: iio: adc: aspeed: clear reference voltage bits before configuring
 vref

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Fixes: 1b5ceb55fec2 ("iio: adc: aspeed: Support ast2600 adc.")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 4be44c524b4d..83a9885b9ae4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
-- 
2.53.0



