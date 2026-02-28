Return-Path: <stable+bounces-220168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGfTCzYyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D21C5B4B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62DF6311DFCB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E24A13A9;
	Sat, 28 Feb 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHnTbfuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A584A13A1;
	Sat, 28 Feb 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300075; cv=none; b=FolTesQ91FLm/NeWBUAAPe6XvkdA2on6aXvx/zmjb5oPfXJIm4kUJGG92arionJVj/A/yETxZXXfnXnnKBiPuI2zq+ycWrLwC8jjWeB8RlA6PkuAJgLgBV2yIqpYUDhwkoUQF6SYS0n4driYiKM7XtSd4IEy6ERSQKy4Fx6/OOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300075; c=relaxed/simple;
	bh=y120UP/A72i4KPCXXzfD+Gijbl0GECCbaubnP5MiEKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG0UaecktPOlutr3ypE8tTUxyOKAgLg8ZIZe1y6JGIw2fYuaW4ucvxweXl8VX83uCTz5PhXP55v5PkdBZYYYCmZ57ORv+CGYiFERaCJOQVP/tjNL6o/XQIHtavZknGgaLdMDdL+di2Wa+do5+ofu6IKM19pDyzuK86COTM7l1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHnTbfuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19863C116D0;
	Sat, 28 Feb 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300075;
	bh=y120UP/A72i4KPCXXzfD+Gijbl0GECCbaubnP5MiEKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHnTbfuPu+HJoWF+fNx6Y0gOpAG7he3n8F3CYLeOIpRegQaEmZw8DQF4zRfCG+Lfa
	 i0EgO5kG8V6ltlgG+3Gb7eflTTzrckLoCoCO7jvu8gAy/qf/PQg7vAFFFppeLtza/y
	 c4dsFhh6w0jq8oihUXiSxVXKJ7W50wE7DWbfvSP5iNE2WIByWESp5nXVoyKSMAD9l2
	 dZU2Tj4sN9+ew4AvyiNP5B3dPH1+/K6Fnr/jWbcnA8kilXdyQgt7ZIuumtpxWTi+hz
	 zfyvr6f5RjQ9EUpp8BB/uUTeIOQsWnlhGnCWt4dY0EN+eLmnJLtTisJ8hmCWi/Feld
	 DSqTkVqTlSjOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 090/844] sparc: don't reference obsolete termio struct for TC* constants
Date: Sat, 28 Feb 2026 12:20:03 -0500
Message-ID: <20260228173244.1509663-91-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220168-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gaisler.com:email]
X-Rspamd-Queue-Id: 507D21C5B4B
X-Rspamd-Action: no action

From: Sam James <sam@gentoo.org>

[ Upstream commit be0bccffcde3308150d2a90e55fc10e249098909 ]

Similar in nature to commit ab107276607a ("powerpc: Fix struct termio related ioctl macros").

glibc-2.42 drops the legacy termio struct, but the ioctls.h header still
defines some TC* constants in terms of termio (via sizeof). Hardcode the
values instead.

This fixes building Python for example, which falls over like:
  ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'

Link: https://bugs.gentoo.org/961769
Link: https://bugs.gentoo.org/962600
Signed-off-by: Sam James <sam@gentoo.org>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e7..a8bbdf9877a41 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -5,10 +5,10 @@
 #include <asm/ioctl.h>
 
 /* Big T */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x40125401 /* _IOR('T', 1, struct termio) */
+#define TCSETA          0x80125402 /* _IOW('T', 2, struct termio) */
+#define TCSETAW         0x80125403 /* _IOW('T', 3, struct termio) */
+#define TCSETAF         0x80125404 /* _IOW('T', 4, struct termio) */
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.51.0


