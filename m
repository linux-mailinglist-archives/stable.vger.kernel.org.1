Return-Path: <stable+bounces-178863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90802B487FA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6816860B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E32F068E;
	Mon,  8 Sep 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9HuzlHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB62EC543;
	Mon,  8 Sep 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322660; cv=none; b=aRGv9kBY8SbKDuun8waANDaEYMTkblccV7wBDywxQIrtXh7bbfyDw3CTDg1uNvwbUViqLZuZNR9mEjNMlBsO0KCrCGUb3qOHZoNp4AJBTImvvJs74MjUj230xxj+PB2FlzB3JGIIbz2GagklTwo6jB2nZSiQ2cKH+YCxEFhq/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322660; c=relaxed/simple;
	bh=ckwGShTeBv15eGYH2JYkdIx0frQUPT5Y+c7ARmeXZbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spF9GKb1o8e6DugvKe0QfWwNIwb2yfe3eKITMM3nbJLj+stmSPS51NzLXyQxrRLg4uUAeutDpSQGOvPhRDt3QBM4amlJ/P9V/jPrnoxG/zvvHGhf+3gzlz3MLseTv1YBTBbNk9rQ384wKx0R3ThclbTAWHz5ocPzpcnYSrkGAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9HuzlHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A2FC4CEF1;
	Mon,  8 Sep 2025 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757322659;
	bh=ckwGShTeBv15eGYH2JYkdIx0frQUPT5Y+c7ARmeXZbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9HuzlHpdnnnXm5t8/jexlNUb3yMdmDQhlklcRqphUTDQE5rTE9YvHKiPIpeIWM3x
	 MZWMzPAQEfKYb+gjzfMb6GVc5ueqajwhXSAUiGfXGWut5A5QtyNKUHBeaKYI7bQbtz
	 fJbVbl9JOZun7SvvPvHy/t2OCXQDyNxfqFNHl0WY=
Date: Mon, 8 Sep 2025 11:10:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Diederik de Haas <didi.debian@cknow.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 013/175] drm/rockchip: vop2: make vp registers
 nonvolatile
Message-ID: <2025090842-untruth-impotent-94e3@gregkh>
References: <20250907195614.892725141@linuxfoundation.org>
 <20250907195615.203313380@linuxfoundation.org>
 <H3KxvGMniMkMPiHrpRDqCn2F7QdfdhNgkc4MJ2dt4y0L4ddta0HvB8xscoZLISq01mLVFg_o1tpoeLCBf8LgvfgIFWH_xBKxgOHerf-l9Dk=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <H3KxvGMniMkMPiHrpRDqCn2F7QdfdhNgkc4MJ2dt4y0L4ddta0HvB8xscoZLISq01mLVFg_o1tpoeLCBf8LgvfgIFWH_xBKxgOHerf-l9Dk=@proton.me>

On Sun, Sep 07, 2025 at 09:33:47PM +0000, Piotr Zalewski wrote:
> On Sunday, September 7th, 2025 at 10:27 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > 6.12-stable review patch. If anyone has any objections, please let me know.
> > 
> 
> Hello,
> 
> Gamma LUT support in vop2 was added in 6.14[1] and even though this bug fix
> does not explicitly depend on vop2 gamma LUT code, the bug won't happen
> if gamma LUT is not implemented.
> 
> [1] https://lore.kernel.org/all/CAPM=9tw+ySbm80B=zHVhodMFoS_fqNw_v4yVURCv3cc9ukvYYg@mail.gmail.com/

Thanks for letting me know, I'll go drop this patch from the 6.12.y
queue now.

greg k-h

