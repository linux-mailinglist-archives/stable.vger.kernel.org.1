Return-Path: <stable+bounces-108023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6834A06245
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EE3A661E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB7201264;
	Wed,  8 Jan 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi2PdbOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F17200B85;
	Wed,  8 Jan 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354347; cv=none; b=EY9AmgEr3WBM5oz2dZOq0c7u8eUTpOWnCT3MFXhLuaZohpwInpx+VVDiDcyL7tconX5rQ4EbZHpzTxZT34SvGxUPC8YvhprKxzUpCAuczPf3L/oU/nbSYe5vEm0+TWeZ/WmITEPj8lS90l1cdkJgwciouGQlZ9MaPvYccdjf7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354347; c=relaxed/simple;
	bh=9n73VRAg92lJzjOneubPEnzgsMyJ10eVPaHaUXDovVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/HJUMSbKbNKixqXs6PZh6DtZE0PqXb5FqrFTL08OUN37vamDAZ4yTh4UyCf33gxlmjFdwWsBJIi+nYdrBGW8kE3kPhyz+znP10UxAjc52S8MQuaGtXeiaQRQoYHiOCvE/GN+7R3AwLT8CJTgeZnFmlasPqYii0cMsEOwLLy1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi2PdbOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5CCC4AF0C;
	Wed,  8 Jan 2025 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354347;
	bh=9n73VRAg92lJzjOneubPEnzgsMyJ10eVPaHaUXDovVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wi2PdbOqqmQI6sc7idiKNc/tDJ8VFvnhPsxMGKur/N5pkBefJkn61CRcL/hL8U6bW
	 0R3M657MO5iVCYJpuDpe28ci0gm4pHM3/uZkHMh3GePlNAjn+As/Zo5OnKjIMVgO3k
	 UW8d5/8YLvnHEC0FURPjUZGkO1oa3XeX/XMte5tFmxWyPjy3RJEFLs/1GaWm686q1D
	 i7vmwMlBCe9z/JRw/KlpdPVgyVK7G9HxgHeoqA1aWc1su3Zt9hvLbH9ti08zdq1D2q
	 dWFKYxtcCy4V7cuR+yTw0AERfbx9i3nqXmx/f9k4nUSBtXRChedHzhApnmeSZ6qfW4
	 rNTlBx+8Uxbxw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64/sme: Move storage of reg_smidr to __cpuinfo_store_cpu()
Date: Wed,  8 Jan 2025 16:38:52 +0000
Message-Id: <173627015564.294742.14608056095112096112.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241217-arm64-fix-boot-cpu-smidr-v3-1-7be278a85623@kernel.org>
References: <20241217-arm64-fix-boot-cpu-smidr-v3-1-7be278a85623@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Dec 2024 21:59:48 +0000, Mark Brown wrote:
> In commit 892f7237b3ff ("arm64: Delay initialisation of
> cpuinfo_arm64::reg_{zcr,smcr}") we moved access to ZCR, SMCR and SMIDR
> later in the boot process in order to ensure that we don't attempt to
> interact with them if SVE or SME is disabled on the command line.
> Unfortunately when initialising the boot CPU in init_cpu_features() we work
> on a copy of the struct cpuinfo_arm64 for the boot CPU used only during
> boot, not the percpu copy used by the sysfs code. The expectation of the
> feature identification code was that the ID registers would be read in
> __cpuinfo_store_cpu() and the values not modified by init_cpu_features().
> 
> [...]

SME is still disabled, but this is straightforward enough and I don't
want to lose track of it so I've applied it to arm64
(for-next/cpufeature), thanks!

[1/1] arm64/sme: Move storage of reg_smidr to __cpuinfo_store_cpu()
      https://git.kernel.org/arm64/c/d3c7c48d004f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

