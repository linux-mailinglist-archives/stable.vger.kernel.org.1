Return-Path: <stable+bounces-94000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DAC9D2710
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72571B284C3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6371CCB34;
	Tue, 19 Nov 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYa5haGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C912B93
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022977; cv=none; b=sMEvH30k8/IKJRctI1TIMjha85KIdTpfsrJ9kgqLLmQw1vKpJe/BRg+zlL80sg96LYZEE/1faJ5dE6iHSgzcWUrAX1YDNbILmLsY3IytE5Y4SQbQrG24sWMnJijGkarfev9/t5JIJRSF+bWAGtZP/FE4pwKheqhVxVV0tEX4uCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022977; c=relaxed/simple;
	bh=4Yq5Y1HkxvONcu+Ne04IiHc+fhdD1aPDqb/GLRVVGqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDgeANdjB1+rSbFrZxJB2wjRrIyczxxNAg0R69qiCsnng+1QX20+fO9+cAT2kngxpIAUdhRmjrX767xEU8bVlSksG87Pf8m9GAEAIiQW2bAp8D3Nmo1mOL9K0FqxDANyTusZtt7vXpJmaoyhtlQROO1Xi8PvRhs2n3vIpu0AdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYa5haGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BAEC4CECF;
	Tue, 19 Nov 2024 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732022975;
	bh=4Yq5Y1HkxvONcu+Ne04IiHc+fhdD1aPDqb/GLRVVGqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYa5haGqxEfBdOu9U1Lu80lOaawC9SRnAb6dLHwiFBJmnZnV4JVRvXr2xI3Q53R5M
	 x7xjoBZJ7wgvtSj4NqropJ0ydXiZruEPrHykNnV9Wfy+4vPDMRaiAiU027iIgqfDwu
	 5B4x7FO46UU9N3BOhOGL/RZrtfCeF+MYelESur58=
Date: Tue, 19 Nov 2024 14:29:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, aha310510@gmail.com, chuck.lever@oracle.com,
	stable@vger.kernel.org, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.10-stable tree
Message-ID: <2024111904-vanquish-subfloor-997a@gregkh>
References: <2024111703-uncork-sincerity-4d6e@gregkh>
 <a83ff8e9-6431-d237-94ec-5059c166a84f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83ff8e9-6431-d237-94ec-5059c166a84f@google.com>

On Sun, Nov 17, 2024 at 08:55:28PM -0800, Hugh Dickins wrote:
> On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111703-uncork-sincerity-4d6e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> For 5.10 and 5.4 and 4.19 please use this replacement patch:

All now queued up, thanks!

greg k-h

