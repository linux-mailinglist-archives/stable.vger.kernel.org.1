Return-Path: <stable+bounces-139481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D6AA73B6
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 15:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F4D162F84
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD40255251;
	Fri,  2 May 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oqamq4ql"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDB25525C;
	Fri,  2 May 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192678; cv=none; b=iwQd/zyCkdwrWOdAAedVqVGvfypO5dApWOdkSwb9fT8medN68v/XjWjJcH30os5fec13aiTzdsYiaS/HbM9aons2+rKPH520XP3Y2mp7iuZbVAi0Z7olpMpuO7mr7IAq8hF3/Yggx4CaQg2LVN4O/YB+uLUh2+1DhlVhambJLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192678; c=relaxed/simple;
	bh=ceItz0NSonxwZNsg0HKxcB2b92rRQMtHm+5vyEc1fiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSVtxQU9AYIEbKE7p+L0dHMATUOY51/IUAEPtkXGvfIln0umAAIEuq0kSnm3MryubNhtCqP8a2clXucpk6FtdpDAD07OOWi+Do737rwF4KSnC2Fi6OgkxThCPOMtYDTnEpLdLltkU8k3oOpvDlo1lPiMNBmvj2P57GvTFM25zYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Oqamq4ql; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 779D940E01CF;
	Fri,  2 May 2025 13:31:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bSZneCzSyNAU; Fri,  2 May 2025 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746192658; bh=yUaue560YkltyOlDG0wH62GcwgC5OBuxzVya6sKvsug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oqamq4qlI7br9n5Wd3igLSUN52Oqi154+I/XEpufXyQzY89hKLUPg0BVnjkQXft7l
	 UZo4Pya0eF+nHC5QI3AEidSN4ivSJbilDTAjd5H9zPx9sXR5KqGM+/9A1AlHCMia1w
	 8wsiqbkIgZxoZDE5PHOm0YkgotZ+YBQVCw+bqNEzuYuBjW90jWBjZsxzLuO1+7s70n
	 qQZ0Xc7Kbsu1FD+MMzGBmBpQAwP6iweMZu0nLZ1RM9uV5FOfkPOqseONVHej5WM+db
	 rw3jIh1HGCJ8UCGbpFjdeIswVFefh6KHfczz3fgWs4iAH/TIadtANJDwlDnPYVKjH0
	 UlZ/ibOIq+/khKozqesbiuZ6Rj8E54KvYOWfDQoLimYvm3+fg7Tx24F6G/cyJVOG0g
	 Fjxn53yGtx/yA7X6atX57UuXLrrQbyse39OuUoOtWSCJY1OwFgvbmTzC6l8B3CcKwa
	 r6RZL5/bLtc5a8M484Hqm88kEoXTtSd/Q3czfvtzM3byaTrfjuCahH/LRxB8nwjcs9
	 GS+jZAs0TkGRjMa+WtyW1CYLmM+f+L/56wJojZCu/ePjN+lRXy3dYQoeFjyj7WsLWP
	 NRIfuuh0RQb111hd3SFtfcBMhj82LCQeKKyNBdyvcSyax/pmEJYKYo9+toO8V7ZXOK
	 pdmGk/nNVdi4Ir5g7G+OLe14=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4775940E0206;
	Fri,  2 May 2025 13:30:43 +0000 (UTC)
Date: Fri, 2 May 2025 15:30:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v3] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250502133032.GAaBTI-AsaIVn4hOS8@fat_crate.local>
References: <20250430231738.370328-1-Ashish.Kalra@amd.com>
 <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>

On Thu, May 01, 2025 at 08:56:00AM -0500, Tom Lendacky wrote:
> On 4/30/25 18:17, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > When the shared pages are being made private during kdump preparation
> > there are additional checks to handle shared GHCB pages.
> > 
> > These additional checks include handling the case of GHCB page being
> > contained within a huge page.
> > 
> > While handling the case of GHCB page contained within a huge page
> > any shared page just below the GHCB page gets skipped from being
> > transitioned back to private during kdump preparation.
> 
> Why this was occurring is because the original check was incorrect. The
> check for
> 
>  ghcb <= addr + size
> 
> can result in skipping a range that should not have been skipped because
> the "addr + size" is actually the start of a page/range after the end of
> the range being checked. If the ghcb address was equal to addr + size,
> then it was mistakenly considered part of the range when it really wasn't.
> 
> I think the check could have just been changed to:
> 
>   if (addr <= ghcb && ghcb < addr + size) {
> 
> The new checks are a bit clearer in showing normal pages vs huge pages,
> though, but you can clearly see the "ghcb < addr + size" change to do the
> right thing in the huge page case.
> 
> While it is likely that a GHCB page hasn't been part of a huge page during
> all the testing, the change in snp_kexec_finish() to mask the address is
> the proper thing to do. It probably doesn't even need the if check as the
> mask can just be applied no matter what.

Sounds like I'll be getting a v3.1 with Tom's suggestions?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

