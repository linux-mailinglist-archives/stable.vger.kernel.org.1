Return-Path: <stable+bounces-172764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBCB33226
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979D344423B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A321348;
	Sun, 24 Aug 2025 18:55:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C4223322;
	Sun, 24 Aug 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061746; cv=none; b=MVl3TXjOLaIP0X6EZU4KcBXlFLLCj10ijJ2Ldck6lKpx5sTkfBuZou8ob+w88a0lAaznnQ+Jnr3lnOt2l0MGRhTNvj5ADOWDqcscmewEvtkm4dui9c2r7VnoSKd6+XY3Wbr4dYs9tTDaP3rztjm7lk8xItL+t5v5PKLTjqoJ4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061746; c=relaxed/simple;
	bh=QWBTUbp0Zm1g2rm++nMhTx28kxwEctJv4LQ6X5NYSwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaQ1WJQIq5wKDIudUzt6h/YP1Mhmg2fjZ3ZaGPsim7Nma6OFS8Ig+cCGiFbmrprdvwN+wIdxiVjdfaaS9F0yE+kVyJggKVPTfI9L8netkW3BPZvfhwhV4y9jBICnShI9sknsB/MS2jGobjbmiuzIqjWS71scmGMy2odg2IqpXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57OItQAT001069;
	Sun, 24 Aug 2025 20:55:26 +0200
Date: Sun, 24 Aug 2025 20:55:26 +0200
From: Willy Tarreau <w@1wt.eu>
To: Kyle Sanderson <kyle.leet@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
Message-ID: <20250824185526.GA958@1wt.eu>
References: <2025082354-halogen-retaliate-a8ba@gregkh>
 <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello,

On Sun, Aug 24, 2025 at 11:31:01AM -0700, Kyle Sanderson wrote:
> Thanks for maintaining these as always. For the first time in a long time, I
> booted the latest stable (6.15.x -> 6.16.3) and somehow lost my networking.
> It looks like there is a patch from Intel (reported by AMD) that did not
> make it into stable 6.16.
> 
> e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e - ixgbe
> https://lore.kernel.org/all/94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org/
> - i40e

Your description is very confusing. First you indicate in the subject
that there is a regression in 6.16.3 (implying from 6.16.2 then), and
you describe a 6.15.x to 6.16.x upgrade, which then has nothing to do
with 6.16.x alone but much more likely with 6.15 to 6.16. Or did a
previous 6.16 work fine ? Also the patch you pointed above is neither
in 6.15 nor in 6.16, so it's not just "missing from 6.16".

Based on your links and descriptions above I suspect that instead it's a
6.15 to 6.16 regression that was brought by a0285236ab93 and that commit
e67a0bc3ed4fd above fixed it in 6.17-rc2, is that it ? If so, can you
apply that patch to confirm that it works and is desired in 6.16.x ?

Regards,
Willy

