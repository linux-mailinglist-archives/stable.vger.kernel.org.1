Return-Path: <stable+bounces-114246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331CA2C2AA
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BCD163A30
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EC1E00BF;
	Fri,  7 Feb 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4k02v/5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553B1DE2D7
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931277; cv=none; b=BjI0YCGeF0DrtLLUA7KnUS5L2XxWBiTL1UXTeqSPNEwloMUtLiXnMhWj6xLHYjprQgn3rtNslxEMx5tMDZGtm3hQqFm4YZUWOoryCBrS2W+gq2QKI5Xl9oSuFlMS1MF9HVvp1EHBKxgCdPzBPBZhpXyArgK0kxIqQDMlBjaz/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931277; c=relaxed/simple;
	bh=KWnPB6zuXy/776k253D59EufsU+hz6oBJ8gyes5fs6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHPn5ZxN1JFVnc5BjiIeWbcoCl/FolR6QG8ng85MkLUuLKa1ApS/Zz3PZrIwNlIz1PatKG5+Pa45ft24Lg/tahCDKy5ER0TbN1gSeCaQYVTjtBRl8qqa8j1wrOzBr3I8t1HN10Mvs6k9r3+H+5Oau3nPLs4PBt4O6mghtEDQiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4k02v/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA915C4CED1;
	Fri,  7 Feb 2025 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738931277;
	bh=KWnPB6zuXy/776k253D59EufsU+hz6oBJ8gyes5fs6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4k02v/5T98DgihBHBpoSWTjgEhAPUjfe35Yu0xqImMpHlm3lRSGzCuI2yqNXQPpH
	 2XbuaNr97G4pWq1zBq5ztaL31Px0cs66UVmu0NaKM6Py8+ljdmwWnJbmeaTUuqYBKI
	 pmrr0wHwpXV4qe63+Twa76/v43tDEd1vEgU7arK/b5U8877wLthoAhOlGl7Go8AUsy
	 al9CTWC6j4lfYrbQiH+EkJzKXZpADqVHw8MXQ5wYwFg8Q6P30yMRNwkIbt5uxcPVOQ
	 QA3frlYUE71HVgJN5xjSQsTCC4Aiw3Ksa8y8OLJkEorjZbs7hGvD4Mz/X23opWQfOP
	 sgN3Byw39M1bg==
Date: Fri, 7 Feb 2025 12:27:51 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 1/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Message-ID: <20250207122748.GA4839@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-2-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-2-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:10:55PM +0000, Mark Rutland wrote:
> There are several problems with the way hyp code lazily saves the host's
> FPSIMD/SVE state, including:
> 
> * Host SVE being discarded unexpectedly due to inconsistent
>   configuration of TIF_SVE and CPACR_ELx.ZEN. This has been seen to
>   result in QEMU crashes where SVE is used by memmove(), as reported by
>   Eric Auger:
> 
>   https://issues.redhat.com/browse/RHEL-68997
> 
> * Host SVE state is discarded *after* modification by ptrace, which was an
>   unintentional ptrace ABI change introduced with lazy discarding of SVE state.
> 
> * The host FPMR value can be discarded when running a non-protected VM,
>   where FPMR support is not exposed to a VM, and that VM uses
>   FPSIMD/SVE. In these cases the hyp code does not save the host's FPMR
>   before unbinding the host's FPSIMD/SVE/SME state, leaving a stale
>   value in memory.

How hard would it be to write tests for these three scenarios? If we
had something to exercise the relevant paths then...

> ... and so this eager save+flush probably needs to be backported to ALL
> stable trees.

... this backporting might be a little easier to be sure about?

Will

