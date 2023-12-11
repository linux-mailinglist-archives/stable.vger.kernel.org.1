Return-Path: <stable+bounces-5249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF64680C178
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991F0280D2C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7901F606;
	Mon, 11 Dec 2023 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgDZsZ8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43B1D69A
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF22DC433C7;
	Mon, 11 Dec 2023 06:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702277045;
	bh=9/0EURPl9PI/VDT8Zn5VHboBP2idCB/whBgSZHxC6mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgDZsZ8zVp+H94QFD02w/pAT4s3aSivtpiNmUI7ORZfyJBt6m1J2dt9pj5olNOEzF
	 SjdYjncFkUq+uTjmYApyOvxj5LPsH++UnoGQaCM5AOjGE+ix4Tr81i5Pl2X/ItHQDc
	 7NyEPFk41xLttwLVOxaovaMym4nfRUfrBYWhtNEA=
Date: Mon, 11 Dec 2023 07:44:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: lkft@linaro.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] parisc: Fix asm operand number out of
 range build error in" failed to apply to 6.1-stable tree
Message-ID: <2023121129-preoccupy-hypnotize-a2ea@gregkh>
References: <2023120949-waged-entail-7b6b@gregkh>
 <c5d9b509-3c37-419b-a325-971d9b2c7c56@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d9b509-3c37-419b-a325-971d9b2c7c56@gmx.de>

On Sun, Dec 10, 2023 at 05:43:53PM +0100, Helge Deller wrote:
> On 12/9/23 13:33, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Right, it does not apply, and does NOT need to be backported.

Are you sure?

I ask because:

> > Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
> > Cc: stable@vger.kernel.org   # v6.0+

Both of those lines imply that yes, it should be backported.  Are they
incorrect?

thanks,

greg k-h

