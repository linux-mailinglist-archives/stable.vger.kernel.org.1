Return-Path: <stable+bounces-244570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEh2HbmS/Gn3RQAAu9opvQ
	(envelope-from <stable+bounces-244570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:25:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BA4E9347
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE2230A0F55
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B33F7883;
	Thu,  7 May 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8HSypZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073F3F074F;
	Thu,  7 May 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160019; cv=none; b=hko5Cgxk9hN9SDaSNeezku+iQ8QES1jUne0Ro08YfWepSLN6WZLFcXUCtxlceA5006VE3TUMaqZuBcSmtpRhGWfyJKWiYJ7SiacOlpkATgCoQAkT7zYaSLuHljeuAhvazoYFyC7a0s7vP4LE6pE00hJgCOApX/1uptmLjaBqQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160019; c=relaxed/simple;
	bh=36ZswlSdEoa6CeQfZEQN8KqozyQBxq2eB7Tc0h/yYIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU1BNsKODfrxUWcVDW8jJ3cwmAOY2oT5rNyXgimQFFHq0tLJuqHFvESycezu8oACRdML/oYex8wcjtzb6N1TDz+fhiGmK2H1VsJhP780EqOjLtvjk8/wkodoOycw6q4qmEF/GwQpEKdpw9A14BL1D2NY9f2imIeLjpIcguxnwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8HSypZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11717C2BCB2;
	Thu,  7 May 2026 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778160019;
	bh=36ZswlSdEoa6CeQfZEQN8KqozyQBxq2eB7Tc0h/yYIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8HSypZiCPj9qsm8/i8LQ4YAD7nehVRteknpw9ph2arJnL2pPxB3EBmL3dAGahj9j
	 sZCTrYzPYsJOJY9lBy5ozrsDHwGQb3KkOUMzb/VDkwDPdRZfPH370snZJWPdDAfp/3
	 OvCtvvkrU/DtmwViqSqTnUCIq4uIJUdI+zMb6A8/wAinaOWvKJuFkRwGQdiVi/X1ps
	 oeUL7Sku6N7VAbfQcyI55LL+7j6vCP8GaVvHC8bcNAlI8i9oeEatjdfbFr9XZqEyHb
	 95CaKZp8yIJwE0UfTY4ab21x2T9drfmD//DwvU1HLGDnHWS6gNknjuVh45WFWLV7UY
	 Nj8i5My6W4B3w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyeG-00000000dmL-3G5r;
	Thu, 07 May 2026 13:20:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <tabba@google.com>
Cc: james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	qperret@google.com,
	vdonnefort@google.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	yaoyuan@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/6] KVM: arm64: EL2 synchronisation and pKVM stage-2 error propagation fixes
Date: Thu,  7 May 2026 14:20:13 +0100
Message-ID: <177816000554.2904218.14736928674688744601.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
References: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, tabba@google.com, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, vdonnefort@google.com, catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Queue-Id: EA9BA4E9347
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-244570-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 01 May 2026 12:21:43 +0100, Fuad Tabba wrote:
> V2 of the kvm/arm64 audit fixes [1].
> 
> Changes since v1:
> 
>     Patch 1 (SCTLR_EL2.EIS|EOS): Fixes: tag corrected to 0a35bd285f43
>     ("arm64: Convert SCTLR_EL2 to sysreg infrastructure"); the commit
>     message now explains that the conversion auto-generated
>     SCTLR_EL2_RES1 to UL(0).  Code unchanged.
> 
> [...]

Applied to fixes, thanks!

[1/6] KVM: arm64: Make EL2 exception entry and exit context-synchronization events
      commit: d7396a72eae795d7f968fb451237b6ac1616d712
[2/6] KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
      commit: 300fac4cc266b7782d88602b6b6a7faf31ce6405
[3/6] KVM: arm64: Fix __deactivate_fgt macro parameter typo
      commit: d4d215e5b81ba5acb17752cab12c514a8062bada
[4/6] KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
      commit: 5130d450d1488e62e1b5310f41910a3c7320e827
[5/6] KVM: arm64: Pre-check vcpu memcache for host->guest share
      commit: 8234409ffb656970e2f5b29e416f041419980bef
[6/6] KVM: arm64: Pre-check vcpu memcache for host->guest donate
      commit: effc0a39b8e0f30670fe24f51e44329d4324e566

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



