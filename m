Return-Path: <stable+bounces-172342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E9B312E6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0396A3A2851
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415B22F14D;
	Fri, 22 Aug 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxW4fhSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C72137750
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854541; cv=none; b=f1nmSSvOBkzhbBBFQIwWh/ijkavTcG1Ip804jSsbBeqA6TS+CHZjYtI2VlxkgsOH4x8D3ZeRo8rijxj2JHm7sLe5EDkucJiOpQ9WQOgQhyubSblkGSSjbbcZHb1WvZ+d60go1ySU4b6/ff5ULd2h/0qNybOROSari+yKRZEqD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854541; c=relaxed/simple;
	bh=ilfNVX9t+rIKzYKY2RFvJBZiOwpj7gwfly/YUKxdXiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd6DkNOsGAQrT72QIH4tOo/53DknRhdY7ZbZ6oqlEzAFAxB4pMDqoZHJQoNVcOwUH7EV+nE9uDs/DjMH10c3oVDq4TPp323g3U6oQfOzx/ywzQz1kAo/+86Bo+hRl3AusY2vSfF/PEsGFK+rr1GESz5FhR0IEBLGXiIPXfQ7HUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxW4fhSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182AFC4CEED;
	Fri, 22 Aug 2025 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755854540;
	bh=ilfNVX9t+rIKzYKY2RFvJBZiOwpj7gwfly/YUKxdXiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxW4fhSMRwT47Hg5KEGkCileLvri/L+3ZgwmW7su3/fRLRQyykMu8WrlRzkBCd/Lm
	 jn5eQeRZ6SieFjTPzAyBPY6o+QcnlItLrPAxd/Yov7Gr75yuoEnpvQYyUmGt3urMI8
	 52uGnPUIAIPWQCAP47G0BF1WIkdIbNa7dlMzG5Xs=
Date: Fri, 22 Aug 2025 11:22:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wyes Karny <wkarny@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 6.6 8/8] sched/fair: Fix frequency selection for
 non-invariant case
Message-ID: <2025082213-awkward-harmonize-4212@gregkh>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
 <20250815181618.3199442-9-guanwentao@uniontech.com>
 <2025082258-starfish-crunching-77ba@gregkh>
 <tencent_5707A7E476AEBAFE766F163D@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5707A7E476AEBAFE766F163D@qq.com>

On Fri, Aug 22, 2025 at 05:10:21PM +0800, Wentao Guan wrote:
> Dear Greg,
> 
> Ohh, i forgot to add the sign-off-by....
> Thanks to point it.
> Do i add it in v2 or you take the sign-off-by?
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

That works, thanks!

