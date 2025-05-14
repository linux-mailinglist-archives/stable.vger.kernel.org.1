Return-Path: <stable+bounces-144345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7CAB6787
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB53F3B25A0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2822A4E4;
	Wed, 14 May 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eATAisn8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C172101BD;
	Wed, 14 May 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215080; cv=none; b=kzejk//2Xry+iIk/CXlIJWELepjpB9RSnpebJLG+jcmc8mcJD+HmDt9elq30BfJ61kbXm/esewdsAkyJusk5GR6kBqbkV9rnIHth0XuLxE1tniELTd1QL/dyuXyF68FrXu7irynVD4uF91M6wYK8mvpYTefVFrkBr7upp5S/SxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215080; c=relaxed/simple;
	bh=wbuzVKsbaIYYgUNIGWiOGf0ggry5wMthmfxhwfd8rRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+rRdOmg6YBmVIum1rrPKZpmcSb5h4S4oCcwX22zZmDfRsbxKBYmruTkY3DNPYJlknksUaTYYh0oFENNrTrJjUcvbgn5g4iS/7B5xQ1nbJQkj1bocsZW5hWGAx3RDsszC+JXsjYF/npmJDP0VGvFRIQIZYn+jBvV52499ci064s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eATAisn8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F1EFE40E0163;
	Wed, 14 May 2025 09:31:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1XWBJqI5yh0g; Wed, 14 May 2025 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747215070; bh=kwlDtAjQb/FKYJpSPJnPSjrxlyBEpr/raI0mZ6JF/6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eATAisn8ZM3v8CbOYOmEmBd8xPyIEXsQ8/ealMrWoF/UBqezBOt15L4SSxL+zLWNy
	 +fgp5e5Gbngg4xMDhUegRVqACsctYWeMRBmnfEuXfvat9blc0xoxnVA7gfHivv6H58
	 65v/C5aOMrSsqdrLX4hAuAIKx4a0mILWAPRFrL6GCY9U4XgkDAPI58xw+nTce8ICRO
	 LW/YBskANRZuaSurIuGDb+1Jp2UFo0KbksghMceHOwWe5IIerZZVZE4uzc/8gYPhMf
	 wzAZFSXYOB7MziksDFt0KG5+QwTA9G/bF8zqZQzz4lpVkVotO9kUOrwcSE/2XASMXa
	 eWmdWscmAW9H2+z9zif3dyuris/cN42uuRkDARiwTox+QenJYehLoVcKjaZ6vxEmBk
	 Zv1PEEQGmZuWxy9AHMGxIZWPQX8enofdIKkXTShhjLViErWIW9wLafupTuuE0dlWuw
	 FmDbqGb025nghU2wmiMB5WEFHJMGKKLFADzBYNa1p2FzxLXF5LhRdefO598Rw9jJf+
	 aE8W2y8uyMHExMHdg4EPFol4wPg0i7L6hdfr8fE89xN0nF4eKClJbCIAZHahctuZ13
	 X/UPWXBYYo4H0omb2itWoDpsoRZ/XAvW1ciLRi+I+AKN1xSchVjd974U10Xek2dvdo
	 CbmYSl5qvepTfqwUfdvnTNPw=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A323640E0239;
	Wed, 14 May 2025 09:31:01 +0000 (UTC)
Date: Wed, 14 May 2025 11:30:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ashish Kalra <ashish.kalra@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Srikanth Aithal <sraithal@amd.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/sev: Do not touch VMSA pages during SNP
 guest memory kdump
Message-ID: <20250514093055.GDaCRiz6rY7f71YnIr@fat_crate.local>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
 <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>
 <aCREWka5uQndvTN_@gmail.com>
 <20250514081120.GAaCRQKOVcm4dgqp59@fat_crate.local>
 <aCRfPTxaPvoqILq8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCRfPTxaPvoqILq8@gmail.com>

On Wed, May 14, 2025 at 11:15:41AM +0200, Ingo Molnar wrote:
> imply that you don't accept the other issues my review identified, such as
> the messy type conversions and the inconsistent handling of svsm_caa_pa as
> valid? That would be sad.

Another proof that you're not really reading my emails:

"Feel free to propose fixes, Tom and I will review them and even test them for
you!"

> Secondly, the fact that half of the patch is moving/refactoring code, 
> while the other half is adding new code is no excuse to ignore review 
> feedback for the code that gets moved/refactored - reviewers obviously 
> need to read and understand the code that gets moved too. This is 
> kernel maintenance 101.

See above.

> All these problems accumulate and may result in fragility and bugs.

LOL, this is very ironic coming from you: to talk about problems accumulating
from patches *you* applied without anyone else reviewing. Hillarious.

> Oh wow, you really don't take constructive criticism of patches very 
> well. Review feedback isn't a personal attack against you. Please don't 
> shoot the messenger.

Sorry, the time for constructive criticism with you is long over. You have
proved yourself over and over again that normal way of working with you just
doesn't fly.

I have told you here why it is ok to do this patch this way. You ignored it.

This patch was tested with everything we've got. No issues.

I suggested you propose changes to that code and we will review and test them.
You ignore that too.

Well, ignoring people goes both ways.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

