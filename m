Return-Path: <stable+bounces-231944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAocHX/7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3C36D40A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 478C53087E9A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C232C15BB;
	Tue, 31 Mar 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jj/iKX/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27781402435;
	Tue, 31 Mar 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975470; cv=none; b=Q3HZueP6jicL8C8fGhdCGJIPVALsLRH+r6UU3oU2VA+tGC8TS2Dg0z9Y5W9C51TO/Xk6qL09tgbbHAxJYes/j4/4B267Pol+5TrPRgVMnI7h0xDnibfuWZzUrAbzPhZzeUzrBjEs7aK50QEcHicoFmaa+iatJMAl//ZsQKCU0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975470; c=relaxed/simple;
	bh=U1PMG9RUTroFLh/ZEpe/os3PSTrdiLFUFqwe//CiaQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS3bP2BP8mUhxD/KIzdx9PRBekCzTUh/IIV4B53NYFzImsiA5kTABbwaunXbMYENJ/23D582w+h2aUKB/flO1MAoMZXuoOcwt3wCn0uawdl+uINKjf9YhRvs9o1ITuHUdDUwU7UuhDpn9XLd2nP8AwDEXCtwMySuF2rHNKW89pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jj/iKX/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79AAC19423;
	Tue, 31 Mar 2026 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975470;
	bh=U1PMG9RUTroFLh/ZEpe/os3PSTrdiLFUFqwe//CiaQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj/iKX/8vAi2OSsIGjwGKKc0sZlQUZw/WcX+hT9DNCJ774OVxSVN8JcIrNM9o0zET
	 k0Ge30Jq6N4BE4nqR20OjGVbdKy2rC4Lh3MS+9HIbeM8TP7bbmZcJkMcy0D5YPxMvE
	 OOfwo/BmotCj1SS4ccjYa82/64dz1lg7nuHN1yY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurelien Jarno <aurel32@debian.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.19 274/342] LoongArch: KVM: Fix base address calculation in kvm_eiointc_regs_access()
Date: Tue, 31 Mar 2026 18:21:47 +0200
Message-ID: <20260331161809.024577618@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231944-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B3C36D40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

commit 6bcfb7f46d667b04bd1a1169ccedf5fb699c60df upstream.

In function kvm_eiointc_regs_access(), the register base address is
caculated from array base address plus offset, the offset is absolute
value from the base address. The data type of array base address is
u64, it should be converted into the "void *" type and then plus the
offset.

Cc: <stable@vger.kernel.org>
Fixes: d3e43a1f34ac ("LoongArch: KVM: Use 64-bit register definition for EIOINTC").
Reported-by: Aurelien Jarno <aurel32@debian.org>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/intc/eiointc.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -481,34 +481,34 @@ static int kvm_eiointc_regs_access(struc
 	switch (addr) {
 	case EIOINTC_NODETYPE_START ... EIOINTC_NODETYPE_END:
 		offset = (addr - EIOINTC_NODETYPE_START) / 4;
-		p = s->nodetype + offset * 4;
+		p = (void *)s->nodetype + offset * 4;
 		break;
 	case EIOINTC_IPMAP_START ... EIOINTC_IPMAP_END:
 		offset = (addr - EIOINTC_IPMAP_START) / 4;
-		p = &s->ipmap + offset * 4;
+		p = (void *)&s->ipmap + offset * 4;
 		break;
 	case EIOINTC_ENABLE_START ... EIOINTC_ENABLE_END:
 		offset = (addr - EIOINTC_ENABLE_START) / 4;
-		p = s->enable + offset * 4;
+		p = (void *)s->enable + offset * 4;
 		break;
 	case EIOINTC_BOUNCE_START ... EIOINTC_BOUNCE_END:
 		offset = (addr - EIOINTC_BOUNCE_START) / 4;
-		p = s->bounce + offset * 4;
+		p = (void *)s->bounce + offset * 4;
 		break;
 	case EIOINTC_ISR_START ... EIOINTC_ISR_END:
 		offset = (addr - EIOINTC_ISR_START) / 4;
-		p = s->isr + offset * 4;
+		p = (void *)s->isr + offset * 4;
 		break;
 	case EIOINTC_COREISR_START ... EIOINTC_COREISR_END:
 		if (cpu >= s->num_cpu)
 			return -EINVAL;
 
 		offset = (addr - EIOINTC_COREISR_START) / 4;
-		p = s->coreisr[cpu] + offset * 4;
+		p = (void *)s->coreisr[cpu] + offset * 4;
 		break;
 	case EIOINTC_COREMAP_START ... EIOINTC_COREMAP_END:
 		offset = (addr - EIOINTC_COREMAP_START) / 4;
-		p = s->coremap + offset * 4;
+		p = (void *)s->coremap + offset * 4;
 		break;
 	default:
 		kvm_err("%s: unknown eiointc register, addr = %d\n", __func__, addr);



