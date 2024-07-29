Return-Path: <stable+bounces-62605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF493FE4B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26862824D6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6C187871;
	Mon, 29 Jul 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MoPsf5UA"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379777FBD1;
	Mon, 29 Jul 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281556; cv=none; b=GlKlkJRL6grXRy8vlQ0nmW3FCCgi8FL1WtziZ+S02NSvmrCq7EMG38aW9IxqlB3lpIuwrxVa+JvN3FB2FApjnk2LbQWtgjdK84vLWl9H0koqGTAk9i0SnSOj0jlcqhQz/kMrkhriwBF60YchV3m0jmZVXyRmpEtZxUZbeBoBbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281556; c=relaxed/simple;
	bh=y0O1daR7qBYuYSvgyYV2W6kDaRxXVMRUBY8MeJsT/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgtfEOqX0dxknfolrQ5iH0HKLsKqO/1rDvemEpL3kMIA61n3qAkma8MspRD7gXSMSIgG6QBAne3/6NKSyCKB79EPK9K3+wmyf/prDhkDnGqdtPC5jyUmiLP0qinvl6BlR3KRFsNQMgPTwtzvywtg1XNSyI5s+CJ+OvtBhV2mx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MoPsf5UA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D763240E01A8;
	Mon, 29 Jul 2024 19:32:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b4ka6JfeQqnD; Mon, 29 Jul 2024 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722281546; bh=I8ev7rn1xiUUV283jkm1+3brjVagAOAzfnWXmP+Wtkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoPsf5UA2DMfmtDuigMQfOIuQBYnfd1BSoyd2ow10fAoNDBOLHXKtqdqHDqpCFYyT
	 Wi+fDcyGPRBBvLoenZvkQc0IaUc/xf0+Rug//zccsrKVi+ubuHnDRhDkd0+8iaUVEz
	 3+nrZo7K94m5OkEopz5TSwnAmrPePwJH2uAC26NBkRSdFJvCHtPC2O59yOzxsVwKyH
	 Zt3E3fQ9UwQ0WvpbVpdceRAHh83j66UAyULADZdrQLcquyOqPEa33dNBNzZfdrwLj3
	 l9wPYEP72VB2eshV4TaBCEgmv/L8Z/BbJoSSvBZsFNB7AoCaTJEUZ9SRVT6gDeOfRY
	 Yi4EYp52m2Xu4uUXn8qWhJh2AwJCmPCkS5STwRTfEXq+ytscfWn0yE2YZV+Z4ZMUNT
	 nnioRBADUJKsu4tzX0o4gRVip62Negf7WnBN21wuO7UZ8mkiKAaLmB4fltK5tFRRxy
	 4BV9WciZafT8rPptIf0Z9/0g9J9tx6uz2bQKwevhQT1V6eL8UwplX6IU4irrr6qHTs
	 VIoCJsT9UCcB0M4Lb1cL3ex2ZbGkh/yThm1y44DFO40Hyku1GHlRfIBIy1SLzrk1L8
	 BEsOrBf7PFOCSGOBBbXE1+mKC3UEBlIbOOx1ytQ+TOcADF1IhFL48OzrVtjsb+vWyf
	 NcH6p43zH4YAS9uedlEeaTEU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C7A140E0169;
	Mon, 29 Jul 2024 19:32:17 +0000 (UTC)
Date: Mon, 29 Jul 2024 21:32:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sev: Fix __reserved field in sev_config
Message-ID: <20240729193210.GHZqfuOs-t9HuYPF_Y@fat_crate.local>
References: <20240729180808.366587-1-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729180808.366587-1-papaluri@amd.com>

On Mon, Jul 29, 2024 at 01:08:08PM -0500, Pavan Kumar Paluri wrote:
> sev_config currently has debug, ghcbs_initialized, and use_cas fields.
> However, __reserved count has not been updated. Fix this.
> 
> Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
> Cc: stable@vger.kernel.org

stable because?


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

