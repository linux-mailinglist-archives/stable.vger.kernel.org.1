Return-Path: <stable+bounces-58033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBDF927319
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 11:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6768F1C20922
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DFE1A070E;
	Thu,  4 Jul 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNAqwIcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C013B29D;
	Thu,  4 Jul 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085547; cv=none; b=hXO2yWLRzvi+eixKryHURq4L16408dqDRlIHDeAE4gbj8jayM+61aV8VBgnWNp2uEW/0ukE3/KY65I4RDkxsmmKyStnUNVAl8v1VTzRbPZ+yPJIVfsdFlO3mePi/71xnHZjjC+WEtoAy1kOzClCyJYW+dkP7wf0su5K10CiKq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085547; c=relaxed/simple;
	bh=w19DchiW/7C37L4MuQM+qfzoS3IEIWVbJxorCmkgc9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M64ITIAVeV/nywuhNjoPfesBcdfCZ9Ivjp+CLp/eAlif62nBxmGgkWnjjaSWkH5GPgJSrPrzlAfcyNm5ZFAm6iDZHzbsLvR/p0f3seP5rFexSZ0/hu9Mu7YM4DvteiuCajTsTdYd0kcBcNgAg/ZQjIsGgh74zQQRIvdpRPll6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNAqwIcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C3DC32786;
	Thu,  4 Jul 2024 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720085546;
	bh=w19DchiW/7C37L4MuQM+qfzoS3IEIWVbJxorCmkgc9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNAqwIcfUM2oyPOu+N0omQ/Aw48pvHWGoHOgMqmb5UR/G0e4vgIkVFYvqx0iZDSOr
	 9t/ejfmTQYtXZniUGFqg8BDScdTYtrChTtBeGk24je6r2xBdutolp7FTElPJcm36lH
	 v09x0CK3UNja4i6Jbm9A34j6eGriKxcgbWG9I3Vw=
Date: Thu, 4 Jul 2024 11:32:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunseong Kim <yskelg@gmail.com>, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Austin Kim <austindh.kim@gmail.com>,
	MichelleJin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ppbuk5246@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
Message-ID: <2024070400-slideshow-professor-af80@gregkh>
References: <20240702180146.5126-2-yskelg@gmail.com>
 <20240703191835.2cc2606f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703191835.2cc2606f@kernel.org>

On Wed, Jul 03, 2024 at 07:18:35PM -0700, Jakub Kicinski wrote:
> On Wed,  3 Jul 2024 03:01:47 +0900 Yunseong Kim wrote:
> > Support backports for stable version. There are two places where null
> > deref could happen before
> > commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of __assign_str()")
> > Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/
> > 
> > I've checked +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9, this version need
> > to be applied, So, I applied the patch, tested it again, and confirmed
> > working fine.
> 
> You're missing the customary "[ Upstream commit <upstream commit> ]"
> line, not sure Greg will pick this up.
> 

Yeah, I missed this, needs to be very obvious what is happening here.
I'll replace the version in the queues with this one now, thanks.

greg k-h

