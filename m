Return-Path: <stable+bounces-231943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEWdIW77y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD836D3F9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81B983082D9E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BB402435;
	Tue, 31 Mar 2026 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTTuyaDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A584262A6;
	Tue, 31 Mar 2026 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975467; cv=none; b=MY7ARML7aoJFuPWgneCoUqW9A5MSx7ahVZ/I2RYbPB74SrpN0Uq45eYZKBD4aMY5hanMUbrAbibJrYzJhdaDnENRy+rrW0moe4Ofw5FG4p8fvEpXan9r6NVGNJa56CBFupVtXFS8F4lClsPaWDflGzxnfIBGynW8EUNwBjkKlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975467; c=relaxed/simple;
	bh=o/BLT4YVzWQvszgDET7VWzb53qYtxHSbOfwNOs+zEqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqM6LSlDMCA0a3pVTa7QsFX+E8IkzNudKu/WmKKwzVzAHQKPb1BNoZrhQFppz7ZsVCT9Nu+ScxUx45bxQKkhL/XPAr5skr71BM+2yBq/MS8EHUjqwnamaeWxRxW6py9d0iz4J1ngsYtDzAbah0aY0UnEzwTFCHsTSP8TzmkOBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTTuyaDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2133CC19423;
	Tue, 31 Mar 2026 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975467;
	bh=o/BLT4YVzWQvszgDET7VWzb53qYtxHSbOfwNOs+zEqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTTuyaDZwpvWLVbia/fkSOEIt6qhrJplOWCPtMPVyGeuENzL4sSBHDMggK6UZ3Som
	 DHqnYaMbkOMYRK8rfc28RBHZmsbA36amKcIRPbegX5oz7Mof5odj6uXBLBxq9BGBEL
	 Su2g5LJbwSXxGFwS6Nn8EBaLd0W854ZEaRMq+gAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurelien Jarno <aurel32@debian.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.19 273/342] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
Date: Tue, 31 Mar 2026 18:21:46 +0200
Message-ID: <20260331161808.989234631@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231943-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFFD836D3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -562,6 +562,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(s
 {
 	struct kvm_phyid_map *map;
 
+	if (cpuid < 0)
+		return NULL;
+
 	if (cpuid >= KVM_MAX_PHYID)
 		return NULL;
 



