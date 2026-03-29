Return-Path: <stable+bounces-230916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCBiNOYmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BA352305
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B91DB301683C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E336492B;
	Sun, 29 Mar 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zu6zzyji"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981D280A5A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790356; cv=none; b=jeLrhZ6IlLwWyL8M+3RqMcq8RmzPFgmczJKD0iCXi0iJOcXB1+avRrR9V8iWzTb1Sh8C/PlzvR/byOphOJVoiU13JaAXrQtAY2BjLPRQg65l6HW8bTu1fErHrT3SfDoZ65EwUTuyjo1rSP5YAbfMsoaAb/1Yavgg8d1qAMEgfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790356; c=relaxed/simple;
	bh=7z4sjbOy41GC51XYKG1HqUvBm9OpBUGuUOZkBysrP9s=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=WPVK4Rs6rD60pmVbaugD6Xm8K/Eb+GTXEAp4RmSwrAf8e6DrbU7d9wpN4NxC2/Rv/HR4QF2gW1AGbAToRaTcy35S2Hx57GjAHopEx5rMA5NW5M1sCW6zSwZQWY55y2nLl5JcmUIHQ1haaJkwTM36V4b1l5dj5YHYPDuxS5QuVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zu6zzyji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C28BC116C6;
	Sun, 29 Mar 2026 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790355;
	bh=7z4sjbOy41GC51XYKG1HqUvBm9OpBUGuUOZkBysrP9s=;
	h=Subject:To:From:Date:From;
	b=zu6zzyjiwHwDscSg5QlQKXIoBZH9MZyUmRt+uDRZm36PqY/G++zYATLVZ0yMT1FCF
	 f86qGqP4x1QTVOrAecpQwBRx+C2ICeHymQ4rbjIYZSa5u0Gx1BN7auVqW6oxKLs7NH
	 74TxwN5hvRjov4GXk3M2tbIfVW7quWgFtPe5btMI=
Subject: patch "iio: adc: ti-ads1119: Reinit completion before" added to char-misc-linus
To: ustc.gu@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,francesco.dolcini@toradex.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:16 +0200
Message-ID: <2026032916-laxative-florist-481d@gregkh>
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
	TAGGED_FROM(0.00)[bounces-230916-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,toradex.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,toradex.com:email]
X-Rspamd-Queue-Id: 601BA352305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1119: Reinit completion before

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 2f168094177f8553a36046afce139001801ca917 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 3 Mar 2026 21:47:33 +0800
Subject: iio: adc: ti-ads1119: Reinit completion before
 wait_for_completion_timeout()

The completion is not reinit before wait_for_completion_timeout(),
so wait_for_completion_timeout() will return immediately after
the first successful completion.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1119.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 7f771c7023b8..79be71b4de96 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -280,6 +280,9 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 	if (ret)
 		goto pdown;
 
+	if (st->client->irq)
+		reinit_completion(&st->completion);
+
 	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
 	if (ret)
 		goto pdown;
-- 
2.53.0



