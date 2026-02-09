Return-Path: <stable+bounces-215300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELmgBJH0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90E1111C6
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 518D8300C55B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561627CCF2;
	Mon,  9 Feb 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEUIh/wa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A828725B;
	Mon,  9 Feb 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648344; cv=none; b=klA29vXqjE/iCJlbGNIFpdPLQRG7CdPWuVrzcsVdDaVKe1b7wQ95+sZi+3xJgz48YyBWkGCzs1KMlLBN23fuL57pQZid0O+UcAWvUlcmLYjoyV6e60YA6uYPwRyg2b4raQrazk/X1ZiAIHONqXKSYywCt0Ion0+i2McbB+40OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648344; c=relaxed/simple;
	bh=AYmIGBxcjURL7yLi7WssTdxecJwv2rZXj5Dzp9mUb4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIMqKSDM5R2RCuZ7drbrCD92ehDRuFPhJJKZxiA7Xcap5NcP4Gh9CcD6onBwi0jB+orm5tB2gnZHFKBNx6L8q6fg5FxB4MpssyzQFPm3RyaatNMNvQF2oUnuSaoIk2fqFBpUe3yXAwLV5pev2mugJb4vhXxElXZL5X+V/3T4Cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEUIh/wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E448C116C6;
	Mon,  9 Feb 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648343;
	bh=AYmIGBxcjURL7yLi7WssTdxecJwv2rZXj5Dzp9mUb4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEUIh/wazK6+URzHAcYvkYCtbmW+SOj1CH5wNOEn94PQBx6Su2fdMxSdJSo3pI+2w
	 bB3wtnBgNhW47B+AHOnlEokZKJHgVpi3cX0aJ+aA5dEj0FarxN9zwFrt9XOshyO65x
	 GHKgLxRUzrMzSxRgtGmPopUwYlFn/5gfIMhG6BDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 6.6 10/86] ARM: 9468/1: fix memset64() on big-endian
Date: Mon,  9 Feb 2026 15:23:33 +0100
Message-ID: <20260209142305.148903635@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215300-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,infradead.org:email,armlinux.org.uk:email,linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C90E1111C6
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>

commit 23ea2a4c72323feb6e3e025e8a6f18336513d5ad upstream.

On big-endian systems the 32-bit low and high halves need to be swapped
for the underlying assembly implementation to work correctly.

Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/string.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -42,7 +42,10 @@ static inline void *memset32(uint32_t *p
 extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
 static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
-	return __memset64(p, v, n * 8, v >> 32);
+	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+		return __memset64(p, v, n * 8, v >> 32);
+	else
+		return __memset64(p, v >> 32, n * 8, v);
 }
 
 /*



