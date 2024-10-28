Return-Path: <stable+bounces-88266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB79B2425
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE517B2157A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82318CBF5;
	Mon, 28 Oct 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/9c/UgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4118CBE9;
	Mon, 28 Oct 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093177; cv=none; b=CDcH5mT4akIcWgwHei9481PmoL8o+PT9fdFgcFVytntiEc5mdYbWhc6YAFnPdWkzNTk4Nq0XswfCZNMTmAHHqDVYCPEaquPQbjP0tfPJnlREPPu9ccSgX7VUVdqii9q0h7XqkZb9xb/G2Pm8ot2mBcHzqda3Oxg8kgEkfyjs5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093177; c=relaxed/simple;
	bh=nA6pfjfAB2+RV2rRgDmuKuNqtYi6ymb+L+byNKDyasM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyx3joiGFTxxpVkagw81WIj1J0IKNQ5zNA3mGkBsRelsUnQ7DBBB16+6qvkHDYfbyWoGGJJsQpSWv6DG+6U3iu2/IkBa8OnuaGs0DW9r1iCvRasjNqvDQtMBE2r5R0qVIlf7caIXT2Fn7ZdSFqYO3PA0eYZem448WK6HnwWKW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/9c/UgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A57C4CEC3;
	Mon, 28 Oct 2024 05:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730093176;
	bh=nA6pfjfAB2+RV2rRgDmuKuNqtYi6ymb+L+byNKDyasM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/9c/UgWO5g2BQ3KsZ22B6waQrSOAPEMYuGE27n+EiQYYnD0mmbs/yFMUojHCOJja
	 U9fCKb2HAYbkuo7NbGTmfq25HMOtK9oCwYY8kpsmq3cL7pkXXc961FC4/YsI2CO50m
	 DqAS49eobpen5tuRkLYJpRBj5B+VT/5+dBFLf9Os=
Date: Mon, 28 Oct 2024 06:26:04 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Seiya Wang =?utf-8?B?KOeOi+i/uuWQmyk=?= <seiya.wang@mediatek.com>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Message-ID: <2024102855-untitled-unfixed-2b9d@gregkh>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
 <2024102406-shore-refurbish-767a@gregkh>
 <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>
 <2024102411-handgrip-repayment-f149@gregkh>
 <ddc5f179dfa8445e2b25ae0c6e382550d45bbbd3.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc5f179dfa8445e2b25ae0c6e382550d45bbbd3.camel@mediatek.com>

On Mon, Oct 28, 2024 at 02:38:49AM +0000, Jason-JH Lin (林睿祥) wrote:
> On Thu, 2024-10-24 at 12:23 +0200, gregkh@linuxfoundation.org wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Oct 24, 2024 at 10:16:05AM +0000, Jason-JH Lin (林睿祥) wrote:
> > > Hi Greg,
> > > 
> > > Thanks for your information.
> > > 
> > > On Thu, 2024-10-24 at 11:47 +0200, Greg KH wrote:
> > > >   
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  On Thu, Oct 24, 2024 at 05:37:13PM +0800, Jason-JH.Lin via B4
> > Relay
> > > > wrote:
> > > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > > > 
> > > > > This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
> > > > > 
> > > > > Reason for revert:
> > > > > 1. The commit [1] does not land on linux-5.15, so this patch
> > does
> > > > not
> > > > > fix anything.
> > > > > 
> > > > > 2. Since the fw_device improvements series [2] does not land on
> > > > > linux-5.15, using device_set_fwnode() causes the panel to flash
> > > > during
> > > > > bootup.
> > > > > 
> > > > > Incorrect link management may lead to incorrect device
> > > > initialization,
> > > > > affecting firmware node links and consumer relationships.
> > > > > The fwnode setting of panel to the DSI device would cause a DSI
> > > > > initialization error without series[2], so this patch was
> > reverted
> > > > to
> > > > > avoid using the incomplete fw_devlink functionality.
> > > > > 
> > > > > [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > > > detection more robust")
> > > > > [2] Link: 
> > > > 
> > https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com
> > > > > 
> > > 
> > > Please don't mind me make a confirmation.
> > > I just need to add this line here and send it again, right?
> > > 
> > > Cc: <stable@vger.kernel.org> #5.15.169
> > 
> > Yes.
> 
> Hi Greg,
> 
> Thanks for your confirmation!
> 
> I've sent the patch again without adding `v2` after the [PATCH]:
> https://lore.kernel.org/all/20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com
> Would that be fine with you?

But it is a v2 patch, why not mark it as such?

