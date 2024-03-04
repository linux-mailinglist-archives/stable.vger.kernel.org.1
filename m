Return-Path: <stable+bounces-25862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A686FD21
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809F41F25D26
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6931C2AE;
	Mon,  4 Mar 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkCEXbhb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB218EC3
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544113; cv=none; b=ZeJPZfT647aQTAWxBwql35Hur4AMwfwK5p9f/6pkl5J3l2hzy8BL+nRdLwH9I2oxWDdLvciI/LkxsFLnAtqMCiQogE9Jih6nZ+Lf1CFVnfTkntuKe6/a2e5JK/wgM/kYg3sfQwMQH9YkpGHZznVBlbJIDvyWBNF979WnZVGIXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544113; c=relaxed/simple;
	bh=aM9NdYKoi6BbOxZv3sOz3qYT7UKQieScFRdxxpNAYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGkyc+9YTbBnbhptjAH2ZBBXkL51N+CleYAAnG5BhUPbM1h9HFRPIXWUK3596N/plmdvOIbSb+3XdKBEzNwCLKC38gW1YRQdU36wyCe9VmLzjQ95xDihd10kGtdz2W/LAj0XErC2YTcL4uxuVwJmkKAO95NQdcazq923a0otCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkCEXbhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6EFC433C7;
	Mon,  4 Mar 2024 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709544112;
	bh=aM9NdYKoi6BbOxZv3sOz3qYT7UKQieScFRdxxpNAYVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkCEXbhbk0T2ndSH0gCmDeEeixu8ckAinbrJ1i9qJNqhR0cr/NNCbPBHPsgfEl/DJ
	 UOmljDoXWRn0GIlukMbhe6AsH/L0eWt+k7Hv4ZQxOHiDABRNSaYskr4lUkHtmjbPHK
	 E2i48ZoFWGiYU6zc7r29aKQM3YfCJapEFxUG7o+w=
Date: Mon, 4 Mar 2024 10:21:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	martineau@kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: push at DSS boundaries" failed to
 apply to 5.4-stable tree
Message-ID: <2024030431-dragging-quack-7f57@gregkh>
References: <2024030448-walrus-tribunal-7b38@gregkh>
 <2cf7b693-af2f-42d5-b0a0-fba19e840fa6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf7b693-af2f-42d5-b0a0-fba19e840fa6@kernel.org>

On Mon, Mar 04, 2024 at 10:00:01AM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 04/03/2024 09:28, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.4-stable tree.
> 
> (...)
> 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From b9cd26f640a308ea314ad23532de9a8592cd09d2 Mon Sep 17 00:00:00 2001
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Fri, 23 Feb 2024 17:14:14 +0100
> > Subject: [PATCH] mptcp: push at DSS boundaries
> > 
> > when inserting not contiguous data in the subflow write queue,
> > the protocol creates a new skb and prevent the TCP stack from
> > merging it later with already queued skbs by setting the EOR marker.
> > 
> > Still no push flag is explicitly set at the end of previous GSO
> > packet, making the aggregation on the receiver side sub-optimal -
> > and packetdrill self-tests less predictable.
> > 
> > Explicitly mark the end of not contiguous DSS with the push flag.
> > 
> > Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
> 
> I guess this patch has been selected for v5.4 by accident because MPTCP
> has been introduced in v5.6. In other words, we don't need this patch
> for v5.4 :)

Oops, I read "5.6" as "5.4", my coffee hadn't kicked in yet, sorry.

greg k-h

