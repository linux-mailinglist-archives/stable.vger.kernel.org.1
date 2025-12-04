Return-Path: <stable+bounces-199951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0DCA20D8
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 01:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0533015840
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B461DA61B;
	Thu,  4 Dec 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmeFWs/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205B1D416E;
	Thu,  4 Dec 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808998; cv=none; b=L8wQ6g9c5od9abKopl2l90ieu1XviXsFoLhppkEoyPPbymYtY+LJnOrjn85+sSge9b5hSOJwow4UmmUESzWfCAKw3O6ymVODv6gV1XgMXEY24/a7k90FIv+IRlMiSHUlmYjEq4b23BzLc/duXSXc9SHqpZ4RQ6nReBW1fU15fvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808998; c=relaxed/simple;
	bh=AAY4jeuMiOcb62fXqwWLqSABPojz23dlDR+d/WfhJVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S81lAFltERNtzDgD7+XO1Wk/wln+ACl3Em7nQd1rJ5WSDGWjAQe7N+gVIefBD3ZpiA0jBHFFgSfGvGEOVgwqDdPpJjzx1ksuRe1TASm7GrZr+FWHOlalA+l9HGIkzrGaGOhImFAr/B8kZasSa3hEAJj6TUfD2Uf07kxMh+CbTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmeFWs/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2219C4CEF5;
	Thu,  4 Dec 2025 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764808998;
	bh=AAY4jeuMiOcb62fXqwWLqSABPojz23dlDR+d/WfhJVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmeFWs/9wztfT7HqX5hzewUlKZ6xzlHbopfhUW8GteDTDule5KVozT2r9FpLWarua
	 oRZsDlQ7QTxYukVUxLitUJ6Au8Wpolyx/eqSVf/n77Qfcf2L3ctEa0eiU7uMcS1Dt+
	 nOSlhrtxW99fuxOnoaplBfftVborEwsICrVNBRl+EqP3W4LB8zqsYdxnYXAfbh3N4M
	 ierRL7GlKCL/X6wHqyjlttkGzHkQLNXfxsn+BzBzALfiDBmpb5mDhJQB1TIRochMQ6
	 iuYEJ25llhmCPZvLk9rIehTxYxAqv71ajYeSHlPP0RvMLQ+SiaWrdf6aaaZfUhjGxx
	 hKlOmJX7k7BpA==
Date: Wed, 3 Dec 2025 17:43:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@google.com>, kernelci@lists.linux.dev,
	kernelci-results@groups.io, gus@collabora.com,
	stable@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
Message-ID: <20251204004314.GA1390678@ax162>
References: <176398914850.89.13888454130518102455@f771fd7c9232>
 <20251124220404.GA2853001@ax162>
 <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
 <20251124224046.GA3142687@ax162>
 <2025112730-sterilize-roaming-5c71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112730-sterilize-roaming-5c71@gregkh>

On Thu, Nov 27, 2025 at 02:22:46PM +0100, Greg Kroah-Hartman wrote:
> No objection from me to delete the driver from all of the stable trees :)

Sounds rather nuclear for the issue at hand :) but I can send the
backports for that change and we can see who complains before trying a
more localized (even if wrong) fix.

Cheers,
Nathan

