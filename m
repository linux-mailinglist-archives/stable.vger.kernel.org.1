Return-Path: <stable+bounces-23847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D8868B52
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB61C22D4B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8113340B;
	Tue, 27 Feb 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orqevyAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273A55E78
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024084; cv=none; b=iOWziqiC9+fhnyQikS6nSo+zGSY5ED1+unNBy+Vco77u/t/9R0N9DTbweo52Knk5ZeWSh8J6ymz3koV4T669cs1eBH1Iy2G6utGwqAA3SeMDBUFnt2Vp3vf3HSJ+FYzx4uaQweEPbyLYpiNdFep5GizBhkbQZ9vy0zPNaxZxJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024084; c=relaxed/simple;
	bh=T9SNTmEJJFyXiiwXdIhtEq1rOuxG3yNIBA4XTTkEvcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKkayp6cfYghfNRd1fPE5mMD+chJoZsYsOR+XLQT808EGprM/2qG6ii1wl5+ypxA0fvma2SUu8l3sbe4kZ0UVO/Y8fA4zZswHh4y2MB4YmOJ78mMr5S/+vp2opg5TdqswTVDbP1V7FtdK9uexy+YTe2jJpH5rMrRFRk534ViK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orqevyAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EFDC433C7;
	Tue, 27 Feb 2024 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024083;
	bh=T9SNTmEJJFyXiiwXdIhtEq1rOuxG3yNIBA4XTTkEvcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orqevyAoX0wMsDM0Fg1SR3Ds97A8qJSUXoP7ZcgHZg4g5glU9ARg0CtSYjrrZOB/D
	 pJmU7YRKqxVohenZJ4tiSMf9nGiIkRn0ILna4TdMMvjECqIibk3AuxpYl6bP1FrMYM
	 y/wvtkBkLQg8agbndFK/33NvwNHc9Xw2nwnI/1lY=
Date: Tue, 27 Feb 2024 09:54:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: chengming.zhou@linux.dev
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Message-ID: <2024022728-phoenix-varsity-45e9@gregkh>
References: <2024022622-resent-ripeness-43f1@gregkh>
 <20240227022540.3441860-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227022540.3441860-1-chengming.zhou@linux.dev>

On Tue, Feb 27, 2024 at 02:25:40AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We have to invalidate any duplicate entry even when !zswap_enabled since
> zswap can be disabled anytime.  If the folio store success before, then
> got dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store().  So later lru writeback may
> overwrite the new data in swapfile.
> 
> Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)

What tree is this for?

thanks,

greg k-h

