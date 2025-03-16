Return-Path: <stable+bounces-124510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73127A63431
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5E3AF0D8
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D98F16A395;
	Sun, 16 Mar 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLfpdPRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25B86348
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742104884; cv=none; b=m8IXOKHxChU5g28BOddKtxecJ8I/UKQuQ5hsfIeeiWrpPCID7kqim/mdXNt+yIE0DuPXpxRWLLgzpFmU9/02Q/Qeg9wcOZhUwBAyAnN/uTzJpr48BHqcZwtX/9QhsnTWD8331xIl29aLSeuFsbEM5rPQKsSPpXylE9XJ6VlQ1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742104884; c=relaxed/simple;
	bh=MQN8+LvreS0VmNSOADcZRkzmFSSSXtdJ71hbRqncFl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3jtgOfqi0EcME8Hl9vqRLLRpPaj75Nj+Kau2vBLUffP27CWsiyHhQVexxI55lVJ0OFrYRaffZviqAWNh6ErLwvtG57f67zUsm/glciNZlnMSPL3y1pbz5AN2ePaHwD+ckrQJd9xF5ue38WyNydvDrGAQJTn2RSewPk2Tofsm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLfpdPRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE70C4CEDD;
	Sun, 16 Mar 2025 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742104883;
	bh=MQN8+LvreS0VmNSOADcZRkzmFSSSXtdJ71hbRqncFl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLfpdPRgvsEYU1I9HvMOUAqy1sp7KSwlmBUYSmDaU6GmAA7jmX6kzUoCNh4YDpyhV
	 JhvdpOCPzLFcGsU7w5W03vP18rQpooaR3TMrmS+5n4JvHb7dr7RP8kRViLTshW6tsc
	 0wgU0ZbbxJE2Hmw/VtVodVj0kmfcFXqPbVwM2ii4=
Date: Sun, 16 Mar 2025 07:01:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.1 io_uring mmap backport
Message-ID: <2025031600-unexposed-flyaway-eba4@gregkh>
References: <9a29cdcc-c470-400a-a98c-8262a5210763@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a29cdcc-c470-400a-a98c-8262a5210763@kernel.dk>

On Sat, Mar 15, 2025 at 06:59:55AM -0600, Jens Axboe wrote:
> Hi,
> 
> I prepared this series about 6 months ago, but never got around to
> sending it in. In mainline, we got rid of remap_pfn_range() on the
> io_uring side, and this just backports it to 6.1-stable as well.
> This eliminates issues with fragmented memory, and hence it'd
> be nice to have it in 6.1 stable as well.

This and the 6.6 set now queued up, thanks.

greg k-h

