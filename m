Return-Path: <stable+bounces-5509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107180D2B5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0E41F21603
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F148CC1;
	Mon, 11 Dec 2023 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5bihOnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C4FC07
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 16:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6254CC433C8;
	Mon, 11 Dec 2023 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702313335;
	bh=wK5qGM4f2x6Jnl23Ta9ut+lgeoAFCbJ816LBgipMPaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5bihOnMAZIwnRnP0so5GgIpfKqf8Ga3i9eGgBgWQClzWKoKdJ/7KccEqIKvDdTBv
	 4Y/wePvrmi+ujysa9pfqhNVnQWjl+aQI+83MFP5eFdBYYASYdRw5TJFHrGqHlOdjt3
	 TEn9s4dHGt+rk263fZRyb+pi2w/+C4vs6rdAswWA=
Date: Mon, 11 Dec 2023 17:48:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: lkft@linaro.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] parisc: Fix asm operand number out of
 range build error in" failed to apply to 6.1-stable tree
Message-ID: <2023121141-reptilian-escapist-0977@gregkh>
References: <2023120949-waged-entail-7b6b@gregkh>
 <c5d9b509-3c37-419b-a325-971d9b2c7c56@gmx.de>
 <2023121129-preoccupy-hypnotize-a2ea@gregkh>
 <aa3d0bc0-5108-4ec5-831d-27d9f326fee1@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3d0bc0-5108-4ec5-831d-27d9f326fee1@gmx.de>

On Mon, Dec 11, 2023 at 03:56:47PM +0100, Helge Deller wrote:
> Hi Greg,
> 
> On 12/11/23 07:44, Greg KH wrote:
> > On Sun, Dec 10, 2023 at 05:43:53PM +0100, Helge Deller wrote:
> > > On 12/9/23 13:33, gregkh@linuxfoundation.org wrote:
> > > > 
> > > > The patch below does not apply to the 6.1-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > 
> > > Right, it does not apply, and does NOT need to be backported.
> > 
> > Are you sure?
> > 
> > I ask because:
> > 
> > > > Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
> > > > Cc: stable@vger.kernel.org   # v6.0+
> > 
> > Both of those lines imply that yes, it should be backported.  Are they
> > incorrect?
> 
> Oh, I added a wrong "Fixes:" tag in the upstream commit. Instead it should be:
> Fixes: 43266838515d ("parisc: Reduce size of the bug_table on 64-bit kernel by half")
> but this commit was originally not tagged for stable series.
> 
> I see Sasha pulled it nevertheless into stable-rc series, together with this commit
> here: "parisc: Fix asm operand number out of range build error in".
> 
> So, either we keep both (as it is currently in stable-rc), or we drop both:
> * parisc: Reduce size of the bug_table on 64-bit kernel by half
> * parisc: Fix asm operand number out of range build error in
> 
> I'm fine with either option.

I'll keep what we have in the stable queue, thanks for checking.

greg k-h

