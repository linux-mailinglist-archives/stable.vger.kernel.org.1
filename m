Return-Path: <stable+bounces-124794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA7A672DB
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 12:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E117F860
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4820B215;
	Tue, 18 Mar 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYYaFeCF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9B20B7E7
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297864; cv=none; b=R2MepJwq4FnaDuSjSWLU+e8bwmG5uZkH+cDNoF+c5GwCFC+fVXWtaLB/4bvxiJSUj1MH7Ac+UryrERyalqOWT26168QO4gugUPK6p7+/uSS7JXP+Qs5oOCWNdjZwq60O7QZMSjpoHDhvDVbeo7hKki60nUrau+RBr0HOjTuuzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297864; c=relaxed/simple;
	bh=X5AEPegJnCWTJZdvz//Ircoe285+jfO/V3sdiCOHHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPoRgsqRDOYL0Yo6/e+t8wcKMmhWRZwH5eIlk0Qp1RC7BHaXwFKf4z8nNGTuV4pIQxKW1DkbMygit+D3VQXQxjTQTMlspiLSQQnAsDoF+5R3LOlP3gWGVev0esKsNRC0tq95yRu6kFgCxisyyawVPz4qwEeRVg9Y7+d06tA4XF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYYaFeCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742297858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11ZNprjj242fLpLRxnWb0Up6kO5h/hr5oXZeYOIssMQ=;
	b=VYYaFeCF+1n4xX4V3Rvjq4lqLJ7zxNl/Nk5O6/P9e+Z/SpQvFZ6NZ7fF6veYx83Iyg0cDy
	ddmq5a8u0cPYt0Adi4tENqSyujb1rRMLqNYYAoepnYMjuiHTlh+3od+Fkoln7R8j/aYyHg
	NgMDEmsCU6cRHfIPdTEtc4jC5PEjc1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-0MmHvMWaPjaNHVL7QiWrIQ-1; Tue,
 18 Mar 2025 07:37:34 -0400
X-MC-Unique: 0MmHvMWaPjaNHVL7QiWrIQ-1
X-Mimecast-MFC-AGG-ID: 0MmHvMWaPjaNHVL7QiWrIQ_1742297853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08E4E19560A1;
	Tue, 18 Mar 2025 11:37:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 00DCB18001EF;
	Tue, 18 Mar 2025 11:37:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 18 Mar 2025 12:37:00 +0100 (CET)
Date: Tue, 18 Mar 2025 12:36:55 +0100
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
Message-ID: <20250318113655.GB14792@redhat.com>
References: <2477454.1742292885@warthog.procyon.org.uk>
 <20250318112245.GA14792@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318112245.GA14792@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Either way... I know nothing about security/key, but grep -w key_put
finds

 *  When it is no longer required, the key should be released using::

	void key_put(struct key *key);

    Or::

	void key_ref_put(key_ref_t key_ref);

    These can be called from interrupt context.
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

in Documentation/security/keys/core.rst

and since key_user_put() takes key_user_lock with irqs enabled,
key_put()->key_user_put() doesn't look correct...

Oleg.

On 03/18, Oleg Nesterov wrote:
>
> On 03/18, David Howells wrote:
> >
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -645,21 +645,30 @@ EXPORT_SYMBOL(key_reject_and_link);
> >   */
> >  void key_put(struct key *key)
> >  {
> > +	int quota_flag;
> > +	unsigned short len;
> > +	struct key_user *user;
> > +
> >  	if (key) {
> >  		key_check(key);
> >
> > +		quota_flag = test_bit(KEY_FLAG_IN_QUOTA, &key->flags);
> > +		len = key->quotalen;
> > +		user = key->user;
> > +		refcount_inc(&user->usage);
> >  		if (refcount_dec_and_test(&key->usage)) {
> >  			unsigned long flags;
> >
> >  			/* deal with the user's key tracking and quota */
> > -			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> > -				spin_lock_irqsave(&key->user->lock, flags);
> > -				key->user->qnkeys--;
> > -				key->user->qnbytes -= key->quotalen;
> > -				spin_unlock_irqrestore(&key->user->lock, flags);
> > +			if (quota_flag) {
> > +				spin_lock_irqsave(&user->lock, flags);
> > +				user->qnkeys--;
> > +				user->qnbytes -= len;
> > +				spin_unlock_irqrestore(&user->lock, flags);
> >  			}
> >  			schedule_work(&key_gc_work);
> >  		}
> > +		key_user_put(user);
>
> Do we really need the unconditional refcount_inc / key_user_put ?
>
> 	void key_put(struct key *key)
> 	{
> 		if (key) {
> 			struct key_user *user = NULL;
> 			unsigned short len;
>
> 			key_check(key);
>
> 			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> 				len = key->quotalen;
> 				user = key->user;
> 				refcount_inc(&user->usage);
> 			}
>
> 			if (refcount_dec_and_test(&key->usage)) {
> 				unsigned long flags;
>
> 				/* deal with the user's key tracking and quota */
> 				if (user) {
> 					spin_lock_irqsave(&user->lock, flags);
> 					user->qnkeys--;
> 					user->qnbytes -= len;
> 					spin_unlock_irqrestore(&user->lock, flags);
> 				}
> 				schedule_work(&key_gc_work);
> 			}
>
> 			if (user)
> 				key_user_put(user);
> 		}
> 	}
>
> looks a bit more clear/simple to me...
>
> Oleg.


