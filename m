Return-Path: <stable+bounces-121725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F5A59AB1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C88A3A75D8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859A22F166;
	Mon, 10 Mar 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPkBWTc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B3221F26
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623164; cv=none; b=e7G47j/hu/xaliRZWegPV6pa6Hi2bGH6pjlasj+bA9vvc/0rXl/ofQwRW+fC484+FZtkq2qN/sczp4t12hqCjgM/PeTuBZR4TjiwkgLVSFUrsW1cosadrb5p5JmDY0u8V9gZWSY8yVDyjapl0xyGG0RsbL9smlii8zGV0jzXL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623164; c=relaxed/simple;
	bh=7B7ohr+ad8GB34hLnAWsK2L95/vPrdiDfYHzkPLsLPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nli1XETEAfmbZ1pIZLPrK4eiZpPfmrGlPqUDrDAtBdyZksUwLCvGW29iuk/XYJj06CU3jTY62Oz2RkxyEkhCRB++6mdCSSS6eT8rdToBCGvAGAiQbXM0AmVjqFPS1YXWVO8IA5OtGcgNcFBxGxzvaPmZY67gRTtso9MGRWgDfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPkBWTc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF44C4CEE5;
	Mon, 10 Mar 2025 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741623163;
	bh=7B7ohr+ad8GB34hLnAWsK2L95/vPrdiDfYHzkPLsLPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPkBWTc5Xp4RwXvGd56WV9FdaNOhOftXO+zketyPQlFJzoK/+lWNQpaB6dl+4mECU
	 lgG1wkrOrGgeQJ6witXV8w62IUw3C9BiZgwP5KklVhZsjXQw+QQSMuNQdL6twKGapG
	 JINCeILNfE1vBLyj64ZF+1jIRPGEI19Xg5j8k2XM=
Date: Mon, 10 Mar 2025 17:12:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Sasha Levin <sashal@kernel.org>, Ralf Schlatterbeck <rsc@runtux.com>,
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [5.4/5.10/5.15/6.1/6.6] spi-mxs: Fix chipselect glitch
Message-ID: <2025031033-pantry-schedule-e9d9@gregkh>
References: <a83d17ac-1d17-4859-b567-fe2abc8638ab@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83d17ac-1d17-4859-b567-fe2abc8638ab@gmx.net>

On Wed, Mar 05, 2025 at 11:25:01PM +0100, Stefan Wahren wrote:
> Dear stable team,
> 
> I noticed that ceeeb99cd821 ("dmaengine: mxs: rename custom flag") got backported, but the additional fix 269e31aecdd0 ("spi-mxs: Fix chipselect glitch") hasn't.
> I think was caused by the lack of Cc to stable. Without the latter patch the SPI is causing glitches on MXS platform.
> 
> Please backport it from 5.4 to 6.6.

Now queued up,thanks.

greg k-h

