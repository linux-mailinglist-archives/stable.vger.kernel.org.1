Return-Path: <stable+bounces-128538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D283A7DF1F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C10C188B1C2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754982185AC;
	Mon,  7 Apr 2025 13:26:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32562253B69
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032404; cv=none; b=iArkyQmF5zc8i2fYp2bc4gUqrMD7y9nfGnWY4pDscaNr5QHsE+/cUU9VJWnWfTY8i9TQwpGV+BMjRM80LqMHSBT6MGksVcHaM/ytgMBDDc0sfjXQ0gds10gZz4SfCHCF1J1t+xS12Ic61CRMkRMemn63K+rctWcaowQ5k5uqGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032404; c=relaxed/simple;
	bh=7ss0b4QcFi6takrmrcUxg3om52YAGXIblU1mebdiSMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brrOEwvGEOV3ink5gKIIiPfBCFwOiAlJHktKzJd5YvK6BUXf7OZGLiXYGsHwJinS1RLIfbHCJ5fp1wbvNCy1Q37uepdW3+cuMq/Aqr7Ero7uLLwT6UWxsgll4UaoiYUpoPECXLFJi+ECt0WnXEsN8ZMZvuKjtkn1L5lkhXmkFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 537DQKkA017531;
	Mon, 7 Apr 2025 15:26:20 +0200
Date: Mon, 7 Apr 2025 15:26:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "Manthey, Norbert" <nmanthey@amazon.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <20250407132620.GA17471@1wt.eu>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
 <2025040348-grant-unstylish-a78b@gregkh>
 <2025040311-overstate-satin-1a8f@gregkh>
 <94605fedd3f066efbe09f21fd1e0533cc6a1c5b9.camel@amazon.de>
 <2025040728-shabby-laborer-4891@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025040728-shabby-laborer-4891@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 07, 2025 at 09:31:08AM +0200, gregkh@linuxfoundation.org wrote:
> > We understand. We might make the tool available to help simplify the human effort of backporting. To
> > make this more successful, is there a way to identify the errors and learnings you mention from the
> > past? Avoiding them automatically early in the process helps keeping the errors away.
> 
> Don't ignore fuzz, manually check, and verify, everything.

Also, diffing the file between the latest kernel and the one you're
backporting to helps discover changed assumptions. For example, a
group of functions might be called with similar assumptions in the
old kernel, with some tests replicated everywhere (say pointer foo
must not be NULL). In newer kernels this test is moved up in the
caller chain and is no longer performed in the lower functions. When
you want to backport a fix from this kernel to the old one, you may
need to reimplement yourself the nullity check that the old kernel
requires. And that's valid for locking and many other things in
general. There's no way to automatically discover these ones, aside
comparing the older and newer states of the file to see how it
evolved over time, and developing your own habits of remembering
that certain areas are different in your kernel, by doing lots of
backports there, as well as following LKML to try to spot some
changes that may affect your areas of interest. After a few years
on old kernel you can start to develop some reflexes but that's not
rocket science.

> good luck!

Seconded!

> greg k-h

Willy

