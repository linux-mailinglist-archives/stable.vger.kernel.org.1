Return-Path: <stable+bounces-100891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767F9EE4BA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0145D282A02
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD692116E2;
	Thu, 12 Dec 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsgUiS5y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E421149E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001603; cv=none; b=mHkbcbbVLAPBjR2DdJwFnTT8ZEDTwMa0Frn3wuzkPFJVb+Xcu4uZmZQ+T1onEF63+lLhobSatOZeNGCXvWwvZOVCZFEUOS4s4hmxxTKQA3K1wKpSitkCFkPTPY044XxA0CofDjZQ8564A7IONd7HHmvWOqzq1iSrUZ+Yo8o84ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001603; c=relaxed/simple;
	bh=4vAM3O8LM0O8XAs+45UJbpa8HJMWlM+/tEoVaFwGS+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AysoTtIm+WKyLrRB4lYe0h4qSmGl4T7h8+2uUxOd/NKEkkqRK9roiZTrxz8ngQii8dfMrJ0Lxsu4OlAmfFZQG/BVrmlQ7OFdoQV1s47Vg4/B16ce+2xLnBMwPzkqxK8VLQb+WM8AncI6vlzQ6YE9CsaVyKiQs+Yh4XxK7RUUR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsgUiS5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A331CC4CED1;
	Thu, 12 Dec 2024 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734001603;
	bh=4vAM3O8LM0O8XAs+45UJbpa8HJMWlM+/tEoVaFwGS+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsgUiS5yuogkU7/OBju5Z6xbj7/XMzrgtdiI9X79nQApKSkexJZyT7tiRd4tCi4z+
	 Ft5h+PtNpshHWNk51A/YrDkLC7gvwjG8qSCMyYA8hc0wJk/uNbCpxS2k2BwJQ1lur0
	 ZLyqjiRBt4D/B5bjbb0O3Foi2OKHsxWGZxw1CQBc=
Date: Thu, 12 Dec 2024 12:06:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Thomas Voegtle <tv@lio96.de>,
	Su Yue <glass.su@suse.com>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
Message-ID: <2024121210-snowbird-petty-f516@gregkh>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
 <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
 <2024121244-virtuous-avenge-f052@gregkh>
 <a6054a83-2dda-4548-afd3-96dcea453159@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6054a83-2dda-4548-afd3-96dcea453159@suse.com>

On Thu, Dec 12, 2024 at 07:01:08PM +0800, Heming Zhao wrote:
> Hi Greg,
> 
> On 12/12/24 18:54, Greg KH wrote:
> > On Thu, Dec 12, 2024 at 06:41:58PM +0800, Joseph Qi wrote:
> > > See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t
> > 
> > And I need a working backport that I can apply to fix this :(
> 
> I submitted a v2 patch set [1], which has been passed review.
> 
> [1]:
> https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#mc63e77487c4c7baba6d28fd536509e964ce3b892

Then please submit it to the stable maintainers so that we can apply it.

thanks,

greg k-h

