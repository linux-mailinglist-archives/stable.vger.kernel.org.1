Return-Path: <stable+bounces-100894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF49EE510
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EABD166B4A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D76259495;
	Thu, 12 Dec 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yw5qhYDa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8C1E9B3E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003102; cv=none; b=X/YrKKpN4tWVQdLrCQpFeGPcPFIgVOFtMaMUb6+V7TbRFlDmVuWCm8yqZjhEdoSPFMmBXxbU4zE7hqEK5iO+UsgSUibcvGS10G12jPH2suQXuc5BJwLOWSSZvS9Xad8hKdxzfNaDTv5qWWD6z63miD5NkIkOigMmCZcuMEs2LsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003102; c=relaxed/simple;
	bh=sT/cnxEPRUca5hOvigsvQdJ/P5qOZZUS42UYq5nHU7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0VQrBPNvp41jH05Xtf0VDN5GSw6YUfroRhDUutqzLT6r80MmlHECoW1ZauOilY7esD4IG+08FxYHKaAOboTZsrJb/D4E0vl4mD+1FNHFnIIbPsY+J3luGkZC6V+BU//GTzx5s9Ox/zv1thHj9I6nbp1y2GayaYrHTnj8b5c47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yw5qhYDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EE6C4CECE;
	Thu, 12 Dec 2024 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734003102;
	bh=sT/cnxEPRUca5hOvigsvQdJ/P5qOZZUS42UYq5nHU7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw5qhYDaI0dNTOdlpDJ4QSBi5s3vSwR0am3mhvquw1SI0RZRGohmGkPXiDpmSmCXf
	 QiQqoTg38rqEOm6+IKytJgE1t4m7wEfWh7mZfX8oDE7b28vdKJSWbzQHS0fxFPjHf3
	 RUH8IdqGzlWI4bhrodyJx2FpY1mMok4lPsiqQDzo=
Date: Thu, 12 Dec 2024 12:31:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Heming Zhao <heming.zhao@suse.com>, Thomas Voegtle <tv@lio96.de>,
	Su Yue <glass.su@suse.com>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
Message-ID: <2024121223-causation-dainty-4472@gregkh>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
 <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
 <2024121244-virtuous-avenge-f052@gregkh>
 <a6054a83-2dda-4548-afd3-96dcea453159@suse.com>
 <2024121210-snowbird-petty-f516@gregkh>
 <20feb966-acb8-40f7-8ee2-26d069b3f939@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20feb966-acb8-40f7-8ee2-26d069b3f939@linux.alibaba.com>

On Thu, Dec 12, 2024 at 07:15:17PM +0800, Joseph Qi wrote:
> 
> 
> On 2024/12/12 19:06, Greg KH wrote:
> > On Thu, Dec 12, 2024 at 07:01:08PM +0800, Heming Zhao wrote:
> >> Hi Greg,
> >>
> >> On 12/12/24 18:54, Greg KH wrote:
> >>> On Thu, Dec 12, 2024 at 06:41:58PM +0800, Joseph Qi wrote:
> >>>> See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t
> >>>
> >>> And I need a working backport that I can apply to fix this :(
> >>
> >> I submitted a v2 patch set [1], which has been passed review.
> >>
> >> [1]:
> >> https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#mc63e77487c4c7baba6d28fd536509e964ce3b892
> > 
> > Then please submit it to the stable maintainers so that we can apply it.
> > 
> 
> The two patches are now in mm-tree.
> We may submit the revert patch to the affected stable trees once it goes into upstream.

Ah, sorry, I thought this was for a stable-only series.  Nevermind, I'll
wait :)

thanks,

greg k-h

