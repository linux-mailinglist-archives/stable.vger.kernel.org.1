Return-Path: <stable+bounces-73910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B79707A3
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041B92823F6
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2115B117;
	Sun,  8 Sep 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vG5WXbg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D41E522
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800071; cv=none; b=Ek0MLDYu/o41a+t+yuRGeaSxZPK5mYoNXlmZO0LlRsOF2sBYuEZMkmO1swnRFSPjiVvD5jfNpI70TqcfOeAWzmzvJL/hWxq0svGfqiaQ4wfThL/zxPIcTiAujA/V4lp3KyuEFmDJwhCRwprp4w9ejGpwyoYRtAPVFU3DFspHpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800071; c=relaxed/simple;
	bh=1TmyTHKLgAhRYkQHEqnzcW8x9hdMgRw3vWXHG4An3sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPBOSF4NDT0bk4isikzlJXo+Slqzg0n7l1yRFjKUPCIS/4I5G/vegydsuEEo7QLC34c1Yez6JZHRyvXuLkP/p7qRtszOTbEeo7LH8TDbUwYzStILCCwjFc5ezZdbB3yPlIBQjLsVBinmYsPr8w/mRBc6JDwE64o9OtmeoErDTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vG5WXbg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FBAC4CEC3;
	Sun,  8 Sep 2024 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800071;
	bh=1TmyTHKLgAhRYkQHEqnzcW8x9hdMgRw3vWXHG4An3sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG5WXbg7hUk455i9VGPqQFKvKyidUy2lwDjP5fB2KQA1Ie5pFVIQ7+XAZLLMgnqeL
	 KoPYyVGnl6lsNR+HJvcSrq9iYqY6/zDCdNietVwlo/5nF7HHbcZQxmgkMEu7vFKKcG
	 KniUCgcT5t2i/92Nb3+toh4Ypexq3BI367W80yPY=
Date: Sun, 8 Sep 2024 14:54:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.10.y] ALSA: hda/realtek: extend quirks for Clevo V5[46]0
Message-ID: <2024090818-maroon-thrift-f095@gregkh>
References: <2024090812-ample-stowaway-5c06@gregkh>
 <20240908113535.13963-1-marmarek@invisiblethingslab.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240908113535.13963-1-marmarek@invisiblethingslab.com>

On Sun, Sep 08, 2024 at 01:35:34PM +0200, Marek Marczykowski-Górecki wrote:
> The mic in those laptops suffers too high gain resulting in mostly (fan
> or else) noise being recorded. In addition to the existing fixup about
> mic detection, apply also limiting its boost. While at it, extend the
> quirk to also V5[46]0TNE models, which have the same issue.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20240903124939.6213-1-marmarek@invisiblethingslab.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit 562755501d44cfbbe82703a62cb41502bd067bd1)
> ---
>  sound/pci/hda/patch_realtek.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

