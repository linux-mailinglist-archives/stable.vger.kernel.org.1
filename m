Return-Path: <stable+bounces-78341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EEC98B6DA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694101C220F7
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3219C54A;
	Tue,  1 Oct 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qu/R/5Op"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70EF19C540;
	Tue,  1 Oct 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771075; cv=none; b=DNcsCdrxy/85eiHW/KFuEdX+IMs7bRM9UuuP6G+zAPPz7HxaJ0inNwI2qZCWtP4bf11EamBS6nD2u/RkFUzhka7MBywqvjwhnkzOpJE9ngrekSBpjOY7G/S9R85mfSPKStiImTHQ+vy77O+xwQjJeu/pkA+FUoihf0WyczrmPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771075; c=relaxed/simple;
	bh=5hAeaPKcDegyrqgozqG09S+iO9i/22jpWZKfzn0l0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnyDLAxuF2yzLudX8oRPKHo86FClEhCoqHxx0mYkH2d1FEuQY5eChgG58N8/peJo/2k5fCnQK9pVdFa623HC3XyTRxhKNVn3zlvoruYRFDzaV1ibYpY9gWi7kOJCqh/fdV3H5Tv7nEsdgBZmd3mv5TupMrD58HlKfRYmQSe6tRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qu/R/5Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4CC4CEC6;
	Tue,  1 Oct 2024 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727771075;
	bh=5hAeaPKcDegyrqgozqG09S+iO9i/22jpWZKfzn0l0p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu/R/5Opdcm542Ywht8v2bL7SPKd+S1L0vp+qAVWdcTFj9fGcJKCp4zJoKw5B74E+
	 umrs+9AuW9MocmUlycgRy9HSbRLaHo6mgqZzKEKj0gBWRvHxmVx1vn78sFJuXIjert
	 S7nAgbA3Hx1sq4wKQs7LBfNgh7n5WMXK8pth+UGE=
Date: Tue, 1 Oct 2024 10:24:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Subject: Re: Patch "usb: dwc2: Skip clock gating on Broadcom SoCs" has been
 added to the 6.11-stable tree
Message-ID: <2024100118-setup-douche-b883@gregkh>
References: <20240930232610.2570738-1-sashal@kernel.org>
 <17c9e4c6-260a-40c9-be1f-4f67ec6d5e3b@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c9e4c6-260a-40c9-be1f-4f67ec6d5e3b@gmx.net>

On Tue, Oct 01, 2024 at 07:23:16AM +0200, Stefan Wahren wrote:
> Hi Sasha,
> 
> Am 01.10.24 um 01:26 schrieb Sasha Levin:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      usb: dwc2: Skip clock gating on Broadcom SoCs
> > 
> > to the 6.11-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       usb-dwc2-skip-clock-gating-on-broadcom-socs.patch
> > and it can be found in the queue-6.11 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> please do not apply this patch to any stable branch yet. Recently i
> discovered a critical issue [1] which is revealed by this change. This
> needs to be investigated and fixed before this patch can be applied.

Now dropped from all stable trees, thanks.

greg k-h

