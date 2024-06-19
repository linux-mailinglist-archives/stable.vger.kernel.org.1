Return-Path: <stable+bounces-53821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E190E8D7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497F71C20DCD
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A59132129;
	Wed, 19 Jun 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tkXRMYcN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWxUHYa6"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6A81204;
	Wed, 19 Jun 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794752; cv=none; b=Ry3ckyaWHNjnx24hUv35vN2VRKBa4nK/MyR2ndnYcliu5+U+cz0zl4QJmBMilexRrzJOS777Cy+FW5z1niuPHGXEQPC1rjQNmXsdx078GauTBTHvWL3SQG5POdKBQYnmZNXj35/Lwj4zb61cF79TBxvGVZpt9mV+eZ27eaBMjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794752; c=relaxed/simple;
	bh=CM3xmlfmM+TzHllb+lpS14Br+vIznOi+vJ+i4b0KavA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm3I01+PcEyf1G7f18swfdYSftMfWLrLRjfpBIX2cS1afRABPkD+18FLaZOSRg6A6B5P5KBSPyULGSh6Wo41rALs7ikfK9QQoQQgRQoM3ih/D29OTODCdcEnwpFZFFIlf6KUoEZQbY9sA5pfq9a5wnWoMQMVIPEDlR43LH4+QMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=tkXRMYcN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWxUHYa6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A48C6138037A;
	Wed, 19 Jun 2024 06:59:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 19 Jun 2024 06:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718794748;
	 x=1718881148; bh=lH+uB87WTdsk4/SHdt06h8+wStTRaycKOhrkqXOp1MM=; b=
	tkXRMYcNmMsgltSOq+QduFo0SFA9JVe/gf6HF0UuF2bSvYUWwjxk8Wj/ftngDhbQ
	1rhY8BI3U1zV0/28stYtZSxcGqhoKYr4qlGIHOKujTKOEpBH1VrkdfiPtXF0fOh8
	GgVf++a3a6XfOwz7mGiJoAvXkUHPaTAYSD0ZytYs2Ceop6ENF7607QqeBFrKwNI0
	MZPXKEUMk5s/gtrkQx1jPB6s1jwudNb01A9DlGJdoTep2ZaveTT0JODtImABJbMs
	2X6pxnFWUeySI6asbYQfHVdziWR8ZMLkHIbxH6D0IqeZuXW49N0vMyvWTYhGZQnZ
	9kl/hLyQBA7ab7V6ZnZsxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718794748; x=
	1718881148; bh=lH+uB87WTdsk4/SHdt06h8+wStTRaycKOhrkqXOp1MM=; b=l
	WxUHYa6bEmn7vGfg5VMO97NMHaZ6e+U7Ngzu10LyJ+rOyuH8nvgEGpx5GMxoCrvP
	7eisbdgCjd7+qXyqhwZgBrw9rg/0sJwkIl5ieNb4B56A0nnFzCQHau5ySThuLlgC
	u0jA8a6T7N+U/KnWlzuONzXav/TBC1aUA9ny4ab62x/L8Ywg5v49J9F6REfvWWuL
	juRX2p3N810EFDrfRB5HXjJhs3gv9L0fCrbPIGH3qkqNgsmJUGa3xE9cVnk6yo7A
	K9qy+eXlqnezY5BBusbx0oZdGXisyl9xiJDsrs9hQNaFFGuQivqxIU8kOWWVlRdl
	7+PpYWHKp4qgSO4YRmr7g==
X-ME-Sender: <xms:-7lyZrCqz_0kNpilER2dw3A38UdneRts15_OOiate5SGJayWVC878w>
    <xme:-7lyZhjp--adRWJkzlhX4YkFAd1zNiJ1PbQfOCkK-ilgnHrazdyeP-uipEeWygRmK
    hrOooJhlPeHTA>
X-ME-Received: <xmr:-7lyZmknLlZyuHxT7GfVDGkx679nj_cFcP3bQfTEv8ox2qT0txModbWwNgMj3tNSEu7rXyofyvx6eZ7Umavzo5VLOoDEmm8Mwi5VFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelke
    ehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:_LlyZtyJvtD_OniCieBKLtlZEEcBGhxHOuZa-4BMumSdkpmZvOjwJA>
    <xmx:_LlyZgQfECySMd5YnAN26YmlJ1wPIwan-lRS0cVk2Vjy1Zquh73X1Q>
    <xmx:_LlyZgZpUc-xG16WCYvwXwd42VoDohtwOhskM4d1xr706hAb7WsICQ>
    <xmx:_LlyZhStKuK6yUiZpJhxNgwmArMtsN6oroxcZuA7meBKD7meHfZK0w>
    <xmx:_LlyZheG1oakrsoiRmVK8wUOlTGJSeykZzGLYpH6O9EU9Y1pdt0fx5-8>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 06:59:07 -0400 (EDT)
Date: Wed, 19 Jun 2024 12:58:59 +0200
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ojeda@kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: Patch "kbuild: rust: force `alloc` extern to allow "empty" Rust
 files" has been added to the 6.1-stable tree
Message-ID: <2024061948-zips-dividing-89c8@gregkh>
References: <20240616021129.1681226-1-sashal@kernel.org>
 <CANiq72ma2Q1tvNboDyKOP+zOuefCW8Ooq_9cUx46MkFOG-8YRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ma2Q1tvNboDyKOP+zOuefCW8Ooq_9cUx46MkFOG-8YRA@mail.gmail.com>

On Sun, Jun 16, 2024 at 12:38:41PM +0200, Miguel Ojeda wrote:
> On Sun, Jun 16, 2024 at 4:11 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> >     Cc: stable@vger.kernel.org # v6.6+
> 
> This cannot be backported to 6.1 unless we upgrade the compiler, since
> the feature is not available in old versions.
> 
> For future reference, this patch got picked for 6.1 a couple more times:
> 
>     https://lore.kernel.org/stable/CANiq72=V1=D-X5ncqN1pyfE4L1bz5zFRdBot6HpkCYie-EQnPA@mail.gmail.com/
>     https://lore.kernel.org/stable/CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com/
> 
> If I had known it would cause your scripts to pick it up repeatedly,
> then I would have probably avoided `Fixes`/`Cc` -- it is a very minor
> issue.

Now dropped, sorry for the problems.

greg k-h

