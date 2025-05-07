Return-Path: <stable+bounces-142006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF98AADB68
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A49A46B1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFA2367C9;
	Wed,  7 May 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoOOBj7G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40C231848
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609625; cv=none; b=OINGsFVIjr9gpSm0C72FUmHRDOBRShstfeSO5sRePDmQPHmWXjvvW54ZdDPy0FTqwdjoJ6FP470aHRic60a5ccHSVE08tQAB3wXBZtkyP/g0J3nBLNqeFWJwY3FiNjVaL2+MHVCWXXVT4b9xGKM2O3Ln2Yk5QnBA0Ggf7oldvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609625; c=relaxed/simple;
	bh=cJC/+/Z0HpMIlrWyATRuxhSWRT8Ke96I/ZpMStWkPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbBAczYbXXvY09/DAakDkyBSyM3WH+AzOKOYjDmb390BrmJTc9QJ00FPdfXPbcZsClw6m4QMR1rM72gCCmC4Y1ydPhWoLnKklhBSeYKxooMSlCEvADXUYZL73si9HcqWkV2OAHLb24MiOUpWjFcX7P5SLKEeN391Ymh9Mpsa3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoOOBj7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C5C4CEE7;
	Wed,  7 May 2025 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746609624;
	bh=cJC/+/Z0HpMIlrWyATRuxhSWRT8Ke96I/ZpMStWkPaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoOOBj7GLP4g0+4IZSntG6aS8xCB8N8lhnvQIcfbgUzXxdf7cHj+/YkR+xFbiw1/C
	 KdaS8swFh4fRp6T05vKtTI/6Dhodhn23C7S8n3iLMBfLYYdR7O4w1qnsuV4QUWbxWF
	 Szes4ZJz5T73tr39ykBBV66HjlNwv/cWk9HY5QLc=
Date: Wed, 7 May 2025 11:20:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jared Holzman <jholzman@nvidia.com>
Cc: stable@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
	ushankar@purestorage.com
Subject: Re: [PATCH v1 0/7] ublk: Backport to 6.14-stable: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-ID: <2025050757-prong-ferry-95bb@gregkh>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>

On Wed, May 07, 2025 at 02:37:48AM +0300, Jared Holzman wrote:
> This patchset backports a series of ublk fixes from upstream to 6.14-stable.
> 
> Patch 7 fixes the race that can cause kernel panic when ublk server daemon is exiting.
> 
> It depends on patches 1-6 which simplifies & improves IO canceling when ublk server daemon
> is exiting as described here:
> 
> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
> 
> Ming Lei (5):
>   ublk: add helper of ublk_need_map_io()
>   ublk: move device reset into ublk_ch_release()
>   ublk: remove __ublk_quiesce_dev()
>   ublk: simplify aborting ublk request
>   ublk: fix race between io_uring_cmd_complete_in_task and
>     ublk_cancel_cmd
> 
> Uday Shankar (2):
>   ublk: properly serialize all FETCH_REQs
>   ublk: improve detection and handling of ublk server exit
> 
>  drivers/block/ublk_drv.c | 550 +++++++++++++++++++++------------------
>  1 file changed, 291 insertions(+), 259 deletions(-)

As was pointed out, you seem to have lost the upstream git commit id in
all of these :(

Please fix up and send a v2 series.

thanks,

greg k-hj

