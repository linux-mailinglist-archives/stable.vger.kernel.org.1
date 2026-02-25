Return-Path: <stable+bounces-218610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAcnBvxTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B118FB2D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA50230A92DD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455F26561A;
	Wed, 25 Feb 2026 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZCRfyin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C6243376;
	Wed, 25 Feb 2026 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983456; cv=none; b=p81tKdHXR6NSuLvRFZlQKN3rTi1ShEtnQ5mYCP0Ssupg7tt3FaQZMh8sG+BI/OhKTtjvhrhdAGSPyNK4xyclM99S22yx/+NbBd98ThZi2GmGa0HdF6XRutU2fQlHTdHofbwGwcU/a2d/6UtKVPHPyoVJEqpRPHHor7EqRgSxLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983456; c=relaxed/simple;
	bh=uG04RXhtvDqeMJOttUatcDPude4UadiuIj/QxIyANsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKgutk1lol8Mtz4gZR/jKK4qr2povPwGX2f7CkAKpnLkskyaave62f6a+DHeuJ4PN6YQXxxblYRiM5ublMD5IbxO54A8t2Wjmh7jA3hGzNt0wyKKk15W2cX2sfUkPtLmm0BseeBceXDq1TLmNCigSbWdTtvjlZEJXxst1t/3PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZCRfyin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E471CC116D0;
	Wed, 25 Feb 2026 01:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983456;
	bh=uG04RXhtvDqeMJOttUatcDPude4UadiuIj/QxIyANsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZCRfyin2nsVKrwf9Hjrf025P+dpQke0exPj71SN7m3mYq82odjOMXhsINWlZ9KMu
	 ak5gZbymj5UMnWibSzoRkztVShmMrEdP1e+GRm29lEi9BDWp4U0K4TuimvY9axDvHD
	 cj2lrv3JUC6hLnEDtfFSXqm+aME2cQW3MEYLIcwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 570/781] serial: imx: change SERIAL_IMX_CONSOLE to bool
Date: Tue, 24 Feb 2026 17:21:19 -0800
Message-ID: <20260225012413.784053931@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218610-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B6B118FB2D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 79527d86ba91c2d9354832d19fd12b3baa66bd10 ]

SERIAL_IMX_CONSOLE is a build option for the imx driver (SERIAL_IMX).
It does not build a separate console driver file, so it can't be built
as a module since it isn't built at all.

Change the Kconfig symbol from tristate to bool and update the help
text accordingly.

Fixes: 0db4f9b91c86 ("tty: serial: imx: enable imx serial console port as module")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260110232643.3533351-2-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 59221cce0028f..98a946096be3c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -486,14 +486,14 @@ config SERIAL_IMX
 	  can enable its onboard serial port by enabling this option.
 
 config SERIAL_IMX_CONSOLE
-	tristate "Console on IMX serial port"
+	bool "Console on IMX serial port"
 	depends on SERIAL_IMX
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the serial port on the Freescale IMX
-	  CPU you can make it the console by answering Y/M to this option.
+	  CPU you can make it the console by answering Y to this option.
 
-	  Even if you say Y/M here, the currently visible virtual console
+	  Even if you say Y here, the currently visible virtual console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
-- 
2.51.0




