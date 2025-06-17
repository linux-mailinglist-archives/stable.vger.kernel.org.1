Return-Path: <stable+bounces-152860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B15ADCE4A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BB1175A04
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F952E266D;
	Tue, 17 Jun 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kle3kcRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEC2E266A;
	Tue, 17 Jun 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168412; cv=none; b=tiACJDEHJFjDzOm4Wn2ivakWGhJo5O40EPDmTrMtsgh4RV3kCl+9fA6HbGvpleXe33ZM/Ym2FqLGCGz9kz+X/LqNUNUjUfkvplx3G4uNr2bEnMUlakGtOKJXQw9ZZARCVCdz/KL7fN66RkLu+Wbx/lpWFImBYSjIqL3bf6ihLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168412; c=relaxed/simple;
	bh=EqOD9uTpVvS59l2vzpX0bTzZGw98e+dt3zU3uwmzXqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfLTBfydO137I9VNj9uWtgEonwO5P54aovz4UEmAfZ7LirOb5cL/QifGj769lStaQ2AmEnk5U0e9uM8CGmC2fuO6d98dwRD3BIJWPLkxGw/+KrLNmSfOtlRoDNh4kJ4XYZc+Q3O85SrbIN7UIgtW4uleYdDzdWXO11DUCocUrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kle3kcRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B10FC4CEE7;
	Tue, 17 Jun 2025 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750168412;
	bh=EqOD9uTpVvS59l2vzpX0bTzZGw98e+dt3zU3uwmzXqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kle3kcRvy/B3XAK1JMNyu1XlR8LHYj3ixIrO6XEyljd1AwXS4QtvEQo8Fvjh9tqh3
	 QH5pLWz24EPGLESEQM1Ym/cDDbKM+MyrEZf5b+/uv+Hsn5pwL98OiKhw/FR7FLosnX
	 y03XhECya2Xl1NomYzhEb7JRAKHPo31ufx1pU1cs=
Date: Tue, 17 Jun 2025 15:53:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ij@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and
 tcp_count_delivered()" has been added to the 6.6-stable tree
Message-ID: <2025061745-epidermal-clothing-beed@gregkh>
References: <20250522224433.3219290-1-sashal@kernel.org>
 <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>
 <aEspV8Ttk7uBM4Gx@lappy>
 <175e6075-a930-196d-37ce-7f2815141d07@kernel.org>
 <PAXPR07MB7984096843D96583972BF35BA376A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR07MB7984096843D96583972BF35BA376A@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Sat, Jun 14, 2025 at 01:55:02PM +0000, Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Ilpo Järvinen <ij@kernel.org> 
> > Sent: Thursday, June 12, 2025 11:17 PM
> > To: Sasha Levin <sashal@kernel.org>; Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: Eric Dumazet <edumazet@google.com>; stable@vger.kernel.org; stable-commits@vger.kernel.org; Neal Cardwell <ncardwell@google.com>; David S. Miller <davem@davemloft.net>; David Ahern <dsahern@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Kuniyuki Iwashima <kuniyu@google.com>; Willem de Bruijn <willemb@google.com>
> > Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()" has been added to the 6.6-stable tree
> > 
> > 
> > CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> > 
> > 
> > 
> > + Chia-Yu
> > 
> > 
> > On Thu, 12 Jun 2025, Sasha Levin wrote:
> > > On Thu, Jun 12, 2025 at 01:40:57AM -0700, Eric Dumazet wrote:
> > > > On Thu, May 22, 2025 at 3:44 PM Sasha Levin <sashal@kernel.org> wrote:
> > > > >
> > > > > This is a note to let you know that I've just added the patch 
> > > > > titled
> > > > >
> > > > >     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
> > > > >
> > > > > to the 6.6-stable tree which can be found at:
> > > > >     
> > > > > https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fw
> > > > > ww.kernel.org%2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstabl
> > > > > e-queue.git%3Ba%3Dsummary&data=05%7C02%7Cchia-yu.chang%40nokia-bel
> > > > > l-labs.com%7C449db2278c004aa84d7b08dda9f68c8c%7C5d4717519675428d91
> > > > > 7b70f44f9630b0%7C0%7C0%7C638853598557368335%7CUnknown%7CTWFpbGZsb3
> > > > > d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFO
> > > > > IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Z6AfId4r6Ys1V4sGov
> > > > > 8bdOct72AAUdfVgFTo7NMOibU%3D&reserved=0
> > > > >
> > > > > The filename of the patch is:
> > > > >      tcp-reorganize-tcp_in_ack_event-and-tcp_count_delive.patch
> > > > > and it can be found in the queue-6.6 subdirectory.
> > > > >
> > > > > If you, or anyone else, feels it should not be added to the stable 
> > > > > tree, please let <stable@vger.kernel.org> know about it.
> > > > >
> > > > >
> > > >
> > > > May I ask why this patch was backported to stable versions  ?
> > 
> > As you see Eric, you got no answer to a very direct question.
> > 
> > I've long since stopped caring unless a change really looks dangerous (this one didn't) what they take into stable, especially since they tend to ignore on-what-grounds questions.
> > 
> > > > This is causing a packetdrill test to fail.
> > >
> > > Is this an issue upstream as well? Should we just drop it from stable?
> > 
> > It's long since I've done anything with packetdrill so it will take some time for me to test. Maybe Chia-Yu can check this faster (but I assume it's also problem in mainline as this is reported by Eric).
> > 
> > --
> >  i.
> 
> Hi Eric,
> 
> I've checked the failure case and could reproduce it using the latest packetdrill.
> 
> The root cause is because delaying the tcp_in_ack_event() call does have an impact on update_alpha(), which uses the values of the latest delivered and delivered_ce updated by tcp_clean_rtx_queue().
> Therefore, tcp_plb_update_state() will use these values to update the state for TCP PLB.
> While before this patch, update_alpha() is called before tcp_clean_rtx_queue(), and thus delivered and delivered_ce are not updated yet.
> 
> This is also in upstream as well.

Thanks for looking into this.  When the fix for this gets into Linus's
tree, can someone make sure to properly tag it for stable backports
(i.e. cc: stable@vger.kernel.org)?

thanks,

greg k-h

