Return-Path: <stable+bounces-59409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FD932721
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96191F23CD2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D319AA7B;
	Tue, 16 Jul 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCNClZF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEE13D8A0
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135316; cv=none; b=murYuCBb8iJ0nqW+wI3zmJMqPcfHVip7qfbFzClF20IYUWtgdV24P4h/X5RMTUeqTcBlGxWmWwZYHSw1OAZf5Hg9d+9sEdP3sYuzLGZEkO8wmpDuaDfffiW7Fm+slcJJxiQmZ8s29lz0pJLELiPve5rd8I+eUoi5TlrUKk1s0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135316; c=relaxed/simple;
	bh=mdZKTuRQ5niA/K7B/Mekk+SN4pW4t+hBGeayDahQP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d52hQBMaLn+O6cJoaVAxCxOVB9Z/J5pfTj7ahwRAwO6ZALFc2Uu9qwHYwKY9NxuUamNLD0ttuxMGETwKfli9W3hJKvbOduPlhB03rgoE6w//HcURgF2zvbpcBa+sx+sJUxRJJdtZhvBnTH35WMeomzgPbZox2Vk4dD4PrsRMLRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCNClZF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5C0C116B1;
	Tue, 16 Jul 2024 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721135315;
	bh=mdZKTuRQ5niA/K7B/Mekk+SN4pW4t+hBGeayDahQP8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCNClZF3Qa55NVn1/MIAmF0T3X34VgqwRBTZCoKnNpR1hrgg227VKlZrHP3nqpged
	 0ljjj7ruOeY3WUcvxSYZvpxfdmvBGMuFP4ahiBlKmjlUyVdRpusthpUSvFNzib5jAL
	 fRf0aN4H3UDNobb8bACiTHLwB2ltJJBcPPeNPVio=
Date: Tue, 16 Jul 2024 15:08:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, felix <fuzhen5@huawei.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 4.14] SUNRPC: Fix RPC client cleaned up the freed pipefs
 dentries
Message-ID: <2024071616-unsliced-tactics-fb0b@gregkh>
References: <20240715131257.22428-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715131257.22428-1-hagarhem@amazon.com>

On Mon, Jul 15, 2024 at 01:12:57PM +0000, Hagar Hemdan wrote:
> From: felix <fuzhen5@huawei.com>
> 
> [ Upstream commit bfca5fb4e97c46503ddfc582335917b0cc228264 ]

You mean 4.19, not 4.14, right?  4.14 is long-end-of-life.

thanks,

greg k-h

