Return-Path: <stable+bounces-96181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2229E1126
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A281648C3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92B139D1B;
	Tue,  3 Dec 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEz+fq96"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCD17555;
	Tue,  3 Dec 2024 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192087; cv=none; b=eEDk7zltUWyDsKAN4rla+Z8JQX0rrN6PZR8FQVECBeBL1YTxU1M2VpJ+1pRxrU8IAY94gYfP3sYWWorxIoY/+3+iTokuOsl0EALIpkFNpyysaDKWETeh/gd+FfqCNNtVty9TpkGeJN0g1bzAlvjdL+YdobKpMSj/AY5NV5pLzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192087; c=relaxed/simple;
	bh=qgAqukm3lu8OrdWEasFNywW+NrV2YcDLOcq2wJiovf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAT6kmduAfXX6gU2pHCsxxkp/60Uy+kB9fBHa1CB78WN+rNKQx0VdDMLrK5yUZRK5Fw5LgJCdmLTc/OHVVRekbhvj0+6JMw9OWHJni0tRuithtlMnTRazTxe+yeUwQc0gSuV8nZ1EHdyfXPuujQeRh4T36/0HK9IgKC5JqRM+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEz+fq96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6AAC4CED1;
	Tue,  3 Dec 2024 02:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733192087;
	bh=qgAqukm3lu8OrdWEasFNywW+NrV2YcDLOcq2wJiovf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEz+fq964EOVNbd6Fb3AN/6rRy6Z3kwlhZtfoi3o1bdjkvPISqDZjucCQG6lI7kZw
	 WeQ/OQVeI/AJxxJLiw96qOvlil/atm4JGQO8sSCnGGjwKyQ4X8y3gm5A7D1FNSbf7q
	 8nzB3RqbBKIYFTOAqjokXVRIEmGBD7vFg/vdcpiwGM+HdQQZCHL9vxwrSpEXTGcgXk
	 6TBCoDADoaavXZOQ0b94I4noV70w6uhDJ2SA2XAMgpA2DyX4RW+hHA1JWbNK7BVQdE
	 PIXFZMh8aasIH76K5qu5kz7nggac9eRQE9PJa7p/1I8hD9KftURBN48RVq7L+yTKUo
	 FauxnDNC8FPNw==
Date: Mon, 2 Dec 2024 18:14:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Koichiro Den <koichiro.den@canonical.com>,
 virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from
 virtnet_enable_queue_pair()
Message-ID: <20241202181445.0da50076@kernel.org>
In-Reply-To: <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
	<CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>  
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

I see Tx skb flush in:

virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_sq_free_unused_buf()

do we need to reset the BQL state in that case?
Rule of thumb is netdev_tx_reset_queue() should follow any flush
(IOW skb freeing not followed by netdev_tx_completed_queue()).

