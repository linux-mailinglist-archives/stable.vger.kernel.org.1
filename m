Return-Path: <stable+bounces-227946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGNJB30WwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:31:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B623D2F01B2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78905300B1B6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD222D9ECB;
	Mon, 23 Mar 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ev/FqtzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lp61ufra"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B752339705;
	Mon, 23 Mar 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261866; cv=none; b=e2PzuxWrc+I6PYI87oE/1APXe0knSJu3ChipeJwp6YbIWsiiMZhqe8LPvm3kJmIZNjQrw4ARY3J3E3e3JBriIFp6neAPe1qYiMMqb9EbIzRQAHtTCi3lEOIm9AdcOmNowoww8kxoTw/wJwuZSEFK5gbr6Ss4xCB8L1VjGQA8KX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261866; c=relaxed/simple;
	bh=o57WsCNbwvjHNhkGhTYhATscjWow/OtPXTYDgOeZ5dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7ITpeNn7CBeGO1kAh5k3eUnkA6o4xj95UrFutXmHYequJ/6H2n7a3VYQEEhYVey4cdrM6qno2TRUVswr+XHrdyU0ROSdtkGaBSr8ADg6nrJWtkAxyr+woBVr0BIhDH0f9lRRxGwm4+/4HClnsoXcF5knnU1NjBzp1nr5TqV2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ev/FqtzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lp61ufra; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE1A77A027E;
	Mon, 23 Mar 2026 06:31:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 06:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774261863;
	 x=1774348263; bh=jfFSOp7ZZS5jsqZDnTSDsz+9Ejh+//+6Fmu2pNUaBIM=; b=
	ev/FqtzZk9yXaNbU5C4NSyF3mD1aQmnt8k5TE9K+XmT5KdF1Kx9RFC6W79uyCReL
	swMcNJ0fOu4dV2pv5yuxCpMFkFBo0lN+d7ngOQJGPFokosv9lrnn1SP46oeQqI7v
	eA+SrN2dPR0J27e61q+LW/iMB2Jwa5z2disOVIntYJ96aUzVkQAR5OrQ3Qn04MKz
	2weIfeReiMkOQaL7vGswLxLCnQuoq5J/fQV0FmgXONZIDpnGcC9z77XMDtRQXVhr
	qyEm+CyKsdZUol9UYYHKZ2dqEyQaK/2WbLd1AL6bVpHlmn/ULvCdko+EkeqV67jX
	W2hgecXXUDaHXHHQEnph4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774261863; x=
	1774348263; bh=jfFSOp7ZZS5jsqZDnTSDsz+9Ejh+//+6Fmu2pNUaBIM=; b=L
	p61ufrayoeAxPZVzkHyPmq/mwtlR1ycFb1qm4zuDcVZU81gzExnY2qwKUzJRWL7Q
	7RhoTKnAQNTJCNUN7ignZgqLer/vRDSXy8+t0+qtJJPBZvzJTL0d79dIbmDUc2KD
	PpVhVwV8zwD2M7nb4qLcw2Xq1fJCOnefEjTdZnuNbBGxSd5UFhJlRoUwsYUgEHzt
	/UDTNmPYMPwTVhDWIiRjSRMR0dVYyC5+kjnhfihlF/4q5sZmWn/X1Ln+idP79ieX
	YMokuwtL9Hn3+JXMww9UweZ0EAJbA2PW6FWnKr4b2FfdUBk0NFOjL8ph98mC4m4s
	Ni8f91YK/S50LZs/1+NAA==
X-ME-Sender: <xms:ZxbBaaWUmbeJOOlSRuT8ESxht47qThp5kGb5_k7hzjfUrjnLMkSipA>
    <xme:ZxbBaajPNhSd5ICbKNxXcN9SwXmzbolsL3DmekPL-nL4cRILVUz_0-eYpJ9-yHouu
    Rdxae_U2HW3u8fCO6ry9XQKYU_mSyGwEvUGlpsVEfjVN8H3Ecs>
X-ME-Received: <xmr:ZxbBaW6ahEF5WNjkwUnvQY1DL3XzoyqV4q5sokmX2_T5NWx6FZelcEyYEsAa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgkeffie
    efieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhosh
    hsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZxbBaa6leDsw0vBXavBvHmTqjl0uiNn6ruvM_xZ0zKvCDB7VpP0I_A>
    <xmx:ZxbBacExaSafb1sqQE4AdHsE-Z_sqaRltVz5hGTboFpFlUH_Jdf3Vg>
    <xmx:ZxbBaQynshhOTSYtqW8zDjuwaVkqD46Vg4zJQZl1MM3Y9CxuHVXI9A>
    <xmx:ZxbBaU0OJ71M4eGFBSOfM0GwDLmKZzQHq6siExUp4aMsTNEY8KsOSg>
    <xmx:ZxbBadNj3PrMiBmGTtLihCDLk3kdZIeNwOlEjDk4SRfLBbHEVc3evyte>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 06:31:02 -0400 (EDT)
Date: Mon, 23 Mar 2026 11:30:42 +0100
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: Patch "rust: task: restrict Task::group_leader() to current" has
 been added to the 6.18-stable tree
Message-ID: <2026032349-unlawful-undercook-400f@gregkh>
References: <20260221161726.4075998-1-sashal@kernel.org>
 <CAH5fLggmuHNXpfHo2mPS0TYu8mwr8G6EKH0YPuCLX77u_dxF5Q@mail.gmail.com>
 <CANiq72k6=OSk-vLbmKjqcAUza700v-OtToEXiVbqWPkNpPbVVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k6=OSk-vLbmKjqcAUza700v-OtToEXiVbqWPkNpPbVVw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227946-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,garyguo.net,protonmail.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kroah.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B623D2F01B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:18:50AM +0100, Miguel Ojeda wrote:
> On Mon, Mar 23, 2026 at 11:11 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > I noticed that this was backported to 6.18, but not to 6.12. Is that
> > because the first user of this function was merged in 6.18, or is
> > there some other reason?
> 
> If it was meant to be backported, then the commit should have Cc:
> stable@vger.kernel.org.
> 
> Perhaps it was picked for 6.18 (and 6.19) because it applied cleanly.

That is correct, we take "Fixes:" only commits as a "best effort" type
of thing.  This doesn't apply cleanly to 6.12.y so it was not applied
there, nor was there a FAILED email sent as it wasn't asked directly to
be applied by the developer/maintainer.

hope this helps explain,

greg k-h

