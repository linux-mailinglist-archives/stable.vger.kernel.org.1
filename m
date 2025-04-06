Return-Path: <stable+bounces-128423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5DA7CF7D
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 20:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E472616A53D
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECD19CC02;
	Sun,  6 Apr 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI4hyVwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9A130E58;
	Sun,  6 Apr 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743963824; cv=none; b=h8LAyQZRiqLzIEq0dXw8spaFnvv4Lwb3y+Az+GpWcwwP8JcfN7DSZiys38m8wkCVDBifYw9Xidv6kWO3PV2BDlaC1MTlSrmoHdRLiAR8Ci31vJIqwh5QmStHHXs5mPhQKOGdc+rhQ1YvtXl5nnH3LPEeiMfCe1e5WL7SgJrNpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743963824; c=relaxed/simple;
	bh=hIwAtHENInLtBpsFxK+X5pk0U9zzW/RsOpqlXmUAH7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl5m0zGPODfnYItJKcc0ElFz0P/gdstpwXCb4SYn+C8VbTYMTEhpi/yTjGMU8ppGecY2nVKR81Qt5bjjnfdihoE1q2k8lY8MRi2LJKv4OgGIik4EdJkXZDeZdsJm1Ykj48ThXok0CtDbhnUwWLTk/7vOv/zkPjXJdLSOobpvXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI4hyVwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E255CC4CEE3;
	Sun,  6 Apr 2025 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743963823;
	bh=hIwAtHENInLtBpsFxK+X5pk0U9zzW/RsOpqlXmUAH7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI4hyVwUy5vQqnn7Bqy41q533twUQFJFiQ1W7WQFq9suTH3neSoLWt5gG/x7LW+MP
	 dIxF++RBbW7ZM+TMU7nySIiquFGaTBEkgHx4AlHgr5d7q5R5gdGc47BA/uZRRny+JR
	 +j7iA0iRipiuKUvc/+g9enmxhCPwfII65THxnpVz/ylbLejdltPW8YCXbVpETOnxr+
	 rK+mvk7fF3VnasaDnQN3UnTz4opl1N2OISc9Oz8KZ5tcQdStGhzi8p1KXo1hX+I74t
	 Py/izx09XyGVc5jI1Rwt/UjTIxsvVdmu7QHM+a0DMzmItv/jBWRT5pYdZy3JwvARp4
	 sWVQW57aWdH3g==
Date: Sun, 6 Apr 2025 20:23:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Roberto Ricci <io@r-ricci.it>
Subject: Re: [PATCH v3] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Message-ID: <Z_LGqgUhDrTmzj5r@gmail.com>
References: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>


* Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz> wrote:

> The current implementation of e820__register_nosave_regions suffers from
> multiple serious issues:
>  - The end of last region is tracked by PFN, causing it to find holes
>    that aren't there if two consecutive subpage regions are present
>  - The nosave PFN ranges derived from holes are rounded out (instead of
>    rounded in) which makes it inconsistent with how explicitly reserved
>    regions are handled
> 
> Fix this by:
>  - Treating reserved regions as if they were holes, to ensure consistent
>    handling (rounding out nosave PFN ranges is more correct as the
>    kernel does not use partial pages)
>  - Tracking the end of the last RAM region by address instead of pages
>    to detect holes more precisely
> 
> Cc: stable@vger.kernel.org
> Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")

So why is this SHA1 indicated as the root cause? AFAICS that commit 
does nothing but cleanups, so it cannot cause such regressions.

Thanks,

	Ingo

