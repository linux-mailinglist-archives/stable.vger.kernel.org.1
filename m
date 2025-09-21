Return-Path: <stable+bounces-180829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5133B8E18E
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E7C7A80C8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DA25F7A9;
	Sun, 21 Sep 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOSBSOg4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F419F11E;
	Sun, 21 Sep 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475188; cv=none; b=uW6oHFFABXRXorz4Z/391l86BzNsEiUL43Yoeh7tGbnuyPuZ4vFTv7z8lu8xNU6RbiXQQ7IZiFv0oTro0YneNgf1FbDwVNeqjtjTvhvDlz7WOkt+tRs1KW/dOa8pRGicWODuLok4UrT3v76M5AnSp/bTrovSdFxYOdFFOdds1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475188; c=relaxed/simple;
	bh=lmVRlAQC4W8NKHiv8+No6drVEafWzMvptZ7ZS20UPUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlLT2OSsrtRHcE4wincv0+kxs2Ug0wkKInAL4qyILxSizz6DCMLzWvL4+l1lyA5+7dv7ltlHnA9eXwRyVNXQwxUKXt3qxd0/NXnLwWT0lD/d4pbYxiZs4L9P3eaG6lz7Fc3fbu0glAFr30rrdSjxhApVuB6vNn9zbholypmrXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOSBSOg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CBC4CEE7;
	Sun, 21 Sep 2025 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475187;
	bh=lmVRlAQC4W8NKHiv8+No6drVEafWzMvptZ7ZS20UPUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOSBSOg4YfGiLA2ey8mlZFwhl/wEty7EfEI5RWKWAwfTYYe0Btc071/gUWUiExWz0
	 qIQocHzDcBWxLztTH7d0DgFmGrP9KAepr57dtoUgwnJZWxuz6ARt0fe56YdxoWOjDY
	 KU+c2bUBIUSlB4fy+9g9VEaKbitYFRqwhTgFSqso=
Date: Sun, 21 Sep 2025 19:19:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/2] mptcp: fix recent failed backports (20250919)
Message-ID: <2025092132-nickname-untaxed-25a0@gregkh>
References: <20250919223819.3679521-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919223819.3679521-4-matttbe@kernel.org>

On Sat, Sep 20, 2025 at 12:38:20AM +0200, Matthieu Baerts (NGI0) wrote:
> The following patches could not be applied without conflicts in this
> tree:
> 
>  - 2293c57484ae ("mptcp: pm: nl: announce deny-join-id0 flag")
>  - 24733e193a0d ("selftests: mptcp: userspace pm: validate deny-join-id0 flag")
> 
> Conflicts have been resolved, and documented in each patch.

All applied, thanks!

greg k-h

