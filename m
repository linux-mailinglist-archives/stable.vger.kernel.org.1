Return-Path: <stable+bounces-208428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD635D2338B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17CB3025A7A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3533BBAB;
	Thu, 15 Jan 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTsFDnHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67933ADA4
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466442; cv=none; b=cIWXoI9mPob0M2dMtZ10Vig8nrZVt1UaJqt/7nRlYpXzQSl9jIztZ7wVbscWJvgGeOjvXu+366rkCthhQpPDctVx6aOqvBjT7ymVQnCeBmIWEKxqafg6IKBT7T8jSx/ZBthw/N3LCqtIpH+uN75FFcLJvuFkZxd/5v0osNp2jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466442; c=relaxed/simple;
	bh=kGAjDZzXN4M/Us+cwgsQzxcZ0zrYKWPTy1HSPmM0J2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfBmePC2O5I4lEvnoVTtbwCsjP1190X8hmampiUKvJgkY8MaDiQiYipkcvRHWIMxaALWQS8twuzr7oPEV0qBr5TcrUd6Sv7dYZ0lKMbdH4SPxitLZDP+PtkyMZtp5o+DMNeJSTL0WoQELsPUqUbBa399a4byEASgVTZrX1qJIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTsFDnHu; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c530866cf0so65875885a.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768466439; x=1769071239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MMFj9gQvn0V+NVRRKsqf5Eg6BpjQZxX0IqjKremmDdc=;
        b=CTsFDnHuyto/ZUtIPByPVikfRnCgoSMcygMfyk440aMVgUruAYRaebcg9VIzs0VaJ0
         BEKAkeJ1r53tgallMAqw7TBzCsqDDT8GJZF9vSrGBXzfvVdl1L3begTZWi4rjilDjyYO
         n5byGXGhbSD7lWLW67rTWVfEVH/MotjGmAExAV30OJ5/IeWeY8pruzIuoOZ20RNsSY9T
         wH48ppJTVODK0rU3cXeo6Bj9fPqApwDaxW6sVaNKGGtDfZk1Xr7Wma42vpit7CnhVDEz
         dNQZsLjuabACw/aggfcEz1sLm3hoRYvuvXusF+Eud37tJ4P8lkVZKZOuDhil3+RtKw84
         gHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466439; x=1769071239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMFj9gQvn0V+NVRRKsqf5Eg6BpjQZxX0IqjKremmDdc=;
        b=eeZmHUcxntY46jes0D/GTibn++hSL6JFjPFBz8G2Sgy4VDG4eGi5lEx0y/q+qOhHL2
         9kVX+CizjLATPwNHeIi+i44NHdJCiYeHlvz6rrF8QmCWBRsWpva6fDhPLUvb4wvZ3mcN
         k8ht9bUpblRdaD+KH4BKo824o9kyqjnG8eiu8W+rlw+DdayJ0EksyR4XBuDbXiX9NoZV
         xvl0TsnkTlSzToVAhbwx7Qr6EX51fwqWBquoD/8SaTysGV8ZGarwX82DzIx2Ff/TyhIi
         EWRJkyxchFoCzcLlJrhMt0b9B7Wam4f5CcBAHUT8dRH1INcxM2K+cO86RvmTTbjAa6aT
         poCg==
X-Forwarded-Encrypted: i=1; AJvYcCXruY1KMWtjxvspzlqbtuMygVXuB7736abf7KTXL6+YH/DBgo6AsRWtyer9HFZskYA1JKVtAew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz50mrquCNIZiZIenf6rFbwt1zu26N8BN2Q+EnZ2UHEJo2BkKW
	ASMQHUqGeQ+65YVSItTPyJUo6+CTzp0CyWaa1LwWGryTXrj0uM7trLSs
X-Gm-Gg: AY/fxX76ivqgdtPttTP1Ygt5xn+iIGCpQIj6Z649M0DJkdvUbB3Kq1G++plxlbMXY6y
	RhwRf1V4WByVBePKiCXDcUdg240JQ7uKQQ2en80pY+JX4o3jbukfVsmBbXGxfJ0LwWOunIEwu8g
	gAvwmVqZNPu0+kkBw2hhnHaSnyngSBdyfROGP4nEm8DMqvLE/RH9NeNhHsuIrCu7m6qzhfKZtQd
	NNu4/IKXHkXCc5hUZKt2FYXQ1Pr2lQ95Z6aWcRqHvum8hHtkO0CahpLb0dbTe3iNRqk6IRqACra
	u0BdMmfGC0viE42OSyxfN0lf4/RnIlSOhwg99D9M2e9IfjhHh/9rfhrZQ5jFEGwYtehwy8OOLtd
	62wLxCeI3OCHqQke2mFPxcbo0CnR/CILieF1rboCw4bxVKuz5VT+TjfSTeBVF90zCFJvXHfSW10
	hAF5+7iOi0uIT8JNl1A3Z9FDNEjE9bp64h1Y2R7yWVKQW3CBFtlrrQsyBu2IKAdqtJGvbH7GuoS
	p1HAaij0qHBqGk=
X-Received: by 2002:a05:620a:45a8:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c52fb26dd6mr717196885a.35.1768466438971;
        Thu, 15 Jan 2026 00:40:38 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530aab8f1sm343318785a.23.2026.01.15.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:40:38 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id D1B16F40068;
	Thu, 15 Jan 2026 03:40:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 03:40:37 -0500
X-ME-Sender: <xms:BahoaXVof-Jyw7Z6RITyRBaIkZ5XlAX1C9SPLmFn5Es3DNK4JVtNFA>
    <xme:Bahoaf9LA3THVNmine0aE8aflwQlZ3_uLKjR2R2kzsd4gPzs2NdIY3rG1BaiwX-fc
    -lmtZgzkpuKH2PD9gETd8EIy2VhNjcYN1wVbr35UcoirbE5R4Hg8w>
X-ME-Received: <xmr:BahoaUiDfAs4aSlYtB_QAPiqUKlJxJe_8pTiE0RWs2r18mToudumnOyj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefhgfeg
    leefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtg
    homhdprhgtphhtthhopegrtghouhhrsghothesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurgestgho
    lhhlrggsohhrrgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BahoaeVGKNaYGqbaDEfjcF7V3emi7UAZMjkIRbsJRCByuXZd5Gtzlw>
    <xmx:BahoaQvyIuuAifADi7UrBTdfqCJux7tGe3R64zvjrjG0bQMSgb_Ebg>
    <xmx:BahoaX-YNtrf8GLDNJtUy7zSy3jrSeXp0gslTd8GgCVCQ5GJi_n04Q>
    <xmx:BahoaYulevMC2AFGaIIvQL1TcHWAYBPwsGl3Dttai3j8AT1MNXZGHA>
    <xmx:BahoaV4lhB06B0R1fxVkyF9e_GlHDU0OyeqB1eYzoSCmzNJH_DlvT0P7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 03:40:37 -0500 (EST)
Date: Thu, 15 Jan 2026 16:40:35 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 5/7] rust: sync: refcount: always inline functions
 using build_assert with arguments
Message-ID: <aWinBMASjagM8gNQ@tardis-2.local>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
 <CANiq72=U93ceCxLH_HYesCvCywpCsou98kM2Z53x=cx=iVXm0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=U93ceCxLH_HYesCvCywpCsou98kM2Z53x=cx=iVXm0Q@mail.gmail.com>

On Thu, Jan 15, 2026 at 08:49:05AM +0100, Miguel Ojeda wrote:
> On Mon, Dec 8, 2025 at 3:47 AM Alexandre Courbot <acourbot@nvidia.com> wrote:
> >
> > `build_assert` relies on the compiler to optimize out its error path.
> > Functions using it with its arguments must thus always be inlined,
> > otherwise the error path of `build_assert` might not be optimized out,
> > triggering a build error.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: bb38f35b35f9 ("rust: implement `kernel::sync::Refcount`")
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Boqun et al.: do you want to pick this one or should I take it with
> your Acked-by?
> 

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Going via rust-next seems more appropriate to me, thanks!

Regards,
Boqun

> Thanks!
> 
> Cheers,
> Miguel

