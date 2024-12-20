Return-Path: <stable+bounces-105400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC59F8E4D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD631896BC3
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09E1A83E1;
	Fri, 20 Dec 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aV6+K+Xu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DE19ADA2;
	Fri, 20 Dec 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684791; cv=none; b=Y1z/i6LXoQpwYiF2BxDEAaz+Yt8sPBt4E0hcS48TAIeX4xurd/iunWLakEP4QWG3as4/AAZA/vNhZvIiprgBgSB7q7bogLVuhda3Uhgnjj4Hl0s3Fa6CLefjfws3Ev38LmKF0QAsVsAYNUEINTZ89YRdswzaeUCCk9YXDqnEBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684791; c=relaxed/simple;
	bh=P1OC0d+7eswfuTcqYH0V8dMNSAezRS37ZcjQlhmq96U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCiOstp2OQdbw10rDzup6V2U/b/87iDu9DpTqEoS8cY66qVc8xzofyN4qA/0gK0QGzAaj/kWUKExyGJCsX8IJyVREPWfzInbi953C3mzfwk5PVoo76m0SyOuSrbAJL0+r7l9+3qEKIZMzMDW+4IcPTKX7YX7PdkqSbemvOXBXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aV6+K+Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43266C4CED6;
	Fri, 20 Dec 2024 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734684790;
	bh=P1OC0d+7eswfuTcqYH0V8dMNSAezRS37ZcjQlhmq96U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aV6+K+XuIZikyNRaQ9AbkeqbOhOyXCH6ROjrjwtbZOUuaHWAiH4vm259qK3TeJPPG
	 lRW4JsJH6QVDqoVxYOTDtMPmxAJyQLein7z01dl3TxB6vOAw0T6T3V/ncIilRBp4Yi
	 26ki35QMqg/k4Uxv+M/DH/WOkzbcUeVtfQ1S4foU=
Date: Fri, 20 Dec 2024 09:53:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Anthony PERARD <anthony.perard@vates.tech>,
	Michal Orzel <michal.orzel@amd.com>, Julien Grall <julien@xen.org>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 1/1] lib: Remove dead code
Message-ID: <2024122052-laurel-showbiz-4d7b@gregkh>
References: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-2-ariel.otilibili-anieli@eurecom.fr>
 <2024122042-guidable-overhand-b8a9@gregkh>
 <2f7a82-67652e80-9181-6eae3780@215109797>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7a82-67652e80-9181-6eae3780@215109797>

On Fri, Dec 20, 2024 at 09:44:31AM +0100, Ariel Otilibili-Anieli wrote:
> On Friday, December 20, 2024 08:09 CET, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Dec 19, 2024 at 11:45:01PM +0100, Ariel Otilibili wrote:
> > > This is a follow up from a discussion in Xen:
> > > 
> > > The if-statement tests `res` is non-zero; meaning the case zero is never reached.
> > > 
> > > Link: https://lore.kernel.org/all/7587b503-b2ca-4476-8dc9-e9683d4ca5f0@suse.com/
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Suggested-by: Jan Beulich <jbeulich@suse.com>
> > > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > > --
> > > Cc: stable@vger.kernel.org
> > 
> > Why is "removing dead code" a stable kernel thing?
> 
> Hello Greg,
> 
> It is what I understood from the process:
> 
> "Attaching a Fixes: tag does not subvert the stable kernel rules process nor the requirement to Cc: stable@vger.kernel.org on all stable patch candidates." [1]
> 
> Does my understanding make sense?

I'm confused, what are you expecting to happen here?  Why is this even
marked as a "fix"?

> [1] https://docs.kernel.org/process/submitting-patches.html

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

for the stable kernel rules.

Again, you have a "cc: stable@..." in your patch, why?

thanks,

greg k-h

