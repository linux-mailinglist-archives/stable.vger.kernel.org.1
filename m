Return-Path: <stable+bounces-10168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920FB827374
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4215628419C
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468195102D;
	Mon,  8 Jan 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4CQouOW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05E51020
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFF7C433CD;
	Mon,  8 Jan 2024 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728093;
	bh=WhtT3FQsrurAQjg3sOvSX2Fx2oYV1xsvGZkeyV3yx3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4CQouOWebulGtsrNwDrm7CIjPlPoF+GbBNpq452tMvwvJH4TDiRngBKPZagKjGtm
	 duR3sw9CPcew2nd2mmWH+pewUBx1kTu+BaPz0C3cZ+WjzyD8UvGsr/lL0QtCEwTfsL
	 VUddl+rZ4xYJgQn7hp5o65Kja8fwwHRigcFVCDis=
Date: Mon, 8 Jan 2024 16:34:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, Sasha Levin <sashal@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, Stable <stable@vger.kernel.org>,
	Yongqin Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable
 sync_state"
Message-ID: <2024010843-cod-many-4c53@gregkh>
References: <20240107155702.3395873-1-amit.pundir@linaro.org>
 <2024010850-latch-occupancy-e727@gregkh>
 <CAMi1Hd37L6NYKNpGOUnT7EO8kfc-HVQUqnoTTARA5gTpTc2wXQ@mail.gmail.com>
 <2024010845-widget-ether-ccd9@gregkh>
 <cb5046e1-7184-4be8-8ce2-01b96be1533c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5046e1-7184-4be8-8ce2-01b96be1533c@kernel.org>

On Mon, Jan 08, 2024 at 04:30:42PM +0100, Konrad Dybcio wrote:
> On 8.01.2024 16:19, Greg KH wrote:
> > On Mon, Jan 08, 2024 at 08:33:00PM +0530, Amit Pundir wrote:
> >> On Mon, 8 Jan 2024 at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> On Sun, Jan 07, 2024 at 09:27:02PM +0530, Amit Pundir wrote:
> >>>> This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
> >>>> commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.
> >>>>
> >>>> This resulted in boot regression on RB5 (sm8250), causing the device
> >>>> to hard crash into USB crash dump mode everytime.
> >>>>
> >>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> >>>
> >>> Any link to that report?  Is this also an issue in 6.7 and/or 6.6.y?
> >>
> >> Here is a fresh RB5 crash report running AOSP with upstream v6.1.71
> >> https://lkft.validation.linaro.org/scheduler/job/7151629#L4239
> >>
> >> I do not see this crash on v6.7.
> > 
> > So does that mean we are instead missing something here for this tree?
> 
> Yes, however I'm not sure anybody is keen on tracking that down, as
> (in short) for the platform to work correctly (.sync_state on
> interconnect not crashing the thing into oblivion is one of the
> signs), a lot of things need to be in place. And some developers
> never validated that properly..
> 
> Removing .sync_state from the SoC interconnect driver translates
> into "keep the power flowing on all data buses", which helps avoid
> crashes that are mainly caused by unclocked accesses and alike.

Ok, queued up now, thanks.

greg k-h

