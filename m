Return-Path: <stable+bounces-251414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I4xLyj7DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-251414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22541595CDA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D5B3345982
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08F3D8137;
	Wed, 20 May 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EppXOpjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1333BBAF;
	Wed, 20 May 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297918; cv=none; b=rLY/6f+/bMTWPzkKbGwgIUetGJ7w8e8eqFEMIg9fgxKIsuAoxWzjmEf4AvmxFy8F92QVPQvQFI0jMNv6Grbru56SJ2HvgVGCbl70HWmzinLdhnnWldmqEELk0WeAoVQlo7x+5MGj7P1lTX/VHhvvMbyaErQLyPLPOn5QjU+S/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297918; c=relaxed/simple;
	bh=K4pECAQNcgcEBlYYQIMmuM4etyvtMySDAfjs4ngjEOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTwCXGMuywj48rvkj8Y74+fRU88Sb6ZQ9igtIXaUOLR3u+EvDRau4WLaZ7l3L5F88ZwNWtXgY9370L9eDdY7tzl92lkox6hx1jkgQFcXSlfFQgM/m0L/kaWQHUeJvMWzdCIBI+mLgfDOuRYygvCtXVtT4mtydyszfTLekw134xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EppXOpjM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5001F000E9;
	Wed, 20 May 2026 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297917;
	bh=JHJstVRzKueY+PHV0v7PvA0V0Xgv/EC7QdVvDIRWjro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EppXOpjMkiKdWmXvQC9GIl7aCj25WRth216CPHv2qfBblbpraITq4YcRgQwXAiRVB
	 e+hQU0mg/D/MsfmhV3lFF5GWrt67/xDvZuJSyYE9UiFNYSLaRYRqtiKGEL/254s6P5
	 8ps1lJLtbCpqu3/Nu6rConJrV7Pk/EMEvKechl20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 211/957] iopoll: fix function parameter names in read_poll_timeout_atomic()
Date: Wed, 20 May 2026 18:11:34 +0200
Message-ID: <20260520162139.115173220@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251414-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 22541595CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 878004e2852bc22ce0687c5597d6fe3909fb59f3 ]

Correct the function parameter names to avoid kernel-doc warnings
and to emphasize this function is atomic (non-sleeping).

Warning: include/linux/iopoll.h:169 function parameter 'sleep_us' not
 described in 'read_poll_timeout_atomic'
Warning: ../include/linux/iopoll.h:169 function parameter
 'sleep_before_read' not described in 'read_poll_timeout_atomic'

Fixes: 9df8043a546d ("iopoll: Generalize read_poll_timeout() into poll_timeout_us()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patch.msgid.link/20260306221033.2357305-1-rdunlap@infradead.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/iopoll.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index bdd2e0652bc30..53edd69acb9bd 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -159,7 +159,7 @@
  *
  * This macro does not rely on timekeeping.  Hence it is safe to call even when
  * timekeeping is suspended, at the expense of an underestimation of wall clock
- * time, which is rather minimal with a non-zero delay_us.
+ * time, which is rather minimal with a non-zero @delay_us.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
@@ -167,9 +167,9 @@
  * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val.
  */
-#define read_poll_timeout_atomic(op, val, cond, sleep_us, timeout_us, \
-				 sleep_before_read, args...) \
-	poll_timeout_us_atomic((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
+#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
+				 delay_before_read, args...) \
+	poll_timeout_us_atomic((val) = op(args), cond, delay_us, timeout_us, delay_before_read)
 
 /**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
-- 
2.53.0




