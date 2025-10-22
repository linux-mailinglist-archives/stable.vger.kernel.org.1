Return-Path: <stable+bounces-188900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F7BFA2BE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563F9501A9F
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881992EC568;
	Wed, 22 Oct 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fQ+MJtKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2F2EC0A4;
	Wed, 22 Oct 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113277; cv=none; b=RymUlTJOX/Tfj/Sd6BCZOtRtXagrCQmNnfnFFRqLgSxyioBY12cs/jmLAx/6RZ++yJ4LPdhbkYKUn8rGPMi5EfMXCh/66KUrVKFOAKbLhEvb0sKvqVQ/KDGR00yv2lVcEMF4FGfVFWERJGCyfB45S74qmdMmFQcc2yW9Y2QkFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113277; c=relaxed/simple;
	bh=srkenRpEiHXPwQ51Ii6mcXFG6JoJPGlwguS23YeEel4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ9K2r3teQ2OmrFDRp0oH4eoVFvQc6Pg+xrn/yBgxXDdNIUBjo1Uiz5MxuUzEixO83nbb2XZa9knDUadNyub0yp2Xm4d06KbQ2xwfG1MAgf9oO0J9cn5EFMy9OABmM3sS4FIIPR9eKCVSnhqWqQ5FzTBSJQeqsctYJLJEd6zuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQ+MJtKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30800C4CEE7;
	Wed, 22 Oct 2025 06:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761113276;
	bh=srkenRpEiHXPwQ51Ii6mcXFG6JoJPGlwguS23YeEel4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQ+MJtKwHr36LOV3G1knlCK+R2NmGpz8aDtIbdAlzs/EJ7QKjuRSL1kK0lnwXqXkj
	 NVoNMlgTR1iPqdlrcsDTa2AQL1eE2b928Wjyralp6cLGchU0sIzB3IOD8WOkMuEKK3
	 j5LoeRq1JK2PQokjwa7wnZN10H3QznVZKEGgFpz4=
Date: Wed, 22 Oct 2025 08:07:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Message-ID: <2025102245-backstage-sprain-76fe@gregkh>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <49bfd367-bb7e-4680-a859-d6ac500d1334@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bfd367-bb7e-4680-a859-d6ac500d1334@linux.dev>

On Wed, Oct 22, 2025 at 02:01:26PM +0800, Lance Yang wrote:
> +Cc: Greg

I have no context here at all :(

