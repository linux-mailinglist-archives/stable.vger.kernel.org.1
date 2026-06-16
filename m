Return-Path: <stable+bounces-265355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LAZ0BUCHMWrulgUAu9opvQ
	(envelope-from <stable+bounces-265355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6C6931FC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="sg/D1cag";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265355-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265355-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 269883032E48
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B302466B5E;
	Tue, 16 Jun 2026 17:26:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648D449EA8;
	Tue, 16 Jun 2026 17:26:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630782; cv=none; b=Sk5VrQCNkJS/xfx9l6MIEZtCVRJkEmaf4jOtjYDkeP0YboMnMX0jXHaCBxrfR0OHh3kmoBGIqQfWq96uw0jW7LA+ZKLTmRyyI7UC8zU+w4ADZlywpgCTxeS7FKZq/+m12/RbDtmHIRNfYXL+v625RvNsSGbUqYYehcdOzKidcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630782; c=relaxed/simple;
	bh=/SYzOVX1ZpL1uahSHBiZXX1bJD9+fVbXfqccCW4KpBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkZlhg4zSNm2H99AY71wAXYhWSKRv/ee7dQX7S3oxcrkGoXiNIyfj2p8H0m1ntqYep2ksYqirolNMBdhBl3QZzjLwrr9Fl/56hl3H6Jjf7LdpYFu19D0AcWY/TzO9Ib1fWGovtoOHyOKbDggRsWnQDZ4SQlFN2kD4yiXS7O8BTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sg/D1cag; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D8C1F000E9;
	Tue, 16 Jun 2026 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630781;
	bh=w2T0GHtgpOkaFo8hN4Y5bMIs8sP9QMk2jhxc/DKq1vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sg/D1cagkR1I02ostwjBGYZYWcTbk209CbguS7A1hhm1YO3dg6rdg+Kr8KpFcpJ72
	 RXNGgwE5J1qH4zWegsm4yvmHlkPVuUU2o6RpWVNtbDvlAwcSW7ac3wMysLyMKy5+hm
	 EOVzSWSCuHbr4vGve6trlP45SvlMEkwQYiQksWcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.1 094/522] auxdisplay: line-display: fix OOB read on zero-length message_store()
Date: Tue, 16 Jun 2026 20:24:01 +0530
Message-ID: <20260616145130.294673748@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265355-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sozdayvek@gmail.com,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C6C6931FC

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stepan Ionichev <sozdayvek@gmail.com>

commit a7511dcd9dd4bc55d123f9b800c8a4ed2662e5c6 upstream.

linedisp_display() unconditionally reads msg[count - 1] before
checking whether count is zero, so a write of zero bytes to the
message sysfs attribute hits msg[-1]:

	write(fd, "", 0);

	-> message_store(..., buf, count=0)
	   -> linedisp_display(linedisp, buf, count=0)
	      -> msg[count - 1] == '\n'  ; OOB read

The kernfs write buffer for that store is a 1-byte allocation
(kernfs_fop_write_iter() does kmalloc(len + 1) with len == 0),
so msg[-1] is a 1-byte read before the slab object. On a
KASAN-enabled kernel this trips an out-of-bounds report and
panics; on stock kernels it silently reads adjacent slab data
and, if that byte happens to be '\n', the following count--
wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().

linedisp_display() is reached from the message_store() sysfs
callback (drivers/auxdisplay/line-display.c message attribute,
mode 0644) and from the in-tree initial-message setup with
count == -1, so the OOB path is only userspace-triggerable via
zero-byte writes; vfs_write() does not short-circuit on
count == 0 and kernfs_fop_write_iter() dispatches the store
callback regardless.

Guard the trailing-newline trim with a count check. The
existing if (!count) block then takes the clear-display path
unchanged.

Affects every auxdisplay driver that registers via
linedisp_register() / linedisp_attach(): ht16k33, max6959,
img-ascii-lcd, seg-led-gpio.

Fixes: 7e76aece6f03 ("auxdisplay: Extract character line display core support")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/auxdisplay/line-display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -80,7 +80,7 @@ static int linedisp_display(struct lined
 		count = strlen(msg);
 
 	/* if the string ends with a newline, trim it */
-	if (msg[count - 1] == '\n')
+	if (count && msg[count - 1] == '\n')
 		count--;
 
 	if (!count) {



