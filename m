Return-Path: <stable+bounces-223718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNDtA14Tr2kiNgIAu9opvQ
	(envelope-from <stable+bounces-223718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 19:37:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813823EAFF
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 19:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 387233000594
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB034BA49;
	Mon,  9 Mar 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbKze7fk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C4346E7F
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081421; cv=none; b=R0XmLicKQnLzjUq3PKUbD1Q8TIbYaGiJao6SgfoMPixN/ApmrbnszJyL9c3GbvVwCYF78buJCqZ4jwmkR9Emv+8KonZiw667uhilmjQhxfi66KjQx29mk4tyECQtDesjEXbTnBGb0ZOy9Z/u7wJ2t9SwJTPkYT2IQ5hZNv/9Xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081421; c=relaxed/simple;
	bh=mxAxOmQdYjnEqMTYxnAUtL7aeRRp+KWuxlBoZAtkI74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqwuaJsZKN63WEdQn4BOhrrnbFYmM7j+arsGsXwQyKTVhBOWrrLKih3iknclfyiCVZ4swmIY6YN9tLBJaUP9RIR+kuEQFffaFpTX5Fw2vS/eNOD3cK/LQ/Nf4X1NY8+VASIipy+7Yu+LYd8H1poHN/AbGv680pHA0me1FSjbuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbKze7fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D8C4CEF7;
	Mon,  9 Mar 2026 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773081421;
	bh=mxAxOmQdYjnEqMTYxnAUtL7aeRRp+KWuxlBoZAtkI74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbKze7fkLP9X9PypcfuHTFupzVfcUzugWlPbglrBmi46hXHrwg3IQxCXKgXWf+1x0
	 Z9kl0e1BOz8nn+5K+RQt90OPWIKUq58xfK25WdkKn5+qchLUt6qyXT/4EnPVC3NRB3
	 zjbrPWmHMS6Eq3dmPNK2ln8U9PFxUArSqhycJ2b1je2oSOcpAakqX2HhKC2DhAq6ac
	 i6zaCz2Y5svcucxSdvNilXxQNmYBvQ8KAiMVxz/dIPVDD+GX6qB4kgZ4reLbK+6UE/
	 vApfOtvwBwYUVLaYoPKu/0JFBeMcDY6iLIPc4oT72uWS2JRLFwDDS+unDsdJEIB/YU
	 YIH7NJbZVMadw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Rainer Fiebig <jrf@mailbox.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] kbuild: Leave objtool binary around with 'make clean'
Date: Mon,  9 Mar 2026 14:36:58 -0400
Message-ID: <20260309183658.1347302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030940-mule-parched-b1ff@gregkh>
References: <2026030940-mule-parched-b1ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5813823EAFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223718-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mailbox.org:email,infradead.org:email,suse.de:email,msgid.link:url]
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit fdb12c8a24a453bdd6759979b6ef1e04ebd4beb4 ]

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
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile               | 8 ++++----
 tools/objtool/Makefile | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index ae059d1885110..616909ef5acef 100644
--- a/Makefile
+++ b/Makefile
@@ -1370,13 +1370,13 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
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
@@ -1547,7 +1547,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs)
+mrproper: clean objtool_mrproper $(mrproper-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.rmeta' \) \
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 02d1fccd495f4..4f6f3121d8ecd 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -91,10 +91,12 @@ $(LIBSUBCMD)-clean:
 	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
 clean: $(LIBSUBCMD)-clean
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
-	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)find $(OUTPUT) \( -name '*.o' -o -name '\.*.cmd' -o -name '\.*.d' \) -type f -print | xargs $(RM)
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
+mrproper: clean
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
+
 FORCE:
 
-.PHONY: clean FORCE
+.PHONY: clean mrproper FORCE
-- 
2.51.0


