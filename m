Return-Path: <stable+bounces-217439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAz0EwAQl2n7uAIAu9opvQ
	(envelope-from <stable+bounces-217439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:28:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A815F101
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753823058572
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763B31C567;
	Thu, 19 Feb 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iup8LWX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3D33A9C1;
	Thu, 19 Feb 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507646; cv=none; b=rKea9swOiR2JMmWWiJeto96GVCLPAvgRoCZ+d7zRhlrT6FYjnXoLOJDGK+NvbP6qc1VVcE9mnomp+DU4TXCKD3NMkTEW4bF30QNYsPn2Fp2SyeaJCkcHZVHR7UWLeiFlnoXVGD/ps8+ExdpOzn+BNrDgDEMV3PrLkuAX4BEsEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507646; c=relaxed/simple;
	bh=dCrBPubZIKcbvmgILfm1PhzeloMsfYN/6KzdN4upxjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlyLTMYHYPbJzPspoxD6aWrKXszhj+M6gTFhLpJhBQh8VbSvy+IAImGFxk8959hDlOTlDyviu7NlC6klb7NPUyZ3pKdYTSy2+n6vUVGW/tNxFFT1ri4odbt0XhmL6xKgs9nB5uJ8X7ItqBYbsIHrRwRg7SESITpOEpbZS94yW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iup8LWX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06406C116C6;
	Thu, 19 Feb 2026 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771507645;
	bh=dCrBPubZIKcbvmgILfm1PhzeloMsfYN/6KzdN4upxjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iup8LWX8ognOvISD9w5llksSOwW3xkoq4ytdQwtwtRTKriqn1u6/Aj9VxoXNDsEsi
	 /0ndxj7apEWcVsezZ02z/cffyAh+UW4Uu6qoTRsLIHwNxalzk5aWXbdhVod0HoOFXA
	 thvLOmgzaa9+T3j7FlxQ4LT/7K00Yxs8bLoN26iSv2gIGxMv/aIbnwrueSmUvTf2EF
	 d+eH1gqbQdqHtWOFaSPtkOKTFjupXJteyxM1fE9CRAavnF+BdgfZXkdPPIvAP9CP7u
	 ryttfjXpMtj49qm1aAYuUkzwTrtQnVinGEI9p/J+HitNp7Ck/lnaMp8LIO2wo+qy0p
	 akI6aeJNUaX/g==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Hyesoo Yu <hyesoo.yu@samsung.com>,
	Quentin Perret <qperret@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Force the use of CNTVCT_EL0 in __delay()
Date: Thu, 19 Feb 2026 13:27:13 +0000
Message-ID: <177150437545.2426887.1189373653228730903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213141619.1791283-1-maz@kernel.org>
References: <20260213141619.1791283-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217439-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm64.dev:url]
X-Rspamd-Queue-Id: 9F6A815F101
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 14:16:19 +0000, Marc Zyngier wrote:
> Quentin forwards a report from Hyesoo Yu, describing an interesting
> problem with the use of WFxT in __delay() when a vcpu is loaded and
> that KVM is *not* in VHE mode (either nVHE or hVHE).
> 
> In this case, CNTVOFF_EL2 is set to a non-zero value to reflect the
> state of the guest virtual counter. At the same time, __delay() is
> using get_cycles() to read the counter value, which is indirected to
> reading CNTPCT_EL0.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Force the use of CNTVCT_EL0 in __delay()
      https://git.kernel.org/arm64/c/29cc0f3aa7c6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

