Return-Path: <stable+bounces-100570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79E9EC763
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F4D284A6C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFF1D88B4;
	Wed, 11 Dec 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xvaMl0f0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0141C4A1B
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905952; cv=none; b=X+rBuT6AuY86A1279jLHVv3hzRQj2SElIMlJSppZOsOA1Ntc6q7udLd100p0Lnk5cizU9JeDc9bBSAacK7dTkOrgB9GlIaxdJMwP3HkKAb8jqVCWfArwaDHaX7nMDXCvHT+YikjK4wYasN1D39x+rEUmBLRf9mWT+XAu4nOAmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905952; c=relaxed/simple;
	bh=2aMw//SR1aG58G4stVCCsOkOVppdPPp+IHTwUgilzcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQJnRPyFTBNqq90Vcylh2mmZOMFCGElRxRLa/6419v/TJ/+i1YmMq34wuT4zQL758yOKbZNF8H0KXZ2tujRfaYyzxcZO9DPZjR16Yp5viASQIbXxN/0YpEeg9YHnPRuUs4hpiDSJNCgS6zP97K8uJQje5tsDaF6qAw4rxTzG2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xvaMl0f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7D0C4CED2;
	Wed, 11 Dec 2024 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733905951;
	bh=2aMw//SR1aG58G4stVCCsOkOVppdPPp+IHTwUgilzcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xvaMl0f0NKOM6QyYvAJE57uPH94xekeebggysPkN5tOOKvsAJLqFrbBkGPTradzsF
	 5LVCZC25apLaA2kEwtmhmE+I+gAT+gYRg7H/8qkXJLgr9ceI9wIN9OReYL/Ue7TAur
	 RYsu29ZrLfPK9cfkKWybtqP07Ae9f3oSv6GAdWOQ=
Date: Wed, 11 Dec 2024 09:31:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Lan <Bin.Lan.CN@windriver.com>
Cc: bin.lan.cn@eng.windriver.com, stable@vger.kernel.org,
	irui.wang@mediatek.com
Subject: Re: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder
 vsi
Message-ID: <2024121135-unlawful-unrated-acf9@gregkh>
References: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
 <2024121140-valium-strongbox-04f6@gregkh>
 <84d56ea4-d239-4eef-8808-2f4260dc0f0d@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d56ea4-d239-4eef-8808-2f4260dc0f0d@windriver.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Wed, Dec 11, 2024 at 04:21:33PM +0800, Bin Lan wrote:
> V2: Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1

Please always document this in the proper place.

thanks,

greg k-h

