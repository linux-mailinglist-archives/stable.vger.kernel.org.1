Return-Path: <stable+bounces-195479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1AC78360
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3DC2B354C3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0A33F8C1;
	Fri, 21 Nov 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HTByEDyw"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE129898B;
	Fri, 21 Nov 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717527; cv=none; b=falP3T2QdeeVrv/+XUGpZWurVFTxXFnYl/9cNsUY+wvZPg6k+nEqJkrL3aG2Iazyc+81+B5+fC62UQuG81ZMOmMHOWl/PzyCi009zAhMYl6/WVwSQ9G/iqKhisj5sKVoQGaCPbwVQItfycKMbgASI2/pzLMFCy1sGv4tro7Vpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717527; c=relaxed/simple;
	bh=2JhYfghup0Lmo62DjLdNv+zikgdwwddelzBoClmammw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvgSMEOsWl5vV+eqLqGmQl4OJXNc/rauZ6rCREAs+CxJ8PH81GtKwIL3d986jE5EkqILI6dW4qhGvEDvIou2xILbP9CQFJyqpWnSXkjQlzzJ7Joo4+V6ldKTGTojQYPYRQZkGKtCWYHF56mO1W3g0G8+kCP5PcAm3HJ2hEmKWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HTByEDyw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3288340E0216;
	Fri, 21 Nov 2025 09:31:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7FgBa1POs6oA; Fri, 21 Nov 2025 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763717515; bh=8+JHNaKdXCXUagJFPXnJLM6CBuMg2i6jG9IS5AL2xLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTByEDywa0qvE7soHA7OD/917ECfD5s9HU+8JKKO3z8Fews5zdZoM9JvIDt/KVOcG
	 QZo3kYlZRpFDsVkqoU2BxyqlwO1Ubr7p8GZEUsYnAPnmcyPycn3H9qXk+MvBHS+yi+
	 1zNRpiFnT5ajBIf7thPYYDk7pDCBMBI1lco6j4UneJMbOxOIoua8Six3PfpbS1tF9R
	 v8kJhICbd8p0zoWVI/yJ/PnMTk0JrUBENJd8Eypu/NyHpCUTwcsdi3dBVM6iEofb8V
	 R4wGNh+WGWNaeUCeo8EXehJWNeFWC3dpShPvOHYeeD1ep3Jhrk/cx2pYVe+Ajh987a
	 Xyfh4bFS5wd/u3h5bKzcZmp7yIsoAFZ45wXNpzLk9ekGnP21kdzrJef8SGg9jf1cBx
	 CdCLicYK12jVNcWR+CenhDFaoEECk/zOef8PbiRSHSGnhEEroUzk+9t/4RwyS62AfW
	 Ca7eTc+T/99wpMorkdqVYOMFXjtZt+iWq8YMmExdYfnUvs5AggciMcJ+UTPSCvbjox
	 M1RSarQQ0xJ2QNgCEHIKkInwttl4YbZUEV69kmFC165JNAmwK6tMwECOqHfHSfmj/C
	 tb52Q9oL11D/OrNnLeXzAuSL8gyE/+Ah1KZWfTsKI3reOAmoEySDkhiKOqZLvtO4FD
	 f3EjAdjkATR5J8lDU90e7t10=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3AE2A40E016E;
	Fri, 21 Nov 2025 09:31:45 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:31:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Naik, Avadhut" <avadnaik@amd.com>, stable@vger.kernel.org,
	sashal@kernel.org, linux-kernel@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <20251121093138.GAaSAxet009yCkqd41@fat_crate.local>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
 <2025112144-wizard-upcountry-292d@gregkh>
 <15355297-4ff3-4626-b5d5-ac50aea87589@amd.com>
 <2025112152-tripod-footbath-80ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025112152-tripod-footbath-80ff@gregkh>

On Fri, Nov 21, 2025 at 08:09:21AM +0100, Greg KH wrote:
> > I think it has not yet been merged into mainline's master branch.
> > This commit was recently accepted into the tip (5th November).
> 
> Then there's nothing we can do about this in the stable tree, please

Yeah, it took me a while to understand what the issue is when Avadhut was
explaining it to me offlist:

So the hunk at the beginning of this thread is needed as a fix for stable
because when they inject a lot of errors back-to-back, after the error storm
detection recovers, they cannot log any errors anymore - see the explanation
in the first patch.

So what we'll do here:

@Avadhut, you take that hunk, pls, and create a separate patch with commit
message explaining everything, blablalba, cc:stable, the whole shebang.

That patch goes upstream and to stable.

The rest of the original

  a5834a5458aa ("x86/mce: Handle AMD threshold interrupt storms")

you then redo ontop of this one and send it too.

I'll zap a5834a5458aa from the lineup for now so that you can split it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

