Return-Path: <stable+bounces-260199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4mtBAsyXIGoe5gAAu9opvQ
	(envelope-from <stable+bounces-260199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 23:08:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A363B51C
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 23:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oBlRaD34;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260199-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260199-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7396830818EE
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A848C8AB;
	Wed,  3 Jun 2026 21:06:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1048C8DE;
	Wed,  3 Jun 2026 21:06:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520817; cv=none; b=BWA7JejOSLLsNGyqQDX8fO58WDoaPQ46Zzpzf9yoVVEV66EaOmUM0EIJcihG/l7+nVyLkSAE+ke4WKAAbyR2lblvuiu0qT3H5wbZi/cU+hNKKz6WwUpBwPMK3/SYoVhCQvIl7DhUrr+jhdFzxM7MH0uJdkzloshup3mDYPwaFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520817; c=relaxed/simple;
	bh=lAkQ/QBLFkVioqbuX9FJ8HVGyg7zuNtJxUcElNByQbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVhCRrrrUFCkdId9ggpYPMUQHVyTcRWQp4yERrC2hsDMSVFSko39mxSnnOmdF824w13vRiQwYZlbWkLJ7lEIE8JBAtRt2J7rjbqdiqrjKjj7YjlT4H838tpBFzA8wcBZg10p6Cc5nLKYGnazDz86SPNpfacffG/ccP376UWB5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBlRaD34; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1406F1F00898;
	Wed,  3 Jun 2026 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780520815;
	bh=0A7+X8eZmyoc1i4vmgDGETla0lDDfCLzGK/eA0mNZd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBlRaD34vBZeBpEWh0RDka5ZDK3j5ozFHCbAA05jkVVLGjJLORfEbxZ92A0YzicD0
	 89Z4ICbuLLj2HW54kbtlNPSF+QkCYc8v/6sUsaE0m5ustrSkJbYt/kf2FlfiwD0rnP
	 xiy/iuHuywYn47LXn07o1dBzUflfiAxP794zI2l9sjcexFyJeqsBPG0HXdJEPl14A0
	 4keVct/og4eG15+4kydngH/fVOQsRQ9NM/NJ/IFWqCDPoohWTMqpcyu5ShpfIy1ZPk
	 t801mSQbW1dWFOJrR1aqiNaGEYaGMWUSS3PEqcgDuqiut6ljIQWo/Te4CePTcuiu4m
	 YOI/dZlIb9xfg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	broonie@kernel.org,
	james.morse@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com
Subject: Re: [PATCH v4 00/20] arm64+KVM: FPSIMD/SVE/SME cleanups
Date: Wed,  3 Jun 2026 22:06:28 +0100
Message-ID: <178050185086.377054.3392422151485171644.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:mark.rutland@arm.com,m:catalin.marinas@arm.com,m:kernel-team@android.com,m:will@kernel.org,m:broonie@kernel.org,m:james.morse@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:stable@vger.kernel.org,m:tabba@google.com,m:vladimir.murzin@arm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[will@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-260199-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm64.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 979A363B51C

On Wed, 03 Jun 2026 12:06:10 +0100, Mark Rutland wrote:
> This series cleans up low-level FPSIMD/SVE/SME state management code,
> making it easier to maintain and extend (e.g. adding SME support to
> KVM), and enabling better debugging (e.g. by making SVE/SME save/restore
> visible to KASAN and KCSAN).
> 
> The first two patches fix a couple of latent issues that don't seem to
> have occurred in practice so far, but would be good to fix for stable to
> avoid any future issues. The rest of the series is purely cleanup.
> 
> [...]

Applied to arm64 (for-next/fpsimd-cleanups), thanks!

[01/20] arm64: fpsimd: Fix type mismatch in sve_{save,load}_state()
        https://git.kernel.org/arm64/c/ae24f6b06e90
[02/20] arm64: fpsimd: Fix type mismatch in sme_{save,load}_state()
        https://git.kernel.org/arm64/c/247bd1539050
[03/20] KVM: arm64: Don't include <asm/fpsimdmacros.h>
        https://git.kernel.org/arm64/c/79e66bb7e8b4
[04/20] KVM: arm64: Don't override FFR save/restore argument
        https://git.kernel.org/arm64/c/dc2337625880
[05/20] KVM: arm64: pkvm: Save host FPMR in host cpu context
        https://git.kernel.org/arm64/c/da20bb4bc5e6
[06/20] KVM: arm64: pkvm: Remove struct cpu_sve_state
        https://git.kernel.org/arm64/c/afd7af2b56ec
[07/20] arm64: fpsimd: Fold sve_init_regs() into do_sve_acc()
        https://git.kernel.org/arm64/c/3efb6c7f22c6
[08/20] arm64: fpsimd: Remove sve_set_vq() and sme_set_vq()
        https://git.kernel.org/arm64/c/e0cde2d2bb1b
[09/20] arm64: fpsimd: Use assembler for SVE instructions
        https://git.kernel.org/arm64/c/f27fe9aa2d06
[10/20] arm64: fpsimd: Use assembler for baseline SME instructions
        https://git.kernel.org/arm64/c/db9d63eafeba
[11/20] arm64: fpsimd: Move sve_get_vl() and sme_get_vl() inline
        https://git.kernel.org/arm64/c/3f26d7c6544c
[12/20] arm64: sysreg: Add FPCR and FPSR
        https://git.kernel.org/arm64/c/36a1d1726634
[13/20] arm64: fpsimd: Split FPSR/FPCR from SVE save/restore
        https://git.kernel.org/arm64/c/1277531fca43
[14/20] arm64: fpsimd: Move fpsimd save/restore inline
        https://git.kernel.org/arm64/c/890712d4507b
[15/20] arm64: fpsimd: Use opaque type for SVE state
        https://git.kernel.org/arm64/c/e1b163e40553
[16/20] arm64: fpsimd: Use opaque type for SME state
        https://git.kernel.org/arm64/c/eb1a68a00c0a
[17/20] arm64: fpsimd: Move SVE save/restore inline
        https://git.kernel.org/arm64/c/2768101b3976
[18/20] arm64: fpsimd: Move sve_flush_live() inline
        https://git.kernel.org/arm64/c/18618d9ea1fb
[19/20] arm64: fpsimd: Move SME save/restore inline
        https://git.kernel.org/arm64/c/bfdfafd90720
[20/20] arm64: fpsimd: Remove <asm/fpsimdmacros.h>
        https://git.kernel.org/arm64/c/987ec51e1841

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

