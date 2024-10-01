Return-Path: <stable+bounces-78558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E298C3C9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A41C217CE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7161CB33F;
	Tue,  1 Oct 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S9/BvfyC"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E01C9ECC
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801145; cv=none; b=FHMRTLYqvtiJsRUUld5KwEouT8FiY6T5lYNGuLGdyRF6mQ6m7Aut7Y8bw/g162XHocH1sfnwNCc2Ha27UlVjUn3IaGNFioKe+lYGJCtSpcJCirZuVNIhLIP0jTFZUYaSVQg+JMLWSAD9nemf4qn6iosw3EKS3QUkwwS1hMQQ2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801145; c=relaxed/simple;
	bh=5ZiqyT1sYrbRIok2EPu+8IwDIatVhIQmTzLsA1XLL0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRmYlfARQ94Tz6ZaQm41CbtzF4LMPHtb96TXjQtdmJSuBSMtgP4O3sUh3sCDC1mrFOtv3lOzhwf6qr+t9K6OqaFLxhyKpAzoRRogIcc549nIA+O7Nc087oXiz3T1y52C16qpYvIs9lVly+NeH9kiKkuoYGpN0ZAxzn6G+UA42SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S9/BvfyC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727801141;
	bh=5ZiqyT1sYrbRIok2EPu+8IwDIatVhIQmTzLsA1XLL0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9/BvfyCI8vrlKKhpjMYgiL+f2Nog9ANnY5+YvReJV6fmxz+K4ahV2x3GTKpExZQG
	 5qi1+9f6D7Zcl/Zn1hRI/nAUi01oomXS7R9cdj6Pqb0KDflC9oMmUEkxX3QwmAc1Wl
	 OplQflqdWPpkpEz9UWpEFMP+qL+TrqDODWm8EN0T7/tiAz+JFEp3vnOHN2fZQabhRd
	 IzaBWNbiGEz1j17Iopvd+VHZjaIF+PnD9/CUOjSo6GlEruXjhL9mMU9OOdgY7sGFQS
	 g3xewuzQAwxdfXClWq51R3fNJjBguHvD2gpy0sRCpJNNIbjJSc5ELehDEniBTvVWjP
	 sBBfpW31XPlUQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 786F517E1060;
	Tue,  1 Oct 2024 18:45:41 +0200 (CEST)
Date: Tue, 1 Oct 2024 18:45:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Don't declare a queue blocked if deferred
 operations are pending
Message-ID: <20241001184537.31582e16@collabora.com>
In-Reply-To: <20240905071914.3278599-1-boris.brezillon@collabora.com>
References: <20240905071914.3278599-1-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 09:19:14 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> If deferred operations are pending, we want to wait for those to
> land before declaring the queue blocked on a SYNC_WAIT. We need
> this to deal with the case where the sync object is signalled through
> a deferred SYNC_{ADD,SET} from the same queue. If we don't do that
> and the group gets scheduled out before the deferred SYNC_{SET,ADD}
> is executed, we'll end up with a timeout, because no external
> SYNC_{SET,ADD} will make the scheduler reconsider the group for
> execution.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Queued to drm-misc-fixes.

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 41260cf4beb8..201d5e7a921e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1103,7 +1103,13 @@ cs_slot_sync_queue_state_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs
>  			list_move_tail(&group->wait_node,
>  				       &group->ptdev->scheduler->groups.waiting);
>  		}
> -		group->blocked_queues |= BIT(cs_id);
> +
> +		/* The queue is only blocked if there's no deferred operation
> +		 * pending, which can be checked through the scoreboard status.
> +		 */
> +		if (!cs_iface->output->status_scoreboards)
> +			group->blocked_queues |= BIT(cs_id);
> +
>  		queue->syncwait.gpu_va = cs_iface->output->status_wait_sync_ptr;
>  		queue->syncwait.ref = cs_iface->output->status_wait_sync_value;
>  		status_wait_cond = cs_iface->output->status_wait & CS_STATUS_WAIT_SYNC_COND_MASK;


