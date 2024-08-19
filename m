Return-Path: <stable+bounces-69573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451F95687D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E8B22C0B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371916630A;
	Mon, 19 Aug 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2CFVf2j"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157516630F
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063206; cv=none; b=Nvlg6MyjM5ejE0BywqfDjJoZaBRXqENB8MV+a4vY/8qIj5GRIKM2ZnFDRFeuiZlvz0XNu83FgMF6/NWB+4Y4jUmwOi8tCiLpWns+0PXal6oY6liMJs5FdBIbDVJucFu7Ot5yRANXzRmNQxmtY6JR9RuzSiocqpM0FAN3BaxHlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063206; c=relaxed/simple;
	bh=cdyOyhWNoTXC4LeD27KIu48ObebtFP2FxFGbU22lqgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oEHUTIFQYNWvst2VwVuQUIEBuF1enpqBX2LLgGrg7T028C6f/f/Gg0pispL04G5I3EW/7oQ+DHQ0L8LKmUvhC0yGLu1Z9N+y7ksOCR7UhwRvbZTAUx0WdZNqFXCmBt7FQH1+b9urW02242zo2CyLNa6MAWEUV9L2Dtl/mkQHp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2CFVf2j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724063203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/Y2a7XQ/A8JKq3enJZgiVV4C1+XLKPaelO5EHyRnro=;
	b=a2CFVf2ju+qTaa9ZyxU/iZmjyOUOqdQS0GxsrjZaQkNlw2yHigkBHvbm7DgdtqTZ9+pU4r
	XwB11BJWqV7Wn1Axkt2BAYHWkr03mz8gmPgJI7OgkZY8S1UNDf74JXKFggSRy22Qz3dWxL
	XR6DpG5BSVTRorcSBK9J3RFBofgWuME=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-fhsG32lFPom9OU0WiZoEtw-1; Mon,
 19 Aug 2024 06:26:41 -0400
X-MC-Unique: fhsG32lFPom9OU0WiZoEtw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA53B1956048;
	Mon, 19 Aug 2024 10:26:40 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80FFF30001A1;
	Mon, 19 Aug 2024 10:26:40 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 469C930C051C; Mon, 19 Aug 2024 10:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 3F50B3FB48;
	Mon, 19 Aug 2024 12:26:39 +0200 (CEST)
Date: Mon, 19 Aug 2024 12:26:39 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead
 of -EINTR" failed to apply to 5.10-stable tree
In-Reply-To: <2024081926-dumpling-ecard-9941@gregkh>
Message-ID: <e3d9087-9f6b-6ce4-6977-a2f8f3d5c63@redhat.com>
References: <2024081926-dumpling-ecard-9941@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Mon, 19 Aug 2024, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081926-dumpling-ecard-9941@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> 1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")
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

Hi. Here I'm sending the updated patch for 5.10 and newer stable branches.

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
 drivers/md/dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-stable/drivers/md/dm.c
===================================================================
--- linux-stable.orig/drivers/md/dm.c
+++ linux-stable/drivers/md/dm.c
@@ -2255,7 +2255,7 @@ static int dm_wait_for_bios_completion(s
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2280,7 +2280,7 @@ static int dm_wait_for_completion(struct
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 


