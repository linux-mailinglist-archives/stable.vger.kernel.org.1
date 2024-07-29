Return-Path: <stable+bounces-62446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722493F228
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA31C21974
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619713FD86;
	Mon, 29 Jul 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wg1YOS/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11E78C63;
	Mon, 29 Jul 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247649; cv=none; b=dFNnHkZ6kvXaMRlb1y+PDbBE3oqikpztnjV/K2biNodLpEC5UPxYGi0dbzWoe4+No/JC63nh/ePNSomqNytxSxceUEFRirvvkIyvs3EFC0jk6UIrra2v/kKGRGd9XGdWofdb9VbLMR1xGJBxt0AfXRpVl64r57awDSso2J+wvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247649; c=relaxed/simple;
	bh=D8iunlNxTf0SVb+0sOiHsIZTnclhUui8dape3ODrnoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1MxaQ+VC4OIzZFYC7nohOGJA4s4xjXWmOg1Kw0+2W64VaTn72Be/tw+R4mHyJWV0Sx+hXM0w78ew4HDR2R1Ra8dN1RMM7FLf9t9WbFIz+5x/hcgYPkk2wH2ApFVWYG1YYi2CZKLznmnSQ9p4vb13DMiDlDzyn1Ifo+WFsXyolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wg1YOS/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952A6C32786;
	Mon, 29 Jul 2024 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722247649;
	bh=D8iunlNxTf0SVb+0sOiHsIZTnclhUui8dape3ODrnoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg1YOS/f0CuUR3+YDBqHNETwORJFnsRHEMMYXddajBjwoDYWy1y69KcGPQNKBMTF8
	 3NmTEXhjcfqOMkbm/v8GO1YKPXPj5XjL7uSLo/ouh0xBrvukUGbLy8cuIVDcFhogDS
	 N2tr0mCWtLUfo7JYvXt2KiXIkD5lZEYkIxGqvsQs=
Date: Mon, 29 Jul 2024 12:07:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Lukasz Luba <Lukasz.Luba@arm.com>, linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] sched/fair: Use all little CPUs for CPU-bound workload
Message-ID: <2024072905-chop-zigzagged-bcd6@gregkh>
References: <20231206090043.634697-1-pierre.gondois@arm.com>
 <999a6c1d-c21d-4d16-a2a2-6d0b6e7df9a5@arm.com>
 <2cbb3467-1b49-4c86-9fad-9c75ce7d9c8f@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbb3467-1b49-4c86-9fad-9c75ce7d9c8f@arm.com>

On Mon, Jul 29, 2024 at 11:50:40AM +0200, Pierre Gondois wrote:
> Hello Sasha,
> Would it be possible to pick this patch for the 6.1 stable branch ?
> Or is there something I should do for this purpose ?
> 
> Regards,
> Pierre
> 
> On 6/25/24 15:25, Pierre Gondois wrote:
> > Hello stable folk,
> > 
> > This patch was merged as:
> >     commit 3af7524b1419 ("sched/fair: Use all little CPUs for CPU-bound workloads")
> > into 6.7, improving the following:
> >     commit 0b0695f2b34a ("sched/fair: Rework load_balance()")
> > 
> > Would it be possible to port it to the 6.1 stable branch ?
> > The patch should apply cleanly by cherry-picking onto v6.1.94,

You also forgot 5.10.y and 5.15.y which need it, I've queued it up for
those as well now, thanks.

greg k-h

