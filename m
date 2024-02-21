Return-Path: <stable+bounces-21813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0F85D5C9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14441C22C25
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4B22095;
	Wed, 21 Feb 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuQspQ1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16924C87
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511985; cv=none; b=edVFK2YzzuW+mesONKDSsRZnou2gC2OYQ23KHhQStji7zQIhIschfrFOti2Q7uJPgxOnYR1ptU8p0sowMrCZ0/MdHtOepCAAAU3tlgfPWaiR+jtV79+/rnhtTqN3bS5yrc5zOHK1h6DiLniwsZbgtO9L00MqmsHzasuYhvngKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511985; c=relaxed/simple;
	bh=paKC+vdq7GeIGBtdMrnGN/mZHY/GUm0P5JfSB0WkIa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRnnRSXMICvhG5rY5tAZhpD8zVto/aeywIe21cAR6FpOrkx7MDuakWG9oJYAWB4RU1x/U/piws25agbuyVMKd6d1LkkzrTFhQ3fU83r24CYXIZRQGGzZa/8Ss7CBYff/7nElRw9mWCmWECdjB9SkrIfUVjifNhSxKmntdHYsvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuQspQ1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4742C433F1;
	Wed, 21 Feb 2024 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708511984;
	bh=paKC+vdq7GeIGBtdMrnGN/mZHY/GUm0P5JfSB0WkIa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuQspQ1ZmEh147y4mR1mKDUxtCg7j89QPuL1z+Pzb+orxD9lZq/KszMPn9pLjqCv8
	 ru7lG3mpfgyxxqRyG5NkWNrrAnWHGIDBrok/jFk5IL5XaZgqEXW+ImYSdh83ImMfbc
	 ybs2f6nAQ71fgYrsTwwB/4t9CMu2tolejuZRxkh8=
Date: Wed, 21 Feb 2024 11:39:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
Message-ID: <2024022130-captivate-gawk-9b93@gregkh>
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
 <2024012936-disabled-yesterday-91bb@gregkh>
 <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>
 <CAMi1Hd2jwt4G4f=3Jh5+uoSiVcw_PqKQXcHq1wipF15uwTdbdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2jwt4G4f=3Jh5+uoSiVcw_PqKQXcHq1wipF15uwTdbdw@mail.gmail.com>

On Tue, Jan 30, 2024 at 07:22:28PM +0530, Amit Pundir wrote:
> On Mon, 29 Jan 2024 at 22:59, Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > On Mon, 29 Jan 2024 at 21:51, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 29, 2024 at 04:08:59PM +0530, Amit Pundir wrote:
> > > > Hi,
> > > >
> > > > v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
> > > > to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
> > > > display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
> > > > ("drm/msm/dsi: Enable runtime PM") from the original patch series
> > > > https://patchwork.freedesktop.org/series/119583/
> > > > and it's dependent runtime PM helper routines as suggested by Dmitry
> > > > https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
> > > > fixes that display regression on DB845c.
> > >
> > > We need fixes for all of the newer stable trees too, you can't fix an
> > > issue in an old tree and then if you upgraded, you would run into that
> > > issue again.
> > >
> > > So please, resend this series as a set of series for all active lts
> > > kernels, and we will be glad to queue them up.
> >
> > Ack. I'll send the patch series for all the active LTS kernels
> > tomorrow after build/boot testing them locally. Meanwhile please
> > consider this patch series for v5.4.y anyway.
> 
> Smoke tested and sent relevant fixes for other active LTS kernel
> versions as well.
> 
> v5.10.y https://lore.kernel.org/stable/20240130124630.3867218-1-amit.pundir@linaro.org/T/
> 
> v5.15.y https://lore.kernel.org/stable/20240130125847.3915432-1-amit.pundir@linaro.org/T/
> 
> and v6.1.y+ https://lore.kernel.org/stable/20240130134647.58630-1-amit.pundir@linaro.org/T/

Sorry for the long delay, been busy :(

All now queued up.

greg k-h

