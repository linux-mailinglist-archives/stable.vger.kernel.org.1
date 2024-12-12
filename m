Return-Path: <stable+bounces-100853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2399EE124
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94371887406
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F320CCC1;
	Thu, 12 Dec 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYT1lsYW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758C20C03D;
	Thu, 12 Dec 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991606; cv=none; b=WKXsUemJp3okokKpLxrah2UI52pNQGBbP/ldRm8oi0sE+hCDXTlFZWNYcCAPCzwOpXGIGl9HaN3mxEnKzr+iuNDdYJrguJwVHJLT6yGpH5Cq3OqqJaAFqweA3/mWn1NBDYVOL5zYVC3NlKItezxV7zFiSM6q4CKWNEYFy5ZhyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991606; c=relaxed/simple;
	bh=8BzNrdXpRYK3J5Zj0vYLHTDTPwgoL6DooDD/zG7Is4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1iVePo7rlACcjVWMUpsC+HfMhEzRP9/41ssncNU11KxLLM/Rpg1idOdYRr0C0GPYSAIlzL0KgPcoy1zwIngsHO9+5/4mGXDL/GkzKd9u0casZq9WhAG+6AMAw5O++CgcaGk75cxvfeS/Q6prX2SkpAjoU3NT8w345rZR3tx0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYT1lsYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D7C4CECE;
	Thu, 12 Dec 2024 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733991605;
	bh=8BzNrdXpRYK3J5Zj0vYLHTDTPwgoL6DooDD/zG7Is4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYT1lsYWI2OxomAdKDSYqD0kthQ1HdQzJFN+ix+HycMDP7h7nfI0mRddKps7TmU3c
	 Qu3f4fcCfahwwnFGAsm6xd0RFXtN9MKHd7N7qNu4YItLzgyPm07H6M9tRaMcihCQcn
	 9qFlgrMjeVPwzH7RVk0sE2QqDdGAt+H16Xk5dsfs=
Date: Thu, 12 Dec 2024 09:20:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address
 calculations via out of bounds array indexing
Message-ID: <2024121233-washing-sputter-11f4@gregkh>
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh>
 <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
 <2024110634-reformed-frightful-990d@gregkh>
 <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>

On Thu, Dec 05, 2024 at 11:41:45AM +0530, Hardik Gohil wrote:
> From: Kenton Groombridge <concord@gentoo.org>
> 
> [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]
> 
> req->n_channels must be set before req->channels[] can be used.
> 
> This patch fixes one of the issues encountered in [1].
> 
> [   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
> [   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
> [...]
> [   83.964264] Call Trace:
> [   83.964267]  <TASK>
> [   83.964269]  dump_stack_lvl+0x3f/0xc0
> [   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
> [   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
> [   83.964281]  __ieee80211_start_scan+0x601/0x990
> [   83.964291]  nl80211_trigger_scan+0x874/0x980
> [   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
> [   83.964298]  genl_rcv_msg+0x240/0x270
> [...]
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218810
> 
> Co-authored-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Kenton Groombridge <concord@gentoo.org>
> Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [Xiangyu: Modified to apply on 6.1.y and 6.6.y]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Hardik Gohil <hgohil@mvista.com>

What did you do to change this patch?

Also, what about 5.15.y, you can't "skip" a stable tree :(

thanks,

greg k-h

