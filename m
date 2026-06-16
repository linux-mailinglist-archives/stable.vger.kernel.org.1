Return-Path: <stable+bounces-264960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kn3nFWmCMWrVlAUAu9opvQ
	(envelope-from <stable+bounces-264960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:05:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25F692B72
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:05:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UEQphk1q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264960-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264960-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47DC3085668
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0C44CAF5;
	Tue, 16 Jun 2026 16:53:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8761C5D72;
	Tue, 16 Jun 2026 16:53:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628795; cv=none; b=OSv0HnMWMj/KT7o1bZHDOl2GCmly7kcfkbCz0XwzjS9cVylpkV+5FRXl5vm8y7BMaR5hHFerchisWaVCRSXfrQG5wIfwvmTpZR4nCGsSpmWzP23u30jeAI2IK1tHoCqATZhSb1NTFgJnr44slh/9UIibPntaOdioLY6FkRQZp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628795; c=relaxed/simple;
	bh=JcmCr5n3uwa6gsvCtRghIH9yUyah9kIBDDi0a75MFVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cScHyHrZvF+GiCgNFRSy9Z0S8DNdgNg43FVHxBoyZGg6glAHAW2jt+ZO74bPLEuTTm+4QgiDJG+1unnzXEdQCzLs21t1NeDSZd9BIG+GEnkB18ulTV9Abaj5r1daa3rmlBzBa9mR0VdPWjiXQJoTCa5IZ9adNhvhTbZp6el6NBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UEQphk1q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBA21F000E9;
	Tue, 16 Jun 2026 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628794;
	bh=BmAY5suhUveNznkh6HnxY4Zbks9+4qdTFZ5fbK5uKOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEQphk1qeCXpbFAqoqKMtgYiGyfZhxaTZZZ/IHUWkWNJBLfRH/FFjam1G8Td8B7cR
	 Cdrehsy5LCSYZ5AgV8AciQ3e5s2jN2w61XWlawyvq5d9KsEMEhO9MXC2A9HlegZsa4
	 u2QK6cn7Mo/K+mFVe8qzcEljo50q6ToQBvaUzPMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nicol=C3=A1s=20Bazaes?= <contacto@bazaes.cl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 146/452] Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490
Date: Tue, 16 Jun 2026 20:26:13 +0530
Message-ID: <20260616145125.375543734@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264960-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:contacto@bazaes.cl,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bazaes.cl,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE25F692B72

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolás Bazaes <contacto@bazaes.cl>

commit 16ca52bc209fa4bf9239cd9e5643e95533476b58 upstream.

The Lenovo ThinkPad E490 (PNP ID: LEN2058) has a Synaptics TM3471-020
touchpad that supports SMBus/RMI4 mode but is not listed in
smbus_pnp_ids[]. Without this entry, RMI4 over SMBus is not enabled
by default, and the touchpad falls back to PS/2 mode.

Adding LEN2058 to the passlist enables automatic RMI4 detection without
requiring the psmouse.synaptics_intertouch parameter, and matches
the behavior of similar ThinkPad models already in the list
(E480/LEN2054, E580/LEN2055).

Tested on ThinkPad E490 with kernel 7.0.5-zen1 and Arch Linux.
RMI4 over SMBus is confirmed working without any kernel parameters.

Signed-off-by: Nicolás Bazaes <contacto@bazaes.cl>
Assisted-by: Claude:claude-sonnet-4-6
Link: https://patch.msgid.link/20260514013552.14234-1-contacto@bazaes.cl
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -189,6 +189,7 @@ static const char * const smbus_pnp_ids[
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"LEN2058", /* E490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */



