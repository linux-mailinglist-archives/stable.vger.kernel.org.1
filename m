Return-Path: <stable+bounces-10165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C798272DC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27794B23199
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3474CE0B;
	Mon,  8 Jan 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dAaMtRTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7751015
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69DDC433C9;
	Mon,  8 Jan 2024 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704727158;
	bh=FyW63OZZAWONLYed31SdC2n9D0Lk8VwDfMkeyUx9UPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAaMtRTatyNG/ygbAM1RADe88874+UhIw2ivX5UQVQsMsvL2F0GCtB4qeWxJRiip/
	 lXun+Ha9FzwBldF3ut0rbc4j3J2XuOqGWGJoL48uGWElBRqbxNDgBLM3F9+xlD+6lx
	 iHG4qMIDXFliubUWdVUMjBR9gtHKVCvqZCatJEik=
Date: Mon, 8 Jan 2024 16:19:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stable <stable@vger.kernel.org>,
	Yongqin Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable
 sync_state"
Message-ID: <2024010845-widget-ether-ccd9@gregkh>
References: <20240107155702.3395873-1-amit.pundir@linaro.org>
 <2024010850-latch-occupancy-e727@gregkh>
 <CAMi1Hd37L6NYKNpGOUnT7EO8kfc-HVQUqnoTTARA5gTpTc2wXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd37L6NYKNpGOUnT7EO8kfc-HVQUqnoTTARA5gTpTc2wXQ@mail.gmail.com>

On Mon, Jan 08, 2024 at 08:33:00PM +0530, Amit Pundir wrote:
> On Mon, 8 Jan 2024 at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jan 07, 2024 at 09:27:02PM +0530, Amit Pundir wrote:
> > > This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
> > > commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.
> > >
> > > This resulted in boot regression on RB5 (sm8250), causing the device
> > > to hard crash into USB crash dump mode everytime.
> > >
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> >
> > Any link to that report?  Is this also an issue in 6.7 and/or 6.6.y?
> 
> Here is a fresh RB5 crash report running AOSP with upstream v6.1.71
> https://lkft.validation.linaro.org/scheduler/job/7151629#L4239
> 
> I do not see this crash on v6.7.

So does that mean we are instead missing something here for this tree?

thanks,

greg k-h

