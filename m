Return-Path: <stable+bounces-246615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFabFkxuA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:15:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0F52728B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B918C306F06E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC08368972;
	Tue, 12 May 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaVwuOjy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3717557E;
	Tue, 12 May 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609677; cv=none; b=SYa/q8ln7E68/CypGYdQ8qWNChb3aqIRKsdbNcrAFwleMfAjRc12c38A9LP2RabCDUKEaAhHZ0NlxTYmNvCcGV0A2ajIjQOPf47Ka8Pmt+wPtlR5HhREckHNnAPGSr0P6ves3gdP0DRrq2witVEbEAzzRjiXKtaiXVDCrgPcmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609677; c=relaxed/simple;
	bh=+K+ovdx58RH7tsVqfs1sJ3D2YHjg9dnVrlXK4spfao0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwq5GnC37kjnUIA4rjUUMP7p2lwerZNQcN949BT2Ir/vuphXC1w2nlILDClnvDwAv83FU6T4QbwWlhkL9WxyTdselumx8e1W7H3mdwhbzDtJfoHjZZmId6Qp/TrhUidbqt7zm9eR+bNRpBmt7Qsvfarf9FJxqtHaLayTNwbFOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZaVwuOjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894BDC2BCB0;
	Tue, 12 May 2026 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609676;
	bh=+K+ovdx58RH7tsVqfs1sJ3D2YHjg9dnVrlXK4spfao0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaVwuOjy5CrVVhyeSjc7AdB5IfSWdLro9kSQtU6qnCh/ru110qpu5yLQhWLWrMoNe
	 U9tF03N0zKMnI4tEp5/LsKRhTGO/YTXktDCJI5F9g/w9IywQ/maD1Rxy+reQ+/hI+i
	 LkbnAX/QWVHJYvXP7ev8oouYA/w6HYfc8XPq+Src=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xianglai Li <lixianglai@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 7.0 286/307] LoongArch: KVM: Fix "unreliable stack" for kvm_exc_entry
Date: Tue, 12 May 2026 19:41:21 +0200
Message-ID: <20260512173946.161250048@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 13C0F52728B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246615-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xianglai Li <lixianglai@loongson.cn>

commit b323a441da602dfdfc24f30d3190cac786ffebf2 upstream.

Insert the appropriate UNWIND hint into the kvm_exc_entry assembly
function to guide the generation of correct ORC table entries, thereby
solving the timeout problem ("unreliable stack") while loading the
livepatch-sample module on a physical machine running virtual machines
with multiple vcpus.

Cc: stable@vger.kernel.org
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/switch.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -111,7 +111,7 @@
 	.p2align PAGE_SHIFT
 	.cfi_sections	.debug_frame
 SYM_CODE_START(kvm_exc_entry)
-	UNWIND_HINT_UNDEFINED
+	UNWIND_HINT_END_OF_STACK
 	csrwr	a2,   KVM_TEMP_KS
 	csrrd	a2,   KVM_VCPU_KS
 	addi.d	a2,   a2, KVM_VCPU_ARCH



