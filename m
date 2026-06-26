Return-Path: <stable+bounces-269269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZIJaLOi9PmopLAkAu9opvQ
	(envelope-from <stable+bounces-269269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B36CF8C3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ls7bAW2+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269269-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269269-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB36430ECB90
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD593AEB26;
	Fri, 26 Jun 2026 17:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C493AEF2D;
	Fri, 26 Jun 2026 17:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496509; cv=none; b=HHgp8o3DLURRaQx1kno59X3h4aO6f5GaLKI7T0bMouJTkVfHafTPtPNYQS85OzI2sARDygAVLwd57J2J1IsvfZ/Ic/MmGc9CJ04WjKmg6mJSQyZrsFaTeWMOdaiMcjxzGBZolfW8xe1oRfVcis25AuRc9btb4TKuiqBnb/OUzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496509; c=relaxed/simple;
	bh=Kv+AeyV1o/K19utKGmCar9oV/XRnd8Bj3IWkpmGX57I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPeSea+vhEtGC9HQO7/RW1TbE2LcBaojbDfjEuX/OKVfbOdBfr2ohnygccgjPlqeyMZ2NgfHJ8TjJDcCmEv02/jyZAbilUiAi8Uc639rz3LCRkA2vJ826QCP9pOCefZ2JU+zmgX5LBqHR5Av2SLbvi18X1zv9zpr7+6CcH4soAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls7bAW2+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77C61F00A3E;
	Fri, 26 Jun 2026 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496507;
	bh=LLfGl8KvfmN7SkY8TxRU8Dpw+AxxkEIbDQBH/XUEaBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ls7bAW2+SLJKcDnx2UwcAwvU1OBweyts7OhBBUDU8y8yt34jC7igPSmqog9Q/gg6V
	 d8uqEwVXPHpcvNdMu6XQBxWOO0M34/d1bGJzHUtOfbIYMJH8r1CTD31g9gdPN/kv8X
	 iIyOPEbwTWCiox8yONVdTv+Ii9Gr1yY06VXJiyYsMzReHrXk5bnEID1eXOklFcfAja
	 mbRVqxzaFbwFfFRab9rZd2vt7pQfTQ3qSZOJNj7GZftEcjAjSN6bLbSyceUDduWtbs
	 UOpn+Ac/z+cxtpBcD9zUs3SKLie7OxdaKFcGuwwYY6bl96K+WXXlMI6aLBhIrvzaj8
	 7DqzlZwpcee+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Ben Gardon <bgardon@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots
Date: Fri, 26 Jun 2026 13:54:33 -0400
Message-ID: <stable-reply-item009-kvm-510-p4-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112634.1778506-5-pbonzini@redhat.com>
References: <20260626112634.1778506-5-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269269-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:seanjc@google.com,m:bgardon@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 416B36CF8C3

> [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots

On 5.10 mmu_lock is still a spinlock. Hoisting it into kvm_mmu_load() means
mmu_alloc_shadow_roots() -> mmu->get_pdptr() -> kvm_vcpu_read_guest_page()
can sleep under the spinlock on the nested-SVM PAE path. The fix for that,
4a38162ee9f1 ("KVM: MMU: load PDPTRs outside mmu_lock"), isn't in the series.

Do we need that one too?

-- 
Thanks,
Sasha

