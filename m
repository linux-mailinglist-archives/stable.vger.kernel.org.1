Return-Path: <stable+bounces-103971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA69F056B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BBD18851E7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF518C002;
	Fri, 13 Dec 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkdVl9xW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638921632CA
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074585; cv=none; b=tLhOUuWuPzmUAmh4CpbDUQ+x1y8T4SEmnQT+XdWW3JxXJ+Fp1OxpXGfqRUIDGsgB0WjVArWapDAcomglHnWqXJ03KHJngMuaOKKeME/SwrPHR5fX0DXfK6k+pakOgxECG/7B8UrF0qItJvGDoACYBHHQ9S611VQ90k546jj6xC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074585; c=relaxed/simple;
	bh=FPtQfzvb7I7UHSdS/uBEIzumEjpR6e+VcT/Bo4Rtcqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwOTXYGs2lBdrjbnCld5DJP/BMHB7gwtVq1f9OmUtUqurnaAvTkDtYYOtU9E8nSkVbXcSwQHpuhcUvI1BSA3kvu/MA2VyeX/lvanEVvgkzaZlqbf9us2YypQdlk24AwqiBu6AiGkXVLmi2RyyfaUSMdMM72QplTbOxldg7i79iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkdVl9xW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1A7C4CED0;
	Fri, 13 Dec 2024 07:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734074585;
	bh=FPtQfzvb7I7UHSdS/uBEIzumEjpR6e+VcT/Bo4Rtcqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkdVl9xWD6m7MgzCQrJxv7v0ySkWQiYfnXXVwWFUFqc0vo148F/Idpv43w+fIfAu3
	 zjpmrSoxxXbTT9cugekdWaN7bnd0WezyALQKYW54hiyh84e8knGYZCpdYUqFnF50UF
	 jVlLMdlh7WVuGzCUckhK7+0DJOFtiYgoTzU/yozM=
Date: Fri, 13 Dec 2024 08:22:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
Message-ID: <2024121318-winking-hybrid-2d70@gregkh>
References: <2024120223-stunner-letter-9d09@gregkh>
 <20241203190236.2711302-1-rananta@google.com>
 <2024121209-dreaded-champion-4cae@gregkh>
 <CAJHc60zMcf7VZKwc61Z3iGaWHe_HayhViOv=rdFxwoRB=AyH6w@mail.gmail.com>
 <2024121202-gradually-reaction-2cd6@gregkh>
 <CAJHc60xTWgCFdQ-Hr0qCPa=FZKK9+8=c44GgTzkc-YPX-jToWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60xTWgCFdQ-Hr0qCPa=FZKK9+8=c44GgTzkc-YPX-jToWw@mail.gmail.com>

On Thu, Dec 12, 2024 at 10:52:07AM -0800, Raghavendra Rao Ananta wrote:
> On Thu, Dec 12, 2024 at 10:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Dec 12, 2024 at 09:41:28AM -0800, Raghavendra Rao Ananta wrote:
> > > Hi Greg,
> > >
> > > This is an adjustment of the original upstream patch aimed towards the
> > > 4.19.y stable branch.
> >
> > 4.19.y is end-of-life, so there's nothing we can do there.  But what
> > about 5.4.y?  If it matters there, please resend it in a format we can
> > apply it in for that tree.
> 
> The version of the patch from this thread applies to 5.4.y as well. Do
> you want me to resend it or will you be able to pick this up?

Please resend it.

thanks,

greg k-h

