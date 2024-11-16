Return-Path: <stable+bounces-93645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49809CFF2E
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D9B22C1A
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24CDDBE;
	Sat, 16 Nov 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUEnJfKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECC2F29
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731764838; cv=none; b=opDGxnfzQdjlTTHJwKAk+hVKZ/9ch/W5QvLlGElISUcstLPG37gA1+vrAu2z2w9p/8pP7EgDH0GQIoGeBMXEa6b5b4Iir0220qXT6saPVrmiyN7O4iLt3LwSVJhyE6jvT8XzxSONCrGa3g9r1w10xPDPpqBwY9+YjM3zK+DrmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731764838; c=relaxed/simple;
	bh=Lks4C1PhCdUs8sfXen3g0iLKyN6c9cFt0Jk0rFhtjnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUo6/biN1QthQVH3sys2qflCtJz30UjQO0CN/5kpFgG2wCnQLK5jh+ZfF0cb0repYNLq8gYUMx2U/zruMk598QFQ9diG45ttfGQ7Y8+drQPaX6W5EhLfi1pepJpsTesVJokPI4hWO0ZQjJcD+pqRKcNzIWj61KSjCwEzXCAR5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUEnJfKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0379C4CEC3;
	Sat, 16 Nov 2024 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731764838;
	bh=Lks4C1PhCdUs8sfXen3g0iLKyN6c9cFt0Jk0rFhtjnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUEnJfKD5IRvoxxjWHxJwSAO9+ltDx5OM59i7UGddrwquKEDaPJfvOdXNf+QWK+PH
	 zzn1Jwq0ZD31zFc1Im7YFQvqDJOOy6588e2zJqYmmMAms6QcgOpEbqPNsgMKlt/yGI
	 iYkZmKu4zKrZ73kxxj6DVv4gu+diMPNmu7yzI6Vg=
Date: Sat, 16 Nov 2024 14:46:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
Message-ID: <2024111614-conjoined-purity-5dcb@gregkh>
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116130427.1688714-1-alexander.deucher@amd.com>

On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> 
> This causes a regression in the workload selection.
> A more extensive fix is being worked on for mainline.
> For stable, revert.

Why is this not reverted in Linus's tree too?  Why is this only for a
stable tree?  Why can't we take what will be in 6.12?

thanks,

greg k-h

