Return-Path: <stable+bounces-246137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGr0DvNuA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821EF52743D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7CE3210044
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5E3C0A0F;
	Tue, 12 May 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mRTUCDA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F703C0A08;
	Tue, 12 May 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608453; cv=none; b=mEopc5YCNa4pMm3MCNG1OTt02xV+/wUTMNOCYXjb8u2JYgTYdlFyh6HeRItt9iouITkOmZItp0yvwLzJda8GMhvN9VnC41dYVNZZsG4qaqWGVivkbIrPpESImpkvo76Jw1X29igMrURDBHsd2U9IwlBO8OZjLKoYTEOF13FzMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608453; c=relaxed/simple;
	bh=kYmGEHClSLH8Rp9szG7Haa90BpBn1CUSsDA5iQnqHxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka0q3fBFWmi777EEvFvShi6Iqhgfi04mUSvPizCSab2YhhFyxut+W+tWCF6smg5J8mUjLEVZ2w3fBLntfIVXEm7UEIEIjcASX4PBrUrpOM0qHnce+yVwylvLIjobDULsL8E9G5f4LVZ/JNomWaj7XwSxn32ob5bFg3aZw0noWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mRTUCDA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F47FC2BCC7;
	Tue, 12 May 2026 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608453;
	bh=kYmGEHClSLH8Rp9szG7Haa90BpBn1CUSsDA5iQnqHxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRTUCDA5DlTm4V0FNwxV9Fo8/3o7PSUlXqjc67o5HFV6IAzpaclhHoTb2pLDmClZW
	 kmwu9mkGL5IBkNaauUFdLaqTtGXqkWULseb5oEnoPoW2CTi1FA+slCuri8hVvNb7z2
	 Unfyy1jhpS+YUQ1EKqM+QoTh0lMthvZrzzZfYdUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.18 086/270] KVM: arm64: Fix kvm_vcpu_initialized() macro parameter
Date: Tue, 12 May 2026 19:38:07 +0200
Message-ID: <20260512173940.270912423@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 821EF52743D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246137-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuad Tabba <tabba@google.com>

commit d89fdda7dd8a488f922e1175e6782f781ba8a23b upstream.

The macro is defined with parameter 'v' but the body references the
literal token 'vcpu' instead, causing it to silently operate on whatever
'vcpu' resolves to in the caller's scope rather than the value passed by
the caller. All current call sites happen to use a variable named 'vcpu',
so the bug is latent.

Fixes: e016333745c7 ("KVM: arm64: Only reset vCPU-scoped feature ID regs once")
Signed-off-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260424084908.370776-5-tabba@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1476,7 +1476,7 @@ static inline bool __vcpu_has_feature(co
 #define kvm_vcpu_has_feature(k, f)	__vcpu_has_feature(&(k)->arch, (f))
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
-#define kvm_vcpu_initialized(v) vcpu_get_flag(vcpu, VCPU_INITIALIZED)
+#define kvm_vcpu_initialized(v) vcpu_get_flag(v, VCPU_INITIALIZED)
 
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM



