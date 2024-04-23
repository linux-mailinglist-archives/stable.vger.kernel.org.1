Return-Path: <stable+bounces-40737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E38AF490
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B937281539
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773313D512;
	Tue, 23 Apr 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="s4OVlS28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaKCTVM0"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358813D505
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890830; cv=none; b=L18Y03O/8aX8GUjY2kGM8WlnD+IiYbHT9Sd0riczq6VCtgFFy6JdJ6BTvRgTyWdFOlesFMGHx5lP5ORHBHLpUGq8HGvUhPUfRO6aGoRk9Ex72o5zSqApz08wBmnrRG+R3tdzRnjMTpKQ8r3QdIw7CsP5WhBzLGDaykKIYmH/klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890830; c=relaxed/simple;
	bh=WoeIrVltUTV3SQ/SEvCatSZ9a600iRbNsoNSieJomgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2f0+i6mbjzC+xv/hryDKPPF4EVJZtCsPJNYLvu2hvk/aMV7+6hVEJQBdSPj5N5hcRyOfXGFvB/FHwfQxHBX3nZeHeJ6bQPNuDTPYrjf7YI3oy8gOKKAf2oBa2hjxpCgA8jtScwpkEG0l1ulrpgbb5pbffug4RP5CwtYkLqPiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=s4OVlS28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaKCTVM0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 25CC013800DF;
	Tue, 23 Apr 2024 12:47:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 12:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713890827; x=1713977227; bh=AZ7MHfrHJg
	of32IYcbhgz3VfP2oNKOZQvC0Z5FMt9Rk=; b=s4OVlS289OL8OJqDatFWesshxv
	KjmKmt+x+jMp+mLXnwvTsxPtNQHPMoFALuk4uqybJ+UiaqCZhQFV7rh7uqWn/aw4
	L++wahLxV05PIwWavmJUKrseScYciLUggUNypPij/2/eAT8PjA6boZklE5NdFAvT
	7Pqtl5vw8TVEHzeLFMLIeH6chLRIG39IUsAraTTqaYrFx9Gxa8qUIAB/CsyGkXdv
	Kk/CsFCcMDks3qSbHi1qnGMpjH0ZXRtAIpmN2V+DfSdDnjXPZtk4rQaG50KcP/Nm
	/kwM7qlN+p/qIt2B8rasa2Fs0WVuhIuIVpsHbGTFRGi9w2CbninSnc05LXzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713890827; x=1713977227; bh=AZ7MHfrHJgof32IYcbhgz3VfP2oN
	KOZQvC0Z5FMt9Rk=; b=TaKCTVM0PpngQK7cZsKpmd7C2R8ioA7qPgZvJB6v8evy
	SlA/fFn1i381BCOio6PvIL/PoSu026NnxD8sd88jFiHslAcWYdTmZcp8jaHr3iRX
	buvsW539Y12cgUBvr+Emd7XAW4MU4HQQswK8/z0RUedJRP0tcywYXqUsS5hc/T2F
	oSikYTBD17QeeOSF5YLt0UboN9r9Za15QGuFXZLV5+mwnY2CD1qbVWEtV7hR/nGu
	rQmTXkodDCVrCxq6hTMUdMq9Uo80GnCOW5Pze9/9keFJwA3h5A1j7ZU6xqQvFRgo
	mri9mIQH8ArkoOIf0/pW0Atb8F4/If9DqmDEdkXhEw==
X-ME-Sender: <xms:CuYnZljCKDSxXg8B5cH9MVGxWfitLY7xp6FJZw4elXung7L_CMB-eQ>
    <xme:CuYnZqDrC5V6ta3_qP9eCoGxbqKItZgJU_KZVWbiyPkJQmcvfoK4ySMbbCg1qWMCK
    C2rVBnbHs6N5Q>
X-ME-Received: <xmr:CuYnZlFrpRoTmNqsntlNvsU2c1kaJvLcrbtXnqfDwjr59I5dZAx9vsxLulyj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehff
    efgffgvddvkeffhffgleejheffhfelheeljeffffevueeuudehgfevueekjeenucffohhm
    rghinheplhgruhhntghhphgrugdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:CuYnZqTjaGhf0bT9N4rTnI8X37d0tuOJ7gxR_m5aOFCdbRty2e5STQ>
    <xmx:CuYnZiwJogAoFID-TJSb07V86inPXbx5jqeRXvUrVqLGsqYRCasZmA>
    <xmx:CuYnZg4MsvZBCoTHboN93x7EWWrpFzzcdtM3N6R-KjjNBg3znbvMnw>
    <xmx:CuYnZnxHKbR0_VwmCvoUKH7HekZUTADgjcPmGpz1lGq2ji-AVmpSRQ>
    <xmx:C-YnZno-jaUgXQGhCU1k6uqUpH8Lt3yYWM_2xI9mWsU9mpuptdIFX7Cl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 12:47:06 -0400 (EDT)
Date: Tue, 23 Apr 2024 09:46:56 -0700
From: Greg KH <greg@kroah.com>
To: cel@kernel.org
Cc: stable@kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Message-ID: <2024042332-feminize-showing-b4a4@gregkh>
References: <2024041908-sandblast-sullen-2eed@gregkh>
 <20240423163702.11681-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423163702.11681-1-cel@kernel.org>

On Tue, Apr 23, 2024 at 12:37:02PM -0400, cel@kernel.org wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> [ Upstream commit f488138b526715c6d2568d7329c4477911be4210 ]
> 
> The nfs4 mount fails with EIO on 64-bit big endian architectures since
> v6.7. The issue arises from employing a union in the nfsd4_encode_fattr4()
> function to overlay a 32-bit array with a 64-bit values based bitmap,
> which does not function as intended. Address the endianness issue by
> utilizing bitmap_from_arr32() to copy 32-bit attribute masks into a
> bitmap in an endianness-agnostic manner.
> 
> Cc: stable@vger.kernel.org
> Fixes: fce7913b13d0 ("NFSD: Use a bitmask loop to encode FATTR4 results")
> Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2060217
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> [ cel: adjusted to apply on 6.8.y ]

This is already in the queue for 6.8.y, perhaps you missed the email
saying that.

Anyway, thanks for the patch, all should be good now.

greg k-h

