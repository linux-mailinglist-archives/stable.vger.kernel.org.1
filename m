Return-Path: <stable+bounces-3982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9E8042F7
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 00:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6480FB20A69
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE003A8F5;
	Mon,  4 Dec 2023 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3qY9VGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35D393
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 23:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD7C433C8;
	Mon,  4 Dec 2023 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701734322;
	bh=cAPNEAG7DshrMnqU/OUIlmu8IazbVjuy/YPvLo4eu5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3qY9VGSgnvK0F8GqK0yzvOSnUFlJq8DChYakqLUhMczYbLtKBMB9Gxdb7EDP5BGK
	 UY88ecpH3L8FOyMQCvV1E+fxCBmEhH3+OwJhSt5hjrmyprMAYNgeYZ/5JRkQPhfL4T
	 +1BAoGb2W73pcGRFhvl6lXDDn/BZZYom95+Ez05s=
Date: Tue, 5 Dec 2023 08:58:38 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.15.y v1 1/2] kallsyms: Make kallsyms_on_each_symbol
 generally available
Message-ID: <2023120533-washtub-data-f661@gregkh>
References: <20231201151957.682381-1-flaniel@linux.microsoft.com>
 <20231201151957.682381-2-flaniel@linux.microsoft.com>
 <2023120247-unsocial-caress-14fe@gregkh>
 <2709501.mvXUDI8C0e@pwmachine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2709501.mvXUDI8C0e@pwmachine>

On Mon, Dec 04, 2023 at 09:19:05AM +0100, Francis Laniel wrote:
> Hi!
> 
> 
> Le samedi 2 décembre 2023, 00:02:58 CET Greg KH a écrit :
> > On Fri, Dec 01, 2023 at 04:19:56PM +0100, Francis Laniel wrote:
> > > From: Jiri Olsa <jolsa@kernel.org>
> > > 
> > > Making kallsyms_on_each_symbol generally available, so it can be
> > > used outside CONFIG_LIVEPATCH option in following changes.
> > > 
> > > Rather than adding another ifdef option let's make the function
> > > generally available (when CONFIG_KALLSYMS option is defined).
> > > 
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > Link: https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.org
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > > 
> > >  include/linux/kallsyms.h | 7 ++++++-
> > >  kernel/kallsyms.c        | 2 --
> > >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > What is the git id of this commit in Linus's tree?
> 
> Sorry, the commit ID is [1]:
> d721def7392a7348ffb9f3583b264239cbd3702c

Please send a new, updated series for all branches that you wish this
series to go on, and MOST IMPORTANTLY, some sort of proof that this
actually works this time...

In other words, you need to test-build this on all arches and somehow
run-time test it as well, good luck!

thanks,

greg k-h

