Return-Path: <stable+bounces-228218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH5jDLtNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E77022F482F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7749A30DC457
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964AF3AF670;
	Mon, 23 Mar 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8C4+Npx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FD3AEF22;
	Mon, 23 Mar 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274483; cv=none; b=pZS5F/GC9f6o0SLbM6ifoatQia9pCVZOgPb1+pGsva8Vrm6REpgpCH5YgtlWyMPC0ZCGmOP1yocRIsMujhitxRLvRgIInOfy4Woheyf8aL2WYFzQaCbatfYebNUO/KvD2H3lWMSGR+sQbXPw4L5IDUnYVYYYj9MEOZ9sOhpxNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274483; c=relaxed/simple;
	bh=QJlEe3quCdqr8yryvu1CEXi+KB7PwjwPFvT7k1k0dmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkhSfPPPYU4RjUQqK/JVZaVz/6Q1Ek9G2YLz+svU/yLrGCwEK2/0xRghOUyl2DgEpwhIpoaXlF6xJybYumLiEEizV94Ko4NthjkGGNNwkXh9BDse0tUD6UDTfBhbuRI6qhSSdJyiEvK+QwpODBDXCpWusbYD+kUioK8HpvGeGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8C4+Npx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0988C2BCB1;
	Mon, 23 Mar 2026 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274483;
	bh=QJlEe3quCdqr8yryvu1CEXi+KB7PwjwPFvT7k1k0dmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8C4+NpxVqDue2JmvaypxeAnGmxYF6snMewcMTfm2rYwRH5F+JTcff5g3hPqtAo7t
	 3PQ+aoUdHfcYZAbHRgBJBeP82Gm5TPcbbfmC0C9cWMy1HIKnPIZk6iGjJB+HZXwRRk
	 GQRmaZ6ZWEjZW2cNrtIyKGde96QXc6p6VMZ8hYPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 012/212] LoongArch: Give more information if kmem access failed
Date: Mon, 23 Mar 2026 14:43:53 +0100
Message-ID: <20260323134504.153706497@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228218-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E77022F482F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit a47f0754bdd01f971c9715acdbdd3a07515c8f83 upstream.

If memory access such as copy_{from, to}_kernel_nofault() failed, its
users do not know what happened, so it is very useful to print the
exception code for such cases. Furthermore, it is better to print the
caller function to know where is the entry.

Here are the low level call chains:

  copy_from_kernel_nofault()
    copy_from_kernel_nofault_loop()
      __get_kernel_nofault()

  copy_to_kernel_nofault()
    copy_to_kernel_nofault_loop()
      __put_kernel_nofault()

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/uaccess.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -196,8 +196,13 @@ do {									\
 									\
 	__get_kernel_common(*((type *)(dst)), sizeof(type),		\
 			    (__force type *)(src));			\
-	if (unlikely(__gu_err))						\
+	if (unlikely(__gu_err))	{					\
+		pr_info("%s: memory access failed, ecode 0x%x\n",	\
+			__func__, read_csr_excode());			\
+		pr_info("%s: the caller is %pS\n",			\
+			__func__, __builtin_return_address(0));		\
 		goto err_label;						\
+	}								\
 } while (0)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
@@ -207,8 +212,13 @@ do {									\
 									\
 	__pu_val = *(__force type *)(src);				\
 	__put_kernel_common(((type *)(dst)), sizeof(type));		\
-	if (unlikely(__pu_err))						\
+	if (unlikely(__pu_err))	{					\
+		pr_info("%s: memory access failed, ecode 0x%x\n",	\
+			__func__, read_csr_excode());			\
+		pr_info("%s: the caller is %pS\n",			\
+			__func__, __builtin_return_address(0));		\
 		goto err_label;						\
+	}								\
 } while (0)
 
 extern unsigned long __copy_user(void *to, const void *from, __kernel_size_t n);



