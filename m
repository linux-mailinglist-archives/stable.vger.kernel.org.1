Return-Path: <stable+bounces-155171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F04BAE1F9F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F53A7003
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C62DE1F0;
	Fri, 20 Jun 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d4YiHGwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9C266568
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435000; cv=none; b=hWFzvr/79Fw4LJ18INOOtSC4PoMAK/K0M+2jXMi6GCwqlJWoBp5QvUKQukufr/KwqHQcdDrG+Ocjx6qTFyH8f97kVJiC1H6qSX9sYLSWwwVkbfHt3PGChanX/Zo1rnpgwSuxeLlMyO7CZi4AMn5/Y+ZZieIwsdJamDFwSN1BcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435000; c=relaxed/simple;
	bh=JLIbgog59+Bv50aT29vJWh/SP7kLQ9wCkIO6oo9pn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl088oevUITdlfvpQE6n8mEVfdX37CgLAhqT4/11hJ/iIbphjGFfdNniokzjjXfnWDehTSZIEg4vB9+2Q3rZkxoCOMBf9mVaTvqlssglt7Ey8kxxx1+j/idg65s606zmW940k5yT4qzbEBSlWGU817hIIaWDoA+XDPG7lWxt2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d4YiHGwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B8C4CEE3;
	Fri, 20 Jun 2025 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750435000;
	bh=JLIbgog59+Bv50aT29vJWh/SP7kLQ9wCkIO6oo9pn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4YiHGwmuXEZbHKLt/BxUhyrWF3LrTA0y1VVVzlHq1eTotPlWh4wP6aZLwri+Fx3n
	 +0HdC98JXeGzE4+pfL+5m8ewkA6E3Y0pM0SBPH7sl0flFg/DS0VdD8JMYFbWjOxQrg
	 C3ch1lpcT/fvX9ACIomJ96PRZwL3BVwJEMJ8YMLE=
Date: Fri, 20 Jun 2025 17:56:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Larry Wei <larryw3i@yeah.net>,
	1103397@bugs.debian.org
Subject: Re: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
Message-ID: <2025062022-upchuck-headless-0475@gregkh>
References: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>

On Sun, Jun 15, 2025 at 09:25:57PM +0200, Ben Hutchings wrote:
> Hi stable maintainers,
> 
> Please apply commit d1e420772cd1 ("x86/pkeys: Simplify PKRU update in
> signal frame") to the stable branches for 6.12 and later.
> 
> This fixes a regression introduced in 6.13 by commit ae6012d72fa6
> ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd"), which was also
> backported in 6.12.5.

Now queued up, thanks.

greg k-h

