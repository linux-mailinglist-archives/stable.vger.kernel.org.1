Return-Path: <stable+bounces-124793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7824A6729C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CBA3B72AC
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4720B1F2;
	Tue, 18 Mar 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iE/uz3H1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF920AF66
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297009; cv=none; b=Ir4LUh9giNcESnOPrm2y0F+PCVCzcPMHJAtkKVT+62FV9aRLwu5FV7XZ3YNjxNmiuPTp4cGwVdPI0TMI3uCYForUVLU6A7GFKOdrOxSkU0bb/++GvY8gHvsj84HS5fUx+YHzAZf5n6ErZB3wyOeP1cuyGJC7N2CZh4vOhByFQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297009; c=relaxed/simple;
	bh=VxFX0H8vuYnSuP8FRJMEaC4dRosxfxvyzCo8piVLDiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs8fXIpmO7eSSvdwqipwUAYnMg2odwz4qKWs66vKmxQcYKgnYQJ6+bPHWpl/nBFLkK0HtfUOpa3juuknMUOeB/NRpwNKIfsNOb19uVtWxoAAUgjMYWk6P36iGiQral3TTqcuRjKXqEFguSNgikP6rRvl/O4ijENIN5PTJp2pW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iE/uz3H1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742297006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybo+VOHVENueC841pTRRg4PdhPKxnG8rDNBPvItst7w=;
	b=iE/uz3H1beYVRzkxWXTTk6UdfvcDiyfc4vXhhLgrl6MHkN/fQ2zSOrNAXdIBnaMiFPdS5l
	wjdv6SWIgmu8o9MyvHQXqMOYgTKYQ8VDIATHHj+5W4y+KRrOXQNae+bAIhJ7OiNApEN98j
	9ouZYx0IynXGgQmOsxCwcM50fyykDOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-OS6Qmz25P1KEqEQ641Rh1A-1; Tue,
 18 Mar 2025 07:23:25 -0400
X-MC-Unique: OS6Qmz25P1KEqEQ641Rh1A-1
X-Mimecast-MFC-AGG-ID: OS6Qmz25P1KEqEQ641Rh1A_1742297003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971AF1800266;
	Tue, 18 Mar 2025 11:23:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 90BDB180175C;
	Tue, 18 Mar 2025 11:23:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 18 Mar 2025 12:22:51 +0100 (CET)
Date: Tue, 18 Mar 2025 12:22:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Josh Drake <josh@delphoslabs.com>,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix UAF in key_put()
Message-ID: <20250318112245.GA14792@redhat.com>
References: <2477454.1742292885@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2477454.1742292885@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/18, David Howells wrote:
>
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -645,21 +645,30 @@ EXPORT_SYMBOL(key_reject_and_link);
>   */
>  void key_put(struct key *key)
>  {
> +	int quota_flag;
> +	unsigned short len;
> +	struct key_user *user;
> +
>  	if (key) {
>  		key_check(key);
>  
> +		quota_flag = test_bit(KEY_FLAG_IN_QUOTA, &key->flags);
> +		len = key->quotalen;
> +		user = key->user;
> +		refcount_inc(&user->usage);
>  		if (refcount_dec_and_test(&key->usage)) {
>  			unsigned long flags;
>  
>  			/* deal with the user's key tracking and quota */
> -			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> -				spin_lock_irqsave(&key->user->lock, flags);
> -				key->user->qnkeys--;
> -				key->user->qnbytes -= key->quotalen;
> -				spin_unlock_irqrestore(&key->user->lock, flags);
> +			if (quota_flag) {
> +				spin_lock_irqsave(&user->lock, flags);
> +				user->qnkeys--;
> +				user->qnbytes -= len;
> +				spin_unlock_irqrestore(&user->lock, flags);
>  			}
>  			schedule_work(&key_gc_work);
>  		}
> +		key_user_put(user);

Do we really need the unconditional refcount_inc / key_user_put ?

	void key_put(struct key *key)
	{
		if (key) {
			struct key_user *user = NULL;
			unsigned short len;

			key_check(key);

			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
				len = key->quotalen;
				user = key->user;
				refcount_inc(&user->usage);
			}

			if (refcount_dec_and_test(&key->usage)) {
				unsigned long flags;

				/* deal with the user's key tracking and quota */
				if (user) {
					spin_lock_irqsave(&user->lock, flags);
					user->qnkeys--;
					user->qnbytes -= len;
					spin_unlock_irqrestore(&user->lock, flags);
				}
				schedule_work(&key_gc_work);
			}

			if (user)
				key_user_put(user);
		}
	}

looks a bit more clear/simple to me...

Oleg.


