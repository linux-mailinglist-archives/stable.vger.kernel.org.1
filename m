Return-Path: <stable+bounces-187832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A01BCBECCFC
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360E41A624EB
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3027C162;
	Sat, 18 Oct 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aAPoz2/M"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B27483;
	Sat, 18 Oct 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781832; cv=none; b=FLQqDmQG4ElZbg/Dx/nE139+CClxXP0dgFWeWh2DZVDvwEd6TvPzRl47FIj1n9SROo9qXfvEdsx/sKSJj99yRO27haiDx5YWL1csr7ALPqSe9GHBPqOnzETkRYxOIM1Vlnkmj619V59vQhM6vIEq5qeoS8T+e50NyEe0EtFJ3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781832; c=relaxed/simple;
	bh=O0668T+ntdxEbSvRBGVIqs4jNLbq5DoSt+5oysBAy+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m07sjMWlQIsliA0fgvhCyrJqFT5HAV2zkNZhZ6TCo65sxUcrPhLSeGktdTWb35xvKiHFdySGyHrs6lRQkpiW3GW8EtOdtOW7blyozYsl4rY3LwK+KimRtNDSlo6sIWcTJhvZ0hEW/INlfBK1Fq84Zp8XfPTyDkstWQxzJ2WiN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aAPoz2/M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06FF040E015B;
	Sat, 18 Oct 2025 10:03:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TA5B3iM546RC; Sat, 18 Oct 2025 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760781819; bh=3L2KwGP6/ZC+BSnaiYXESmM7V7g7tJOrCI6I1Ptu18k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAPoz2/MgSQSLqZJxw6WHIOgqnujPQuOcUkAxkw8LHZlmJb7fa7JZBHzpyJYjp+Rj
	 HjzbzhVnzH7iU7UFnmd1SPFygA2lCZDidb/IIWJzEZRnARKtgjB/lP4cKhHS1qqtR9
	 4Zqr2FWk8+hIhlOse3OLhkqT9TUWuhcAKtA+8wiypV+LQFyUDqwbAGvGW4Ou9oILBN
	 O8ZqBC8sIowIkH6yFsI2qmOb2jgiY6VY0P2ny4oi7Cj+s3j7DAsiOmsB/1Y01wTIe5
	 1Y15gy3YWbnx1ZCrIcEE1/4cJHBZdx8mD8uKP9OmOWTx4HbmM0LRmu1Q5WWM+W4SdE
	 tojopAqNE31vE5KF9lXIDcxmlnbgVC3++gAn+dmh5oA79gqDrxE+Xv25Sq6G6Ncao9
	 skiWpQPdKaghzXfc7w6E2NJOxWbwUqB8VwJL2PFvoNj8tR7yNm9vjaW5n2S5gbxr2w
	 vOPrxBqAndMzgksqZoE79i5lh09631Iys78hhIxZl4R6KtT+WObY8B50dbNDrO/pm1
	 09LMHMV1G3d5QCA3FZVVnYTtD3pcB2FmcQIizMND9AP2msKiPUI7gIaWLRNob8jIS+
	 gexJT84xIBO80c8KVIMJDuPo/fr0dsouShfXp+070pCig3W2LUEU3bXXaF3vo7ikAw
	 JETjof8euzNvpXMqLU6vlL+I=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 58B4B40E00DE;
	Sat, 18 Oct 2025 10:03:23 +0000 (UTC)
Date: Sat, 18 Oct 2025 12:03:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	peterz@infradead.org, mario.limonciello@amd.com, riel@surriel.com,
	yazen.ghannam@amd.com, me@mixaill.net, kai.huang@intel.com,
	sandipan.das@amd.com, darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <20251018100314.GAaPNl4ngomUnreTbZ@fat_crate.local>
References: <20251018024010.4112396-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251018024010.4112396-1-gourry@gourry.net>

On Fri, Oct 17, 2025 at 10:40:10PM -0400, Gregory Price wrote:
> Under unknown conditions, Zen5 chips running rdseed can produce
> (val=0,CF=1) over 10% of the time (when rdseed is successful).
> CF=1 indicates success, while val=0 is typically only produced
> when rdseed fails (CF=0).
> 
> This suggests there is a bug which causes rdseed to silently fail.
> 
> This was reproduced reliably by launching 2-threads per available
> core, 1-thread per for hamming on RDSEED, and 1-thread per core
> collectively eating and hammering on ~90% of memory.

Which version of RDSEED was used? 32-bit perhaps? Can you repro this with
the 64-bit version of RDSEED?

> This was observed on more than 1 Zen5 model, so it should be disabled
> for all of Zen5 until/unless a comprehensive blacklist can be built.

As I said the last time, we're working on it. Be patient pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

