Return-Path: <stable+bounces-230904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBq2JLUmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F73522A9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED813015867
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF88374E55;
	Sun, 29 Mar 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlB5f/r4"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB33374E47
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790306; cv=none; b=Bf5icqjmjChsI04XQdioNIiyIa10FKTti9Q8Kdu5EC8p7WXm5wRVm8IR/YCMRvkVwRu0jEyKtS3plL0dYAM3hfO4XogKc+6qP3Ava96gCOI9DwdkZ7jg77vjDvbl+BS+HlbOOkiibea5LBlnEFk2AMNFxx5Xu8NROpYSer4G3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790306; c=relaxed/simple;
	bh=hlKtHSMJ3KtpL2SFBwghwMvgSi1Rbuc8EtkwBZh/tyE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BXpsHy2dM6fu/Z7gH7qmDWdsZm7iaqN4XZRiPh+TWq5lByIwPu112PpgRWQ4rD4K7u8ZOQfwuYNPtg1tU115RMlWlsF2TbJhOuhhIfC4zF8aSyHClZ5Cge5vpnpDl7hxgtqoeT/g+2MpTj4AiRck6G5BzoJZklnch13kPYg0+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlB5f/r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6374C116C6;
	Sun, 29 Mar 2026 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790306;
	bh=hlKtHSMJ3KtpL2SFBwghwMvgSi1Rbuc8EtkwBZh/tyE=;
	h=Subject:To:From:Date:From;
	b=DlB5f/r4MOfhz+CaIXcuzCpSah+KdXyTrnHdYn9jBMmVYFTZHg++np994K/QO9tQF
	 qBDl9ITPBJpzIpKmn8R5nseQnLjqwkwUtY2nkkSo/1Q01RT+2Ud3Tu/jWQdhxrocH6
	 Z42Olcj0FrPrLlo5JPtSbesLEbrz1PymWB2EyoTk=
Subject: patch "iio: adc: ade9000: fix wrong register in CALIBBIAS case for active" added to char-misc-linus
To: giorgitchankvetadze1997@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,antoniu.miclaus@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:09 +0200
Message-ID: <2026032908-immature-ebook-5fcb@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230904-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,analog.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,analog.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 064F73522A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: fix wrong register in CALIBBIAS case for active

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 86133fb1ec36b2f5cec29d71fbae84877c3a1358 Mon Sep 17 00:00:00 2001
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 26 Feb 2026 18:07:02 +0400
Subject: iio: adc: ade9000: fix wrong register in CALIBBIAS case for active
 power

The switch statement in ade9000_write_raw() attempts to match
chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
the calibration offset write for active power channels. However,
chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
num), so after masking the phase bits, tmp holds
ADE9000_REG_AWATT (0x210), which never matches 0x00F.

As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
falls through to the default case and returns -EINVAL, making
active power offset calibration silently broken.

Fix this by matching against ADE9000_REG_AWATT instead, which is
the actual base address stored in chan->address for watt channels.

Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
register at 0x00F (p. 44), while AWATT is the total active power
register at 0x210 (p. 48).

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c62c6480dd0a..945a159e5de6 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_dev *indio_dev,
 			tmp &= ~ADE9000_PHASE_C_POS_BIT;
 
 			switch (tmp) {
-			case ADE9000_REG_AWATTOS:
+			case ADE9000_REG_AWATT:
 				return regmap_write(st->regmap,
 						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
 									chan->channel), val);
-- 
2.53.0



