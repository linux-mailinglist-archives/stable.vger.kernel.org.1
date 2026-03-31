Return-Path: <stable+bounces-231680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMnFJFP5y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43636CFCF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8801A30010C5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AFA4266A4;
	Tue, 31 Mar 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBeYSPzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E91423A8B;
	Tue, 31 Mar 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974791; cv=none; b=n4Og3Ox93FxFHXxPfYrhoB+ROrdcEh2rm5Sid92JrUSLuOAk0i1kYwhdJMfs6nQAVF1H3unq5VG3ba6W80Gz6v0mGH7aAGMif0v9rvkF66cln3CWR3C3ObdTTyo3sbQ22PFbJnyCYS3u8jL1s4aqd2UkvAy+Kz427WsmbWueSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974791; c=relaxed/simple;
	bh=kzO1MQNtXISVnyYx/uyXpxlKtb0sbibAmdedYuiASAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh6XaDhHjvvd3TdA3zGCGkLaRfnmxKQgkN4xEHPFnXVoCPY47b/2SEG+mncLxNe1Efg9yxPW1Yz6qIgiXGmAJe04ZCqvJZn+0QG0KfyxMLy3EZ0y2pVQ0CD2uPbkHSZ0D4kI8w7Q/qCt2PNNvz6/iCOIULWhdeyFXLeHt0xO42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBeYSPzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07FC19423;
	Tue, 31 Mar 2026 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974791;
	bh=kzO1MQNtXISVnyYx/uyXpxlKtb0sbibAmdedYuiASAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zBeYSPziiUPovH2r+WL8Yk9i5U/slhYaJwUjBZWFnAfpK8Mj7Wj+qSCDYyJTaYK66
	 P2/QKsdbra/baInlZ5+i9eqcGO3I2VT2qkZnrrRbMXqDCBZ69vkv7Q44Hf6jolBptM
	 cpDbrpBA3UfU0/J/Ve1XLZnTzUUowgygLGH7rqWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 045/342] module: Fix kernel panic when a symbol st_shndx is out of bounds
Date: Tue, 31 Mar 2026 18:17:58 +0200
Message-ID: <20260331161800.558741076@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231680-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,samsung.com:email,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2F43636CFCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihor Solodrai <ihor.solodrai@linux.dev>

[ Upstream commit f9d69d5e7bde2295eb7488a56f094ac8f5383b92 ]

The module loader doesn't check for bounds of the ELF section index in
simplify_symbols():

       for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
		const char *name = info->strtab + sym[i].st_name;

		switch (sym[i].st_shndx) {
		case SHN_COMMON:

		[...]

		default:
			/* Divert to percpu allocation if a percpu var. */
			if (sym[i].st_shndx == info->index.pcpu)
				secbase = (unsigned long)mod_percpu(mod);
			else
  /** HERE --> **/		secbase = info->sechdrs[sym[i].st_shndx].sh_addr;
			sym[i].st_value += secbase;
			break;
		}
	}

A symbol with an out-of-bounds st_shndx value, for example 0xffff
(known as SHN_XINDEX or SHN_HIRESERVE), may cause a kernel panic:

  BUG: unable to handle page fault for address: ...
  RIP: 0010:simplify_symbols+0x2b2/0x480
  ...
  Kernel panic - not syncing: Fatal exception

This can happen when module ELF is legitimately using SHN_XINDEX or
when it is corrupted.

Add a bounds check in simplify_symbols() to validate that st_shndx is
within the valid range before using it.

This issue was discovered due to a bug in llvm-objcopy, see relevant
discussion for details [1].

[1] https://lore.kernel.org/linux-modules/20251224005752.201911-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index bcd259505c8b3..21c5c0d14fa83 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1568,6 +1568,13 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			break;
 
 		default:
+			if (sym[i].st_shndx >= info->hdr->e_shnum) {
+				pr_err("%s: Symbol %s has an invalid section index %u (max %u)\n",
+				       mod->name, name, sym[i].st_shndx, info->hdr->e_shnum - 1);
+				ret = -ENOEXEC;
+				break;
+			}
+
 			/* Divert to percpu allocation if a percpu var. */
 			if (sym[i].st_shndx == info->index.pcpu)
 				secbase = (unsigned long)mod_percpu(mod);
-- 
2.51.0




