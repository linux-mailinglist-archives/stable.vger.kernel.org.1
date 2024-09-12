Return-Path: <stable+bounces-76001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25A976AD5
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE031C203C0
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0B1A3037;
	Thu, 12 Sep 2024 13:39:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E319FA91;
	Thu, 12 Sep 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148369; cv=none; b=HqfIiXMe3+blHO+1LwcUONJDtsJgUa6tur4GHDHbRSaT6cTfWofCD8IPHVkJcex1jTTafMjJaUDTJJgQbVKn8EocdpezwagcikAqyVIxhSnGU8X4iIlyeXsLkubgdcJ10yHzPFq2jNM82381wGJZsMjCPiPLFNMQuEsxz/u2aL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148369; c=relaxed/simple;
	bh=B5FSzcEMnYcLk0t6+V/tT8z1lfxHJVmfxdzb9FHptGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtoNEsLvWtK2gJc4GvVGnX5GCKkn2iROM7l3YnCpPs+ILxBb7ucXhAO29ILEypDiAE8EtEJBiXT1RIp6qUwzGwDD1CBlOnMPmjOr3gRt5x1mO9JBSqZjk68jlaBiz43LGy+Gs3cQ3x6P8tF4svpaoay2Nuvz3fWi6pTDqP8qUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DDB2DA7;
	Thu, 12 Sep 2024 06:39:55 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9FB3F64C;
	Thu, 12 Sep 2024 06:39:23 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:39:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
	nsz@port70.net, mst@redhat.com, jasowang@redhat.com,
	yury.khrustalev@arm.com, broonie@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2] net: tighten bad gso csum offset check in
 virtio_net_hdr
Message-ID: <ZuLvCTYl3bhN9C6r@bogus>
References: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>

On Tue, Sep 10, 2024 at 05:35:35PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The referenced commit drops bad input, but has false positives.
> Tighten the check to avoid these.
> 
> The check detects illegal checksum offload requests, which produce
> csum_start/csum_off beyond end of packet after segmentation.
> 
> But it is based on two incorrect assumptions:
> 
> 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
> True in callers that inject into the tx path, such as tap.
> But false in callers that inject into rx, like virtio-net.
> Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> 
> 2. TSO requires checksum offload, i.e., ip_summed == CHECKSUM_PARTIAL.
> False, as tcp[46]_gso_segment will fix up csum_start and offset for
> all other ip_summed by calling __tcp_v4_send_check.
> 
> Because of 2, we can limit the scope of the fix to virtio_net_hdr
> that do try to set these fields, with a bogus value.
>

I see it is already queued and extremely sorry for not testing and getting
back earlier. Good news: it does fix the issue in my setup(same as reported
at [1])

So, FWIW,

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/netdev/ZtsTGp9FounnxZaN@arm.com/

