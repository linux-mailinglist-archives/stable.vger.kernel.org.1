Return-Path: <stable+bounces-43614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8288C3FDF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E51F2226C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA314C59D;
	Mon, 13 May 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IETCUzfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EED14C584;
	Mon, 13 May 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600082; cv=none; b=jOJF1+toX03+c/8iu8cOFrBV3b17s+gqov7/8XrzfXd6zZuiBmPZVYtI/xN8mxAPTUCP8rKdYHrsUBxrBLvbWm89+vRMelu5BnMsuRMs0qP+uok27sN2rafVNx3Yz4FziTH2VNEcTObfd0CEBF+iawrNkazxOlWFbaV1QpTxpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600082; c=relaxed/simple;
	bh=DHrYNEdecnDABIWBGsNAh2z8ehBvEPKHa9+Et/dWf5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtprNtP0bbLNzuLWzT0w1iZ7t6VtIP5lKaaBMsfK/Qh43PBwbYEYHYvD3fW8xHpLrFU5mkKF70Hycmj3FTByHq96wUaXgcv5fbWQdwZpomet1ZYVmxeHR5KHbTSICfpX+0J5U/Dqfmy84engzNAqVrXnvWEHZ01zTF6JhKLryNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IETCUzfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F14C113CC;
	Mon, 13 May 2024 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715600081;
	bh=DHrYNEdecnDABIWBGsNAh2z8ehBvEPKHa9+Et/dWf5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IETCUzfBfh2ifeQqTF3TmWB4YBFCM0L2SxDwnaXK1C4pFtGfA4X+sqjckvObBbTiq
	 VtAu++J7+Sp6m7RhZ+rFjFxB1xV0uH91jVK6c8gxuQfwingNszxjGLAj8jEREp26kc
	 GXs7GUqopCaSlj5lLtCzXfZhP4rV05iC4ezxezY0=
Date: Mon, 13 May 2024 13:34:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	johan+linaro@kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: qca: fix invalid device address check" has
 been added to the 6.8-stable tree
Message-ID: <2024051328-mama-hanky-a754@gregkh>
References: <20240503163852.5938-1-sashal@kernel.org>
 <ZjUVBBVk_WHUUMli@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUVBBVk_WHUUMli@hovoldconsulting.com>

On Fri, May 03, 2024 at 06:47:00PM +0200, Johan Hovold wrote:
> Hi Sasha,
> 
> On Fri, May 03, 2024 at 12:38:51PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Bluetooth: qca: fix invalid device address check
> > 
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      bluetooth-qca-fix-invalid-device-address-check.patch
> > and it can be found in the queue-6.8 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this one temporarily from all stable queues as it needs to
> be backported together with some follow-up fixes that are on their way
> into mainline.

Dropped from all queues now, thanks.

greg k-h

