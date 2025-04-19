Return-Path: <stable+bounces-134671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68744A941E8
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744347B0153
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F98157A72;
	Sat, 19 Apr 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPicrS72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96C3232
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745042530; cv=none; b=kA1wlFiERSVyp6plJXqMA+WTWn8ocvTSdB86+teHPiF3RyGnYjvB8U+3zbbcizemf8Q/9rJnmrnX+ExJP0uWeQ52RW93lMpg7R3NZ+L3thr7UaSnGy5pWyqg2OwjUDo9/ngwmLFom06qV1rMpEHwwB26BH/Ris/Nwpv53U+f3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745042530; c=relaxed/simple;
	bh=LIko6X+xYrxCUctk4TJixQ4zc8A7oa/07HOwCBydDpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBrpIC6qz+hLgfEA77JCFJfPq0qv/SfQnq97gCyT4BmW+MfVnJsQNaxqVLGG9JmM4NUj7p4BRIuS6Lr3TlEi54oihErmH/FLdJHiwCkL9GnOyIv19IotBGCYq4kTFZxo1e6qjCCbvWf1A52ICUG33qylxncNFvpa+/J93wB2EUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPicrS72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA8C4CEE7;
	Sat, 19 Apr 2025 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745042530;
	bh=LIko6X+xYrxCUctk4TJixQ4zc8A7oa/07HOwCBydDpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPicrS727Zqq8ams2rnGGqGT8Ih7NNwmNQEFs4vdIF4Kogs6hh6q4tZTD9ClOcbhQ
	 dnXTkQuE/mmJUhLz8F3+N3wPBUFFfzm8uCggbrAQKbH10uuwt6j1LlRtwP1OglWoJJ
	 YA4wwioQtchFTaUxnR+aH8i/eWR1i3+AooutswF0=
Date: Sat, 19 Apr 2025 08:00:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/pvh: Call C code via the kernel virtual mapping
Message-ID: <2025041916-babbling-munchkin-6e25@gregkh>
References: <20250411160833.12944-1-jason.andryuk@amd.com>
 <bb347b9b-0dcc-4fe2-8deb-11661b3e2510@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb347b9b-0dcc-4fe2-8deb-11661b3e2510@amd.com>

On Fri, Apr 18, 2025 at 04:32:35PM -0400, Jason Andryuk wrote:
> Hi Greg and Sasha,
> 
> It's been a week, so I'm following up on the status of this.

Please relax, right now I have 477 "backports" to dig through for stable
tree inclusion, including your 4 emails.  They will be processed
eventually, when we have the time to do so.  Newest kernel trees are
always handled first, and then we move down to older ones.

thanks,

greg k-h

