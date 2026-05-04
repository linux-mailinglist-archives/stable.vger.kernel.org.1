Return-Path: <stable+bounces-243190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM8XFb2o+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:10:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F44BEA5A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0635030091FB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E713D904D;
	Mon,  4 May 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="De97IWsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D834F483;
	Mon,  4 May 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903247; cv=none; b=VhhSsBJBiB2W5xL+GnR0bK+cIXhbaD2NXCG0qnFW3Yjd13iCn5PqW4m7xx5YayV1jkr6B1L7l++10jNKYz1ROPIh40MjdiWRxwQanXqzrkntpK1GxKp9ruKyJqLXbc4u/N1jboODI8cRgC75Ci5Tmr52j2W+kappcfFDAmki9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903247; c=relaxed/simple;
	bh=OEykEuped0KiV3nuy18/f5/Vz/feu27KRlB4L9NO/8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTNnusOafWS6OFaaoFu5b57Ld5GHOKyWlt937t4wrf1epwxQcwt7b4cXmPNr/aalHaIIyZkPvLuh8IoUF9Mf+ukG3nNTy4sImWdSyC+l26jcTG4ItVQ9wa4DNzvaQHsSASVfXoA/gJPWk38tkXAfRsWcOWgbtMpghuwHYgMN0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=De97IWsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4E8C2BCB8;
	Mon,  4 May 2026 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903247;
	bh=OEykEuped0KiV3nuy18/f5/Vz/feu27KRlB4L9NO/8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De97IWsgnm6oiwXzy46E/DIFJFDaI73eQbAYRAPQW9kMY94Z2UEQptfZ7yZ01u+7k
	 Mx4h+S/BEmIIzt91f/WM9o0OKtxQmZElIdDC2pz4tfp18QiNkB4V2R0JXloJo0G2mK
	 uOrgzCiTRHpB0T+4JjlLD9bEAYoFqtutVodcwXkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 7.0 160/307] LoongArch: Make arch_irq_work_has_interrupt() true only if IPI HW exist
Date: Mon,  4 May 2026 15:50:45 +0200
Message-ID: <20260504135148.860764512@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 403F44BEA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243190-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,loongson.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 02a6a1f9d77a816fbac01de9bfcd0e0914552f2f upstream.

After commit 7c405fb3279b3924 ("rcu: Use an intermediate irq_work to
start process_srcu()"), Loongson-2K0300/2K0500 fail to boot. Because
IRQ_WORK need IPI but Loongson-2K0300/2K0500 don't have IPI HW.

So make arch_irq_work_has_interrupt() return true only if IPI HW exist.

Cc: stable@vger.kernel.org
Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/irq_work.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/include/asm/irq_work.h
+++ b/arch/loongarch/include/asm/irq_work.h
@@ -4,7 +4,7 @@
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return IS_ENABLED(CONFIG_SMP);
+	return IS_ENABLED(CONFIG_SMP) && cpu_opt(LOONGARCH_CPU_CSRIPI);
 }
 
 #endif /* _ASM_LOONGARCH_IRQ_WORK_H */



