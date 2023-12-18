Return-Path: <stable+bounces-6984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA553816BB9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1BE1F235CC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB4182AE;
	Mon, 18 Dec 2023 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2EPVIYeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8683199A5
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3E4C433C8;
	Mon, 18 Dec 2023 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702897170;
	bh=MyeuODBoyfla5GwGWsQUFBoRELvv4fA9KXJIaDrKDBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2EPVIYeXgPAspftjHpqr47q9NTBkZGqodaH45lR69SxWuqUz8z8K6Q34Gnz6Cmo5i
	 itunasJ8OLovRPU5FAeRUPylD0PprZEcExxWdENz7llxPsCW8pknE0mW+IgpmUoS3U
	 +UcimzB9pgsDtA7lhPYNLjLpzS9pIzCtiY6B1baU=
Date: Mon, 18 Dec 2023 11:59:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4] mmc: block: Be sure to wait while busy in CQE error
 recovery
Message-ID: <2023121819-humming-emphasis-62cd@gregkh>
References: <2023120314-freeware-thesis-5dd5@gregkh>
 <20231211183345.275334-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211183345.275334-1-adrian.hunter@intel.com>

On Mon, Dec 11, 2023 at 08:33:45PM +0200, Adrian Hunter wrote:
> commit c616696a902987352426fdaeec1b0b3240949e6b upstream.
> 
> STOP command does not guarantee to wait while busy, but subsequent command
> MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
> be sure to wait by employing mmc_poll_for_busy().
> 
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://lore.kernel.org/r/20231103084720.6886-4-adrian.hunter@intel.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c    | 2 ++
>  drivers/mmc/core/mmc_ops.c | 5 +++--
>  drivers/mmc/core/mmc_ops.h | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)

Both now queued up, thanks.

greg k-h

