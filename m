Return-Path: <stable+bounces-25849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AB86FB59
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150C21F22B08
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFB168D0;
	Mon,  4 Mar 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpN0P1Py"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949A134D1;
	Mon,  4 Mar 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539872; cv=none; b=J7lJpnKx5Zopvks/Nao6R1z6WYwticFb6Ur/B+nAScbaeLF/PsL20KGmjPVkuX260VijAehXmu2K+1vSwqAGwCV/ZxDjutY6MrcUcJpg0TMBVWtuWZNs5iIJoKwNjufy8tGDletr/t2vwsHOTg0dPt74bdVV26WnOOaAnTVI1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539872; c=relaxed/simple;
	bh=txYIOabwZjydyVsXUDKvS3A2ZAVFm/PtH9SCcipuSXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFmKCMlByd3/B2T2VnFoebA3YDs7pNUIHC4O1cy3/NAM81jTdJW9zHcmHF1yOm4xaRr43acusFaJhGgYgm0zABWGY8XLxu56xsBgXHekpQiw66hbQcUfWr9ERNFr8LoqaUzHb9nc4cPZDPLgCLwB3/wUlfB5UKdfiMNTYDVpfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpN0P1Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82213C433F1;
	Mon,  4 Mar 2024 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709539872;
	bh=txYIOabwZjydyVsXUDKvS3A2ZAVFm/PtH9SCcipuSXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpN0P1Pybz/qORAol1orNMwKiJH83nxGgFQAJv5/wsnQs/rEyJ8lO74YYzq3A+0s8
	 RKnSjCCcxPjUDn0slU9rPoLVQmQhqQgwY/8E4shZsqLvLud8e3Po+G5GYqnNuEH68v
	 6Bi5fcNoNEiOxaTDMU3nIcbrEeIg/6dLKnlZU/PQ=
Date: Mon, 4 Mar 2024 09:11:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH 6.1.y] mptcp: continue marking the first subflow as
 UNCONNECTED
Message-ID: <2024030459-value-disburse-1bc8@gregkh>
References: <20240228172121.243458-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228172121.243458-2-matttbe@kernel.org>

On Wed, Feb 28, 2024 at 06:21:21PM +0100, Matthieu Baerts (NGI0) wrote:
> After the 'Fixes' commit mentioned below, which is a partial backport,
> the MPTCP worker was no longer marking the first subflow as "UNCONNECTED"
> when the socket was transitioning to TCP_CLOSE state.
> 
> As a result, in v6.1, it was no longer possible to reconnect to the just
> disconnected socket. Continue to do that like before, only for the first
> subflow.
> 
> A few refactoring have been done around the 'msk->subflow' in later
> versions, and it looks like this is not needed to do that there, but
> still needed in v6.1. Without that, the 'disconnect' tests from the
> mptcp_connect.sh selftest fail: they repeat the transfer 3 times by
> reconnecting to the server each time.
> 
> Fixes: 7857e35ef10e ("mptcp: get rid of msk->subflow")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - This is specific to the 6.1 version having the partial backport.

All 6.1 backports now queued up, thanks!

greg k-h

