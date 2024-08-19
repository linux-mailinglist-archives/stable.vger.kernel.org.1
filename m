Return-Path: <stable+bounces-69574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC09956880
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AE31C21DE1
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA67160865;
	Mon, 19 Aug 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBlD/uXf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AB1607B4
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063340; cv=none; b=sVXPCeU2F0LJlm+Eo3zPIVOGuGXMVzIin3LggqU8qYKcP5z7P6BkMDMSp2TX12oCpFXOpeLZDdxiD5qwf2tyu+KvhFv0rnNUTzC+dApVeLB2VIUkAXymaStAGAImPVCb9+JfhBALwH9Yf5sUFlu1YHFCjl42lFZWMum51MUadx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063340; c=relaxed/simple;
	bh=l8ZbmO6Lv+Wg7bzzIAkFARQu8z8b43FyamU0Djc64CM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YV/u6mfCg9iQyJxUF/ZIc9n5PGTPQCoZ/buMGfjEA9kV9QTSpz3gyX/otv2SiTNMj4C6yba/siLQk3wfx/Y0C4fi6+0JkN/98N+EFrf1OC2mfFiM9NJCJPOGzUEkmayUWEz6UbkOkEIMTG5ur40L1EjOmaQiWaEJJuKWqOt18SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBlD/uXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724063337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pItcLM8wa8tu17zUOu3tXm7ZXWAByQE/2p3M5RP3lC8=;
	b=eBlD/uXftkBcPAWhzPjojqAAcZFVZCubnSrY6mVene+dExhpZwtxcV6Nc3LUVawhFZfOtE
	NHYgQW3jWd6NuRdsuPeXb6zHeM8NTdd19Tegq9rlA8b2pd6u5n5a3WgD6c5Bl0ce3Cv12K
	w3sJtWMF0BQRZNwOELaT3j7WljMVSvI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136--QoEfT0QOQKEEBfe9lUFPA-1; Mon,
 19 Aug 2024 06:28:54 -0400
X-MC-Unique: -QoEfT0QOQKEEBfe9lUFPA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D2971955D4B;
	Mon, 19 Aug 2024 10:28:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27C1F1956054;
	Mon, 19 Aug 2024 10:28:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 0C43130C051C; Mon, 19 Aug 2024 10:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 09BB93FB48;
	Mon, 19 Aug 2024 12:28:52 +0200 (CEST)
Date: Mon, 19 Aug 2024 12:28:52 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead
 of -EINTR" failed to apply to 4.19-stable tree
In-Reply-To: <2024081927-smoky-refrain-8af1@gregkh>
Message-ID: <e7ae27a1-14c7-baf7-d44b-7f73b6eb571f@redhat.com>
References: <2024081927-smoky-refrain-8af1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Mon, 19 Aug 2024, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-smoky-refrain-8af1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")
> 85067747cf98 ("dm: do not use waitqueue for request-based DM")
> 087615bf3acd ("dm mpath: pass IO start time to path selector")
> 5de719e3d01b ("dm mpath: fix missing call of path selector type->end_io")
> 645efa84f6c7 ("dm: add memory barrier before waitqueue_active")
> 3c94d83cb352 ("blk-mq: change blk_mq_queue_busy() to blk_mq_queue_inflight()")
> c4576aed8d85 ("dm: fix request-based dm's use of dm_wait_for_completion")
> b7934ba4147a ("dm: fix inflight IO check")
> 6f75723190d8 ("dm: remove the pending IO accounting")
> dbd3bbd291a0 ("dm rq: leverage blk_mq_queue_busy() to check for outstanding IO")
> 80a787ba3809 ("dm: dont rewrite dm_disk(md)->part0.in_flight")
> ae8799125d56 ("blk-mq: provide a helper to check if a queue is busy")
> 6a23e05c2fe3 ("dm: remove legacy request-based IO path")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 Mon Sep 17 00:00:00 2001
> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Tue, 13 Aug 2024 12:38:51 +0200
> Subject: [PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR
> 
> This commit changes device mapper, so that it returns -ERESTARTSYS
> instead of -EINTR when it is interrupted by a signal (so that the ioctl
> can be restarted).
> 
> The manpage signal(7) says that the ioctl function should be restarted if
> the signal was handled with SA_RESTART.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 97fab2087df8..87bb90303435 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2737,7 +2737,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
>  			break;
>  
>  		if (signal_pending_state(task_state, current)) {
> -			r = -EINTR;
> +			r = -ERESTARTSYS;
>  			break;
>  		}
>  
> @@ -2762,7 +2762,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
>  			break;
>  
>  		if (signal_pending_state(task_state, current)) {
> -			r = -EINTR;
> +			r = -ERESTARTSYS;
>  			break;
>  		}
>  
> 

Hi

Here I'm sending the updated patch for 4.19 and 5.4.

Mikulas



commit 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Tue Aug 13 12:38:51 2024 +0200

    dm suspend: return -ERESTARTSYS instead of -EINTR
    
    This commit changes device mapper, so that it returns -ERESTARTSYS
    instead of -EINTR when it is interrupted by a signal (so that the ioctl
    can be restarted).
    
    The manpage signal(7) says that the ioctl function should be restarted if
    the signal was handled with SA_RESTART.
    
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Cc: stable@vger.kernel.org

---
 drivers/md/dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-stable/drivers/md/dm.c
===================================================================
--- linux-stable.orig/drivers/md/dm.c
+++ linux-stable/drivers/md/dm.c
@@ -2468,7 +2468,7 @@ static int dm_wait_for_completion(struct
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 


