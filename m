Return-Path: <stable+bounces-121229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54132A54AF8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42A63B1B73
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A720B7F3;
	Thu,  6 Mar 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFK/I2NH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949B20B7F0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264860; cv=none; b=oMHB1mVpYK/f0eomev4bsVou/CNhqkmKBP2A9INMIq5tBDpXtANtCxNuENx8s2hy+TIIhtQKOCZU/FKatyP8LGeH2Ek1cCEy3JHma/FQOBI5AiE2aX+2Ng/rNbNt0qUzWUuwd8H+7n+6/J8e1V2H2roo7fRR4rOxuc7ftzCK6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264860; c=relaxed/simple;
	bh=8j6yfcAOAslJDJHFFxApFFiMplFeACmnSuaMoDmyEJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtIlJsrDAqy29RxgXtXbXh6wtS3C4TsgynVOhpf+DSx7nmXUHgwRL598rvLLHVtf7Bs9eakkjPpyyYre/tmpPZVyEA4UztCbcd5kuwZ5pdMtcs8mIK5CBxsseTbGdEfpHd3DS6mtzrbflPxInyR0Z6f3dztJJp1ZLz58NjIKDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFK/I2NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C1C4CEE0;
	Thu,  6 Mar 2025 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741264859;
	bh=8j6yfcAOAslJDJHFFxApFFiMplFeACmnSuaMoDmyEJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wFK/I2NHS0RwEGaH/1Ov8uijnGDCIGLRShrJnHA0p7tQhuyQUtm2VfeRuEqn/DKXQ
	 f5wkqpWXKXyehcpe1qulhrLfqFRx+//qzlH0297ag4blpXtGjKW55VBpESn7EMdGAT
	 nJcAUDm3r+A2LKfEPDjG6saVFxqEBcBqoWo5GPk0=
Date: Thu, 6 Mar 2025 13:40:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>,
	stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10.y 0/3] vsock: fix use-after free and null-ptr-deref
Message-ID: <2025030650-duty-tinderbox-459c@gregkh>
References: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
 <2fx5pzum52zhb45vp7f2csns5gc7l2pl75mo67gy2ewirofy5e@5yh56gdgyiha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fx5pzum52zhb45vp7f2csns5gc7l2pl75mo67gy2ewirofy5e@5yh56gdgyiha>

On Thu, Mar 06, 2025 at 10:21:47AM +0100, Luigi Leonardi wrote:
> +To Greg

No need to top-post :(

> Ping :)
> 
> This series is also available for 6.1 [1] and 5.15 [2]

Yes, I see it.  The backlog of patches manually sent to us for stable
trees is very long now due to lots of different reasons.  I'll be
working to catch up on them over the next few weeks.

> @Greg:
> In the future, should I put you or someone else in CC every time I send a
> series?

No need.

thanks,

greg k-h

