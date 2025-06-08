Return-Path: <stable+bounces-151878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F56AD1193
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC243ABE04
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABAC1FBE8A;
	Sun,  8 Jun 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b="Jc6pgfTq"
X-Original-To: stable@vger.kernel.org
Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE21367
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.147.51.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749371708; cv=none; b=gBHSStsz9tkT8ceZXVzHF1WYhg7SJSU3DcMnjN4qLiytjj3zvnEP42QE1F1+JLpRxffHiWSrpE72ZDSKx8Fum656aUs+ojg7l7vgARN4EoM+vq7vOz4m3hC5cNmTT5Jc+cEKL1FLSjN+PLEgAndwFnHgZzXBy+6vIk+xLZRmRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749371708; c=relaxed/simple;
	bh=rLRUKbIheIYC5N3ESF85L1H5yULmOan/iopEZGO1iPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfsLEF31NZI0lsQ9786IStuyHi8n+68sG3ZHh9Ojt/SqjT1zWQBJ+S/AB8b46JLXhoFQBcXvp+ncdQogX57uM6iZt29VP7LYCWNjSnXkqyJHjzsnnPbmZnAiuq/aCdVn/SpgMji+0Ysp8SQcsYER0fG0C6MOAo/2JICab+v45zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hannover.ccc.de; spf=pass smtp.mailfrom=hannover.ccc.de; dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b=Jc6pgfTq; arc=none smtp.client-ip=80.147.51.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hannover.ccc.de
Received: from spatz.zoo (unknown [94.31.115.35])
	by hannover.ccc.de (Postfix) with ESMTPSA id 66CFF2090A;
	Sun,  8 Jun 2025 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hannover.ccc.de;
	s=ds; t=1749371151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FduPFD9NBAvZKbmCKKAr0654gj3xXHW9v/6qyi/zjv0=;
	b=Jc6pgfTqyM6JH2RzFpem616AFA8bP1kItPE9ub0Z27vjPcfcO0FCpALt8Q7exfqIsuhU9h
	DraGNVEh648YFbkSdc0sd+XxMyegAn/5ZUswyGSMBxO4q2ivDNUk6Tq3Z3nrru48GBpQly
	XdHcXIuYyleZMs2TLcgEODyfsu8bLSk=
Received: from ingo by spatz.zoo with local (Exim 4.98.2)
	(envelope-from <ingo@spatz.zoo>)
	id 1uOBLi-000000002A6-1oj1;
	Sun, 08 Jun 2025 10:25:50 +0200
Date: Sun, 8 Jun 2025 10:25:50 +0200
From: Ingo Saitz <ingo@hannover.ccc.de>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ingo Saitz <ingo@hannover.ccc.de>, 1104745@bugs.debian.org,
	stable@vger.kernel.org
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
Message-ID: <aEVJDjS6_po-kMj-@spatz.zoo>
References: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>
 <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>

On Wed, Jun 04, 2025 at 10:43:11PM +0200, Uwe Kleine-König wrote:
> Control: tag -1 + fixed-upstream
> Control: forwarded -1 https://lore.kernel.org/r/20250530221824.work.623-kees@kernel.org
> 
> Hello,
> 
> On Mon, May 05, 2025 at 05:40:57PM +0200, Ingo Saitz wrote:
> > When compiling the linux kernel (tested on 6.15-rc5 and 6.14.5 from
> > kernel.org) with CONFIG_RANDSTRUCT enabled, gcc-15 throws an ICE:
> > 
> > arch/x86/kernel/cpu/proc.c:174:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1516
> >   174 | const struct seq_operations cpuinfo_op = {
> >       |              ^~~~~~~~~~~~~~
> 
> This is claimed to be fixed in upstream by commit
> https://git.kernel.org/linus/f39f18f3c3531aa802b58a20d39d96e82eb96c14
> that is scheduled to be included in 6.16-rc1.

I can confirm applying the patches

    e136a4062174a9a8d1c1447ca040ea81accfa6a8: randstruct: gcc-plugin: Remove bogus void member
    f39f18f3c3531aa802b58a20d39d96e82eb96c14: randstruct: gcc-plugin: Fix attribute addition

fixes the compile issue (on vanilla 6.12, 6.14 and 6.15 kernel trees;
the kernels seem to run fine, too, so far). The first patch was needed
for the second to apply cleanly. But I can try to backport only
f39f18f3c3531aa802b58a20d39d96e82eb96c14 and see if it still compiles.

> 
> This wasn't explicitly marked for stable, but I think a backport would
> be good.
> 
> Best regards
> Uwe



    Ingo
-- 
const_cast<long double>(Λ)

