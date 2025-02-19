Return-Path: <stable+bounces-116972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6BA3B264
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E93C174E0D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A61C302E;
	Wed, 19 Feb 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1AN+uzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDF1C2432
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950193; cv=none; b=TYMyJhtaO10OqQLfCNGMx42sb2tdVN+BMa6rkA3+aelOCbwPYfeX+KWBFQL4nl9NVNBupAyuskhIZCguHmBUZ6DyZ2zAwJUtHQdGKMDxRdFZbr3Cgn95F3Yo4+xulp9y3x6nDziep7inhHrlolZzjdvYo8FbwxHGb1Twj1yt1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950193; c=relaxed/simple;
	bh=wh4Dlcafj9avvb9mNztg9k+EmgoPpHdOJNoxHMB5C+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhve8m9Rv24C+En6V5bPHI/YeVQzGnShw5L4+BUiQQ3t8UFhQTJWRtXOnH8WuEZ+IFCZnhcxggFsNRmWkh7H3FHljQGVTHrhrytMhE2+Mk9zGkM8neRIG50hX3hApc2vWBTwWpyeqCuNNlcv6gwp1ySGuRXmW5vkbKnKtD288EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1AN+uzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C47C4CED1;
	Wed, 19 Feb 2025 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739950193;
	bh=wh4Dlcafj9avvb9mNztg9k+EmgoPpHdOJNoxHMB5C+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1AN+uzzf+OOWZxLZ9PGtrmZHzJydcrX13g5Bcdhxbt6TgsDcSn5aRfk2piS/nsqo
	 rTqnmelO3TusvfFTaI47U0ku9dYeJrbEYMiSfZX9Z7fTM0A8Abwo+HoLnJHG+eBDAo
	 H9/sn+cUPfzKnZEenZYg2OAK2ELZgoGx6WJDy3RU=
Date: Wed, 19 Feb 2025 08:29:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: stable@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>,
	Christian Brauner <brauner@kernel.org>,
	Michael Forney <mforney@mforney.org>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 5.15.y] Revert "ext4: apply umask if ACL support is
 disabled"
Message-ID: <2025021904-emergency-woozy-1353@gregkh>
References: <171468877064.2998637.14217086529278734176.b4-ty@mit.edu>
 <20250210202801.2415267-1-jesper.nilsson@axis.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210202801.2415267-1-jesper.nilsson@axis.com>

On Mon, Feb 10, 2025 at 09:28:01PM +0100, Jesper Nilsson wrote:
> From: Max Kellermann <max.kellermann@ionos.com>
> 
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.
> 
> Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Tested-by: Michael Forney <mforney@mforney.org>
> Link: https://lore.kernel.org/r/20240315142956.2420360-1-max.kellermann@ionos.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> (cherry picked from commit c77194965dd0dcc26f9c1671d2e74e4eb1248af5)
> 
> ---
> This revert never reached linux-5.15.y, and caused the same regression
> with symbolic links. The original problem is just as the revert states
> fixed and the test program for O_TMPFILE works as expected.

This revert never hit any of the other stable kernels either, should it
go to all of them?

Also, you didn't sign off on this :(

thanks,

greg k-h

