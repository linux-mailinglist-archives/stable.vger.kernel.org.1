Return-Path: <stable+bounces-3632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD02800ACD
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD421C20CCB
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516124B58;
	Fri,  1 Dec 2023 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDpsz72t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7142136C;
	Fri,  1 Dec 2023 12:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B293DC433C7;
	Fri,  1 Dec 2023 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701433380;
	bh=h06/4p1GZzaajczTIM5HZpG3PzVjvySvL9yjyPOr2No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDpsz72tyQHBZLXGkq3eKdNAOh3JKY370uKvEIiI97rNlCWa1YvUVyHIXgZUfJSJu
	 R6TvgsEW9a+lDZRm1+GvG0h9mm+MvB7bbs1jFTj6/Kov1Rs5aVPddZulGfRnmXDDIj
	 Y9+dXvYDmwyjGKqxO5Ob4wD/S3+SiZfZONOAJnC4=
Date: Fri, 1 Dec 2023 12:22:57 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org,
	adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <2023120139-untried-unholy-456e@gregkh>
References: <20231201100527.1034292-1-jorge@foundries.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201100527.1034292-1-jorge@foundries.io>

On Fri, Dec 01, 2023 at 11:05:27AM +0100, Jorge Ramirez-Ortiz wrote:
> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
> 
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
> 
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
> 
> This commit fixes that regression.
> 
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Cc: <stable@vger.kernel.org> # v6.0+

Why only 6.0 when the "Fixes:" tag goes back to a 4.14 commit?

thanks,

greg k-h

