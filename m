Return-Path: <stable+bounces-104429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7489F432D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2809016A0E1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6914F11E;
	Tue, 17 Dec 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sD4oeyqs"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA883CC7;
	Tue, 17 Dec 2024 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414663; cv=none; b=llUk7aOLKEO2b9pREyk4RHqnGXbed8HafXz229m/zLIYBx+7ujffMHBi+B5YWYuZ26XajcoZvG7Uy5N/thAhCStHFrEQ6797YcO4gDFv+WQuXSuUItoR4K+NgoAHWaafBf2cRrZx/iSTVCne+jkp9DPUqFqutU3HFPHiDzZsHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414663; c=relaxed/simple;
	bh=bPwQShof+vswbSf/CYo+caDqGjI4PPBpNF2MsWMY7Hs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=XcIiJJf1kUw3yFLynzvN03RSVXbK4G8hLdfS0RcPxTD0hOK3FHWdW3/HiQUpNELCPli/tkdC+aSH3JWWqrRdVFi+NwKP7b5w55LmILjBPyXVXce89wkim2Sg8p8cAofOabIl2rA6S86f/kjKApLX6Ihs+4cYF5IkNnYv7tx46p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sD4oeyqs; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734414656; h=Message-ID:Subject:Date:From:To;
	bh=k594UHrD4sW4gyFiUBIeQmb6/7gl1rH5o5a9yezmc84=;
	b=sD4oeyqs21VLo3R90ztoS5EQnBNbjB635VPVuvsWX8Uf+/1grD2DrS96L6sRUL6DDm5fTdq52wdE03ej9Z7DtzcUHEKYjlTZ25KuryMohT3WhvBqLE/WqkGh/kJvhNxmzDVSJ/5wTA+bDRE6X0sYTbG1LDzTfFTIV6gaKqeKbdo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WLhajSd_1734414655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 13:50:56 +0800
Message-ID: <1734414558.011073-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: fix reference leak in register_virtio_device()
Date: Tue, 17 Dec 2024 13:49:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 arnd@arndb.de,
 viresh.kumar@linaro.org
References: <20241217035432.2892059-1-make_ruc2021@163.com>
In-Reply-To: <20241217035432.2892059-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Tue, 17 Dec 2024 11:54:32 +0800, Ma Ke <make_ruc2021@163.com> wrote:
> When device_add(&dev->dev) failed, calling put_device() to explicitly
> release dev->dev. Otherwise, it could cause double free problem.

Who frees it doublely?
If device_add() failed, the put_device is called inside device_add(),
why we need to call it again?

Maybe you need to say more?

Thanks.


>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> --
> 2.25.1
>

