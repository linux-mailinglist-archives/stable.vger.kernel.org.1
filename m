Return-Path: <stable+bounces-230930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6De7EL4pyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EE352418
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01626301AD2B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A7375F96;
	Sun, 29 Mar 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsAuxHEb"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39279376475
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790952; cv=none; b=XGGLDnuzz5tU0ZJ5UYeFgCeU4nCCfwY6AX3bHRcTFhJkqGuFzgYUZ0mLTnPFkP2EJLjb8hEPfnhJDjUu/OMz5HKHtPb4gsJxgCm/dj0s3AFLsf3UKMOyy6KMfPanCIqfRncCwm4t1PPZVmGwwF674Q0l7EqJ0Iz9WT7kw9Flu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790952; c=relaxed/simple;
	bh=htxaZaaN5qvE+aB7pCzVBRQzTqUhryIALEM+KIT76pM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jYUTNhF6NtB4qIleo/MIiDTOEFLqMiw0ayjLnR1zr/k/a0UR25luKM6tyNfXffe3aCyiyYG12uzqPalxfC36a3dMKWLzAAE4F41PBHYhVFWwG1Y5sqVNY7CfJ7ndHMsL5WRy70e/ueZxcz02nPj5NxiNROGfFdkCfdXGWx+Y7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsAuxHEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1E5C116C6;
	Sun, 29 Mar 2026 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790952;
	bh=htxaZaaN5qvE+aB7pCzVBRQzTqUhryIALEM+KIT76pM=;
	h=Subject:To:From:Date:From;
	b=QsAuxHEbiOxsTmAbYnFSRUyWH+uZbWo7ehZJKH2bY2DuPh7uhiTs6CD+deoyJq7wV
	 azMSI44BHUCoGa1RmJRHkCFsSkyTxGVYh7dWw4que8p2HWEQO2lrIihGLVuVj7+duP
	 VwVA9lszB5J9d7/CeCN+yUMKY93S5gaNSacuxK7I=
Subject: patch "iio: light: veml6070: fix veml6070_read() return value" added to char-misc-linus
To: aldocontelk@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:17 +0200
Message-ID: <2026032917-parasitic-bronzing-7394@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230930-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: CD5EE352418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: light: veml6070: fix veml6070_read() return value

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From d0b224cf9ab12e86a4d1ca55c760dfaa5c19cbe7 Mon Sep 17 00:00:00 2001
From: Aldo Conte <aldocontelk@gmail.com>
Date: Wed, 25 Mar 2026 12:32:16 +0100
Subject: iio: light: veml6070: fix veml6070_read() return value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

veml6070_read() computes the sensor value in ret but
returns 0 instead of the actual result. This causes
veml6070_read_raw() to always report 0.

Return the computed value instead of 0.

Running make W=1 returns no errors. I was unable
to test the patch because I do not have the hardware.
Found by code inspection.

Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/veml6070.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 6d4483c85f30..74d7246e5225 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = (msb << 8) | lsb;
-
-	return 0;
+	return (msb << 8) | lsb;
 }
 
 static const struct iio_chan_spec veml6070_channels[] = {
-- 
2.53.0



