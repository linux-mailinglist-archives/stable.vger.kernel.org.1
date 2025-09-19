Return-Path: <stable+bounces-180678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3CB8ABD0
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DAF1C206F9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2972271464;
	Fri, 19 Sep 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K5PL6AR/"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D374267AF1
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302449; cv=none; b=H5JIztmRggMyqwy5th2btnXRFIRs/bKRY00yI/YXmuGzYQu/NrO9Vf/KAs5Docu15XMegr/C8fBH8s3CO6Ol6iqX9t0JyTL11mnEKV7cGR1q47QtnaHEHxa1cf38ZhSA8jr4h0Xy9G7WhJvrl6nag/SF3BFeLb81xczrl3eIC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302449; c=relaxed/simple;
	bh=+ZXTL9ughxuEJrk0UoHDP2xRAgKLRReA6kuppagwkyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPf6l5D968B9sXturGW2dxgFsVwDLuchrXfXe9+w/rf3Sv5/VfszyxDhKIuxQTeCMowI2PFi+gc7bTRsekZgAYqDz5yc1rabCutoTP3iVQDwCtVc22ca5FapW7vpQdfJRXGt6w93mI1ROE5v0s0K+C9r4RhzZCGlX4dIeNm1sOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K5PL6AR/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17B9840E01BB;
	Fri, 19 Sep 2025 17:20:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rJHfAKqq4lVK; Fri, 19 Sep 2025 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758302439; bh=5Pk44VxBaBs7hbVnJwFTDxBhb49l67Y/UBRyVrdjWDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5PL6AR/k7yNBQqjvGXE/1DSSKaLKvLJKi7TH4qE2nC/cFhUrGMyaetIknBaF5BEv
	 1h9ha4xPP+s5hAnpDXab+seXF6MERegIaIKexou2/m5etKhS5TD/zZRmT+Cq66EtaB
	 L4FdR77bgxS1MIf5A9w1F9cJ+Jk1l0HWdRHLooKj/x1hMGJ178ycpsmpOxhWZKay66
	 T+AGJgQSUUMYzhZMGg1Q2q0opQGnnpjTz+FzRt2W7fOAxjtUNKPbDttA/MXhBP/HjW
	 1gYq9GgUEC5FfV15jYjiP2x+TanxfqlgdZ8OvyR6GZHRAWGQ1wk602FHQSMs3dub5L
	 naGRSiyx81kgZwNT9JYpeVba0CWC69ta5sQ+n2X7o42FSSFdSVD904CQFxjozpx94C
	 30mSR7H+4q9qTXqI5yfPh91Xz8//uwbcdpwdc81cr09lFCfZ4j5+0SQm29/bixzkvw
	 LxLJq+nrBd/55rml+pTK2gDUCdsXgLYZwhW2GLkxbV6hWiMWvrd0x8EvWa57WAzhjj
	 zFUWEgryYzQmISh7w9RPxdOxGkTtQogoeEMpLgdTbFhfgtOOC//d68hw0bRxJy2dRQ
	 6COBkkW68/b8V99s90Ujh9XHYQIlnFzC8V9kYgF1BYQEv/iYRa+weHETuCDZD+SWxU
	 AUpuzqnE/ulZ4oF+uyjyiN2s=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 28B8A40E01A3;
	Fri, 19 Sep 2025 17:20:30 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:20:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	pawan.kumar.gupta@linux.intel.com, dave.hansen@linux.intel.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [bug-report 6.12.y] Probably a problematic stable backport
 commit: 7c62c442b6eb ("x86/vmscape: Enumerate VMSCAPE bug")
Message-ID: <20250919172024.GEaM2Q2Go9RKnb0VYD@fat_crate.local>
References: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>

On Fri, Sep 19, 2025 at 10:42:33PM +0530, Harshit Mogalapalli wrote:
> Notice the part where VULNBL_AMD(0x1a, SRSO | VMSCAPE) is added, 6.12.y
> doesn't have commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO
> support") so I think we shouldn't be adding VULNBL_AMD(0x1a, SRSO | VMSCAPE)
> directly.

Whoops.

> I can send my backports to stable if this looks good. Thoughts ?

Sounds about right.

I wonder what else is missing in 6.12 for Turin though...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

