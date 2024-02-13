Return-Path: <stable+bounces-19727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1EA853303
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20728275A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21D58103;
	Tue, 13 Feb 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kg95dkCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7459154
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834187; cv=none; b=D6knoP8MoZtcM28wwumv9BKvRFBap7+6bd+YAKxeDRhrNdTtHeQpzszfX4grUYdHVKrqrx+gELxuM0d1vUe9akJdl7/OFmk3pvndXFhlGrUjCgPQ/eWQtDkWmL/vNDEk6QmmciYUN/0JIGuuZ7WxRTOZLKA1YIB5ilHmqRAu6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834187; c=relaxed/simple;
	bh=B3RpHplTLidwSHM1uRDhtEdX+lt+KuAUcLc6eiKX9oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoq3RPqh2Ae2HsrcCP8epcmZOflu5TfBD3GI6wZBbhHSANkiprmVn6rFTMP/+cA6c5czHgscsq5GlfcdUZjb1ifujFfnaDz3TpLLMx4q2L26ce46LF0QrJAdbJqsWuWZP1tb4iVS0IILdbA5vtbDYFwb1RykE5np59BXgfFNgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kg95dkCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A287C433F1;
	Tue, 13 Feb 2024 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707834186;
	bh=B3RpHplTLidwSHM1uRDhtEdX+lt+KuAUcLc6eiKX9oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kg95dkCTGF6wg0iqZDZsYMkq9NWj0b/J4lir707m73ul3MtVRQxJ0bgg4g1oIb5oq
	 8DXvadDz/yWdwFJzWRgh/EOCsPVrgdqx1lJhJV8E/Od5f3roI86+0wlGB1BWCvTNuZ
	 cdnLUzEf/AphKqVcRgbMbMlTTJrnEe6ZbX/piPYI=
Date: Tue, 13 Feb 2024 15:23:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: johan+linaro@kernel.org, bhelgaas@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] PCI/ASPM: Fix deadlock when enabling
 ASPM" failed to apply to 6.6-stable tree
Message-ID: <2024021339-spearmint-dumpster-4202@gregkh>
References: <2024021328-stylus-ooze-f752@gregkh>
 <Zct55VEPNGX2ThvT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zct55VEPNGX2ThvT@hovoldconsulting.com>

On Tue, Feb 13, 2024 at 03:17:09PM +0100, Johan Hovold wrote:
> On Tue, Feb 13, 2024 at 02:25:29PM +0100, Greg Kroah-Hartman wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1e560864159d002b453da42bd2c13a1805515a20
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021328-stylus-ooze-f752@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 1e560864159d ("PCI/ASPM: Fix deadlock when enabling ASPM")
> > ac865f00af29 ("Merge tag 'pci-v6.7-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci")
> 
> It's probably not worth trying to backport this one further back than
> 6.7 which had the commit that introduced the issue.
> 
> If the offending commit itself is being backported then that may
> possibly affect some Intel devices, but this fix would not be needed for
> Qualcomm platforms before 6.7 at least.

The offending commit was backported further, but if no one asks for
this, I think it should be fine, thanks.

greg k-h

