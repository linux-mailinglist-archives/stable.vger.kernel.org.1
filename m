Return-Path: <stable+bounces-180946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD1AB91154
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077CA3ACF09
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FE2FBE09;
	Mon, 22 Sep 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYwlSOmS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFA4A1E;
	Mon, 22 Sep 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543403; cv=none; b=Rt7T+eMXoGJCx+O+uKRaQWSWyRNK37Amc+bTbAWIfctzraNr64Rj91rtjcepurYmPx5puTHIxd9a0ImiUTq2DDHLB4XNFl3c7TN8urfCk/lQ5mpIjY7YHuxzmSVMxOJo8bJmAa8HtiXTisMBqfwL7ZSPyO+7hB2qWmAGpleaHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543403; c=relaxed/simple;
	bh=MJRt97EEe+BT3wKWfiRwNQssgVD1wapxckttGIZqWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRPJPjMbJk17RA2xD2fhhoTXFb3ez+e5ohPakCflIe/LPv0YmkgBj2gY6pdAiB4pR4F0rOQ+ykLlbhCpldtkHa282H24vKMHjBm5/1DAcCGwe6biTRdOZ1/bwhYAR7+xqoZHf15y4OCbIMAp7wBAaVVxwpP8BfePFJLmiRTSgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYwlSOmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75042C4CEF0;
	Mon, 22 Sep 2025 12:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758543403;
	bh=MJRt97EEe+BT3wKWfiRwNQssgVD1wapxckttGIZqWW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYwlSOmSMnFxs6Lvzk6HJAtDGU49gI1t4M+FhL091gGLts7ydg1g5Z8vPMAtZxGH5
	 lErN3Orr16VH+wSn8UesZP/qMARzUBN5W+5ZBeMzMRKPq406MIINrg50pZYsDxhJ8q
	 gkgZXlz302UQ81dlreq57Gac1i8BlkwVV942JJ58=
Date: Mon, 22 Sep 2025 14:16:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: akpm@linux-foundation.org, David.Laight@aculab.com, arnd@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/7 6.12.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <2025092229-tribune-opponent-1a56@gregkh>
References: <20250922103123.14538-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922103123.14538-1-farbere@amazon.com>

On Mon, Sep 22, 2025 at 10:31:16AM +0000, Eliav Farber wrote:
> This series backports 7 patches to update minmax.h in the 6.12.y branch,
> aligning it with v6.17-rc7.
> 
> The ultimate goal is to synchronize all longterm branches so that they
> include the full set of minmax.h changes.
> 
> The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
> min()/max()/clamp() if the arguments have the same signedness"), which
> is missing in older kernels.
> 
> In mainline, this change enables min()/max()/clamp() to accept mixed
> argument types, provided both have the same signedness. Without it,
> backported patches that use these forms may trigger compiler warnings,
> which escalate to build failures when -Werror is enabled.

All now queued up, thanks!

greg k-h

