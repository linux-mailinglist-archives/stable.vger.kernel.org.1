Return-Path: <stable+bounces-155245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B58AE2EF1
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B2816F5D5
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B101BC9E2;
	Sun, 22 Jun 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLOp773A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606ED1AB6F1
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750583266; cv=none; b=dHTPlN61e/zFOUTpfesCww7HUPsKSUxVFf2y9XneliMcdxxa+cKtkzEqPayFuK60rdKhBAweiOfDqWuFNk90C//vukKQi7W9bLCa1dGGjCyVsTpgH6NspTm55SrjT1gm8kxtZdS2KtyQ38Xee476qN/zdtIdZzVKvum2P3qUKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750583266; c=relaxed/simple;
	bh=mKifGyLjwQ//bZ0+DG01yUhhZ7m95kY5WovJaKk/SMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP0Y2XetuyhDNmtHbzuLotFm8ZLTNtL1X/9Inda4SZUxm1ByodINm2mMUP68WF+Npaf+rK97l6DYbrMGR6ejGl0sCv+4M8oxUwBumlSdCSuTNhayVF6waRxC5TxCBajXhst/iphqpCbjrg1g/PhFkWx+CvfkvSJ/kuDqFT2vBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLOp773A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E59C4CEE3;
	Sun, 22 Jun 2025 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750583266;
	bh=mKifGyLjwQ//bZ0+DG01yUhhZ7m95kY5WovJaKk/SMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wLOp773AKVJacPXH+r+2IYVPLU8aupHK4qXg3lrASxD9uFpMFUkXAL0tFBI++L/Fq
	 ZIFmnZ2VoP/mHHqFBUT3ORqoL3KF5KfFoGJQw+ELfceBzTUWApoRS7pt2RFG7wfKOI
	 8IpTuZ/9HdI7nbKLsBdVI+8ObIlCXKo41bwYz/Ec=
Date: Sun, 22 Jun 2025 11:07:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	tavip@google.com, edumazet@google.com
Subject: Re: [PATCH 5.15.y 0/5] Backport few sfq fixes
Message-ID: <2025062251-wing-juice-d680@gregkh>
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
 <9ddde997-df26-41d8-b51d-90572eb2c9dc@oracle.com>
 <2025062204-battered-appeasing-617e@gregkh>
 <7a627a46-0820-4594-9755-88649182a01b@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a627a46-0820-4594-9755-88649182a01b@oracle.com>

On Sun, Jun 22, 2025 at 02:20:30PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> > > Ping on this patch series:
> > > 5.15.y: https://lore.kernel.org/all/20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com/
> > > - [1]
> > > 
> > > 5.10.y: https://lore.kernel.org/all/20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com/
> > > 
> > > But looks like Eric sent these 5 recently as a part of a 7 patch series to
> > > 5.15.y here:
> > > https://lore.kernel.org/all/20250620154623.331294-1-edumazet@google.com/
> > > 
> > > 
> > > Just to avoid any confusion adding context here. I feel like Eric's patch
> > > series is better as it includes two more new fixes than my series while the
> > > first 5 backports are exactly same.
> > 
> > I'll take Eric's patches.
> 
> Thanks, that sounds good.
> 
> > Should we also drop your 5.10 series or go with them for that tree instead?
> > 
> I didn't see Eric's backports to 5.10.y, so maybe we should go with my
> series to 5.10.y and then apply any additional patches as needed.

Ok, thanks, I'll get to them next week when I work on 5.15 and older
kernels.

greg k-h

