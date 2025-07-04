Return-Path: <stable+bounces-160219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC17AF99F9
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 19:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4ED1C82538
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272D2DAFB2;
	Fri,  4 Jul 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiOO0OYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896692D8397;
	Fri,  4 Jul 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651071; cv=none; b=SdkQQcTP9VaO6PtXL1KYKW/7+UJNu0e/buRmKVE6zrUDfc6qL62S76NG4ADJJt7fkSnn2JZ4NFfpZWL9UkuRiajOuBoITLqOiqmyN2R+usqGmNw9gTxSSchW5NRLJPmMQExAhIKaAgsCBkuXaVmNlunk0KJwZPeDdv4K8hvqt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651071; c=relaxed/simple;
	bh=iQPCag/CMmrdNN8jXkXcdi2pgaLZRiU1dC347/6lGyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OllxxTLeebsa6EVeQ2V4IFC3In48oKCVxmdXxyr8LXSOjZU51z0LLHzj5stngXEIiO7cQgD1CGDxLLJ+612gN2jOZGVxrGn0gNQilyAUeRE3b4xTjvb9TcXoubaSj7tbzFzUdsXeG8tqSpWIAco1bWvKmSn87lAH+QizX3YRFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiOO0OYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C00C4CEE3;
	Fri,  4 Jul 2025 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651071;
	bh=iQPCag/CMmrdNN8jXkXcdi2pgaLZRiU1dC347/6lGyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiOO0OYDfD/dMXIc9qXQXmd9E49UqynbdXyiwZpN6JIZW9Y6TCi2xZtoinpXAkEu7
	 i57ljCLpi0Z5d7grd73b+sBnzu8IQ3GrUROu8nxThQnAvQdEt5jYd4UJDfmRDMmfG5
	 UVIeXIQi5TbJjhdCoiJDEJsWJEAeeCjO8u9zHCVx4EMzO7S9jM+C3EUv4Yz10hmUqU
	 b1KVXxC+CyjrpxuMQFRcdqM0ed+MaHdqiQUiZgZWin6pi/DKmQbDJ7zWlw+/M/pgno
	 74FAsH0+nCIgCHQBfU+2Xlb6ihVj/NizjbkrfL0adDtMvebLZ0zPr8B25RV0/7qOUx
	 3NDwxPCoPj8XA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Filter out SME hwcaps when FEAT_SME isn't implemented
Date: Fri,  4 Jul 2025 18:44:10 +0100
Message-Id: <175164333073.1188085.16117765198083829346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org>
References: <20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 12:28:48 +0100, Mark Brown wrote:
> We have a number of hwcaps for various SME subfeatures enumerated via
> ID_AA64SMFR0_EL1. Currently we advertise these without cross checking
> against the main SME feature, advertised in ID_AA64PFR1_EL1.SME which
> means that if the two are out of sync userspace can see a confusing
> situation where SME subfeatures are advertised without the base SME
> hwcap. This can be readily triggered by using the arm64.nosme override
> which only masks out ID_AA64PFR1_EL1.SME, and there have also been
> reports of VMMs which do the same thing.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Filter out SME hwcaps when FEAT_SME isn't implemented
      https://git.kernel.org/arm64/c/a75ad2fc76a2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

