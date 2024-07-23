Return-Path: <stable+bounces-60779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7693A13E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939DAB2286B
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB11534FB;
	Tue, 23 Jul 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CAm/1y1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zp1wSOgY"
X-Original-To: stable@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C531534E7
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740807; cv=none; b=C0Cznn4QF1LUFZdTS5IVKSXzpf1xc5xSL0enziReXLbJeidFhG84h4fiD+3CwlN/dkuAITF5aiMu6kZeag1hm+2WhX/wtOmOJs5grZUeMt3VI3Eru5YaOtmUW5F0iBqOM4h2Bx3B2mLTc+s8htaA2+J5CiWV2n1oi63KYWKNBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740807; c=relaxed/simple;
	bh=owrmssXDvgdeR+v3N6J0SxGu6irElxQu2K/6W4OznCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7+hh5s2O8waqcfcVszR5aS7AaANMPJheGzhWt9JKqPpsqg2Q7bgHKQptjkdRb18solLO85DT63T6x+4UMCy8YOK8C5t3tEzsKRH71prVugPJvMZ1DtZ/BGGvofQgSBWSH6jTrEzoXg/bS4lud1W9ENsrUXbOwJ6E/D7nc3KEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=CAm/1y1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zp1wSOgY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7F38D1380318;
	Tue, 23 Jul 2024 09:20:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 09:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721740801; x=1721827201; bh=4R8nGwPaXz
	/azKgHfDX5tsy0BcGis6AXT50vfuYJPkI=; b=CAm/1y1NtIdPf9ToSvWIWnj9Df
	ePmYP1hxoyHoJ2qgBtVUNLHYi0m3BFIs9LbW+758iUfB1VuSUELPdbNFidbfDTOi
	zi9FYJu+grfMM4rI1YXO9IsAUvx3+dFWiiFrhRC3QPgl1xK8Xez655RZHUfoClIa
	9q9TLhz1b682vhAPRTNr/5eb2g5RKuvFk7t+zdSAywYFTBb42681Zq4kuI3zOY3H
	HJpfakhbUxg7wngLDHcl915mFiNMGxyNT4BEFcYWLjeOLjFy52BFjlf2DvHj7how
	BftaY0gzIkYBVHnopYmvGCoZc6yLTKKjRTnRO3YRQ6tr3K2lGA5SZp7IITzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721740801; x=1721827201; bh=4R8nGwPaXz/azKgHfDX5tsy0BcGi
	s6AXT50vfuYJPkI=; b=Zp1wSOgYbdlOgFOP2Es6ZqyXPcvS5w4+c9+EMn8DcK4P
	33KjPQFkmS45DFCUhAs83mi5gL6d6Q/5vI3OeP5FKr+QEwLKKNBpGboMkc3dN81L
	SAFedVRtHu6yCkblbgZMChdqPekOSLUDOUEIi3K1hYpEBB0+uTa12zYYzVNvFTS7
	XuvhyV2YzhPOS2QN8gocUkDTyq7eJfl3/X5oiSg/eO5GtQRcFqIQyTiH/95gE6rD
	NxgsL2Y+aBdukX1hkFf1MmCPgT7Hey954wOr5xFZI/D55xRTHwTky+LnI3sD2I6b
	UYqGLO9U/iS/uHAWohniC0AvmcGDonlpQrlbZCrb0w==
X-ME-Sender: <xms:Aa6fZuTmKOcs0a1BRkcKA85X9yHgqIW94KoKx2h2obB0jFWtbHLmTQ>
    <xme:Aa6fZjxDAQbLI314atLkTDMWSMCP3IbGoDNWtWcj327FDA_kM6n3wEJHptjOZVBnE
    yV1wntBtC9Z3g>
X-ME-Received: <xmr:Aa6fZr3goavtY7iyAmFRBLNJOorND-kzUAJL4TvXshIWPzPGRZipcAEseBzyY5x9L1XVd4nGUymWGtGgGcNA6uDesw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedvgedufe
    efueehfeeugeelffelieefvdektdfghfejueejleeuudektdfgkeelgeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:Aa6fZqDq9dzaCfqJkFs_26WLXOEk7d1HJt68RHCM0o3NNrWU6Zo0TA>
    <xmx:Aa6fZnhqRE1PqgBctl5nmpPElWR0wLjBCfKkT8GTu7HK-n6Igr2bNg>
    <xmx:Aa6fZmrBTxW0qOrevIQWyEHz36Oj5xoBMrdmc2nhn6xCcNfcgGBeDA>
    <xmx:Aa6fZqgnEGcoZA22DfjAoN8yis2W3ZDqsy7OeBrtCv0BqE5W6agHWw>
    <xmx:Aa6fZoVyLsVj04_cU2zb9epLeUkvI53nBv3CkV_NhxlbFm4PQF30z6_y>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 09:20:00 -0400 (EDT)
Date: Tue, 23 Jul 2024 15:19:52 +0200
From: Greg KH <greg@kroah.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: stable@vger.kernel.org, Julian Sikorski <belegdol@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5.15.y] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
Message-ID: <2024072342-oblivion-stucco-3808@gregkh>
References: <2024071528-foothill-overdraft-d69a@gregkh>
 <20240716153031.159989-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716153031.159989-1-visitorckw@gmail.com>

On Tue, Jul 16, 2024 at 11:30:31PM +0800, Kuan-Wei Chiu wrote:
> The acpi_cst_latency_cmp() comparison function currently used for
> sorting C-state latencies does not satisfy transitivity, causing
> incorrect sorting results.
> 
> Specifically, if there are two valid acpi_processor_cx elements A and B
> and one invalid element C, it may occur that A < B, A = C, and B = C.
> Sorting algorithms assume that if A < B and A = C, then C < B, leading
> to incorrect ordering.
> 
> Given the small size of the array (<=8), we replace the library sort
> function with a simple insertion sort that properly ignores invalid
> elements and sorts valid ones based on latency. This change ensures
> correct ordering of the C-state latencies.
> 
> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Julian Sikorski <belegdol@gmail.com>
> Cc: All applicable <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20240701205639.117194-1-visitorckw@gmail.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> (cherry picked from commit 233323f9b9f828cd7cd5145ad811c1990b692542)
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/acpi/processor_idle.c | 40 ++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)

ALl now queued up, thanks.

greg k-h

