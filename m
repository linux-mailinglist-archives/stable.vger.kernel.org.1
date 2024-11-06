Return-Path: <stable+bounces-90062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EB9BDEA1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FE3B20B9C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 06:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11DD1922DF;
	Wed,  6 Nov 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZx6U/nF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED301917C0
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873599; cv=none; b=Q7Rncf3p+4AeoI9b5XhvWPAbSi/iuYxjyy/bGSwyUkZ8J/gaC4TNs0mhyn15/Shz9g3rESLITaAP5Zbhgk8F4zJCidTf64TTFKAowiEyY3WpA8qE/UGYqUJKGSxCf3KfsrCl4/SdpV8ddnS4ocwUB3QYbaKViIvg4mKF4ugBnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873599; c=relaxed/simple;
	bh=eh6bDxnVZqFSUU+FNQBPdE32o/DlX1wqM79ME1VzLyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CO1cPLH3fWyXroDxMOhrnOKkxHdZlOPNZIICCaCGmZqBhAII5wcf2f7tQJrqDwUROTNOyOjN64YdOeP90mstAYL0DO1J8Wls//jHUGimKesc5F1jMF9Vv640aG3/SK65wqJU1L5vGp/iuOc9RKR3ka1Dj6JkWmnnvA88pPXiDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZx6U/nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8961C4CECD;
	Wed,  6 Nov 2024 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730873599;
	bh=eh6bDxnVZqFSUU+FNQBPdE32o/DlX1wqM79ME1VzLyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZx6U/nFGE9yRx2ZYt2VHqpSbz+cDS1OaAmREuJr9Ni644nITECDLhVs9dmGzUkJC
	 a323H2XqkM5TkQ61ZGOvk0oa8/mJ9m8JJLJL8FZ8laxoTOGebNmrafVRWZKqHuQJcU
	 peSKd7aKDhR7J4Pv6q9RCg2O+8BaV9A5Yyh4yxnY=
Date: Wed, 6 Nov 2024 07:13:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6] SUNRPC: Remove BUG_ON call sites
Message-ID: <2024110646-crimson-eldest-b168@gregkh>
References: <20241102065203.13291-1-asmadeus@codewreck.org>
 <ZyXOg2gepysQBic0@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyXOg2gepysQBic0@codewreck.org>

On Sat, Nov 02, 2024 at 04:02:27PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Sat, Nov 02, 2024 at 03:52:03PM +0900:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > [ Upstream commit 789ce196a31dd13276076762204bee87df893e53 ]
> > 
> > There is no need to take down the whole system for these assertions.
> > 
> > I'd rather not attempt a heroic save here, as some bug has occurred
> > that has left the transport data structures in an unknown state.
> > Just warn and then leak the left-over resources.
> > 
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> grmbl, missing my signed-off, sorry:
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> hopefully didn't miss anything else..

Can you resend with this fixed up so we don't have to manually edit
this?

thanks,

greg k-h

