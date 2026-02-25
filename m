Return-Path: <stable+bounces-219423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKtcCNqenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC1192DA0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304903102447
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FE3128DF;
	Wed, 25 Feb 2026 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liR84OpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10A30E85D;
	Wed, 25 Feb 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002706; cv=none; b=p/H4/+C0qsUBLgV3tkuxMRcs7Omn6dBehwwEtY9XzFSjGp2yfHOC1gGzZxkQ5xvI+rcA3ngUvKN8QYsq0cc4PxNym/Ddi9jS8GipQK4o4Er7xd8KM61A0bee+655VAWjx+W44SlnBVhngYwi/22ghmQO4Q/0dDPb9ES5+jo8/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002706; c=relaxed/simple;
	bh=wGiwoiSQTlhu1geUa/BVOkOij7QNb6GGUf4mIl6tcGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZd0HCDLKd8S1QzgmgqBCNaEPG0M/ESKXPSIYm4v1RYo2Q6BOWypxjz7og/wpWVqBtXcHOAe0IJNn6BeTqY754M6SyAm2/m+sNBNjYXwxWDFp+2UGZx8mvAkyxV2FhWlb+r+z0ZQ7hM0XomC4kFSWtlkdqPDbw6qAAFyDkjAzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liR84OpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EB1C116D0;
	Wed, 25 Feb 2026 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002705;
	bh=wGiwoiSQTlhu1geUa/BVOkOij7QNb6GGUf4mIl6tcGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liR84OpRrhUnKb25kDgeMw4uV9V+7SwC1p6HkpNEn3zhBFYPlM8z50nQ+llnA3AmR
	 bsWVjTjRNdhD95/NBDHjyND92WpFVgIEP8U7iwmwKzP9IRzaIzfIM44rMfqMr9U5sj
	 AytcugEfbeCL6QT9nfQMgw4014UXy3hKnsCh6ANU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Remus <jremus@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 505/641] kbuild: Add objtool to top-level clean target
Date: Tue, 24 Feb 2026 17:23:51 -0800
Message-ID: <20260225012400.759747867@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219423-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AFC1192DA0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 68b4fe32d73789dea23e356f468de67c8367ef8f ]

Objtool is an integral part of the build, make sure it gets cleaned by
"make clean" and "make mrproper".

Fixes: 442f04c34a1a ("objtool: Add tool to perform compile-time stack metadata validation")
Reported-by: Jens Remus <jremus@linux.ibm.com>
Closes: https://lore.kernel.org/15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Jens Remus <jremus@linux.ibm.com>
Link: https://patch.msgid.link/968faf2ed30fa8b3519f79f01a1ecfe7929553e5.1770759919.git.jpoimboe@kernel.org
[nathan: use Closes: instead of Link: per checkpatch.pl]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile               | 11 ++++++++++-
 tools/objtool/Makefile |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c4b22ec262784..bc34a825aba80 100644
--- a/Makefile
+++ b/Makefile
@@ -1440,6 +1440,15 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
+PHONY += objtool_clean
+
+objtool_O = $(abspath $(objtree))/tools/objtool
+
+objtool_clean:
+ifneq ($(wildcard $(objtool_O)),)
+	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) clean
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
@@ -1603,7 +1612,7 @@ vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
 	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
-clean: archclean vmlinuxclean resolve_btfids_clean
+clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean
 
 # mrproper - Delete all generated files, including .config
 #
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8c20361dd100e..99d3897e046c6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,6 +7,8 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
+RM ?= rm -f
+
 LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
-- 
2.51.0




