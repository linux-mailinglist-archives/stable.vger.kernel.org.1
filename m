Return-Path: <stable+bounces-251941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGdMH0D9DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CE5963CB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C9D34F4E04
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40B233933;
	Wed, 20 May 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bin5m8DK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD623F1AB8;
	Wed, 20 May 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299331; cv=none; b=eT174r5OI2/XG69kvyZbqSvskIA95bslmjEDyYu7MzUpS2RCH0uacdVQExDyJSd9Q5XhTiiRLNG1DtZmIEugZ/nCkECDWPf2TbHsk2lkUqFyJpQyE/Rr/3hyLiN4meUDpxozaaPsgC2TApTuYw/nKksxaSmLD1iUm1JYbRpuxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299331; c=relaxed/simple;
	bh=0tLbY+y/x5Oq0EGlqsbf7xc8ohuKTnJL8pK9JdH3xmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COF0Xf+cHsJJXoVUYE7a7n6t8YI8yGTpLkkLBlhKaAIuPHfPyQBnHXUXLI7t8yErR6uUidf55xg+dfMgY0NzW+yO/e7khdtX+Gd0WZuIFtMd4ZHxxIkSu64ByjTy3hYbNEYEfNKS09fbgAh0FE3HHj0/4e/RNWZa+iZR/NANNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bin5m8DK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC171F000E9;
	Wed, 20 May 2026 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299329;
	bh=VZ8YGK+ulsweBKv82/98pHHNZ12zEWrPneuYmfZ5I/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bin5m8DKsDWSq9dQ6Ny7BR4tdxAOJIfMUT9uQVWUQ/ILHuT+SqYPN5kZpAc0LdV4d
	 SsWCZKJMokIaqt2DyYofW5jVlib/agf7wLi73f2jCL3y3RqsWHWVPgPmKBe00KBvGe
	 l6hnURhYISIbwCIWt0YaeSQaNGN6bhNf+w2yUXfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 731/957] kbuild: Never respect CONFIG_WERROR / W=e to fixdep
Date: Wed, 20 May 2026 18:20:14 +0200
Message-ID: <20260520162150.408403648@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251941-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,weissschuh.net:email]
X-Rspamd-Queue-Id: CB5CE5963CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 75f7c47ccd78c947cf1b6ddb18ea453ff0555716 ]

The fixdep hostprog may be built multiple times during a single build.
Once during the configuration phase and later during the regular phase.
As only the regular build phase respects CONFIG_WERROR / W=e, the
compiler flags might change between the phases, leading to rebuilds.

Example, the rebuilds will happen twice on each invocation of the build:

  $ make allyesconfig prepare
  make[1]: Entering directory '/tmp/deleteme'
    HOSTCC  scripts/basic/fixdep
  #
  # No change to .config
  #
    HOSTCC  scripts/basic/fixdep
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[1]: Leaving directory '/tmp/deleteme'

Fix the compilation flags used for scripts/basic/ before
scripts/Makefile.warn is evaluated to stop CONFIG_WERROR / W=e
influencing the fixdep build to avoid the spurious rebuilds.

Fixes: 7ded7d37e5f5 ("scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e for hostprogs")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/20260422-kbuild-scripts-basic-werror-v1-1-8c6912ff22e0@weissschuh.net
Signed-off-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index d1fcec7cf9568..70e10b29b3859 100644
--- a/Makefile
+++ b/Makefile
@@ -655,6 +655,8 @@ export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
 
 # Basic helpers built in scripts/basic/
 PHONY += scripts_basic
+scripts_basic: KBUILD_HOSTCFLAGS := $(KBUILD_HOSTCFLAGS)
+scripts_basic: KBUILD_HOSTLDFLAGS := $(KBUILD_HOSTLDFLAGS)
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 
-- 
2.53.0




