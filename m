Return-Path: <stable+bounces-126654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8BA70E5D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A1189EA82
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D311185;
	Wed, 26 Mar 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7kSCXyV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295633F9
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951928; cv=none; b=iY4JSqk1iF3Iv8bQh/6a0UYR+wn1YMYrl319x4mlKtXxHNqsd3dNLMai1E9/YuyU1AVCr8WTt8lFJ5+MdnsVW8uuGr796HWjHMXOE098JAa/cHzw1FDLTHbr+XTv3UwnVIOv8tE+ydvILBTRr5GhTtPbIEYq67R0VN8NzfBJaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951928; c=relaxed/simple;
	bh=mLXvMxrBMr5+BJrmRrfu5Frs7cq1E/1YBFIj4aZJ+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbnDdG1awrpub71VNvM7qST9DEVk8awO1fU+E0zx8d6PRPislMqWb26ZZc6qFnVeU8dzTzfbWswgOlAkRROMqFZkeMqFa6VNRtDomQMRHFYHJttN34LikxUoZCTXcUDxHMHGPHvHIZCcKDlR2LCg4mTJDFuQae87OKNysgiMyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q7kSCXyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F7C4CEE4;
	Wed, 26 Mar 2025 01:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742951927;
	bh=mLXvMxrBMr5+BJrmRrfu5Frs7cq1E/1YBFIj4aZJ+lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7kSCXyVelIszX4BpH4rOE2NF8D9fJTG6rhxXQHmhND0XqiAtsE1q0RvIV7gfSepj
	 dXmSBmWAx/9jMfiafwAQKagOfOGGaOeLoCYLDlC0x9gQjuQNcqFET5fm0DQow4VHmp
	 iqijPVSVJulMeRUES7qIL/IBlmpde4efWj79i/Q8=
Date: Tue, 25 Mar 2025 21:17:25 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Larry Bassel <larry.bassel@oracle.com>, stable@vger.kernel.org,
	xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
Message-ID: <2025032503-payback-shortly-3d1c@gregkh>
References: <20250325234402.2735260-1-larry.bassel@oracle.com>
 <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>

On Wed, Mar 26, 2025 at 06:32:19AM +0530, Harshit Mogalapalli wrote:
> Hi Larry,
> 
> 
> On 26/03/25 05:14, Larry Bassel wrote:
> > From: Xie Yongji <xieyongji@bytedance.com>
> > 
> > commit ad993a95c508 ("virtio-net: Add validation for used length")
> > 
> 
> I understand checkpatch.pl warned you, but for stable patches this should
> still be [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]
> 
> Stable maintainers, do you think it is good idea to tweak checkpatch.pl to
> detect these are backports(with help of Upstream commit, commit .. upstream,
> or cherrypicked from lines ?) and it shouldn't warn about long SHA ?

Nope!  Why would you ever run checkpatch on a patch that is already
upstream?

confused,

greg k-h

