Return-Path: <stable+bounces-125585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F1FA69508
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094D17AC52F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68B1DE3AA;
	Wed, 19 Mar 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWZxgAzi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABA15A85E
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401889; cv=none; b=KvalXZyyTmHA+l02nkQL+CiTIs13uQ6wJXAKg7hOthbJd5DOl1INsa68m1Jb6te21Ev4PdKmfMDkRXlmDcwFfivhpLLjxiLYN+knRuFs/X5MuaiW0Lqxa1JhgsOybHIlzrBakw/KZNiYiz9yFmtVm+V4zo86SEJttk0a8XPZ94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401889; c=relaxed/simple;
	bh=t5HTl/1sN+/sdSktoUHTbciuxtU3lbC7SvM0xor5DjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH112dN4YyKC84qdx6XrD+s20IebI9p1E77y9Joyr4RBpB7CeOfqyIjZM+YAHOMKaJE0n7RkgTuGobLzL96ZWzxFZaQgSGi1xekrMGxC6H5adgtXNAXTsT7QHuMctSrxmqmxoqY2GhZz7q5XuBvk3vFSbYUHA0Sr/ctCwLXGDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWZxgAzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742401886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEuAVN1LlysmY3w8d4Fl+/NM3c03ETBt86dyGKQMHmE=;
	b=XWZxgAzirsUKxAFnPTrinVIDvYGiplSWvGlFqSKIZQP+y4qHQn6eHDbF7/JKNMxku6rnMG
	6625LR6A/pWH/pYG5VqdkUds2buUfipttbWdo6fWgBmmbfKr5o7aoOJNJNT1KcUmshJAuV
	PyiLbpeKvym+++KsmWaULQJSBIzy0TM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-1Tcnj-kcMDO0qR63P9N4DQ-1; Wed,
 19 Mar 2025 12:31:19 -0400
X-MC-Unique: 1Tcnj-kcMDO0qR63P9N4DQ-1
X-Mimecast-MFC-AGG-ID: 1Tcnj-kcMDO0qR63P9N4DQ_1742401877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 072F11955E90;
	Wed, 19 Mar 2025 16:31:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 01EC31955DCD;
	Wed, 19 Mar 2025 16:31:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 17:30:44 +0100 (CET)
Date: Wed, 19 Mar 2025 17:30:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Josh Drake <josh@delphoslabs.com>,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Fix UAF in key_put()
Message-ID: <20250319163038.GD26879@redhat.com>
References: <2874581.1742399866@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2874581.1742399866@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/19, David Howells wrote:
>
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -218,8 +218,10 @@ static void key_garbage_collector(struct work_struct *work)
>  		key = rb_entry(cursor, struct key, serial_node);
>  		cursor = rb_next(cursor);
>  
> -		if (refcount_read(&key->usage) == 0)
> +		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
> +			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
>  			goto found_unreferenced_key;
> +		}
>  
>  		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
>  			if (key->type == key_gc_dead_keytype) {
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 3d7d185019d3..7198cd2ac3a3 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -658,6 +658,8 @@ void key_put(struct key *key)
>  				key->user->qnbytes -= key->quotalen;
>  				spin_unlock_irqrestore(&key->user->lock, flags);
>  			}
> +			smp_mb(); /* key->user before FINAL_PUT set. */

Can't resist, smp_mb__before_atomic() should equally work,
but this doesn't really matter, please forget.

> +			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
>  			schedule_work(&key_gc_work);

I believe this patch is correct,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


