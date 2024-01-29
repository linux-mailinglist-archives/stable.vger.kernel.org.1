Return-Path: <stable+bounces-17430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA84842963
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 17:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E48F1F29B80
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665B38DD9;
	Tue, 30 Jan 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxANwIZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FA27458
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632515; cv=none; b=Tj+8g5Qg/8K0ou0g/hCmtG39NE4/IueZTA6BpFnlXHuxjdhhfBy83lyITm1mvrha7XTNFzX/gqx/qqW1jGzVOMGhm7rQg3GIpvvvKxMymmWnH7hy62gpe1Y5YsaK/VbNrtAJtLZOhV/lMrk349/5i7dBUn3LPQUnQPYOqqj04k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632515; c=relaxed/simple;
	bh=XuQsHtrhaHSAdWgRys1SfzqmTtbp2ymx/dNPoxHHWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkFLSa22oquxgIatxm2Zp69lEmPZtPgHILwR+o0V3TeCsj3oTzT/O/QoJ8xlxWSCASpNzNrOt4bBiGY687WTwyKsNw/4edvEtvpa6ixTr19l4cExce2ryIyspFGUcakNiQH+xzY2dcINWryaSsTxTnn6nQKA3F1lKkMueMu25m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TxANwIZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D308DC433C7;
	Tue, 30 Jan 2024 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632515;
	bh=XuQsHtrhaHSAdWgRys1SfzqmTtbp2ymx/dNPoxHHWL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxANwIZDiD9GbT0TbEVvfli0hqWElhiB3DyQOHCQ/0ZTWges1bp0QlhBnX7n376kY
	 5Dbe5jjyX+6D/qPLVc4cPBn3m27jIcESB0pFBPm8qcpS+OKpKiIpaW11xa+o8ZNce7
	 6HuUxHPunAxQEk85qvQTVQ4X+luaZ5tV6c0Xujpg=
Date: Mon, 29 Jan 2024 09:42:57 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
Message-ID: <2024012940-lumping-lunchroom-98e6@gregkh>
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
 <2024012936-disabled-yesterday-91bb@gregkh>
 <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>

On Mon, Jan 29, 2024 at 10:59:53PM +0530, Amit Pundir wrote:
> On Mon, 29 Jan 2024 at 21:51, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 04:08:59PM +0530, Amit Pundir wrote:
> > > Hi,
> > >
> > > v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
> > > to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
> > > display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
> > > ("drm/msm/dsi: Enable runtime PM") from the original patch series
> > > https://patchwork.freedesktop.org/series/119583/
> > > and it's dependent runtime PM helper routines as suggested by Dmitry
> > > https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
> > > fixes that display regression on DB845c.
> >
> > We need fixes for all of the newer stable trees too, you can't fix an
> > issue in an old tree and then if you upgraded, you would run into that
> > issue again.
> >
> > So please, resend this series as a set of series for all active lts
> > kernels, and we will be glad to queue them up.
> 
> Ack. I'll send the patch series for all the active LTS kernels
> tomorrow after build/boot testing them locally. Meanwhile please
> consider this patch series for v5.4.y anyway.

Nope, I have to wait until the newer changes show up, for obvious
reasonse.

thanks,

greg k-h

