Return-Path: <stable+bounces-247699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LjbHX8PB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:20:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCDA54F589
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FC131A569B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AD47DF87;
	Fri, 15 May 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MdVV+s0w"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316D47F2D5
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845613; cv=none; b=e10+IkQDRq0NMc9YXAXy5S5+6yY4QAHZWLsNjvdzdqVGOnGF0YT4uUDJ25Y8zDECIDKZtkoC4iHDVV6+MkHj7vPDfyskZ0y8udDuse2UJo6PMpkXPkAQxO2wIl8wR1RIgLLEqR1l/cC0t9ceybeZp6TkbClLRRsRCK5UBODEUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845613; c=relaxed/simple;
	bh=y1z99AcdgtHWGphH/YRRsEPypdbuS94ebbgrwHtLAAA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=f1afaWQ8LwUYV2Rmvz7jF93hlgW4enFDm/Z7INzmgmYxOnPQ+sZGB01WTQbi26iQDvkpvAmY/L/r6vhIxe49itGd2fGC2oAvBEjCSGAmCDsHC3VZqlkQTGnTg9Cx2mnQKH81bhPQaEyE1MO/2Nlg21oCN0uuhWW8hmRMfE7kkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MdVV+s0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9F4C2BCB0;
	Fri, 15 May 2026 11:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845613;
	bh=y1z99AcdgtHWGphH/YRRsEPypdbuS94ebbgrwHtLAAA=;
	h=Subject:To:From:Date:From;
	b=MdVV+s0wk8H50OARMco1I1VNA+u8Ozs209HxhjQDFhYb2xWJdvtxruigdAo088FY2
	 //MgYnHQ096pPUk6979/uUexW7Vx+y3ijsjMB7e3nUomf7riIhxrfNyrzuYijNqaGB
	 uNwp/X2T5cKqXeuJOitjFV8wlLcCsRjfsiNF97Cg=
Subject: patch "iio: ssp_sensors: cancel delayed work_refresh on remove" added to char-misc-linus
To: sanjayembeddedse@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:46:00 +0200
Message-ID: <2026051500-flattop-stoning-805b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCCDA54F589
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247699-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: ssp_sensors: cancel delayed work_refresh on remove

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From eedf7602fbd929e97e0c480da501dc7a34beb2a8 Mon Sep 17 00:00:00 2001
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Date: Sun, 26 Apr 2026 14:47:04 +0530
Subject: iio: ssp_sensors: cancel delayed work_refresh on remove

The work_refresh may still be pending or running when the device is
removed, cancel the delayed work_refresh in remove path.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..e2538a84c812 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
+	cancel_delayed_work_sync(&data->work_refresh);
 
 	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
-- 
2.54.0



