Return-Path: <stable+bounces-266125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oc2JGfyWMWp7ngUAu9opvQ
	(envelope-from <stable+bounces-266125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:33:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24B6943D6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:33:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pxqjiGIR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266125-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 462EF309CBFC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C450477E33;
	Tue, 16 Jun 2026 18:33:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2E47CC71;
	Tue, 16 Jun 2026 18:33:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634794; cv=none; b=AmNCpzKPFiF06l5wKWSioOUaKvDiq2a27yJk3NkRkKXlTNWJSGAUsLEm2PyVCyvyYJLj/nzuUlNpW0x9P/0ioIFuQp92DmPLzmz+peRpT61ivKb8xMGCZ56JcSRI2aXPPbggmiNyZKvGwsdWXsxBTubaeLLyNKz0M4lLrgviLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634794; c=relaxed/simple;
	bh=ODdNzHFr0rAtSt32WFn7qmwd27ScU6RYILIre1eDmtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cds6CjMpMBgxnfL+EJcft+LxQULDs6qpbGmcoKnCXKH7PETyguDgmOL4LyCqnsA2Fs9rhHPkQYGVI3tccZODfvtpwr2WE8wQh1bAYWBmQ+oYa/BzXm70wZ01wJ0hZHGIQpSPKObbZu5Xn4MMnNxxAyaYL8DANDI5xl9a93Mitak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxqjiGIR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78BB1F000E9;
	Tue, 16 Jun 2026 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634792;
	bh=cL3IXt/CBAGrwj6A7uTK94U40+4XxDIAg9aGeP6PcY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pxqjiGIRGXpbMI3P5sW+yQtZVpsVZYhTOHGB1HTAavDOToJw3aAHo/DpWYoqJEvLY
	 R1vhntDxuofcTPUf3bqWd0+414W+4Qk3mGbeU+WCD/T9dEfEDg/VbkTAB5Zd/pzkPH
	 sIzvwL1x8KMfLyNAvP7jiYpB75bFmi5qu0UO4cJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 300/411] printk: add print_hex_dump_devel()
Date: Tue, 16 Jun 2026 20:28:58 +0530
Message-ID: <20260616145117.092738029@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266125-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:herbert@gondor.apana.org.au,m:thorsten.blum@linux.dev,m:john.ogness@linutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,linutronix.de:email,apana.org.au:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA24B6943D6

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit d134feeb5df33fbf77f482f52a366a44642dba09 ]

Add print_hex_dump_devel() as the hex dump equivalent of pr_devel(),
which emits output only when DEBUG is enabled, but keeps call sites
compiled otherwise.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 177730a273b1 ("crypto: caam - guard HMAC key hex dumps in hash_digest_key")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/printk.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -740,6 +740,19 @@ static inline void print_hex_dump_debug(
 }
 #endif
 
+#if defined(DEBUG)
+#define print_hex_dump_devel(prefix_str, prefix_type, rowsize,		\
+			     groupsize, buf, len, ascii)		\
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
+		       groupsize, buf, len, ascii)
+#else
+static inline void print_hex_dump_devel(const char *prefix_str, int prefix_type,
+					int rowsize, int groupsize,
+					const void *buf, size_t len, bool ascii)
+{
+}
+#endif
+
 /**
  * print_hex_dump_bytes - shorthand form of print_hex_dump_debug() with default
  *                        params



