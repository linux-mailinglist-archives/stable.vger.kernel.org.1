Return-Path: <stable+bounces-272815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uLAUOOU1T2q4cAIAu9opvQ
	(envelope-from <stable+bounces-272815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 07:47:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43A72CDD9
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 07:47:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="NIqL4Mh/";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272815-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272815-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96AF3038F67
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED23AC0E6;
	Thu,  9 Jul 2026 05:45:12 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C123AA9CA
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575911; cv=none; b=lKjDUwehwRyj+y2SLIB/6ofv2/2Gqs69dBuVEQB5kI8aN2dD/MyP+OJTxGFdZcJI0Lt/3mjotT0ObfOO23iJl/oSK3afuKSyGAZBWK2Z140gWosbiaIzexY3t0R8aHBF7udYRSga+qyEsUiuqqJPwDPnGkzYp/HIW+JXlHVIc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575911; c=relaxed/simple;
	bh=IyntsvvsAuZMQvV+12ylHZ17q073z3iurmH9e4cNI44=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=u43dzhomjWjGdpQUdQI2kw9NoyvG25Q7JfrBox3wUc4b+wyo80eVT/aduSuDFXLrN4ahKD2oyM9+aA+4LYjY6/XQLPSmkiFfQ3sScHlQYaZmOaLlJAk/L0j4zZqJv+2SRrAi3lgJ3CnQc+FIdr97P78lANHYO9aeRklABeVT/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIqL4Mh/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE211F000E9;
	Thu,  9 Jul 2026 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575910;
	bh=EJG0XVo05OObmoli996VyGivzMvP4dJgFP0fYnV9kvk=;
	h=Subject:To:From:Date;
	b=NIqL4Mh/ipo5mpauXrbHeioojxW81LWdDOmWLgZiZSI8EyGz28rvzIy18rmmZR+zl
	 4FH0lF4GgykkV85+p4+pFBfbPVLNFbfsGlH8J41keG5GhcoGIA+tXsWFzLe87bKxrp
	 wB3iQxSrxlCC6LNPPvOtCNvg0SKPg9Y+UfeLei8I=
Subject: patch "iio: adc: lpc32xx: Initialize completion before requesting IRQ" added to char-misc-linus
To: m32285159@gmail.com,Stable@vger.kernel.org,bookyungwook@gmail.com,jic23@kernel.org,jjy600901@snu.ac.kr,sangyun.kim@snu.ac.kr,vz@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:48 +0200
Message-ID: <2026070948-accent-puritan-3e56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272815-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:m32285159@gmail.com,m:Stable@vger.kernel.org,m:bookyungwook@gmail.com,m:jic23@kernel.org,m:jjy600901@snu.ac.kr,m:sangyun.kim@snu.ac.kr,m:vz@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,snu.ac.kr];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snu.ac.kr:email,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A43A72CDD9


This is a note to let you know that I've just added the patch titled

    iio: adc: lpc32xx: Initialize completion before requesting IRQ

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e561b35633f450ee607e87a6401d97f156a0cd54 Mon Sep 17 00:00:00 2001
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 12 Jun 2026 19:58:10 -0500
Subject: iio: adc: lpc32xx: Initialize completion before requesting IRQ

In the report from Jaeyoung Chung:

"lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in lpc32xx_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

lpc32xx_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: 7901b2a1453e ("staging:iio:adc:lpc32xx rename local state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/lpc32xx_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 43a7bc8158b5..db3a602327ff 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -179,6 +179,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	init_completion(&st->completion);
+
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
 	if (retval < 0) {
@@ -197,8 +199,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iodev);
 
-	init_completion(&st->completion);
-
 	iodev->name = LPC32XXAD_NAME;
 	iodev->info = &lpc32xx_adc_iio_info;
 	iodev->modes = INDIO_DIRECT_MODE;
-- 
2.55.0



