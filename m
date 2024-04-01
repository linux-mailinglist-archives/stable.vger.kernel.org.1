Return-Path: <stable+bounces-33920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD62893A46
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60166281EBC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3020171C1;
	Mon,  1 Apr 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dOqJdiJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C1119F
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968291; cv=none; b=d3NPEIormwZCj3VKg+YOf+Wlk6mtunjy8JQTE6r0xUcoBNIkyET34iZiYcwjOzIbZUDP85oncV6jXik9cVlT2tfr4g2l+cNpG983Dc63kOpeJswijWwAAeG6gd+xQbjDp/489NoONetagHcngscULOX+nL9XCMCDWFs3vsBeFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968291; c=relaxed/simple;
	bh=AntwOfzzGfJhX2sZUL/CxwaktPpZ+BvSYOhtA8/MWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD+nAl+nvzeU3L3T0GAsCwdMnXJ4JIYTImnEi+bfc050YW5mHtg2o+koeyHOnsYYjMi5ZU27ReL+mHxKWwau9EKaR7bOYIUrE21lj8O9JaQrytdhDWrJStP2fMkBi5AdQhKgVBTVMdc8N15wb207/SOhSj9/5b1r/LEy0TCVmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dOqJdiJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B144C433C7;
	Mon,  1 Apr 2024 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711968290;
	bh=AntwOfzzGfJhX2sZUL/CxwaktPpZ+BvSYOhtA8/MWEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOqJdiJKP/ZQ5ln9K0BK8C5vDegKGP3n9nQzINSOy2/5Pc7j09oDUY+SDWUTXU9Zm
	 eZGnqguBcWT0Gr1JLzkK/ehwd346lv8I5gkBYmQZbL4k7Af6XKvLJXN+sVucVdrRqX
	 eb6zKf/rvWrr54uvb/Y1y2f23jHdqPpOX/qYNp8k=
Date: Mon, 1 Apr 2024 12:44:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.7-stable tree
Message-ID: <2024040138-pardon-recharger-a097@gregkh>
References: <2024033028-lumpiness-pouch-475f@gregkh>
 <20240331094945.GAZgkxuZYOCg8jwh82@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331094945.GAZgkxuZYOCg8jwh82@fat_crate.local>

On Sun, Mar 31, 2024 at 11:49:45AM +0200, Borislav Petkov wrote:
> On Sat, Mar 30, 2024 at 10:46:28AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.7-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 28 Mar 2024 13:59:05 +0100
> Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4
> 
> Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.

Thanks, both now queued up.

greg k-h

