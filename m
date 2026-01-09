Return-Path: <stable+bounces-207901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC5D0BC63
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08A6C30215F0
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B563644A1;
	Fri,  9 Jan 2026 18:01:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F03314B9A;
	Fri,  9 Jan 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981660; cv=none; b=BgiG6qPpVWkssbVPvYn6kg2SPnae/nvz0ZguRdzxlYPGInGrPOTpC9c6XwMnaq9ZkN2Y1w1h8gQoR48S45jJWBveoaQVoCv9agg6FhKftqsZV1JxVAAA85rqp/3j30mIkUGqDWZErsWm5FrcIgshNtQzzYppubAxfau9qFTlRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981660; c=relaxed/simple;
	bh=wLfASfDrDHptAU185teXAL76JoE11LO/7SHwertbZWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owww3jeoQo7oGjRFShEmyxzjtgLHJyDpWDH2C8xqYwU4sGQ7zV+scM1gxUQSzBE4ukj9e1FucjmyHbxaCo9TAYecqDQS2O3Nw0N9WD0Ticup83XJblVvTis6f0LltmoSVClTlcdcFkgYD9G150MyILq6BNzEhiHMTYxnu7ez3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEDBFEC;
	Fri,  9 Jan 2026 10:00:50 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A458F3F5A1;
	Fri,  9 Jan 2026 10:00:55 -0800 (PST)
Date: Fri, 9 Jan 2026 18:00:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: rafael@kernel.org, pavel@kernel.org, will@kernel.org,
	anshuman.khandual@arm.com, ryan.roberts@arm.com,
	yang@os.amperecomputing.com, joey.gouly@arm.com,
	kevin.brodsky@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: fix cleared E0POE bit after
 cpu_suspend()/resume()
Message-ID: <176798145230.2606771.17247725038196582505.b4-ty@arm.com>
References: <20260107162115.3292205-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107162115.3292205-1-yeoreum.yun@arm.com>

On Wed, 07 Jan 2026 16:21:15 +0000, Yeoreum Yun wrote:
> TCR2_ELx.E0POE is set during smp_init().
> However, this bit is not reprogrammed when the CPU enters suspension and
> later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
> and there is no save/restore logic for the TCR2_ELx system register.
> 
> As a result, the E0POE feature no longer works after cpu_resume().
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
      https://git.kernel.org/arm64/c/bdf3f4176092

-- 
Catalin

