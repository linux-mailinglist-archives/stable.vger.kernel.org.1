Return-Path: <stable+bounces-214241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH7ZBkJvg2lqmwMAu9opvQ
	(envelope-from <stable+bounces-214241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D521E9F0E
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47020308D0F4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827282BE621;
	Wed,  4 Feb 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zl0JLDv5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749F273D77;
	Wed,  4 Feb 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219034; cv=none; b=VrsDTvECjiKvGP2Us8vuBL0Jqqjg+Yy/+2/Uji3JSRc7FT4zvwNZ29o6dyjL38jzDxDVgDZe5FWaTc9JqR4gOdNx1wRsebQQ6hXVykaS2mnNti4KEiJN8DtloRTEdIj1K4zHbU9yFIe86N7sC7NPuGefpMfN/7cxvG67NqSMRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219034; c=relaxed/simple;
	bh=61J0WJ5JaDV0poKgm4GTRENn3u8RR7D+2g8vVMaQmaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIa6HYxOLhwB0Gi1Mc9o7YiX2weV3DdI4qH5tq68NaWrcRW+NiALGUzAJ+mxudIW/Igi/m4ymxhW3PTXdXsKBQV+DebCgftiBIypUW0XG+m462lEbpM/E8UI/K7vt1ICLc+5XX2YwRjXwVd0wfOje+UD8lnZQQ+TipZCk/jfPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zl0JLDv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A6C4CEF7;
	Wed,  4 Feb 2026 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219033;
	bh=61J0WJ5JaDV0poKgm4GTRENn3u8RR7D+2g8vVMaQmaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zl0JLDv5BYwkO5NfpNoSF4G522G7Rd6rMVHAlaZpHQQ9KgJI2Gjhh2YQm+LmdjCV8
	 JHKF+ChvYhrin2yRBtEOzkEif02oQ9zz0hQ0h42oKdjlvfTyYujBRmwKVrg1eRS5R3
	 QxiL0J5h69uZFnnGwhBL5MBqBoPcxopcP4i8CgIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Zuo <yuxuan.zuo@outlook.com>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/122] kbuild: Fix permissions of modules.builtin.modinfo
Date: Wed,  4 Feb 2026 15:40:29 +0100
Message-ID: <20260204143853.551510845@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214241-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,outlook.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D521E9F0E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Zuo <yuxuan.zuo@outlook.com>

[ Upstream commit 6d60354ea2f90352b22039ed8371c4f4321df90e ]

Currently, modules.builtin.modinfo is created with executable permissions
(0755). This is because after commit 39cfd5b12160 ("kbuild: extract
modules.builtin.modinfo from vmlinux.unstripped"), modules.builtin.modinfo
is extracted from vmlinux.unstripped using objcopy. When extracting
sections, objcopy inherits attributes from the source ELF file.

Since modules.builtin.modinfo is a data file and not an executable,
it should have regular file permissions (0644). The executable bit
can trigger warnings in Debian's Lintian tool.

Explicitly remove the executable bit after generation.

Fixes: 39cfd5b12160 ("kbuild: extract modules.builtin.modinfo from vmlinux.unstripped")
Signed-off-by: Ethan Zuo <yuxuan.zuo@outlook.com>
Link: https://patch.msgid.link/SY0P300MB0609F6916B24ADF65502940B9C91A@SY0P300MB0609.AUSP300.PROD.OUTLOOK.COM
Signed-off-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.vmlinux | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index cd788cac9d91d..276c3134a563a 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -113,7 +113,8 @@ vmlinux: vmlinux.unstripped FORCE
 # what kmod expects to parse.
 quiet_cmd_modules_builtin_modinfo = GEN     $@
       cmd_modules_builtin_modinfo = $(cmd_objcopy); \
-                                    sed -i 's/\x00\+$$/\x00/g' $@
+                                    sed -i 's/\x00\+$$/\x00/g' $@; \
+                                    chmod -x $@
 
 OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
 
-- 
2.51.0




