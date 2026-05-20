Return-Path: <stable+bounces-251270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFVlKroWDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65759962F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2ADE33EF352
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05636F421;
	Wed, 20 May 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qz4hWOR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30A364E89;
	Wed, 20 May 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297546; cv=none; b=NRQASw53L9ruDPXlyp67tsxO4VTY46y/OTSF+lmvCy88joq9iwxDNMLAshBMXSviDRn0KDmKelyUi5SLw48BKliuznal8WIrcsBOQ7/CexP5HRmKgK5gD26Sm3uF8tm5GzQ6ltEDgJGf1FHzRv46RSYKDbcPCj9OG5vs0YndEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297546; c=relaxed/simple;
	bh=mOagDc4kL3j9XOeAwc1StrMwJRkWxuuhABMh88ieWI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9wzi4lR0B3+8ATopnuV+Pc+WeetZ+MYQ/qRZB+egUUiGn0emfobyG9Us4j+7hLA73jEcNxBrHDR8zo/roxkw5+A9WJuG1I8P5eUMI8QqJZmDbjye6KW5P/4x/fabsqa2CevQs+wDixUCUC87076tPPNdrJUFNkr0cXFpjlZBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qz4hWOR7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA81F000E9;
	Wed, 20 May 2026 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297545;
	bh=9zjTuw2E+PkVrtdx1bASqhcWewPPkeAfED3ShrX1HR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qz4hWOR7zTuctRUl9urMSgLfbFpMdyznJLzJgpqK0oAsxo+krCi7deNJMJjuyNUeV
	 xeXSwaTlL+QBsZpuWM3sMrnKsSU2J4Xx56CVeIO3CyoOxj39on75xOsk1yX1hGKtIG
	 Aa7/2i1gPgdyOBN+f4twMZ9FaFHBdP+rcfxskyd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 071/957] tools/nolibc: implement %m if errno is not defined
Date: Wed, 20 May 2026 18:09:14 +0200
Message-ID: <20260520162136.104601602@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251270-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,weissschuh.net:email]
X-Rspamd-Queue-Id: 8B65759962F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit fbd1b7f6b322a63b21ebbf00c732a17bb8bdb5d4 ]

For improved compatibility, print %m as "unknown error" when nolibc is
compiled using NOLIBC_IGNORE_ERRNO.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Stable-dep-of: 4045e7b19bbf ("tools/nolibc/printf: Move snprintf length check to callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stdio.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 724d05ce69624..1f16dab2ac884 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -321,11 +321,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				if (!outstr)
 					outstr="(null)";
 			}
-#ifndef NOLIBC_IGNORE_ERRNO
 			else if (c == 'm') {
+#ifdef NOLIBC_IGNORE_ERRNO
+				outstr = "unknown error";
+#else
 				outstr = strerror(errno);
-			}
 #endif /* NOLIBC_IGNORE_ERRNO */
+			}
 			else if (c == '%') {
 				/* queue it verbatim */
 				continue;
-- 
2.53.0




