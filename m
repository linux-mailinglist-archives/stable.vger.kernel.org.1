Return-Path: <stable+bounces-61804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7693CC0E
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 02:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34241C212C3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 00:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CAF7F8;
	Fri, 26 Jul 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="K93ilpvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+iLQzTB"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24363C
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953254; cv=none; b=tF7pK2tZ/S2PsFNRQe0DNnByjzxOewPPeArokuTrD0IshnG7APZQsFh6R9e4vYc7ymAVmVl1FDMjp40BCepgAHfxLWNxJhGf3K08xZw2ePjS/90VaLwLeVP2EqhgIifCgcS+bXSonpK4JRCkwZOA26JR4QaAGJAViBnQVaVBoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953254; c=relaxed/simple;
	bh=19PffjGX6HnTrYfEMcthrkk1yAnQMUN/ntCDAQqVhTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWCY0/IwimGZnjSgRXxM1lTbs9zkmVyijMUDaxm40jAqv3mMUsFXM5Gu1eygGxtZMgruXkEEexpCj6yR0alJD0fxoDpAidGyFmymezjPfq0ZzLJCHSLvhIfgFs5Gu/MrJ0KJQEHn0L/Chj4qvv13Q2qzHA8llJOlAqXMe+tCVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=K93ilpvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+iLQzTB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1BA5213801FC;
	Thu, 25 Jul 2024 20:20:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 Jul 2024 20:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1721953251; x=
	1722039651; bh=0fr/o9zcjd3R+gK3Ltf8ysW/U6DybHbmm3mRh7A1eWs=; b=K
	93ilpvFftS8pMRjbsnrb7qqVpsJ7xtyrdcHPO1jlWJmXzQDUd0cLeTwLxxp8KlPP
	P1Mt4w03bnUNzJUHJgRpz38HUWUtxMgsEQW6G2hk9g6H6wL1bIfZuzsg1c9boUsC
	0h1RpbItelqWnu4f1zCxWlGnXSNsp5y6uRZJarjHE4EhFGcJAzh1sf9O/TU5qlmY
	aRsNEzlyPy9JZN9SrsDikK9SHN2ijVXVX3+q4hEnn+mucc8f6tLh4EArg7ilHXo1
	17bmC+mjR4U2nU58fIXZc2NzFhfsSB3Cf3Founps9K9Aq3jcXI8lzcbRq7QOPph3
	LVt4RDGeWb5A8A28PQtfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721953251; x=1722039651; bh=0fr/o9zcjd3R+gK3Ltf8ysW/U6Dy
	bHbmm3mRh7A1eWs=; b=N+iLQzTBKvbstz8l3ps2uYKgM1bnI8mFvTLf8tbuaq3Y
	MNow0A8FqQ2x3WecCEfivpZGD9BN1KbbMC1b48fs7XB1XL9YiVC1KUygc1n6PO3I
	mvxplxIbG8vQZ4r+hJVD3HD48VOI75MC3yvhSrd4pBOIJs3IxUkodyOrajmD4ynd
	/vkhu9XDpGSIlB+am4P1hVvpkIiO9qk6SQwaUWBrczsfTRg1y/GLBU4/hx4Bl9kd
	Ppa0/mr+XAknrzLWDRk6f/xObjUOz/6xS72QN5H0QTNpiFGwfFdKqvW2oAYstZXc
	Uw/yLxQVZ6ZxGl1A1H94Zg6qPjOk44bHN+f9AqmdgQ==
X-ME-Sender: <xms:4uuiZkJDdd-xCPNmp0TNYWwO826QpErvp2aZa9vhBu3f7fGmelpPHA>
    <xme:4uuiZkILKQQSUEAi-qMBddg4J3iCFmEPnX-ZFdhhJDOI0elgwx-RFff4TBUzCSfWb
    bXsfvCZ49m92lU4Eq0>
X-ME-Received: <xmr:4uuiZktvzzk9u08LRBgzSWEPDP0QOrdquRG2ukK4I3xH_bDpI6msIQWNwVYCwluFAyp-mA_fZfoaGGqcGHkIELH7IY_V804FI_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeggdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:4uuiZhYxV-OHivnMeSmaDLkyivCh3j3-7xCziySAgMYVxiQ7oMLBpA>
    <xmx:4uuiZrZuxbJ97D3VpLhpzcHTcZCybDFSF0Jv2MFhwHk0U9ReGrHU0A>
    <xmx:4uuiZtBDNuRQmVg_llO5VFUX_CsxHGuipeew7h2geVNY5XRYLqvsLg>
    <xmx:4uuiZhZRZULlc57utfEWellLpXzZfWIyXlMVZfv5PifYJBHk4cBMRA>
    <xmx:4-uiZqWsizNCdBX9FoYeFgSH06uv5a-c77jAwSN1YUgA60hshL7RR-QO>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 20:20:47 -0400 (EDT)
Date: Fri, 26 Jul 2024 09:20:37 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header
 for CIP_NO_HEADER case
Message-ID: <20240726002037.GA136176@workstation.local>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
 <94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
 <877cd9ih8l.wl-tiwai@suse.de>
 <9d039b39-06c1-4328-bd5b-8b2c757ee438@embeddedor.com>
 <20240725162537.GB109922@workstation.local>
 <8734nxickf.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734nxickf.wl-tiwai@suse.de>

Hi,

On Thu, Jul 25, 2024 at 07:52:32PM +0200, Takashi Iwai wrote:
> On Thu, 25 Jul 2024 18:25:37 +0200,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > On Thu, Jul 25, 2024 at 10:16:36AM -0600, Gustavo A. R. Silva wrote:
> > > Yes, but why have two separate patches when the root cause can be addressed by
> > > a single one, which will prevent other potential issues from occurring?
> > > 
> > > The main issue in this case is the __counted_by() annotation. The DEFINE_FLEX()
> > > bug was a consequence.
> > 
> > Just now I sent a patch to revert the issued commit[1].
> > 
> > I guess that we need the association between the two fixes. For example,
> > we can append more 'Fixes' tag to the patch in sound subsystem into the
> > patch in firewire subsystem (or vice versa).
> 
> OK, then I drop your patch for the sound stuff, and you can take it
> through firewire tree.
> 
> Feel free to take my ack:
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
 
Okay. I'll send them to mainline as fixes for v6.11-rc1.
 
> thanks,
> 
> Takashi


Thanks

Takashi Sakamoto

