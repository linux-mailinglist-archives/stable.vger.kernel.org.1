Return-Path: <stable+bounces-228770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKc5Ff1TwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63D2F5623
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978E730A6806
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082313B19A2;
	Mon, 23 Mar 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pzsw9Ihy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00113A9D9D;
	Mon, 23 Mar 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277076; cv=none; b=o+KncEky8MRtFkHyFPNYvLPdqbofAMN28QYwSLjqqSySDMScuUebrcHe8Ki/8oBOrkbASYqlw0xjjEABpfEt2dIgXwm3XSAe25BSKItEms1c41Jrn33qETChCfQiNUKOeOZRjhKkXMiIon2OHD2ORqQM7dDPhDneg/yoA5I+gTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277076; c=relaxed/simple;
	bh=xcGeLtSWAufkV/+iK0x6SOgwC3CUFx5D25jbIFy7KV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5zFoE4N3yRE5WyeNon5fMPgUCHtf6LY8hy0+z7eJOsioHMPXGvPxT250caf9faw9RvlBE+1Ed/aa6JqoqT7lr5UGepd4BHoKmweJjFjYmYtUbZpgkX5bCNTjJ/unCEV0Qh42/D3Hn9wUKzaCHkxyYaSkcjMd0E37ZgeLhaeUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pzsw9Ihy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3B5C4CEF7;
	Mon, 23 Mar 2026 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277076;
	bh=xcGeLtSWAufkV/+iK0x6SOgwC3CUFx5D25jbIFy7KV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pzsw9IhyG4xshBhAEtJo2rjm6L15Dyfh/OwCAeRGPMXAhil23a7SZbnpLqqndXYJK
	 Pg8OE1axTY1txA7g6Mz4JUEL6/mcv5OE2GUeVRZDHzqeMdpL0ismScUd0+7oNFvOPe
	 2EjnhbzcpSvoOJkJunypr7CAbJiD/ICkUOyGfrS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 312/460] LoongArch: Give more information if kmem access failed
Date: Mon, 23 Mar 2026 14:45:08 +0100
Message-ID: <20260323134534.168977637@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228770-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD63D2F5623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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



