Return-Path: <stable+bounces-126656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A604A70E88
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1351216B838
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF962E403;
	Wed, 26 Mar 2025 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSOjjgHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2F1F94A
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953126; cv=none; b=Th26jbcC8YJITLHp9o2FUi+MkqzDKeNd3/JBpeix0uLaAUhvP+5aXEvXSbwZAYbH2wkL+qK01Br2SX7OYi4npAq0rdCMBBmK2txt78GVY9k52bLT8SixQ9DB4s9R3r7Xbh4RXqLi1q9BRzysozxqfCJAMulLtxnyqN9YuKYbGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953126; c=relaxed/simple;
	bh=9SjCwjIJviBmE908v/JT7HhU1fxHCUwga73uBCGrS7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WApNxt5wkSbuIZ7aADTssmQDk0anxlXGl0LyuEdmtk4pRRoOVWlxTlL6dWhtS77vOp/DUKVPq+zszWHg+tDEn3pFPmqBSiXv8toLcX+PME6sWeNZBgfw9ghfXZHqR6JPQgljHb6zBLytzk4yk1XHNA/+JxvPUWBFIyNY4G9zeOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSOjjgHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33584C4CEE4;
	Wed, 26 Mar 2025 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742953125;
	bh=9SjCwjIJviBmE908v/JT7HhU1fxHCUwga73uBCGrS7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSOjjgHobvJxQOUXiJ7VYyQPmEk03kb23paqpI0/F1m8UyzMkr5xr23BMJD4FNLVb
	 BeV+zcOATxCtB8rKnYjWbFQRUr6s+dYnabzoKSoVWiSnG0bgdN+ep453eQinYdRfmV
	 XPgdglly0YE4Z9eTYNs6/Y3AnBU7SYVh9xHj9GFI=
Date: Tue, 25 Mar 2025 21:37:22 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Larry Bassel <larry.bassel@oracle.com>, stable@vger.kernel.org,
	xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
Message-ID: <2025032554-petite-choosy-9e9c@gregkh>
References: <20250325234402.2735260-1-larry.bassel@oracle.com>
 <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>
 <2025032503-payback-shortly-3d1c@gregkh>
 <ca78826b-bff7-43e2-8ab7-f4679e13726a@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca78826b-bff7-43e2-8ab7-f4679e13726a@oracle.com>

On Wed, Mar 26, 2025 at 07:02:38AM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 26/03/25 06:47, Greg KH wrote:
> > On Wed, Mar 26, 2025 at 06:32:19AM +0530, Harshit Mogalapalli wrote:
> > > Hi Larry,
> > > 
> > > 
> > > On 26/03/25 05:14, Larry Bassel wrote:
> > > > From: Xie Yongji <xieyongji@bytedance.com>
> > > > 
> > > > commit ad993a95c508 ("virtio-net: Add validation for used length")
> > > > 
> > > 
> > > I understand checkpatch.pl warned you, but for stable patches this should
> > > still be [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]
> > > 
> > > Stable maintainers, do you think it is good idea to tweak checkpatch.pl to
> > > detect these are backports(with help of Upstream commit, commit .. upstream,
> > > or cherrypicked from lines ?) and it shouldn't warn about long SHA ?
> > 
> > Nope!  Why would you ever run checkpatch on a patch that is already
> > upstream?
> > 
> 
> Ah right, not in this case but it might help when the backport is a bit
> different from the upstream patch(i.e after conflict resolution if the line
> in code exceeds 80 chars) -- checkpatch.pl might help us do it in the right
> way ? (only in a case where there are changes between current upstream code
> and the stable branch where we are backporting to)

Then run checkpatch like normal to catch that if you feel you need it,
you know to ignore foolish warnings from checkpatch, that's just normal.

People doing backports better be experienced kernel developers as this
is NOT a task for newbies for obvious reasons.  Which is maybe why no
one has ever brought this up in the past 15+ years we have had stable
kernels?  :)

thanks,

greg k-h

