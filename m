Return-Path: <stable+bounces-192755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B032C4216E
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 01:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB64E472C
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC078F48;
	Sat,  8 Nov 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bnxQLLsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9918A55;
	Sat,  8 Nov 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560305; cv=none; b=CHmAwOkK8wxJNUIYoSTCViSZFIhaJOUqcFDbC6JtnR2GIHecEXN9jn3Z2oOKGdyhXWLFbL+OZOz8eX76PNbpUUyXGnnExzRaJc9nKXUPZCzvyd7blV5jkIuk3fZjsGVCIhnCNgv0DxWp1LM8oL6lb9ITnH+1Z4UPmb499S2oNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560305; c=relaxed/simple;
	bh=Tqh33xIA4mgDa2BptdErXA8zNQ+Bw7zeLAuOimDde5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFnvjxx6Z1tTGnSCL+EjCd9nZvuGV88YYLhCuG6zbzJ7017PPmW20zdARJOQCkr5VBnxEv5iP40BoCrRakAMmdqZK1KbdVgufnNwLwImJ/mcYgJyGYRoyIRnRaWiRQ+83IDWKhEP251eUqMc8k7wi0Gh58ziPEZIzYd0Xoj9+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bnxQLLsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFC2C116C6;
	Sat,  8 Nov 2025 00:05:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bnxQLLsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762560301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j317frlHa+Qx5iwhsewyfIq0wiwLQtpXQJB2BERP3GE=;
	b=bnxQLLsDNXzJcp27d6vn6WbaTpnp4mJTCJQnkxyMCWTRMwDUMaEbWAbEZBJKeaR63Y60o4
	vso/1xejKtJMsUxye+W6brvjTz13PNV1PnFYrPOP8rBSQiZiIvDHjAhJf+nzNuwbxGFMok
	E++oXwA/NfcTlqtjhiSsW0aTB7KFiVs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b485aa65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 8 Nov 2025 00:05:01 +0000 (UTC)
Date: Sat, 8 Nov 2025 01:04:57 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thiago Macieira <thiago.macieira@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Christopher Snowhill <chris@kode54.net>,
	Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <aQ6JKYcnNVRM2Fwk@zx2c4.com>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <2790505.9o76ZdvQCi@tjmaciei-mobl5>
 <aQ57ofElS-N0gEco@zx2c4.com>
 <27717271.1r3eYUQgxm@tjmaciei-mobl5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27717271.1r3eYUQgxm@tjmaciei-mobl5>

On Fri, Nov 07, 2025 at 03:11:51PM -0800, Thiago Macieira wrote:
> On Friday, 7 November 2025 15:07:13 Pacific Standard Time Jason A. Donenfeld 
> wrote:
> > Oh. "Entropy source draining" is not a real thing. There used to be
> > bizarre behavior related to /dev/random (not urandom), but this has been
> > gone for ages. And even the non-getrandom Linux fallback code uses
> > /dev/urandom before /dev/random. So not even on old kernels is this an
> > issue. You can keep generating random numbers forever without worrying
> > about running out of juice or irritating other processes.
> 
> Thank you. This probably seals the deal. I'll prepare a patch removing the 
> direct use of the hardware instructions in the coming days.

Cool. I've got an account on the Qt Gerrit (I think, anyway; it's been
some years), in case it's useful to CC me.

Jason

