Return-Path: <stable+bounces-83812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288A99CBC8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466041F22F21
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB51AA78D;
	Mon, 14 Oct 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9WDJyb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E019E802
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913500; cv=none; b=G4SgncBLzSPy2oL20Gr1aZ3D2P9Oh44zzqPSW3Ne0JopOKbCsrEE7EBznGnsJTBmJQrZ9UoNKhKQDHhEikFsk5H+2WZBNJ0fcJLgQsl6Fw3Dryfn1mXTud6hfXdBUOIjMrzhPIrq9BqsdjMMBBc2164YGhhVwt2b1GihFf6MnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913500; c=relaxed/simple;
	bh=U8Ov9T4OmzxogLErkC0vq65DO7DqWh/kkhNQeFMzbRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgorGMjGL0835MvlQLe5+prCRzYy0ifb5d7FavujGplTD4O+KYFlsVptAPK4mmI2GUDlRSlQ+zH+cQTAv59F5fhSFc18UArYaEU4DXshXKZzhz8hvIPJQO1GNIH0ovTXe7pTYEuIyiVP4gyEZXrW35X4fGGxExcxFABjkfv3hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9WDJyb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBECC4CEC3;
	Mon, 14 Oct 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728913499;
	bh=U8Ov9T4OmzxogLErkC0vq65DO7DqWh/kkhNQeFMzbRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9WDJyb1NNmHtT21wOlrzfA++RH/v8VzUJM+q/J8HIUmIZ1nEc6XXd6wk12UgEDjx
	 tdfk+l7sDbSYOkGWExRgUIVZ1GrEFVS+Fmn9GFHGduuuE7CSOvHLdbl1z4yvuwMCks
	 H/JoX9VY0+xum8Dd7U168tlAfpkjq9AyjMIAy6oo=
Date: Mon, 14 Oct 2024 15:44:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix cflags posting for
 single issue multishot" failed to apply to 6.11-stable tree
Message-ID: <2024101450-flaxseed-shorter-2907@gregkh>
References: <2024101436-avalanche-approach-5c90@gregkh>
 <d2971cde-895e-4161-bed2-5661217050b7@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2971cde-895e-4161-bed2-5661217050b7@kernel.dk>

On Mon, Oct 14, 2024 at 07:33:12AM -0600, Jens Axboe wrote:
> On 10/14/24 5:48 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.11-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x c9d952b9103b600ddafc5d1c0e2f2dbd30f0b805
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101436-avalanche-approach-5c90@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..
> 
> Here's the tested backport of that patch.

Thanks, now queued up.

greg k-h

