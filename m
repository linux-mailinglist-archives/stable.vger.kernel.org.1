Return-Path: <stable+bounces-78297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF998AC18
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C23E1F23BEC
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E3192D82;
	Mon, 30 Sep 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuRU31Su"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92343AD2;
	Mon, 30 Sep 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721236; cv=none; b=SK/LRbk4RDcHL16rU4oVPICITjZ+T7Ds/YxKjmb2od0FWiT2jrNKt+XnviGOGRklG4Va3hjHRqansiZuja5QNcOOdPhgT+eJ7BTPkp820uunzwSzhXLg57UwEnXDYaofOU9Sn+3d+ZAwPlNGgtKnwqK7e9Ln2GiI9c2nBktbEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721236; c=relaxed/simple;
	bh=cOBLCCsbfP/TLPo1ZYALFHUrqYntztNFyLx4RgzI+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY/x0o3scAcG3v8BorCjXg3p3QfHAZLR5x8eQOicXdB9n7nlLG8oi+PJpoyiDJ9A/W8jZwAD7PzeUQgl8jD35uZOBGLE5tgx0b1+NkgG1DQ/6MmIztnxmJpYNFAa2Sv7vCh2e7JipHj4n4fxLLWfCiiJvrrXexj874cTKRqNNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuRU31Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF1C4CEC7;
	Mon, 30 Sep 2024 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727721235;
	bh=cOBLCCsbfP/TLPo1ZYALFHUrqYntztNFyLx4RgzI+F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuRU31SuhI6R5+IOP2DQT2o0dW4XhokpxU8F3Z58lQmXZOqV4Io9jVZG33r1g9oxF
	 /49eFLs7Zs2hQHlPXKhTeUigQo5TE9OAtkO4Sf7DPoZ90qCgrbX76wsESumKECMQ5T
	 7ghIYOZiNt9X+mILAtH6xKOS9wObdRsXIHFRmg2w=
Date: Mon, 30 Sep 2024 20:33:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Sasha Levin <sashal@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Bibo Mao <maobibo@loongson.cn>, loongarch@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: stable-rc/linux-6.10.y: error: no member named 'st' in 'struct
 kvm_vcpu_arch'
Message-ID: <2024093040-onslaught-camping-3faf@gregkh>
References: <CANiq72mHQ0eKJoZeRxB5h1eHza8nERA_DtWUMKecyQuivH7SXw@mail.gmail.com>
 <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>

On Sun, Sep 29, 2024 at 09:02:33AM +0800, Huacai Chen wrote:
> On Sat, Sep 28, 2024 at 8:29 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Hi Sasha, LoongArch,
> >
> > In a stable-rc/linux-6.10.y build-test today, I got:
> >
> >     arch/loongarch/kvm/vcpu.c:575:15: error: no member named 'st' in
> > 'struct kvm_vcpu_arch'
> >       575 |                         vcpu->arch.st.guest_addr = 0;
> >
> > which I guess is triggered by missing prerequisites for commit
> > 56f7eeae40de ("LoongArch: KVM: Invalidate guest steal time address on
> > vCPU reset").
> Hmm, please drop the backported patch "LoongArch: KVM: Invalidate
> guest steal time address on vCPU reset".

Ick, missed this, can you please send a revert?

thanks,

greg k-h

