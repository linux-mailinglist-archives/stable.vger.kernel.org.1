Return-Path: <stable+bounces-33577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA3891DA6
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7BF1F2992D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1927BBC5;
	Fri, 29 Mar 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aCch/FTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="saAnDzp0"
X-Original-To: stable@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D38264D9D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716404; cv=none; b=Y9FJbJ5xeoic7stunaeGyV4ZVci33rdKJGZX99skikjkWhyAQaKzzqDACcfVPUE0ieIhVG7F43AkQ6RzJ8JQtajy7FAqXskbfSWxlsm+A4UXZIQneGlwcjxLzEqXM81OHfpzWlsAcIC+NqpwcMuPRk+WehYKA3fyyGNCyG0q2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716404; c=relaxed/simple;
	bh=CA7TXGN+N8A7k+Id+HNnB2cWMvU2B9wyx3TgPK9wBps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiJO9jzcT4h9rAj4nsVrGJONegMUd+B9IIQ/AGnhO82oiT/Ho8uGM60VVM2nUKzlgRUs8zhGHQHXjWnVQ3CEZ51FnUJZ2dLjCZ8ybrV4u1wZAJqieIPV49bgrnHGuOgxAg2LhjmnF7nj+t1nNYD76Wts0A2o+4sRqB35Fzoh4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aCch/FTb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=saAnDzp0; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id A1328200497;
	Fri, 29 Mar 2024 08:46:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Mar 2024 08:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711716401; x=1711723601; bh=C7kBcjxKQv
	HoMNz9HyBxpQkj6y8S+glzvNj2UrCOq8c=; b=aCch/FTbF/OhLmQNhp9C/b0pRs
	DUXR8KK78rWp2Fafwm5n4hXBHxHhKC9zN1zeS0AFa/BhRbtRgv4TH9a54a+RjLtS
	8kmxum0gtCEBbJ1zKLvAwgRn3uwi9V1ypAv93gVR8Cd00BV7yJo6KU1Jf+OmzujX
	KUx8dzhdHwUBeGknChcgg2ajiB0uLfdRtnh/GoNwHfbi+Z4uAerXMIa1x3GvVbAR
	T60ZlaOvAso7ekzrdp0VCryiCx/6rvvFc/hhA1bK3pqENoFlnApsMmgdidMfXSTm
	ypV6zwQYEITVrK65H1h6MIQSP9xDmAX61Ka79WwEcOpXWSePLfXOYq1fHb6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711716401; x=1711723601; bh=C7kBcjxKQvHoMNz9HyBxpQkj6y8S
	+glzvNj2UrCOq8c=; b=saAnDzp0VHdlL48vEhmKJOueWa911CSy3ZkJq2aY/w5h
	pOIzuJ9tk/bjwhMYNexxE3i8kUMJ4GfabDJx1T+gH2BFmGYg8st6q2gEVqSrvP/+
	/r9z5YRVpyaJggsllYFNr5liPYPHDG3wgYDYBnF6mqdpyLRrVzFAK7tCpui4OEsN
	ljKqbfcNYJkoxMmmU79ynLweFHWo425imdOt4c7b3/b6DZZ/E53LNL5y+tiFlqpX
	2etRYl9BviiB4JkBgQzjk3eniNTjQuY+d3GYP6wcamBmVAU4LihMEwEyOAo/afwz
	vVTdrGH3P5UviysLjwvpw2WdxyYX2LfwDRXf0qCOPQ==
X-ME-Sender: <xms:MbgGZk0uKGXv-tANubpsNbKfe-o9foDC3ZNCmlw3Rno2fIubAuKZ3A>
    <xme:MbgGZvEAp-heWGl8fadgB3U1oAPrY339rcw5YJoC0JBH0AnTluGnEyCSTczMk_UKE
    7tPNF1yACBuqQ>
X-ME-Received: <xmr:MbgGZs5EgO17JnV4Pp6iZiplsSBg5LqsBKEiSjp1KUkgzPeyAC3nzTBLhmO9406QZ41SXWaeF5xUNeD2vHxEIeM65DJG6rw7SIzlOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:MbgGZt3LObRiJsOZC8emosXjCuYNhIcZSLBkkpVNZ4X24uSAKgKkjw>
    <xmx:MbgGZnEfxHvPSMZ6qMHdH8kSojJWzTsmctAyyx0oeH5eTSvbbgFBXQ>
    <xmx:MbgGZm-F02HkgvNHXSF79hSXu1ljkrvO6QMu4FofmwqdqdoqUAIO3g>
    <xmx:MbgGZskb42dgjVF0Eif_3pd50FNVogfTvZ_zCbKvfpg2KsRAvlfPZw>
    <xmx:MbgGZvWlnzmjSgC4T6t7egxKj7t5SQCf3Qe6TAAtAycOoiHwtujDjkqswiY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 08:46:40 -0400 (EDT)
Date: Fri, 29 Mar 2024 13:46:36 +0100
From: Greg KH <greg@kroah.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 5.10.y v2 00/11] Delay VERW + RFDS 5.10.y backport
Message-ID: <2024032929-bucket-screen-157b@gregkh>
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

On Tue, Mar 12, 2024 at 03:40:21PM -0700, Pawan Gupta wrote:
> v2:
> - This includes the backport of recently upstreamed mitigation of a CPU
>   vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746).
>   This is because RFDS has a dependency on "Delay VERW" series, and it
>   is convenient to merge them together.
> - rebased to v5.10.212

All now queued up, thanks.

greg k-h

