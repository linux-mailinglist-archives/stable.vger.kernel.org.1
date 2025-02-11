Return-Path: <stable+bounces-114900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038DA30927
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AD6188278D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958541F3BBE;
	Tue, 11 Feb 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFSyAug4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559381F193C
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271255; cv=none; b=c592Ggz0dF1mEBxtYRK4J7wvA7z/Y0lLsqMlYye12jjEXONi9j+Pxvm/VuB8HOkz/yZRqeO7VJKR6h88vwPt6D+dDsAjpkdfoEct5ZvOEgUpWNUJQ2s+UwKkR8AVx0FTszzmjA5CtTLqc2MbkP5E37aWWm75mADD+1JKEnOnc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271255; c=relaxed/simple;
	bh=gvR5Gc98h3L06ABJw2i/dOoJfPGho486AqmDRVgdMOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VB0xGSrb2vTpPR6UqpJwZJH8u0fA1hEXH9K399bOi3AUcMyfGrkdqY4MfD2L/xoeVO6HQiKySZGfu7EOiH6S4irg0EibMt+t4Bsu/iBBJTKW6pkgwxvgVLBHF9YAK3vn8vMXMzz18U5g05YIFYnb0jxzDIiXMxn1w23XdhiHUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFSyAug4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B8C4CEDD;
	Tue, 11 Feb 2025 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739271254;
	bh=gvR5Gc98h3L06ABJw2i/dOoJfPGho486AqmDRVgdMOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFSyAug4djM4VTvlW8FibumaKBvYyycTQ4EuBGQg8H5bkMvWCWMXnONvdHt9B5GFN
	 frKMeJW+8w7G1xoiQ8pt8HXhKr2tYRgSTe3qyynJDGh24UhvdfCsKtQV+KR7YBi8le
	 5diAMPikhsHrZSQl+TkZP0MHa42H5WEVw3PpoIbTSe5X1p13cJIwaSbrfMciwibS7U
	 4Cxb4ykpw3hkE1hZKRnB1LoNd6558478BJs4sy5ONvOV8Dw5f41i2YMROyaefMkbJz
	 rcwGCRmeMbGRN8qYD36jvOVbM4UIN4rAX0/0GWyYTtwrkJYKR7f5QREt8rlkzmpZbs
	 8qluE4hc/fEfg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1thnu7-002wLB-Uj;
	Tue, 11 Feb 2025 10:54:12 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	eauger@redhat.com,
	eric.auger@redhat.com,
	fweimer@redhat.com,
	jeremy.linton@arm.com,
	oliver.upton@linux.dev,
	pbonzini@redhat.com,
	stable@vger.kernel.org,
	tabba@google.com,
	wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 0/8] KVM: arm64: FPSIMD/SVE/SME fixes
Date: Tue, 11 Feb 2025 10:54:08 +0000
Message-Id: <173927124349.2205649.5810375580627240253.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250210195226.1215254-1-mark.rutland@arm.com>
References: <20250210195226.1215254-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, broonie@kernel.org, catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 10 Feb 2025 19:52:18 +0000, Mark Rutland wrote:
> These patches fix some issues with the way KVM manages FPSIMD/SVE/SME
> state. The series supersedes my earlier attempt at fixing the host SVE
> state corruption issue:
> 
>   https://lore.kernel.org/linux-arm-kernel/20250121100026.3974971-1-mark.rutland@arm.com/
> 
> Patch 1 addresses the host SVE state corruption issue by always saving
> and unbinding the host state when loading a vCPU, as discussed on the
> earlier patch:
> 
> [...]

Applied to fixes, thanks!

[1/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      commit: b671313b36591cab3d4cb4fe40ffdbac213635d1
[2/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      commit: f000c2b1bcb471e35bb65cc0f0c31cb18d8677d8
[3/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      commit: 82695cf636f155917eae61b9f86565184a683d76
[4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      commit: 8adb7db3c85f917ca59a76205e4be1ee82a289da
[5/8] KVM: arm64: Refactor CPTR trap deactivation
      commit: 1afdd3f832570aa27ae82819020bd319820337ce
[6/8] KVM: arm64: Refactor exit handlers
      commit: d59128af7ac954f80636548a60f1b1b41a7d067f
[7/8] KVM: arm64: Mark some header functions as inline
      commit: 03ce3e0db4f42252de4eeae01c5e5fa832af7585
[8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
      commit: 9a053b84b508b32b824d4a088cf3f5091a3e7c15

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



