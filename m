Return-Path: <stable+bounces-235261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cATyL6um1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 849743C2505
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9400303DB78
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1313D890F;
	Wed,  8 Apr 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lr7qzwBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E8352C3C;
	Wed,  8 Apr 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674984; cv=none; b=atcYs3Luopqh1I2tpbBFaZP/UNaNHj34+6U3tNAu9T8Azo6Vd7cMTT/GFQH8IX0AYzhwq6evFO9X4iyF6aTY3sY7xC9AQf2r+7jcykKl5gfxO9DK3CY+NDt+9MskL8zCIkoObxjgKPf/OjKvRZgQz15QZuFn1tgzQjiMo6AZCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674984; c=relaxed/simple;
	bh=5tXUZjNWEOwYzgopX2TMRqkyme34ffEzCCQBlIhn/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaNT16cajjDKXQzr9ecB3xZYLfKYGODrz4vPzNR7EvBGhz4bWnsrcsUjxe72awHDBD+Ab3VKAuQheJnDfvSdIwddV4Dg8cgCkPbwIzRg/4T2L7NXvJx1v0wxiURl+3kHrwAFwVio9UxV8zfcAsb91MPLiso1SoqaSTjyYGNNSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lr7qzwBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DAAC19421;
	Wed,  8 Apr 2026 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674984;
	bh=5tXUZjNWEOwYzgopX2TMRqkyme34ffEzCCQBlIhn/dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lr7qzwBdPmjYM6n5IlYM8/udFR4qx255aFQEV5eongd52KmGtC9ar9uNJ0+kAvLmD
	 iapW5rbSamN9EF6+eaCx/PCGploqKpSoBLlNI320otkwqWalrBHiICtpTWvrYB/Y+s
	 cBkisxeHFntcW8dGEa6L7L4lB0C7YDuv6XWgRowU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Mladek <pmladek@suse.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkman <daniel@iogearbox.net>,
	Daniel Gomez <da.gomez@samsung.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Marc Rutland <mark.rutland@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.19 308/311] kallsyms: clean up modname and modbuildid initialization in kallsyms_lookup_buildid()
Date: Wed,  8 Apr 2026 20:05:08 +0200
Message-ID: <20260408175950.866569266@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-235261-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,atomlin.com,kernel.org,iogearbox.net,samsung.com,gmail.com,arm.com,google.com,goodmis.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 849743C2505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Mladek <pmladek@suse.com>

commit fda024fb64769e9d6b3916d013c78d6b189129f8 upstream.

The @modname and @modbuildid optional return parameters are set only when
the symbol is in a module.

Always initialize them so that they do not need to be cleared when the
module is not in a module.  It simplifies the logic and makes the code
even slightly more safe.

Note that bpf_address_lookup() function will get updated in a separate
patch.

Link: https://lkml.kernel.org/r/20251128135920.217303-3-pmladek@suse.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Marc Rutland <mark.rutland@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kallsyms.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -362,6 +362,14 @@ static int kallsyms_lookup_buildid(unsig
 	 * or empty string.
 	 */
 	namebuf[0] = 0;
+	/*
+	 * Initialize the module-related return values. They are not set
+	 * when the symbol is in vmlinux or it is a bpf address.
+	 */
+	if (modname)
+		*modname = NULL;
+	if (modbuildid)
+		*modbuildid = NULL;
 
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
@@ -370,10 +378,6 @@ static int kallsyms_lookup_buildid(unsig
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       namebuf, KSYM_NAME_LEN);
-		if (modname)
-			*modname = NULL;
-		if (modbuildid)
-			*modbuildid = NULL;
 
 		return strlen(namebuf);
 	}



