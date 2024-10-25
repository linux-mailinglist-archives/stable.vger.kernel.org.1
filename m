Return-Path: <stable+bounces-88150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7229B034C
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1681281880
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8077206518;
	Fri, 25 Oct 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="swDCX4J8"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149E2064FE;
	Fri, 25 Oct 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861293; cv=none; b=e7rLfBG1Fz9hk47yBDo5wp71QPziK4GhsDuuQRcMtlbis/Qf0OO0EsgIelpblNIrF4HpvKoWxJIJqBh5k/cNNGABKdzvOgF/2R0xJ0ACUjLCdr2Mvvvilc4QF+HxYmvvqAScolZoD6hWmRPCp46f3Ie1S0KTdF6SadwWGLULbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861293; c=relaxed/simple;
	bh=/ysGckLZJCe+gBmz3q/oulljZ0jqEfIVDR0AK+63u1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o/NbVJFm/h49I/zaSWxibk5OrOUfp5nyBhL7b3bZVY8PC6QkV4GsTkIawalGIgwpKxKgWYx0GjXaLgvWvFgwku7fL/o4OjX7zSKkJOLEeXKYRKsSBUFE3Qgud97YFGP0K3vdLSSJ+1wmFjZbtwfrZlV1s1HTx2NhEMgXzko+K1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=swDCX4J8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2C75040B1E72;
	Fri, 25 Oct 2024 13:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2C75040B1E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1729861282;
	bh=+DUqoN8vOUbI7OOzjYrkuFWgqJLyKddpc0opWW34GKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=swDCX4J8y19ceNvifb0Fkwr7OjUSrrIRLUUV0ENKzBwS/Fzqw/obPFs+H/Vx5F/zB
	 gSywSQu6Syd3ufy4Rjik17Z7wMUgtZJIFyWuWVdyXvzuHQpqyu+A3p7gdwvikxQ0Q0
	 bElOuYpdkJ2RPuJ2CefDQPh6RuHcC0K3Gf3GKZqU=
Date: Fri, 25 Oct 2024 16:01:18 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917061226.GA3839@lst.de>

On 2024-09-17 Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I suspect the patch has been lost - it's still missing on nvme-6.12 or
nvme-6.13 at git.infradead.org/nvme.git.

--
Thanks,
Fedor

