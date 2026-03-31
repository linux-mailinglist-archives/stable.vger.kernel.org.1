Return-Path: <stable+bounces-231859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INJVA6z8y2nDNAYAu9opvQ
	(envelope-from <stable+bounces-231859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174F36D734
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6FDC3102DA2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C5426D17;
	Tue, 31 Mar 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Uzcb/Qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C763FF883;
	Tue, 31 Mar 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975255; cv=none; b=RW/sx9eyBbDjTFWA0Y3CRa8JRCTtTiY2KVXEXxQmmq7/cMRnz/UJGtiWd3yfz2CCvImyoCF8VOp7I9P7oR1Y9rBZSRXlFlhrS9vw+AlC45y32et5blMPLU9M6UBOfPhBdQYkdvoR+fvEu7ufazcTtTZFwim2XkXatmk0ETXFzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975255; c=relaxed/simple;
	bh=Jy/YMoVqo1kroCfgbhk5gtqODFZiO+uxha07mS6h9sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxAaAuvCVk9SyR7jl1A5yO5WUS/7tU6BVPKqXHnfNEs+bFF0q0IJbMdcXZCM7jx4S63dHvLuvy5ZUgM0lHsj5FGIiDpTWsTjUOXYH+yvxefITz/r/azh1EWJrcXJ41dTHK2qErcbaxvQr7jxeL0HpFR5U2dFdVcD8e37tUSEgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Uzcb/Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D788C19423;
	Tue, 31 Mar 2026 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975254;
	bh=Jy/YMoVqo1kroCfgbhk5gtqODFZiO+uxha07mS6h9sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Uzcb/Qar/0vKRxFfT6VnzMemGXEXPxzd6Ac46d/nEwhj6tEk555NpGa+VLA9hBPw
	 b9UvvY5G2zlJNKpHHPqMzq1WMIvKc/gQsgSZ1ZuUB1re4xwHq3X+bN5HB3TUzQA4Wz
	 Zjzh0gUJkvhZJSTXO/HSCvq5x8sckN1ReCHWiDJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.19 223/342] KVM: arm64: Fix the descriptor address in __kvm_at_swap_desc()
Date: Tue, 31 Mar 2026 18:20:56 +0200
Message-ID: <20260331161807.176882939@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231859-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6174F36D734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

commit 0496acc42fb51eee040b5170cec05cec41385540 upstream.

Using "(u64 __user *)hva + offset" to get the virtual addresses of S1/S2
descriptors looks really wrong, if offset is not zero. What we want to get
for swapping is hva + offset, not hva + offset*8. ;-)

Fix it.

Fixes: f6927b41d573 ("KVM: arm64: Add helper for swapping guest descriptor")
Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Link: https://patch.msgid.link/20260317115748.47332-1-zenghui.yu@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/at.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1785,7 +1785,7 @@ int __kvm_at_swap_desc(struct kvm *kvm,
 	if (!writable)
 		return -EPERM;
 
-	ptep = (u64 __user *)hva + offset;
+	ptep = (void __user *)hva + offset;
 	if (cpus_have_final_cap(ARM64_HAS_LSE_ATOMICS))
 		r = __lse_swap_desc(ptep, old, new);
 	else



