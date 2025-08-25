Return-Path: <stable+bounces-172798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF0B337F8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E6A1B21A96
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D357242D96;
	Mon, 25 Aug 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYTbt20q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CC4400
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107545; cv=none; b=Tw41FcCAdF5JkDz8L+stkLmsQbbg5v8IsH23KNhQ7l3rdf4PRwJTw2FUmbratono/fu2N/iet+MjCfZnzuKuTR5BZ6rN2Vww+nXYIURkoB/88egUljtHHRwFsctBWMZB24UCjBm+ysnjjFURWizztyV12bFHZFpBAIPw92d1c1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107545; c=relaxed/simple;
	bh=pmeVbwxJDSN4S4OTtGp7efPRf05nnuvx+h/GF4osyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUjOQFqsYEvgMPfuECxiqxxQOqklpNmLBJZEb5CrDkCiAQjd0pKEr75IDidiB+LWE/PLl6qrDrrR6LhaWJUoXMoHjZ7qiKtheWUqGjz0GjiCNK6DsAmHCW4Rx8lWrYYMNunup3EUFQrXraEIc75MIuK00+uZ/nrx+zpJWqj68Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYTbt20q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACF8C4CEED;
	Mon, 25 Aug 2025 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756107544;
	bh=pmeVbwxJDSN4S4OTtGp7efPRf05nnuvx+h/GF4osyJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYTbt20qaFMLGxTqLH5n9LwF5fKb9cVue6Wk1jagJSnYXKcBf2jmucUnU4h7LAZgp
	 bJLy5wpGjUWIG74NPPALfp7D7CPOfhOYyvYN0L6hlEBp+8LeWfGKTffthA0N28Ivzm
	 T7NqN7hY+tEIm45Zn40cljkTFvcFd2WU6v7SLk5I=
Date: Mon, 25 Aug 2025 09:39:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-stable <stable@vger.kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after
 link up
Message-ID: <2025082533-altitude-reapprove-3061@gregkh>
References: <29e310e4-4ef9-40bf-9570-7b72e0369ce4@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e310e4-4ef9-40bf-9570-7b72e0369ce4@mailbox.org>

On Wed, Aug 20, 2025 at 12:39:05AM +0200, Marek Vasut wrote:
> Please backport the following commit into Linux v5.4 and newer stable
> releases:
> 
> 80dc18a0cba8dea42614f021b20a04354b213d86
> 
> The backport will likely depend on macro rename commit:
> 
> 817f989700fddefa56e5e443e7d138018ca6709d
> 
> This part of commit description clarifies why this is a fix:
> 
> "
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> "
> 
> In practice, this makes detection of PCIe Gen3 and Gen4 SSDs reliable on
> Renesas R-Car V4H SoC. Without this commit, the SSDs sporadically do not
> get detected, or sometimes they link up in Gen1 mode.
> 
> This fixes commit
> 
> 886bc5ceb5cc ("PCI: designware: Add generic dw_pcie_wait_for_link()")
> 
> which is in v4.5-rc1-4-g886bc5ceb5cc3 , so I think this fix should be
> backported to all currently maintained stable releases, i.e. v5.4+ .

Can you send backported and tested patches for these kernels so that we
know they work properly?

thanks,

gre gk-h

