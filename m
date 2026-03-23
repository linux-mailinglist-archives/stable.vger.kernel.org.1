Return-Path: <stable+bounces-228403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLWUNPdLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505092F4316
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B9BA31A3F1A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349117C203;
	Mon, 23 Mar 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2QxfUx1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764438F630;
	Mon, 23 Mar 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275020; cv=none; b=GE/JnVGDAHW9Ki8BvGFy+MJLcXCGKyj+NqMvKGsFX6teNjwDzo0+vezUhhcp99/Fg/tPwvLDFuyNQnhoPGSRGI3HQeLz68Me0OGKLfrFiNJUgsXwHMTKpmLt2sxD4A3ZDmR1Y88Jm18H7kUS7wrb43bidm1zNIVbVhfMN2TktLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275020; c=relaxed/simple;
	bh=InyBuwKelAQQnjq4qOCkDQjYxoFcwPUYnoFVrq/S/QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO5m1mnIcz904jFeq95Im98yA/CCKKTSIDt8MqxcgJwkaNAmyx8QpynRuz2OsS5+tmzIhU8kDTUrqK7hs/IGXTBCXjk3E3hynsMMSsZUAx8H+33CgefHkPdFoEzxcjCBY6Vt3gfU1WXIZlDycEJatlz5bCPB+Z2ayXRRcsIGZnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2QxfUx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75817C4CEF7;
	Mon, 23 Mar 2026 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275019;
	bh=InyBuwKelAQQnjq4qOCkDQjYxoFcwPUYnoFVrq/S/QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2QxfUx1I9JswENhj82dePpf30973WfPcKF8WT3w5ZjO0QpRk9eeCAFGGRdeKd7pe
	 N3jvrWrjoGXHqDgyektalFJBIvCix95alTQ83oZiK7usYoG1RvLzK/EM01uYNmzzuq
	 en3Hj0SzygxQT/pJOEFyk+L8UCdCI6jtTiNJf4aQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
	Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 195/212] binfmt_elf_fdpic: fix AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
Date: Mon, 23 Mar 2026 14:46:56 +0100
Message-ID: <20260323134509.950590270@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,suse.com,futurfusion.io,google.com];
	TAGGED_FROM(0.00)[bounces-228403-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 505092F4316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Vagin <avagin@google.com>

[ Upstream commit 4ced4cf5c9d172d91f181df3accdf949d3761aab ]

Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
vector size calculation in create_elf_fdpic_tables() and
AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.

Similar to the fix for AT_HWCAP2 in commit c6a09e342f8e ("binfmt_elf_fdpic:
fix AUXV size calculation when ELF_HWCAP2 is defined"), this omission
leads to a mismatch between the reserved space and the actual number of
AUX entries, eventually triggering a kernel BUG_ON(csp != sp).

Fix this by incrementing nitems when ELF_HWCAP3 or ELF_HWCAP4 are
defined and updating AT_VECTOR_SIZE_BASE.

Cc: Mark Brown <broonie@kernel.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Fixes: 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4")
Signed-off-by: Andrei Vagin <avagin@google.com>
Link: https://patch.msgid.link/20260217180108.1420024-2-avagin@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf_fdpic.c  | 6 ++++++
 include/linux/auxvec.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca05..a3d4e6973b299 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -595,6 +595,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 #ifdef ELF_HWCAP2
 	nitems++;
 #endif
+#ifdef ELF_HWCAP3
+	nitems++;
+#endif
+#ifdef ELF_HWCAP4
+	nitems++;
+#endif
 
 	csp = sp;
 	sp -= nitems * 2 * sizeof(unsigned long);
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d60..8bcb9b7262628 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
 
 #include <uapi/linux/auxvec.h>
 
-#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
+#define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 #endif /* _LINUX_AUXVEC_H */
-- 
2.51.0




