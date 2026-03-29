Return-Path: <stable+bounces-230921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OL0L5ApyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8C3523F3
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E90300F518
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F3375F69;
	Sun, 29 Mar 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDPEu814"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A893644D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790920; cv=none; b=NqHiQ6rMq6sCzbaUYpyZ9exIogFYJJFLkEl+1sjTzv3toHK6PT0JqAxkcOpEYlnjlTRY72zxlYAoolknFE6CdPtnyf70efpFPR6nlnGE02VLi9n7wY2NeiBxIff9nhpOUDoFOnfC66CbUSzIaA66VCBCoC3JRsf37kvbk85nQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790920; c=relaxed/simple;
	bh=8C4lacSkk8epOjRH+K7uov6s3c8fH7YGospVmdmvwAc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=txaHpSMJ4X3UjSLYtvPqIrdNB955fwu2yx1aQ+QyGZmfTHTsl5nEDz8zJbqrF9RS4Wf7eSzndyfQj4uI9iB6aShHrdt9ZOKJpnGngtPHYw0xJcu7bqjWHlgxx2QF398FihLkR/A9yEtyaNDJyja9NTpRq4zzM5qPYduMVdI9g08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UDPEu814; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1702C116C6;
	Sun, 29 Mar 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790920;
	bh=8C4lacSkk8epOjRH+K7uov6s3c8fH7YGospVmdmvwAc=;
	h=Subject:To:From:Date:From;
	b=UDPEu814Oh1sbL4GSH0jCUPps8DgoeTtHkgWWbgW5esKtRBSXDcHcEsre+CcgPGTD
	 j54kFgYRa7af646RCzPtnONVJLJRiv/s3mb7DjxPe6WHmlbiZ9PKz3gPVNwW3P7o72
	 bx3EfOkTSl5pK7ItSJsj9x/tWiV8LPQ41aNKVjtI=
Subject: patch "iio: proximity: rfd77402: Fix completion race condition in IRQ mode" added to char-misc-linus
To: ustc.gu@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,raskar.shree97@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:12 +0200
Message-ID: <2026032912-stupor-cornball-ac48@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230921-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EE8C3523F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: proximity: rfd77402: Fix completion race condition in IRQ mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 9978d74031f25fde575bef3e4e3e35c5009091ce Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 4 Mar 2026 22:14:32 +0800
Subject: iio: proximity: rfd77402: Fix completion race condition in IRQ mode

In IRQ mode, the completion was being reinitialized after the
measurement command had already been sent to the hardware. This
created a race condition where the IRQ handler could call complete()
before reinit_completion() was executed. Consequently,
wait_for_completion_timeout() would fail to see the signal and wait
until it timed out.

Move reinit_completion() to occur before the measurement command is
triggered to ensure the synchronization primitive is ready to
capture the interrupt.

Fixes: dc81be96a73a ("iio: proximity: rfd77402: Add interrupt handling support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/rfd77402.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 6afdbfca3e5a..81b8daf17a54 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -173,10 +173,8 @@ static int rfd77402_wait_for_result(struct rfd77402_data *data)
 	struct i2c_client *client = data->client;
 	int val, ret;
 
-	if (data->irq_en) {
-		reinit_completion(&data->completion);
+	if (data->irq_en)
 		return rfd77402_wait_for_irq(data);
-	}
 
 	/*
 	 * As per RFD77402 datasheet section '3.1.1 Single Measure', the
@@ -204,6 +202,9 @@ static int rfd77402_measure(struct rfd77402_data *data)
 	if (ret < 0)
 		return ret;
 
+	if (data->irq_en)
+		reinit_completion(&data->completion);
+
 	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
 					RFD77402_CMD_SINGLE |
 					RFD77402_CMD_VALID);
-- 
2.53.0



