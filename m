Return-Path: <stable+bounces-252591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KipChAnDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357159AD99
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339B73318DA7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C9368968;
	Wed, 20 May 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2k+DGtHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA923F23C5;
	Wed, 20 May 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301076; cv=none; b=gY8pMC4FMsjk7tnABMFkmTA27VR/1+GrcWofXTtHSrqDTyOfRtR59zBxrc1B/aPY4/L5KJEa/u9Q8ulyiP77/CseEROaZV0VO4TgpBqEF3BIqOK4z7PfcuE9FHiA3JMKhS6jzhSRF94xe2R7gpw8o1TYwx8EFbxcegyeq7Svdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301076; c=relaxed/simple;
	bh=uEm+g9YunSQYtmpRNDKQ0uSBGWc2rvxwd+zzYVt9O+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UByiCEEUdy7BwFpG2vOKFRlc5YAxN4E/QTZG415MOTljx/ik9st9zMKkYxspB5fxhv3wUwNKSPlyYnOUWplLDwIKJrLXRR1dDXz5NxhG8DbtjVX60fbTLa7R6xnViFejU94ir88kwjyuqDlyYwA1S/Bn1IHrzXAlIx+pp1hb7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2k+DGtHR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31801F000E9;
	Wed, 20 May 2026 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301075;
	bh=atJg9WthQOb7Y+yTv/wQFiBDGfYqzSv8sB14KJkJMIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2k+DGtHR/FiYsZxBnXKktXtGZLZAXzv8bDldFgQJCX8yhlHvHHyTqUKUThU4sHUxf
	 YEsXY2/SRq/HQAzFjUgNjJXZECQAnJVZDl1j6PDdJ35MTYnRBYsSrC5ATxc4JfE6H+
	 dQ+xryRUQnJ1T9Y3OqpEFs8guoRyWIt240sJohw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 416/666] x86/um: fix vDSO installation
Date: Wed, 20 May 2026 18:20:27 +0200
Message-ID: <20260520162120.281377166@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-252591-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email,vdso.so:url,weissschuh.net:email]
X-Rspamd-Queue-Id: 6357159AD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit d1895c15fc7d90a615bc8c455feb02acaf08ef1e ]

The generic vDSO installation logic used by 'make vdso_install' requires
that $(vdso-install-y) is defined by the top-level architecture Makefile
and that it contains a path relative to the root of the tree.
For UML neither of these is satisfied.

Move the definition of $(vdso-install-y) to a place which is included by
the arch/um/Makefile and use the full relative path.

Fixes: f1c2bb8b9964 ("um: implement a x86_64 vDSO")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20260318-um-vdso-install-v1-1-26a4ca5c4210@weissschuh.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Makefile.um      | 2 ++
 arch/x86/um/vdso/Makefile | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index c86cbd9cbba38..19c13afa474e9 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -60,4 +60,6 @@ ELF_FORMAT := elf64-x86-64
 LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
+vdso-install-y += arch/x86/um/vdso/vdso.so.dbg
+
 endif
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b3dfd60619e8a..bde42fac402ca 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,8 +3,6 @@
 # Building vDSO images for x86.
 #
 
-vdso-install-y += vdso.so
-
 # files to link into the vdso
 vobjs-y := vdso-note.o um_vdso.o
 
-- 
2.53.0




