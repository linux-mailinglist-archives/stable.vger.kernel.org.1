Return-Path: <stable+bounces-81309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD915992E0E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4821C22D46
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBB1D461B;
	Mon,  7 Oct 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIGlvDwn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B31D4176
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309574; cv=none; b=WNYc9PPk6BEDt/fIWQRF5K93foSfgJcCHbuXlvaT+xOA2orxUu/uiZMzcUbYym2nLfuamGbPYWvdBTtCd1bQjkK2d+ER+0QNcYypqFYI0+1c06VlvIozGxzECgRWGhDtrN7MAbjLnIHHGObHKrqL3i/td9ESQRCvgPnvE4ajoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309574; c=relaxed/simple;
	bh=23GlKY3zZfzOtKHuafxEveTfC6r9mTEr8RcVdlLKRac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hycCJLzbZ37Y+2Dc/g12D0HpEJRLd1Jctxu/PuOH6evJkE+VGg4Zk45/+svQjdoPBk3xZrJVPYQP5OuNWaVH5wy4+3o0Y9woink1wit6unmPY07ro0wa6WKG2Y1Voxsoqxw33xsqZuAj0JyZ7lY5CF00uvBj7SW6lHavDxy/gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIGlvDwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF711C4CEC6;
	Mon,  7 Oct 2024 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728309573;
	bh=23GlKY3zZfzOtKHuafxEveTfC6r9mTEr8RcVdlLKRac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIGlvDwnHS95tl+7s0H9eqWkXdsCslWBvWVtAZ4aRyReEqSWAyXoJJcoWiBvS6x0P
	 gMY8Zf+/RY3jT/h5U/7n9qoARMUGrmWb20NZU2QQRQYyPuWYsHr/0kL2TM1s3mE2cu
	 LNQ393DF3m2EWdOeXrd7VP4APt+LUQ7z83aBPSvU=
Date: Mon, 7 Oct 2024 15:59:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Wrong tag for queue/6.1 = v6.11.2
Message-ID: <2024100715-emphatic-calculus-f9e0@gregkh>
References: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 02:58:51PM +0200, Sedat Dilek wrote:
> Hi,
> 
> can you check the tag for queue/6.1?
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1

I have no idea how these are generated, that's on Sasha's end
somewhere...

