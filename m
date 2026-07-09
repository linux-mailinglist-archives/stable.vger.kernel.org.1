Return-Path: <stable+bounces-272820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VM2oGWU2T2rccAIAu9opvQ
	(envelope-from <stable+bounces-272820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 07:49:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6072CE1F
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 07:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UtW7t2cQ;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272820-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272820-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDE5309DACA
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF313ACA5A;
	Thu,  9 Jul 2026 05:45:30 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E123AA9CA
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575930; cv=none; b=nG2fVFTj2T2Fl5hdznF+Mq7jaZL0Byi1PIHMRcYdd4jTdwuf6/ylw2ydclVUZuWYXgyM3Xli0n7VMz0CxNz2DGaJyJxwZklRfncWW7W8QMP+zBHhHb0coDnBTzXKljumSVFRTHa08Zgll0sfkh7EYyb0mJIzpyLi0zuP0ql14mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575930; c=relaxed/simple;
	bh=3EFBZBk5WoCzwyemq6c5RgtxwguDDhrMMWn7FICgoR8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Bjeh6y3ncFv+yvKfd3GiYGNQcPgEhzmwxj/vZqleWbl6YMV009B8DzVYdG80UW7IVkDFKKv6wl3hpe3H8L1TOkKCAg1C1mZYLX5UB3I4pILNKo/Kc2uXO87WQ5F2tQHyvQK1lo30k0SyWRNt3zi/UZq8xmLhF0Bw5kf1dS1qpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UtW7t2cQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC01F00A3F;
	Thu,  9 Jul 2026 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575929;
	bh=HUDERsjh8Sw/pApF13BmAqbyh0bnv+n98kt35pxkmxY=;
	h=Subject:To:From:Date;
	b=UtW7t2cQtd7z6uG+SjbcTgwkFBc/j+iFjzYfXNgV0Z1igrdSsTaGJGoSxt5maK4t0
	 U3sZriLVveNuZ2bKumqFcx01dDuBrNmMe06zmC5T/ocyuvwlqtqEUB80JHxf/DEAi7
	 sSvcfzlgWI6c814BEZ5MrjTtPbZ9umdH71jeVvXw=
Subject: patch "iio: light: al3320a: add missing REGMAP_I2C to Kconfig" added to char-misc-linus
To: joshua.crofts1@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,david@ixit.cz,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:50 +0200
Message-ID: <2026070950-kindred-commode-10eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272820-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,intel.com,ixit.cz,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:Stable@vger.kernel.org,m:andriy.shevchenko@intel.com,m:david@ixit.cz,m:jic23@kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,intel.com:email,gregkh:mid,ixit.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADE6072CE1F


This is a note to let you know that I've just added the patch titled

    iio: light: al3320a: add missing REGMAP_I2C to Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 9efcc9ba9b2e940cc01e63d132ae741e4c5d09c7 Mon Sep 17 00:00:00 2001
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:10 +0200
Subject: iio: light: al3320a: add missing REGMAP_I2C to Kconfig

The Kconfig entry for the al3320a is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4ba3151ebea7..f23bbce12c72 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -67,6 +67,7 @@ config AL3010
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3320A
-- 
2.55.0



