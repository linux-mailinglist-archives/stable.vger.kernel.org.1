Return-Path: <stable+bounces-143257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28ACAB3575
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC347AE140
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66902749EE;
	Mon, 12 May 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SOXzQQjf"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F83254AFE;
	Mon, 12 May 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047679; cv=none; b=R4e1htY9fGuvrbcnT8+se+RSQkJX7uKPc9cMmKBQCsDVPCE9VJZnYmRrbM34J/2kKub4lFKYAJRR3hpHaooxiUGtQBp2oyx6gHSkLjjKDVK9TKLxgJES/if2xY7husjdwNSQooQIyrFea6RAwHKPgYycF6mqMMxGpVktIf1I81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047679; c=relaxed/simple;
	bh=YgwBukWEosEIHWzTEsDv8Iae7lg5GArJS4aQGtAZfN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ60vfGti6qZPQhfTAmXKPfgutvObMnBkQfvCGPfUXdaxpSui7UhKzulAYv3aUCm0zP4cwo8hGo7ycMqICBcVCXj3JvzOI703Up3FAUcwx5rBU498Y91wBoDCdWwVtGGiDjfpXEjxirP14ggjBEdU2512sXomyt5KBL9MWNd4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SOXzQQjf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 566C040E0240;
	Mon, 12 May 2025 11:01:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hCkH_1Sc274B; Mon, 12 May 2025 11:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747047667; bh=QKy89tNXgNFis/DTzsa49kV8LAatgNLvxLkLTbLtMQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOXzQQjfUzh0ZsJjQVsdz4u/Q2feLkgC9dHGooiJP2/NoWIh1lyvUwuWKTCSqd27W
	 0UBlCxD+8HbBifIkGFhRfoeCrupj2QfCdwlOk6lp2eEbwpZWaUvAu5eQNcVxytsM1a
	 HKYoJE/a1k051Uzwbg5vPYqDQQoO26756rdlxro4cMGphAQU9ILbf2QGuAcch6gBlE
	 8lXCkke3xw84Mxed8spj6kFaQ0Eprx74WH1IsVmefTiv2BZaOD8Uzr8YKxpQI3IHA6
	 k3oCD+f/fCjrNug8aCtTvcm5gUmK7cbsxm0xi9O/2btNJt8NXtZEt+Gf9Rh/Gxoc9P
	 TvHpKKvPuY002FwalJc5MvzNXCOVku6r77+FSm+uUfTrO0zFWmRd1OZBwf7QTnyAFN
	 6+v7FDJfnmYueF8nm7Ilh8wuYZLmpQJ3Xwz+i4MKuk0x+ylFunKlj75SMJdY0krOdG
	 NZKFPCC0D7c2mp+kWj8wTx9wOcJnNmcVuCAsg06qSa5xBIfEtHSm0LCyBus/Vx3/gp
	 5yQSAZ5UrtlIxS78adQWAb79H1zHcICSeVkbUZNuOwr/4l/avnUmiPOFhIadbQHYN0
	 xlZVWphz8slfyFNcUIDNTLvm6aNJzGBe4joL663Wzk2UrVpGoPVTF5ODAy/bTYlgNt
	 P3+Vw3G6wqKTlcN0TnqsmtSA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41EF340E023B;
	Mon, 12 May 2025 11:00:56 +0000 (UTC)
Date: Mon, 12 May 2025 13:00:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
	Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed-range MTRR exists in
 mtrr_save_fixed_ranges()
Message-ID: <20250512110049.GCaCHU4feKMhVUmcMY@fat_crate.local>
References: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>
 <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local>
 <0ec52e49-3996-48e2-a16b-5d7eb0a4c8a6@linux.intel.com>
 <FFB8ACEC-7208-40D0-8B57-EBB2A57DF65F@alien8.de>
 <1862275b-e7ca-4fa0-bdea-f739e90d9d22@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1862275b-e7ca-4fa0-bdea-f739e90d9d22@linux.intel.com>

On Mon, May 12, 2025 at 05:24:21PM +0800, Jiaqing Zhao wrote:
> Actually it is happening on virtualized platform. A recent version of
> ACRN hypervisor has removed emulated fixed-range MTRRs.

Oh ok, nothing urgent then.

Will queue it for the next merge window.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

