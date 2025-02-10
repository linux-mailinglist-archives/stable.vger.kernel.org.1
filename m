Return-Path: <stable+bounces-114733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFEA2FDC6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C4C7A3626
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D32586DD;
	Mon, 10 Feb 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGtNENBk"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8B1CAA8D
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227885; cv=none; b=RqV+QuM9xquBijIQqBouzA5aPhHahrJzaul7/QSa2rdemmIwcdtL0Zy5BuhWyJLMcyfo0F/KOdZRmM6klm4VSZ20IvsuIXQpYD8SEasWpp/hgPWpAptOV0bjnaj+lCbdxo8dnXyAmQAQN1bYW5HG1OfGMQ+gGzOllPOmRwKpc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227885; c=relaxed/simple;
	bh=wpwCSU2p1UPn17FovjXnm2huKpEMnGssUTZLuIcZOgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWsq4NgU81MhBh5AphxLWNTYEOHutSVqEX7ZvYXJyCVbXCeHNbb989Dzms1ngySZ0Psakv4RrswTziMUTJY549jioA7afzJ/qj7ghWTyMjPwute/gndvxjpmM1O8DHUMlzjENPq8roHCyjeQPuK4eBixjt2Le3AbJRXZhGnuWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGtNENBk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Feb 2025 14:51:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739227880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4q8A/QNPo7f3delSEdi+al1Uy+9aScXUwI7BSMw6+q8=;
	b=HGtNENBkTFlyb6xBS1L8/B0qGpQouXyiWEflyGuIGHh+KvDndIZ7P+hpHQ0t3S47KUZcRS
	toE1B/HsviDHWSl/SGgcg1si7hu7DKHqIFd3FsKKWH151bCKf0lxu9IV6+Xx54fjYze3hA
	kLR2lsexxEq71S9yFlJb84I/XvY91KI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com,
	wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH v3 0/8] KVM: arm64: FPSIMD/SVE/SME fixes
Message-ID: <Z6qC4qn47ONfDCSH@linux.dev>
References: <20250210195226.1215254-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210195226.1215254-1-mark.rutland@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 10, 2025 at 07:52:18PM +0000, Mark Rutland wrote:
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
>   https://lore.kernel.org/linux-arm-kernel/Z4--YuG5SWrP_pW7@J2N7QTR9R3/
>   https://lore.kernel.org/linux-arm-kernel/86plkful48.wl-maz@kernel.org/
> 
> Patches 2 to 4 remove code made redundant by patch 1. These probably
> warrant backporting along with patch 1 as there is some historical
> brokenness in the code they remove.
> 
> Patches 5 to 7 are preparatory refactoring for patch 8, and are not
> intended to have any functional impact.
> 
> Patch 8 addresses some mismanagement of ZCR_EL{1,2} which can result in
> the host VMM unexpectedly receiving a SIGKILL. To fix this, we eagerly
> switch ZCR_EL{1,2} at guest<->host transitions, as discussed on another
> series:
> 
>   https://lore.kernel.org/linux-arm-kernel/Z4pAMaEYvdLpmbg2@J2N7QTR9R3/
>   https://lore.kernel.org/linux-arm-kernel/86o6zzukwr.wl-maz@kernel.org/
>   https://lore.kernel.org/linux-arm-kernel/Z5Dc-WMu2azhTuMn@J2N7QTR9R3/
> 
> The end result is that KVM loses ~100 lines of code, and becomes a bit
> simpler to reason about.

LGTM, although a minor nitpick would be to repack the host data flags at
the end of purging SVE/SME.

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

