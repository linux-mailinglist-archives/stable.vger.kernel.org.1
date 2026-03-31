Return-Path: <stable+bounces-231701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAolAl3+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3952E36DC04
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFC4631297C1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6D423A82;
	Tue, 31 Mar 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXgbm5KU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403E3F7887;
	Tue, 31 Mar 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974845; cv=none; b=Frt5s/LQ49JhrJOQKPoMBBeJvqOZyFYmuJU8uvEmBH9y7SbL3E6hRrbCt2Rl+FS17NHBHJMUZoKVHRwaMpjaIKzoCUZ/lXuG080EBxj7AuVHtkyYhEKjDLaXAvGh66JWU8WptVaOzwFs29YHLUudo8yfE7m8cM1wBQRaWAcp0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974845; c=relaxed/simple;
	bh=y2Td8xYSzGVOmZ6XnTlNz5HuisqKvUcs+HrCslY9rso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1kpnMD3WSahVlWUDFh3tpb4odmsa/O/lNuAP+KzPrt6mr0JqEB6aE3EUUMfeAf8nLrVel82rYGfBqSK8FRBxuGbnYkYTjXpH+J6sR61QjZPOC3n7n3IivfiTXJxM0QA2jMh9byaCXm/SayGDvf7v1KKBN1znFD1X6Sp9HNG83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXgbm5KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD3EC19423;
	Tue, 31 Mar 2026 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974845;
	bh=y2Td8xYSzGVOmZ6XnTlNz5HuisqKvUcs+HrCslY9rso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXgbm5KUHzGr0M6YzEPIEVgmDPOq+de+76I85nOXwCq2STcEDbDg/5Y38/5CXdfhV
	 Nv/L4Xa7vW5MpAqUg0uSOsUSxiNFUfU2PYfM4TMLlk7Bjgutt2ajbSYi4UGF4IwjDn
	 mdCaKuYu9NqVwcOGM5z/vr63EOgH1XU1L2qeUzQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH 6.19 067/342] objtool/klp: Disable unsupported pr_debug() usage
Date: Tue, 31 Mar 2026 18:18:20 +0200
Message-ID: <20260331161801.361727223@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231701-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3952E36DC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit e476bb277cf91b7ac3ea803ec78a4f0791bddec3 ]

Instead of erroring out on unsupported pr_debug() (e.g., when patching a
module), issue a warning and make it inert, similar to how unsupported
tracepoints are currently handled.

Reviewed-and-tested-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/3a7db3a5b7d4abf9b2534803a74e2e7231322738.1770759954.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/klp-diff.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b1847828217ba..b9340ef8d370c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1335,18 +1335,18 @@ static bool should_keep_special_sym(struct elf *elf, struct symbol *sym)
  * be applied after static branch/call init, resulting in code corruption.
  *
  * Validate a special section entry to avoid that.  Note that an inert
- * tracepoint is harmless enough, in that case just skip the entry and print a
- * warning.  Otherwise, return an error.
+ * tracepoint or pr_debug() is harmless enough, in that case just skip the
+ * entry and print a warning.  Otherwise, return an error.
  *
- * This is only a temporary limitation which will be fixed when livepatch adds
- * support for submodules: fully self-contained modules which are embedded in
- * the top-level livepatch module's data and which can be loaded on demand when
- * their corresponding to-be-patched module gets loaded.  Then klp relocs can
- * be retired.
+ * TODO: This is only a temporary limitation which will be fixed when livepatch
+ * adds support for submodules: fully self-contained modules which are embedded
+ * in the top-level livepatch module's data and which can be loaded on demand
+ * when their corresponding to-be-patched module gets loaded.  Then klp relocs
+ * can be retired.
  *
  * Return:
  *   -1: error: validation failed
- *    1: warning: tracepoint skipped
+ *    1: warning: disabled tracepoint or pr_debug()
  *    0: success
  */
 static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym)
@@ -1404,6 +1404,13 @@ static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym
 				continue;
 			}
 
+			if (strstr(reloc->sym->name, "__UNIQUE_ID_ddebug_")) {
+				WARN("%s: disabling unsupported pr_debug()",
+				     code_sym->name);
+				ret = 1;
+				continue;
+			}
+
 			ERROR("%s+0x%lx: unsupported static branch key %s.  Use static_key_enabled() instead",
 			      code_sym->name, code_offset, reloc->sym->name);
 			return -1;
-- 
2.51.0




