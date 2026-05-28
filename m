Return-Path: <stable+bounces-256397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCYVKXWuGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A663E5FA3BC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2598E30AD06C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7741352012;
	Thu, 28 May 2026 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGx4FwSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5034F483;
	Thu, 28 May 2026 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001583; cv=none; b=eI3qIrQ2NoylubJtSXhs/UvFf3xn8DjAg5p5LA5qAjGdUJDwHn3IDfHlQ28Hg7uq1E9Ht5FBfiv0a8zlrnvYmZlKAOzIRrzeNTbBZnkHAsqs1yDqXPu+Dh1kunSQ7hXzn3TjWIqamnE44h3I31gWyW91SrWmAiJgHn0rEGNgVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001583; c=relaxed/simple;
	bh=PHPOJOq08XWNjM8QzN5pZd3KGPxNMv5ZFNl/ExylTgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAKEUNApu0+DCF0GF64yCBKhXEPPUEh5DVpjM+du00fVJk8g/a3Rly8coMN9NMiW2wK9HUww/iH1ZNoyaCOu9yRgbUtZYtOQOVsK+/tw245Nx/MAcqOhSwhCRIq8J/KS1idel3DltuUROgOgTuoZ7CIfW8Lw9NSirmYwePmyfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGx4FwSh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDF1F000E9;
	Thu, 28 May 2026 20:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001582;
	bh=60Ie6kAZsZ9daF94hguqaF5Vzv397WX6pTwtRvsGw7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGx4FwSh7fI5LdmliqoLyZpvNU0VrPextKznjNkbOln2blZ37nIG/5YN4gDi8zZpo
	 MqQuQjgBECKBDYYt8Rpvzr2aXhodIOJBzp1YYyu0qBnrJ4UDe6btV2+OmCM8qfKboF
	 xYrl1LrErGutAmsQWLAY2vmgl0qrZ3EyJUqhuWfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/186] string: add mem_is_zero() helper to check if memory area is all zeros
Date: Thu, 28 May 2026 21:50:58 +0200
Message-ID: <20260528194933.793615204@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256397-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A663E5FA3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 3942bb49728ad9e1f94d953a88af169a8f5d8099 ]

Almost two thirds of the memchr_inv() usages check if the memory area is
all zeros, with no interest in where in the buffer the first non-zero
byte is located. Checking for !memchr_inv(s, 0, n) is also not very
intuitive or discoverable. Add an explicit mem_is_zero() helper for this
use case.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240814100035.3100852-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: 3e6ccd790ed6 ("gpio: cdev: check if uAPI v2 config attributes are correctly zeroed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/string.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index ce137830a0b99..bbcaceb8fb6f5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -212,6 +212,18 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
+/**
+ * mem_is_zero - Check if an area of memory is all 0's.
+ * @s: The memory area
+ * @n: The size of the area
+ *
+ * Return: True if the area of memory is all 0's.
+ */
+static inline bool mem_is_zero(const void *s, size_t n)
+{
+	return !memchr_inv(s, 0, n);
+}
+
 extern void kfree_const(const void *x);
 
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
-- 
2.53.0




