Return-Path: <stable+bounces-261785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QuRXEZRQJWqBGwIAu9opvQ
	(envelope-from <stable+bounces-261785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:05:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3F6504C7
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:05:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YtUATppg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261785-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261785-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94719308E264
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F83264F2;
	Sun,  7 Jun 2026 10:57:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C312CDA5;
	Sun,  7 Jun 2026 10:57:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829833; cv=none; b=VAjF7Yrguoa0ILCWYo5m/KUWABwvLCPkK6F8LqtfxA/kdax9sGZPGXLkFc8ngpdN/sG4BfTctmAUUG+7UGxBc99YoMJyRKA5rTjXWtSScPyoeJ/PMVFGU+MiCSTH5kmK5k2dl8V0lOYAJNRZHt4BlR4A9EZif3fWzOuG0z3E+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829833; c=relaxed/simple;
	bh=ReyHCevcVavu3jGW/EAcde77P6FARZmA7xADER4MtKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/Hia4XqN3EcMvm8TCklgwzhIanjxFT61hqTkgcEIOF19UwtMPr2SoT8b9gPqf4EvGzkrD9iEjL3TEi0AuTAlY52gLefUvKhIHP8GLjQWMJnuP9oEk7b06/GqOvmD9X389PpfsqQ78H9U4OVaAvHHSG7pFF/5o6xL/+KzTUr4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtUATppg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5361F00893;
	Sun,  7 Jun 2026 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829832;
	bh=6Vah41ns4ZiHwnXYHojg36ukwxBSQUn1ogDHow6WCzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtUATppg/cJ0lAsxrIvjodySkeMJBoCo1L/11NkvmIyvkeZznB2SoZ/ex/k2gAXhG
	 dvGHeA3buFXnZ42uK80TJhyRzi3AZCZSboaHx+TFkbrt5Vk1zQviUhYTEStqUzUAjN
	 L8G/9i4Z5tf7CE42f4gop0WnZzPhLo8QHBytSgks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.18 264/315] serial: sh-sci: fix memory region release in error path
Date: Sun,  7 Jun 2026 12:00:51 +0200
Message-ID: <20260607095737.266117240@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,intel.com,gmail.com,kylinos.cn,glider.be];
	TAGGED_FROM(0.00)[bounces-261785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:lkp@intel.com,m:error27@gmail.com,m:zenghongling@kylinos.cn,m:geert+renesas@glider.be,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,glider.be:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB3F6504C7

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongling Zeng <zenghongling@kylinos.cn>

commit 92b1ea22454b08a39baef3a7290fb3ec50366616 upstream.

The sci_request_port() function uses request_mem_region() to reserve
I/O memory, but in the error path when sci_remap_port() fails, it
incorrectly calls release_resource() instead of release_mem_region().

This mismatch can cause resource accounting issues. Fix it by using
the correct release function, consistent with sci_release_port().

Fixes: e2651647080930a1 ("serial: sh-sci: Handle port memory region reservations.")
Cc: stable <stable@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202604032356.SzEjYkBC-lkp@intel.com/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260421065737.724187-1-zenghongling@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2845,7 +2845,7 @@ int sci_request_port(struct uart_port *p
 
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0)) {
-		release_resource(res);
+		release_mem_region(port->mapbase, sport->reg_size);
 		return ret;
 	}
 



