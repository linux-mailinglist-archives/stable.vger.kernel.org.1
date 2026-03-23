Return-Path: <stable+bounces-227993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cApWNAhHwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-227993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D90132F388F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE1DA303AD27
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8B3AD527;
	Mon, 23 Mar 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7BVFfZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDA3ACA5C;
	Mon, 23 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273799; cv=none; b=bIXhTJFHg4kBmktQKpU5woaGJsZP77z5y6ndBouT7Vqau1qFpW6OslpMjecxAgCnTREJNIED/LtTPF1GXwa/tXojgRjzErrbBDKYmrlczBKEG3g0XpXltz544KwJR8AjuXI9EYC+R/g9NM9SH+U2W6i4UQvxVG0CW8orE+ZpIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273799; c=relaxed/simple;
	bh=SZjYdjsZbBxNRwrZMmdExAxuL4taCotmXJcLSuWGG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9oeD9KY3HfRm5EWCJ0/K3iYAHPvr4H+onwzDwRa0PcEyphdhb3FvE46qD/Mig498IURwYTFVPkOC11nfxZmXs9s+JFElbteyIYlLRGgwakwYUO8pHRaxRVKRxq7/50urEAQHH425R3ffJiuob42PD5mg9+PRjqD3T+3tXAcf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7BVFfZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169CBC4CEF7;
	Mon, 23 Mar 2026 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273799;
	bh=SZjYdjsZbBxNRwrZMmdExAxuL4taCotmXJcLSuWGG1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7BVFfZHoux3/P4nJzt94TTNddpBjXSaEBkVACa2wQH2UdJ6xMxE4C1IkqOi7vivD
	 /bMr6IqTytG12peoBfS3eYXoO3qezSN4TjeACcmMzwuG94Kwjjk4RfTGROnN2Icl2L
	 lsATr3xH16E/zUc98BtUZntiWzFf9eK/WOaIaSJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.19 013/220] LoongArch: No need to flush icache if text copy failed
Date: Mon, 23 Mar 2026 14:43:10 +0100
Message-ID: <20260323134504.996036612@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-227993-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: D90132F388F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit d3b8491961207ac967795c34375890407fd51a45 upstream.

If copy_to_kernel_nofault() failed, no need to flush icache and just
return immediately.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/inst.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -246,13 +246,15 @@ static int text_copy_cb(void *data)
 
 	if (smp_processor_id() == copy->cpu) {
 		ret = copy_to_kernel_nofault(copy->dst, copy->src, copy->len);
-		if (ret)
+		if (ret) {
 			pr_err("%s: operation failed\n", __func__);
+			return ret;
+		}
 	}
 
 	flush_icache_range((unsigned long)copy->dst, (unsigned long)copy->dst + copy->len);
 
-	return ret;
+	return 0;
 }
 
 int larch_insn_text_copy(void *dst, void *src, size_t len)



