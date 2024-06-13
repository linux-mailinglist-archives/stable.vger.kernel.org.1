Return-Path: <stable+bounces-52061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60B9075AF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68141C20D83
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E31487E7;
	Thu, 13 Jun 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbx5ouQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216C1465BF;
	Thu, 13 Jun 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290139; cv=none; b=OIBmqsqvu1kCTOOmHzwe0Zywge2zQO6YkVr4sFtJ/FTyqpXs/sAkl1/mkFjEC+3SFwYjgie1j+nsmIMYOVu+vkVCk5Jt3MT/5lLLl6tPWgaQ1dHObJbR63h2azY3D+0v8DknW9p9P8QslIaspZ0wb1v5aYWTxJgYC1WzmkU8u9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290139; c=relaxed/simple;
	bh=B+9gF8yl1K0CumjuNYOoyHlhsRpoDqgBX0KW/HKrKEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsup76Vfip4Op8I2yOlMvsghP+Yk4mD04mPwVkghI98GCbTP7HGmtI8LgrFMkr4/ZlOmYvCSclkIU83N4Kr+mj+mjFNkLkbF2qxv3aJQDzat3nxpEJvF+bVlZIX9E72BaNF4CwDPhoyCI4EPgpw+nwKv8obGwNFaWpatED7INiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbx5ouQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99850C2BBFC;
	Thu, 13 Jun 2024 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718290138;
	bh=B+9gF8yl1K0CumjuNYOoyHlhsRpoDqgBX0KW/HKrKEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mbx5ouQLUVHNkaKqAEuvCwiIAt592ly3ZPjrIsi1+0X5GZicw+QH4rn9GZwIAnNNT
	 zYuRXP5YPXu7bmJshx/8e33TnL7TqVybDgGNPcJh5mFap1NYK7wSvf6AM6CQxdIjn/
	 4Eop14ISSEAP0N7yGZtI4BKjzhZGAhWKafcPQfIRgv7Cl1GXcbNCQTueIl04IXdtNs
	 Ue85YcZV2qqs+4iPDs/a7BHeULLWwdNElPa1SyVZOzTZ5YwM5AQ0YsvpSZ89lwlCJR
	 S62d7/XYjrls6jgO3LcdgWDE+onRIUuAfy9k9NsnjuPAdoTLhbJIcjAueBx+f4Vuhq
	 eC37JLIhxmNPg==
Date: Thu, 13 Jun 2024 07:48:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] bnx2x: Fix multiple UBSAN
 array-index-out-of-bounds
Message-ID: <20240613074857.66597de9@kernel.org>
In-Reply-To: <20240612154449.173663-1-ghadi.rahme@canonical.com>
References: <20240612154449.173663-1-ghadi.rahme@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 18:44:49 +0300 Ghadi Elie Rahme wrote:
> Fix UBSAN warnings that occur when using a system with 32 physical
> cpu cores or more, or when the user defines a number of Ethernet
> queues greater than or equal to FP_SB_MAX_E1x using the num_queues
> module parameter.
> 
> The value of the maximum number of Ethernet queues should be limited
> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
> enabled to avoid out of bounds reads and writes.

You're just describing what the code does, not providing extra
context...

> Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")

Sure this is not more recent, netif_get_num_default_rss_queues()
used to always return 8.

> Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
> Cc: stable@vger.kernel.org

>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index a8e07e51418f..c895dd680cf8 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> @@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
>  	if (is_kdump_kernel())
>  		nq = 1;
>  
> -	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
> +	int max_nq = FP_SB_MAX_E1x - 1;

please don't mix declarations and code

> +	if (NO_FCOE(bp))
> +		max_nq = FP_SB_MAX_E1x;

you really need to explain somewhere why you're hardcoding E1x
constants while at a glance the driver also supports E2.
Also why is BNX2X_MAX_QUEUES() higher than the number of queues?
Isn't that the bug?
-- 
pw-bot: cr

