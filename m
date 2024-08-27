Return-Path: <stable+bounces-70301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90B96029B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB95628398C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D31494DB;
	Tue, 27 Aug 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHBFgHo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDC13E028
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741872; cv=none; b=ERb/gceZEmMVOiJBh1xnNRkW0yxbq6lCzGNPnImar2Y5eAOszxvlqVj9CC1uK/iUbdYYM7v3MmfDeB4NDLIzdqO5jKn2QltivKUp3pnexM+uWlJdNfIoLP06g5sSeXdA5HPy4GhY4OiDtFhPE+FXQVstIiZzt2Z8sQHv35nmwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741872; c=relaxed/simple;
	bh=UiMXWQ8rKp7T8gM8ljIJ/zVAHzfuKXG3lWJ9j7FZ+YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diiXS8dXzFRvmzL4PYPD0KhsFxUu56u205DbytOarpwOgl6VugPhiEcTO3DTGvGO2yKMto/bn1qIatA7LpJC8xhUB4XLCc8/YvEUVd5Zak/QDDwHlaCzGZiBz037NT+92Km9WGCblJhWcuQbTuMzCdcySruix+rxMO3z0pnxBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eHBFgHo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747EBC4FF0B;
	Tue, 27 Aug 2024 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724741871;
	bh=UiMXWQ8rKp7T8gM8ljIJ/zVAHzfuKXG3lWJ9j7FZ+YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHBFgHo+hdA/2OVcwtrIP60LiUgSTQ65YJN+MKi+DsSUO2uMrM1+DcSLelfzkA2un
	 xx0o60xSrskMVGt1yuRAH60brNpDOXT8jw7/O8lY6jYOaLj0sFFdNDpI/PdO+MOsv5
	 dp7oHl5lpADh+1pLMMsxgDkzKFkKmnC05z7yGMr0=
Date: Tue, 27 Aug 2024 08:57:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ksmbd: the buffer of smb2 query dir
 response has at least 1" failed to apply to 5.15-stable tree
Message-ID: <2024082706-spray-simply-cd72@gregkh>
References: <2024082604-depose-iphone-7d55@gregkh>
 <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>
 <2024082730-squire-entire-f488@gregkh>
 <CAKYAXd_7ipUOCPOOJTGCKWQOzcc34pX4dDHzG=d+O-4+o67kRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_7ipUOCPOOJTGCKWQOzcc34pX4dDHzG=d+O-4+o67kRA@mail.gmail.com>

On Tue, Aug 27, 2024 at 03:45:40PM +0900, Namjae Jeon wrote:
> On Tue, Aug 27, 2024 at 2:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 27, 2024 at 11:54:56AM +0900, Namjae Jeon wrote:
> > > On Mon, Aug 26, 2024 at 8:38 PM <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >
> > > > The patch below does not apply to the 5.15-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > As follows, I have marked stable tag(v6.1+) in patch to apply to 6.1
> > > kernel versions or later.
> > >
> > >  Cc: stable@vger.kernel.org # v6.1+
> >
> > Yes, but you also say:
> >
> >         Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")
> >
> > Which has been backported to the 5.10.y and 5.15.y kernel trees, so this
> > is why the FAILED email was triggered.
> >
> > > This patch does not need to be applied to 5.15 or 5.10.
> >
> > Are you sure?
> Yes, I have checked it.
> 5.10 : ksmbd is not here because it was merged into the 5.15 kernel.
> 5.15: smb client developer backported eb3e28c1e89b commit for only smb
> client's header.
> So it doesn't affect the ksmbd server.

Ok, thanks for looking into this.

> > If so, why is that the Fixes: tag?
> checkpatch.pl guide to add Fixes tag if there is a stable tag in the patch.
> 
> WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?
> 
> In this case, I should not add fixes: tag...? I didn't know that.

No, it is correct to do so, smb is a bit odd in how things have been
backported recently to different kernel trees, so all is good.

Thanks!

greg k-h

