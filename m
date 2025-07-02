Return-Path: <stable+bounces-159251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932AEAF5B27
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7684B3B9D0E
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB45F307492;
	Wed,  2 Jul 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dlKLYjRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C7306DD4
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466684; cv=none; b=pmIUrWGDCBRDzzneMlBp0KqiGbPrd4SWc8O84s4oGGQAe/zGAeE4wpB4heCzGr3UTnG1p4lmlm8HFC1kNxdJ1m0fWQJdCliFOaCp7VeHd/bpAoCzf/onAmQbHSdkzanPabUkT6pPPicm+73AwfnfR/byWqSrdnE/jWM+4Mrb+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466684; c=relaxed/simple;
	bh=GjAKfB8ZkevNmwYxs/UFrL+xjM9OYeOoYT31302DVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdLwnhsMl+KggBQDoQhKBdou1xn0egEO+5ZYWg63BCwFko0Jd83CwwEi9vq9nw5TD3IWFRhTB2ZU7xcImuWqXZhc0SPJYqKoKl/C1xy9zd6q74AaM8oR/FSL23qh3gEeVTANhsDV3jMEosN5VJ90F/GQwRcL5HPaLXucZyRHIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dlKLYjRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83150C4CEE7;
	Wed,  2 Jul 2025 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751466684;
	bh=GjAKfB8ZkevNmwYxs/UFrL+xjM9OYeOoYT31302DVBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlKLYjRq+/rNHetrEUEDjrtHkblEOSTU4a4CgnJ1lGErCmbnn9RK65tokMmqRZo+/
	 dLYLnDDkFvAZt4dfQIxO7aWtc4Ts6Lv9wC3km2yHAUtCE4rF9l/j7tnp7tjnMdg0UJ
	 WXEBFjmtJcYf8z3mIkF5aF0G356OFpHKuledyV1I=
Date: Wed, 2 Jul 2025 16:31:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for
 Non-Power-of-Two DIMMs
Message-ID: <2025070258-panic-unaligned-0dee@gregkh>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701171032.2470518-1-avadhut.naik@amd.com>

On Tue, Jul 01, 2025 at 05:10:32PM +0000, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
> SOCs has an Address Mask and a Secondary Address Mask register associated with
> it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
> during init using these two registers.
> 
> Currently, the module primarily considers only the Address Mask register for
> computing DIMM sizes. The Secondary Address Mask register is only considered
> for odd CS. Additionally, if it has been considered, the Address Mask register
> is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
> total capacity is a power of two (32GB, 64GB, etc), this is not an issue
> since only the Address Mask register is used.
> 
> For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
> two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
> in conjunction with the Address Mask register. However, since the module only
> considers either of the two registers for a CS, the size computed by the
> module is incorrect. The Secondary Address Mask register is not considered for
> even CS, and the Address Mask register is not considered for odd CS.
> 
> Introduce a new helper function so that both Address Mask and Secondary
> Address Mask registers are considered, when valid, for computing DIMM sizes.
> Furthermore, also rename some variables for greater clarity.
> 
> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
> (cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

This was not a clean cherry-pick at all.  Please document what you did
differently from the original commit please.

thanks,

greg k-h

