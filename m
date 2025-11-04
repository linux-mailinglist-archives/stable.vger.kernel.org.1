Return-Path: <stable+bounces-192407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF65C31797
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A244F8E21
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C232E741;
	Tue,  4 Nov 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xepY+hgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B132E6AD
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265822; cv=none; b=o2Jr4zseUkslReD4ODcksaNZutJ8y1GSfwLWABLmB8LGe87pS8y57zHgZYXZ6tLh/VW1sXJpZC3TWlTZpbGJPWbqzW1HN4mRWFTfptEEelioyEzM/7Ve8kcGbIBFgb+QyiDGkQ2g8NEK6vJus4JrkTHLktzoDeveJ9TQudCV1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265822; c=relaxed/simple;
	bh=+EddtDDQECe3Sx6STk6iJRVzzDHW+zI2DLLKm7/IQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZT7REFH1xYP6cacYjEX42+gJFjkqJtnQ+MgId9UhGmwsPa+HPeMmNeP66gcH4G8nzx6Ey9ffWv7sP6e4XWOw1Colf+Qmbcdt4Z7W+DalVCbm8z9UM2E9b9hekf2EeYGGVBpJ5Ny/s2Xqe4mMoUnREuN7yYbqoE6DjefKBSeXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xepY+hgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90B7C19422;
	Tue,  4 Nov 2025 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762265822;
	bh=+EddtDDQECe3Sx6STk6iJRVzzDHW+zI2DLLKm7/IQho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xepY+hgMrK+FMzFjDNB0QBrD133pMtSTqq64AcRS2/t6LsX03vRlAURXrUzG+sMhB
	 UM3Cg1YCfduy8ypXaAbjx7UrbR5qYt1StkIiT1apNzAVZ4Tke3uMR6LOyhik0owLQ6
	 mEqdBIv+afJZr3htsH8QfHjrKkuGMMlOv5Wyghl8=
Date: Tue, 4 Nov 2025 23:16:57 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: stable@vger.kernel.org, kuba@kernel.org
Subject: Re: Re: [PATCH] dccp: validate incoming Reset/Close/CloseReq in
 DCCP_REQUESTING
Message-ID: <2025110425-congress-saddlebag-6d48@gregkh>
References: <2025110351-comfy-untwist-fabb@gregkh>
 <20251104095808.4086561-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104095808.4086561-1-zhaoyz24@mails.tsinghua.edu.cn>

On Tue, Nov 04, 2025 at 05:58:08PM +0800, Yizhou Zhao wrote:
> Dear Greg,
> 
> Thank you for the guidance.

I'm sorry, I don't have any context here.  Remember, some of us get
1000+ emails a day and don't remember what we wrote in response a few
hours ago :)

> I'm sorry that I haven't explicitly stated that this should be a
> stable-only fix. DCCP was removed upstream in v6.16, so the issue
> cannot be fixed in mainline. I missed including that context in the
> original submission.

Why not remove dccp in older kernels as well?

> Jakub confirmed that this fix may proceed as a stable-only patch for
> branches which still contain DCCP. [1]
> 
> Do you prefer that I submit a v2 explicitly marked as a stable-only 
> fix? Just want to ensure I follow the expected process.

Yes, it needs to be blindingly obvious that a patch is "stable only"
including the reason why in great detail.

But really, why not just do what is in mainline and remove dccp as
obviously no one is actually using it anymore?

thanks,

greg k-h

