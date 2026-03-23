Return-Path: <stable+bounces-228719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLVlLDdUwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F72F5695
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD92630926F3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EA93AEF4E;
	Mon, 23 Mar 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTkSLhLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5F3B19CC;
	Mon, 23 Mar 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276937; cv=none; b=Bt6egixxky4PmpHgM2oFWG+XYPX5qa4zHOru2FnYnHEjttG04oUIhdPxPOm4Xm+RL2+H6Yh43jaX1q6CR6izH8hHxhW3UA8+G9+pkj+YxGqN5/n1Kwx6AdBYLEj+AkmJ1/6rcnk9MNsLIWEHeAgQLELbIqYfggW0eYVVwRusUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276937; c=relaxed/simple;
	bh=vYV/C0ku2aqyNOms7T1eqt1RcJo5dh0I0hOq49+nOH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3MD519j1E40UBKV8Mo6hsjuAJGsgX0JrDO7RcLXD+igVhi0vZAzCK1qp4SI81XhQG5KBeou/tekMb6zhX69RWZrSJxJdE11/kckTBe6+nLVJwv7FUjPuq7lNYRVNvu7T9iok0NSoFJmlo+SZ3sfahVqvR+ida1/9hZvweT0r0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTkSLhLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3616C4CEF7;
	Mon, 23 Mar 2026 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276937;
	bh=vYV/C0ku2aqyNOms7T1eqt1RcJo5dh0I0hOq49+nOH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTkSLhLJimX8rGwhUnuoSd3X8MZVVpKBffJVvBEdh6s8/62TkAfEtgHIJbGOnt5uX
	 /VtNY6mrkqHyGBSUVRuEs7dtiGLn8sOrYFkcyUFagLWB+UDjZMod+SfVePmLSblHdv
	 GDGxjR/wvVx8IXiR3rra5cpgUwbIdrrceTN+Szb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 261/460] KVM: x86: do not allow re-enabling quirks
Date: Mon, 23 Mar 2026 14:44:17 +0100
Message-ID: <20260323134532.899186797@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228719-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 026F72F5695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 9966b7822b3f49b3aea5d926ece4bc92f1f0a700 ]

Allowing arbitrary re-enabling of quirks puts a limit on what the
quirks themselves can do, since you cannot assume that the quirk
prevents a particular state.  More important, it also prevents
KVM from disabling a quirk at VM creation time, because userspace
can always go back and re-enable that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6538,7 +6538,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
-		kvm->arch.disabled_quirks = cap->args[0];
+		kvm->arch.disabled_quirks |= cap->args[0];
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {



