Return-Path: <stable+bounces-257980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDk1Er0iG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:47:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A261064D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF4303068204
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CC6342CA7;
	Sat, 30 May 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2sY77Mr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3C2E7379;
	Sat, 30 May 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162823; cv=none; b=ml0YaURQ47UtJ5My12+2XYhs+53FlWeWc4ljWcaplfHZ7GSwA+z6OFRWcU4YDF6h1PQ4/VQHDBihCsIZnmLfVMVFD5O1TWVubvsp5eSwk09HEQsm9mmPcDl+DBcGZj+DGZeze9GRRKPI2Vl916OdQaqcDY5A2j6tS/lyv+ZSt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162823; c=relaxed/simple;
	bh=O0u/K6W3SckqUkVtrLmF69cm1pnIsoKRuYCuYcQSZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sePAOqI6lqcUlSvDe4OwHfubnhiPPmFi4Q2RrLewE2ll/fqeySR7I7srWfshFSYxdKPhE0frUmOq89Uk9y4tTI6NaYuPRLGrafBIY+KsQ6vHgceKgMrKWu2qP5eXXOQ2yXp8a4M7V5FbnVm8FJ7YcH7TXPfC+jg+QIjg6OjgJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2sY77Mr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2221F00893;
	Sat, 30 May 2026 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162821;
	bh=8B2bKfnp3yxaoYEtGtfGHuEEPHPr4pxCuVhD4BAj52Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s2sY77MrZaRG9GwcRse5XLivB08r2mg6ScrdQf895qlNwozHuQrja03/a9AQH5k0E
	 fRKybOxhlSJp3Nj7h/DzSDWZIpx4tHMdiO1q7Pil0qKGNVNNMjRpWm67xJBIqHLT7j
	 jL7Yio7N9NpqZjQKzUoVgaJKRLMsqJo1PUyL+AKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Daniel=20Br=C3=A1t?= <danek.brat@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 066/776] usb: storage: Expand range of matched versions for VL817 quirks entry
Date: Sat, 30 May 2026 17:56:20 +0200
Message-ID: <20260530160242.024417151@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vacharakis.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,weissschuh.net:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D42A261064D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Brát <danek.brat@gmail.com>

commit 609865ab3d5d803556f628e221ecd3d06aed9f30 upstream.

Expands range of matched bcdDevice values for the VL817 quirk entry.
This is based on experience with Axagon EE35-GTR rev1 3.5" HDD
enclosure, which reports its bcdDevice as 0x0843, but presumably other
vendors using this IC in their products may set it to any other value.

Signed-off-by: Daniel Brát <danek.brat@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260402172433.5227-1-danek.brat@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2339,10 +2339,11 @@ UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x
 		US_FL_SCM_MULT_TARG ),
 
 /*
- * Reported by DocMAX <mail@vacharakis.de>
- * and Thomas Weißschuh <linux@weissschuh.net>
+ * Reported by DocMAX <mail@vacharakis.de>,
+ * Thomas Weißschuh <linux@weissschuh.net>
+ * and Daniel Brát <danek.brat@gmail.com>
  */
-UNUSUAL_DEV( 0x2109, 0x0715, 0x9999, 0x9999,
+UNUSUAL_DEV( 0x2109, 0x0715, 0x0000, 0x9999,
 		"VIA Labs, Inc.",
 		"VL817 SATA Bridge",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,



