Return-Path: <stable+bounces-232183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL6jKTf+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA436DB73
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45854328E0C2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD785423A89;
	Tue, 31 Mar 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/eHr6qF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F14035AB;
	Tue, 31 Mar 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976091; cv=none; b=Oog07PEhUauKZ2IYZL9JFzwQH6JON4umzgRiJaAfkkJObdv5ZaXa4ReQb/Hr5LD4RaGFKSapNym9xwnr0H7a3bdn4YrXFlqmwUQQCCTB9myL6N5GO4qZ8DnXDMqC+GW7RDUQG2HTSTn7cfsWMxxjUl3plPwSAtLAYu9q02G5ReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976091; c=relaxed/simple;
	bh=+DDH0wl7THdzxEAsU8+kKwe/rTZCGdjxaJz/BAuW9fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrotpzaAifJX6i9hPvfe0Nnmev9IomyhwmKz0kbN4Jj99Vufe3oABjRFkDeSfPTAWf+pAkp68+EyZWlrYJ+v5kSLVXkzo726u6a2k1u+fRSOWthd3MG9I4MP0AzewPUb3WPx7GY+ikY+yZwSQdpQ6K3r8ROE9G1vBU85Xj7dqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O/eHr6qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59AC19423;
	Tue, 31 Mar 2026 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976091;
	bh=+DDH0wl7THdzxEAsU8+kKwe/rTZCGdjxaJz/BAuW9fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/eHr6qFN9VoILY26DZ5CoKg5bXN/8to6DcuP/Ev7FPgX3uk6aAYLylgAUDUaFKEA
	 kYLXwA/RRvNA9xX6OYyXxJbodpG0GpQUMpFY00BqbkDYTywRzLHZvoBEiTQwPLkqjZ
	 u5rqIm2Uq3IGClTQ53J1Fbs0we7HvHO2r/gOhzPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurelien Jarno <aurel32@debian.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 176/244] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
Date: Tue, 31 Mar 2026 18:22:06 +0200
Message-ID: <20260331161748.256918963@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232183-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0EBA436DB73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 2db06c15d8c7a0ccb6108524e16cd9163753f354 upstream.

kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, so
cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for this
case so as to make it more robust.

This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].

Cc: <stable@vger.kernel.org>
Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from physical cpuid")
Reported-by: Aurelien Jarno <aurel32@debian.org>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/vcpu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -531,6 +531,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(s
 {
 	struct kvm_phyid_map *map;
 
+	if (cpuid < 0)
+		return NULL;
+
 	if (cpuid >= KVM_MAX_PHYID)
 		return NULL;
 



