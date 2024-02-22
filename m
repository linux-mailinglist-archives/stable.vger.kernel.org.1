Return-Path: <stable+bounces-23319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E948C85F78F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D471C22330
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8F4C60C;
	Thu, 22 Feb 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2CeyJch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F79495E5
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602851; cv=none; b=F4HEZAV9fi6FH10MuWol0/jkRLah53cpgBaWgl4p3FzRDUv75oVkLV04ryCJ4v4GirbQK0hZHHtjHVIpzIfSEKr7T5WLXmNU9WspEqLn+XgFP6BxB5VcevEr81VadDaJHKDJqPrTcUyRBZn7G+z3SiLPpjnPZz+UBNkPP+ZEhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602851; c=relaxed/simple;
	bh=wxRzRiXEFm2bo4QE7S7hYevvdqUNgvgWC9K7Tsz6lgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtBELh8q2AigNLCQZdEW1LMiP1974eRPjehv7kFQHEDjEolhWukDrJ9qAdAPYgfBgIr8y6IQ8fyR/xZyaOCrQYXWgU1PCWyBUAUdom672VeEEcqPAtcdzqfpUtKcs/3j72YpwD0sIE+0FMK6qxHBF2uJLnCmPE1J3DWNCcNJqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2CeyJch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D6C433F1;
	Thu, 22 Feb 2024 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708602851;
	bh=wxRzRiXEFm2bo4QE7S7hYevvdqUNgvgWC9K7Tsz6lgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2CeyJch6Z8Dgg+dvo2cuiWzcvRiG6cJlPXBLYflhlnB4u0D3pDUoRe5z3Rw8PZDi
	 v+gF0T5mRQAuP/Jj34nn5rSg5V2299hCjcb+5rZyLDZgXscnS+SpkBo6JgAO39S6vd
	 5FXUsfTTh9/BkxD3LOUoyrpsYDKYpkGekhjI+TT60iYQlu4XxNqe5qjS5p/hXsLJZq
	 UP6naus92XILRnLm3fnXOh6uCJmCEh+nd3Qgo1klj+VlcIN6hOInbriq3lCmMN+gvE
	 wj9I9SEokNajlDuvbhnPRy/ri10K5AoFDdGtPLwhijCk4fDF1KiUs7i2kPWS1/WdIQ
	 tj9O4vIWgmWAw==
Date: Thu, 22 Feb 2024 06:54:10 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jiri Benc <jbenc@redhat.com>, stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <Zdc14lqx0Yo_sYLe@sashalap>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdaAFt_Isq9dGMtP@sashalap>
 <yp7osx43maofpmebvkrevi6qnuwwa2nrvx6uly4utny33j3o4u@jgrvcn5ylowo>
 <2024022224-spotting-blunt-1edb@gregkh>
 <kcu4dlcablzlybppobcql7roqehim6ejkgsqkbw2rkrfv7xuch@edklzskv4iaa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <kcu4dlcablzlybppobcql7roqehim6ejkgsqkbw2rkrfv7xuch@edklzskv4iaa>

On Thu, Feb 22, 2024 at 01:30:01AM -0500, Kent Overstreet wrote:
>On Thu, Feb 22, 2024 at 06:48:58AM +0100, Greg KH wrote:
>> We NEED and REQUIRE you, if you do modify a commit from what is in
>> Linus's tree, to say "hey, this is modified because of X and Y", not to
>> just not say anything and assume that we should blindly take a modified
>> change.  You don't want us to do that, right?
>
>I can provide commit messages in the format you need - but also: _none_
>of this is documented in stable-kernel-rules.rst, so I'm going to want
>something clear and specific I can go off of.

This part is explicitly documented in stable-kernel-rules.rst. In
particular, it lists the 3 ways one could send us commits for inclusion
(https://docs.kernel.org/process/stable-kernel-rules.html#procedure-for-submitting-patches-to-the-stable-tree).
To summarize, it's your choice of:

1. Tag it with a stable@ tag. OR:
2. Send us a mail to the stable mailing list with commit IDs for us to
cherry pick. OR:
3. Send the patches themselves (which is the option you've picked), and
then the doc proceeds to call out how to include the upstream commit ID
in the patch
(https://docs.kernel.org/process/stable-kernel-rules.html#option-3).

-- 
Thanks,
Sasha

