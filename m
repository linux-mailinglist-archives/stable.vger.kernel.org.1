Return-Path: <stable+bounces-143260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CEAB3726
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E6C19E1DD6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F927978E;
	Mon, 12 May 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+YKvXPl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533529373D
	for <stable@vger.kernel.org>; Mon, 12 May 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053388; cv=none; b=jpXRJ6Dvn9RaI+iTKX8xMILXybWkBChTROkDO/LF+posmdPgqHyVrss0l77685hNOvK4Cn7q5ISzEqHFhlTgy9xQjB684P0ER6FX5pmjDqvupX8221UJmGMWX0CtLpdiZBRs64AS/L4XtGsz0+qlkP+lt+rgsDWgLdPLVYWKl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053388; c=relaxed/simple;
	bh=7eKz9Met6byrIAUH9adG7uBbtkmmO6hjECkeW8IwJLA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dqf+m9LJypvRRNL0Sgu6+9vKwt+I0x/WDRA7FlW13sUIerDVHnOpkmsZ9/Zpf86LMlEqrSVlR2iPRwnQbRN52NccTM+hGI8zrjBhqyxYrlvvO9WJwf3ths1w2bgcgoA55P06h+R16v6vCUj2TrherT871Eu8sYeu7+QN7IdTv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+YKvXPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6S/p4Jp0Aj0fVbsxpazo/Y1fkTp28o7I5t0XKUfFF0k=;
	b=I+YKvXPlqce6Rf03F+Yv41Z7y2QR0Sq1kmf1uVRb7QpnzyA2ovknB27MV5FCvOPViGB9UT
	CKT5W4wFROMoYdRLpkpO9Qbyby0U2NUFDlNpU3jPSi+66lzK1wF+kod//0bORbKnnwSKwI
	RMXhbfupVWfxb839B7ZOLjqtTougFto=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-6OV1FC7nOlWe4a212UYIOA-1; Mon,
 12 May 2025 08:36:23 -0400
X-MC-Unique: 6OV1FC7nOlWe4a212UYIOA-1
X-Mimecast-MFC-AGG-ID: 6OV1FC7nOlWe4a212UYIOA_1747053382
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E7E31955DE8;
	Mon, 12 May 2025 12:36:22 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65E2330001AB;
	Mon, 12 May 2025 12:36:21 +0000 (UTC)
Date: Mon, 12 May 2025 14:36:16 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: dan.carpenter@linaro.org, stable@vger.kernel.org
Subject: [PATCH 5.12.y] dm: add missing unlock on in dm_keyslot_evict()
In-Reply-To: <2025050954-excretion-yonder-4e95@gregkh>
Message-ID: <c9d4dfc7-2300-e271-0308-056633142226@redhat.com>
References: <2025050954-excretion-yonder-4e95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi

Here I'm submitting updated patch.

Mikulas


On Fri, 9 May 2025, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 5.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 650266ac4c7230c89bcd1307acf5c9c92cfa85e2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050954-excretion-yonder-4e95@gregkh' --subject-prefix 'PATCH 5.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 650266ac4c7230c89bcd1307acf5c9c92cfa85e2 Mon Sep 17 00:00:00 2001
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Wed, 30 Apr 2025 11:05:54 +0300
> Subject: [PATCH] dm: add missing unlock on in dm_keyslot_evict()
> 
> We need to call dm_put_live_table() even if dm_get_live_table() returns
> NULL.
> 
> Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
> Cc: stable@vger.kernel.org	# v5.12+
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 9e175c5e0634..31d67a1a91dd 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1173,7 +1173,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
>  
>  	t = dm_get_live_table(md, &srcu_idx);
>  	if (!t)
> -		return 0;
> +		goto put_live_table;
>  
>  	for (unsigned int i = 0; i < t->num_targets; i++) {
>  		struct dm_target *ti = dm_table_get_target(t, i);
> @@ -1184,6 +1184,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
>  					  (void *)key);
>  	}
>  
> +put_live_table:
>  	dm_put_live_table(md, srcu_idx);
>  	return 0;
>  }
> 

We need to call dm_put_live_table() even if dm_get_live_table() returns
NULL.

Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
Cc: stable@vger.kernel.org    # v5.12+
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-stable/drivers/md/dm-table.c
===================================================================
--- linux-stable.orig/drivers/md/dm-table.c
+++ linux-stable/drivers/md/dm-table.c
@@ -1251,13 +1251,14 @@ static int dm_keyslot_evict(struct blk_k
 
 	t = dm_get_live_table(md, &srcu_idx);
 	if (!t)
-		return 0;
+		goto put_live_table;
 	for (i = 0; i < dm_table_get_num_targets(t); i++) {
 		ti = dm_table_get_target(t, i);
 		if (!ti->type->iterate_devices)
 			continue;
 		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
 	}
+put_live_table:
 	dm_put_live_table(md, srcu_idx);
 	return args.err;
 }


