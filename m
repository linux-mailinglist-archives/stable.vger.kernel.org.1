Return-Path: <stable+bounces-263856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLxPOltoMWqQigUAu9opvQ
	(envelope-from <stable+bounces-263856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:14:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDB690D9F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=FwIqSU7r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263856-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263856-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBD233028DC9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DC43CEC7;
	Tue, 16 Jun 2026 15:13:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653642B738;
	Tue, 16 Jun 2026 15:13:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622833; cv=none; b=H7iZQalISMWMwHomYRTWK1rXe7YnCcH6SbtrTkOtN6xMAGswizA7uFtvnC6Jd1DRaj9HMEmJCZ/YyPd4V6GQ2rCjrktIiJbkjSHRZ47Ks/tKmhwr6sKRPDMCVo8gHPF8pzRa3YbMaj8d5L0YGtcX8nAw9nmymNXWP0I2ZIte9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622833; c=relaxed/simple;
	bh=n08eyZPpxhUL4+eA1l7MU/0EIjasq/QfMkAhEyWXbPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWxiPlfk2V76GyTvb6+A85UDjoMLUjxqC7tnO7KHdrEUxH/43gkhfOABKPYVBxC3ZDzMnsBTWvhJ+HRjh76qav0qQBD9g7ljUFWOsF5Yubv/bRMcxpbRMms1xMWMTxZTkQccb4ZzWZo9TVO0t1YTRT4n8eXUajiJPPk0UYI1tSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FwIqSU7r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7836F1F000E9;
	Tue, 16 Jun 2026 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622832;
	bh=nnDIF1D6OhYW+8ttsrSvfQVkwyhJpXbGuHtCsKygaZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FwIqSU7rRJHJBjpMOoi6YT03iiZA6lBWh5RiRgda1ErZuE7d0i8FM15OggvTDudg7
	 aClu8VfE/c3Q6Po/lfu8aXL6LTztAuPSlPkP9pKQAv2+7fjIegf9uN6jOxkhXRTIS0
	 C0Elk3V7ZU9bdD+aBcNXwE9FkDpSf2f8T/OvjxnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Polensky <japo@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 014/378] s390/bug: Always emit format word in __BUG_ENTRY
Date: Tue, 16 Jun 2026 20:24:05 +0530
Message-ID: <20260616145110.553232031@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263856-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:japo@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89DDB690D9F

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Polensky <japo@linux.ibm.com>

[ Upstream commit 3daad7f60aa92d0307fa2b2edd38c886a09902f2 ]

When CONFIG_DEBUG_BUGVERBOSE is disabled, the s390 __BUG_ENTRY() macro
omits the format string pointer, so the generated __bug_table entry no
longer matches struct bug_entry.

With HAVE_ARCH_BUG_FORMAT enabled, the generic BUG infrastructure reads
bug_entry::format via bug_get_format(). If the format word is missing,
subsequent fields are read from the wrong offset, which may:
- Misinterpret flags (BUG vs WARN classification errors)
- Fault when dereferencing a misread format pointer

The root cause is that __BUG_ENTRY() delegates format word emission to
__BUG_ENTRY_VERBOSE(), which is conditional on CONFIG_DEBUG_BUGVERBOSE.

Fix this by moving the format field emission directly into __BUG_ENTRY()
so it is always emitted unconditionally. Remove the format parameter from
__BUG_ENTRY_VERBOSE() and keep only file/line emission conditional on
CONFIG_DEBUG_BUGVERBOSE.

Fixes: 2b71b8ab9718 ("s390/bug: Use BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED")
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/bug.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 59017fd3d9358d..50a270edb02035 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -12,12 +12,11 @@
 #if defined(CONFIG_BUG) && defined(CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS)
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __BUG_ENTRY_VERBOSE(format, file, line)				\
-	"	.long	" format " - .	# bug_entry::format\n"		\
+#define __BUG_ENTRY_VERBOSE(file, line)					\
 	"	.long	" file " - .	# bug_entry::file\n"		\
 	"	.short	" line "	# bug_entry::line\n"
 #else
-#define __BUG_ENTRY_VERBOSE(format, file, line)
+#define __BUG_ENTRY_VERBOSE(file, line)
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
@@ -28,9 +27,10 @@
 
 #define __BUG_ENTRY(format, file, line, flags, size)			\
 		"	.section __bug_table,\"aw\"\n"			\
-		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
-		__BUG_ENTRY_VERBOSE(format, file, line)			\
-		"	.short	"flags"	# bug_entry::flags\n"		\
+		"1:	.long	0b - .		# bug_entry::bug_addr\n"\
+		"	.long	" format " - .	# bug_entry::format\n"	\
+		__BUG_ENTRY_VERBOSE(file, line)				\
+		"	.short	"flags"		# bug_entry::flags\n"	\
 		"	.org	1b+"size"\n"				\
 		"	.previous"
 
-- 
2.53.0




