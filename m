Return-Path: <stable+bounces-3681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E60780173D
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 00:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3337B20DBC
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794893F8CE;
	Fri,  1 Dec 2023 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoNxALy4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239717D2
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 23:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F735C433C9;
	Fri,  1 Dec 2023 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701471781;
	bh=416DK5PCLIvTh+RxZkSMRH7YhAoQUVgJGbQlCFkidtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoNxALy4an0NWNVy6wmrzMDQCYGK1aZH5Tm8IUQEfvf/gJYwyQkEydx0CqUyvp34V
	 keY1Odx3X9iCdUHsVO2mt0gXl76B8ReAaiWELaU1NZSZUSg/tY4Djov4Yn5qoDnwpc
	 6nLezNSuS3iSCeOQgyhgTMtthE9bJGJafU6iu1T0=
Date: Sat, 2 Dec 2023 00:02:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.15.y v1 1/2] kallsyms: Make kallsyms_on_each_symbol
 generally available
Message-ID: <2023120247-unsocial-caress-14fe@gregkh>
References: <20231201151957.682381-1-flaniel@linux.microsoft.com>
 <20231201151957.682381-2-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151957.682381-2-flaniel@linux.microsoft.com>

On Fri, Dec 01, 2023 at 04:19:56PM +0100, Francis Laniel wrote:
> From: Jiri Olsa <jolsa@kernel.org>
> 
> Making kallsyms_on_each_symbol generally available, so it can be
> used outside CONFIG_LIVEPATCH option in following changes.
> 
> Rather than adding another ifdef option let's make the function
> generally available (when CONFIG_KALLSYMS option is defined).
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.org
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/kallsyms.h | 7 ++++++-
>  kernel/kallsyms.c        | 2 --
>  2 files changed, 6 insertions(+), 3 deletions(-)

What is the git id of this commit in Linus's tree?

