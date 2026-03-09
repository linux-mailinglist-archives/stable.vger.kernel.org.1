Return-Path: <stable+bounces-223592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIrZGL6hrmkLHAIAu9opvQ
	(envelope-from <stable+bounces-223592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:32:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0ED23721F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E723051D08
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621AF34EF09;
	Mon,  9 Mar 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ous/DnxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC7238178
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052253; cv=none; b=QyVLWMMfZ65nGGPleVPuX4+IFE8V2v8do4NyBYiwS/wWQEG8ThMumPR7W6UkL1HZi6d7THLunfg8L1H87lsyKb2MckRB0HgLGuwrT1TyFJ4kmTI6S6DyWnv3sWrnJtfKYpPwJSdgZB0FzlCFGrf9JZQUpD6tU/CuBDiySj7SXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052253; c=relaxed/simple;
	bh=gbetlRgox91KLq0F2crqxzU82g1aIrQi6gP1UiH8dGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jsxjKo3+iVxfArVTj2MOUL50BDt0PMo/+Wh9Z6v/mPCDZLZx/ZFlsFMp86cJpbotlGty8qfwzDcPZMAzZMPBTvS+Du1lIOfxeYyR1ZV/SqeHlVNx01GMwcx6FoVVAohk9MZi6yk7PNyrDxKl5sJ6GAFnA+bTBD/OIC0nzsSN7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ous/DnxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC27C4CEF7;
	Mon,  9 Mar 2026 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052253;
	bh=gbetlRgox91KLq0F2crqxzU82g1aIrQi6gP1UiH8dGk=;
	h=Subject:To:Cc:From:Date:From;
	b=Ous/DnxCnI+ZhWmwT7T0TBG4Ip5aXrHQPs3m3kOt5E5hSFq1Ru0WH5O/bz2fbRz++
	 7o5FxUeLjeL/52aEgC/IMJ8Wo/aEjKbUxPtAWtyvz4HYEMKDUtaW9l3oMb82BfJbJN
	 6sPZiQxH9uzHsiJEafmvKUyRGyk86HFVjz8xpZMA=
Subject: FAILED: patch "[PATCH] kbuild: Leave objtool binary around with 'make clean'" failed to apply to 6.12-stable tree
To: nathan@kernel.org,jpoimboe@kernel.org,jrf@mailbox.org,msuchanek@suse.de,nsc@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:30:40 +0100
Message-ID: <2026030940-mule-parched-b1ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D0ED23721F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.323];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fdb12c8a24a453bdd6759979b6ef1e04ebd4beb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030940-mule-parched-b1ff@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fdb12c8a24a453bdd6759979b6ef1e04ebd4beb4 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 27 Feb 2026 22:40:48 -0700
Subject: [PATCH] kbuild: Leave objtool binary around with 'make clean'

The difference between 'make clean' and 'make mrproper' is documented in
'make help' as:

  clean     - Remove most generated files but keep the config and
              enough build support to build external modules
  mrproper  - Remove all generated files + config + various backup files

After commit 68b4fe32d737 ("kbuild: Add objtool to top-level clean
target"), running 'make clean' then attempting to build an external
module with the resulting build directory fails with

  $ make ARCH=x86_64 O=build clean

  $ make -C build M=... MO=...
  ...
  /bin/sh: line 1: .../build/tools/objtool/objtool: No such file or directory

as 'make clean' removes the objtool binary.

Split the objtool clean target into mrproper and clean like Kbuild does
and remove all generated artifacts with 'make clean' except for the
objtool binary, which is removed with 'make mrproper'. To avoid a small
race when running the objtool clean target through both objtool_mrproper
and objtool_clean when running 'make mrproper', modify objtool's clean
up find command to avoid using find's '-delete' command by piping the
files into 'xargs rm -f' like the rest of Kbuild does.

Cc: stable@vger.kernel.org
Fixes: 68b4fe32d737 ("kbuild: Add objtool to top-level clean target")
Reported-by: Michal Suchanek <msuchanek@suse.de>
Closes: https://lore.kernel.org/20260225112633.6123-1-msuchanek@suse.de/
Reported-by: Rainer Fiebig <jrf@mailbox.org>
Closes: https://lore.kernel.org/62d12399-76e5-3d40-126a-7490b4795b17@mailbox.org/
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Tested-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20260227-avoid-objtool-binary-removal-clean-v1-1-122f3e55eae9@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>

diff --git a/Makefile b/Makefile
index e944c6e71e81..d76d706a5580 100644
--- a/Makefile
+++ b/Makefile
@@ -1497,13 +1497,13 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
-PHONY += objtool_clean
+PHONY += objtool_clean objtool_mrproper
 
 objtool_O = $(abspath $(objtree))/tools/objtool
 
-objtool_clean:
+objtool_clean objtool_mrproper:
 ifneq ($(wildcard $(objtool_O)),)
-	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) clean
+	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) $(patsubst objtool_%,%,$@)
 endif
 
 tools/: FORCE
@@ -1686,7 +1686,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs)
+mrproper: clean objtool_mrproper $(mrproper-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.rmeta' \) \
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 6964175abdfd..76bcd4e85de3 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -142,13 +142,15 @@ $(LIBSUBCMD)-clean:
 	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
 clean: $(LIBSUBCMD)-clean
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
-	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)find $(OUTPUT) \( -name '*.o' -o -name '\.*.cmd' -o -name '\.*.d' \) -type f -print | xargs $(RM)
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/cpu-feature-names.c $(OUTPUT)fixdep
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.objtool
 	$(Q)$(RM) -r -- $(OUTPUT)feature
 
+mrproper: clean
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
+
 FORCE:
 
-.PHONY: clean FORCE
+.PHONY: clean mrproper FORCE


