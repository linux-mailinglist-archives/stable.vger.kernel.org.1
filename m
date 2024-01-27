Return-Path: <stable+bounces-16038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CA83E875
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C171F23C61
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3039E;
	Sat, 27 Jan 2024 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CYjoyuGF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED619A
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315298; cv=none; b=pJoGhnL2UD27YWG6fjhTkcGm6SuyPHaqS/GDcCxF7xEU+SUZPwvajIzjVz0fSWmeVimfO/R7THE9v10kJRpiV1x6rNlurwFkTqRan8Agy1uWZioEDIVH6QrEGD+y6v49UfiFDGiMyg6q9iEeZ1+8Pk24UJFUU+8ME/hP06vatig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315298; c=relaxed/simple;
	bh=qsHKRjbn3SmRtUSdoC90y+V19HZ4g8YEs+gp+6GAxrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUBSc7tAIQ9qk1bww7qmwQR7yrcv2HtfeTJUvji2plQJs5dhu3s8xqk/u1XcIcPu6Hl7U1yVM2I30TpGseRv6NRWtDAeyDw4hIRVwHASCEfYiv1fVpQCrsjOALde1OrriPRLcu/4Afl+BgZzDjjyHjjerbr1h8+sDrmsU2SjDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CYjoyuGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E45C433C7;
	Sat, 27 Jan 2024 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706315297;
	bh=qsHKRjbn3SmRtUSdoC90y+V19HZ4g8YEs+gp+6GAxrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYjoyuGFlB3LON+NRC2SWevVAcNFYxRBei/u5ftJZBYM2V0dP1UgX8EQ3JYbpgz2F
	 cVGg9ZsqspgcWwe6obOwwmCl6x9WZeXdwWITCVg7O4OurzBCxzuYebcLSCYFTx8Wgl
	 7qyzL34+LsGW9wz1vuJXrrbmtxBSIkZ7Wo7Zy2XI=
Date: Fri, 26 Jan 2024 16:28:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 4.19-stable tree
Message-ID: <2024012608-alienate-nautical-59ba@gregkh>
References: <2024012229-dealer-luster-6ff4@gregkh>
 <Za8hOgYxV3Y8Jnqo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za8hOgYxV3Y8Jnqo@casper.infradead.org>

On Tue, Jan 23, 2024 at 02:15:22AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 22, 2024 at 11:31:29AM -0800, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 4.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> and here's the one for 4.19

Thanks, all now queued up.

greg k-h

