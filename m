Return-Path: <stable+bounces-125677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1810A6AB37
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEF98A7331
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597421C9F2;
	Thu, 20 Mar 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8gWJplu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03617591
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488765; cv=none; b=OTxsvNomw9n+Odz8Bb7WlNfBVIUtiEjLt5wSyZ7aLbH/z4WInwmIzl9PVM1aWOrvcmgUREKT4Ud27HdrXKTjVHawzuJNIi7rlrduWip+shp9eIMBEXw8utdjbTFnON2AVCT54MywnV0WCtGlV8Ltf6kA8EWoEeVRI3pZ+4T8yrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488765; c=relaxed/simple;
	bh=cp2CKcEWiOBT48JJ7MbRp1eSyf9f2/60kLxLkajDvrU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HroyqsFR+8gfydK5QzPXz0yzNtDGn4Hr2zRG4d6COsbo0PTMOBg+REY3RvSexxKpKjVNzDV69TBOC7AjErzZuQmTU5Mh0IvjVtQPhlceVyC824OgIAh95pN8su/vRCU0QKTmRIn0ES+/XxLjaGH4/Ef6A2d36yM6f8h/3idrkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8gWJplu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742488762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZKowq3xF7umz5WK6einNU67q1AItzKpymlHIT/PbDU=;
	b=Q8gWJpluJmhbPmJ18ReYA+C+7+hUm6WxGzqSXxvY/HlJb9b71n1CI3IzUotOd2pGcP+p9z
	yckML+xc0T/C3s3GD6A494aBGSleUPvBL681S7XMRyYpR7IM8fYbEeqMGEIwGgw8QHILGv
	c8HKVLCmLGyE/DZWEjuDz/11TGkC1jE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-A5I6YRPhPf-9DET5RdcTsw-1; Thu,
 20 Mar 2025 12:39:18 -0400
X-MC-Unique: A5I6YRPhPf-9DET5RdcTsw-1
X-Mimecast-MFC-AGG-ID: A5I6YRPhPf-9DET5RdcTsw_1742488756
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 513151800EC5;
	Thu, 20 Mar 2025 16:39:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 327B2180175B;
	Thu, 20 Mar 2025 16:39:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z9w-10St-WYpSnKC@kernel.org>
References: <Z9w-10St-WYpSnKC@kernel.org> <2874581.1742399866@warthog.procyon.org.uk>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Kees Cook <kees@kernel.org>,
    Oleg Nesterov <oleg@redhat.com>,
    Greg KH <gregkh@linuxfoundation.org>,
    Josh Drake <josh@delphoslabs.com>,
    Suraj Sonawane <surajsonawane0215@gmail.com>,
    keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
    security@kernel.org, stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Fix UAF in key_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3176470.1742488751.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 16:39:11 +0000
Message-ID: <3176471.1742488751@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> > +		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
> > +			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
> 
> test_bit() is already atomic.

Atomiticity doesn't apply to test_bit() - it only matters when it does two (or
more) accesses that must be perceptually indivisible (e.g. set_bit doing RMW).

But atomiticity isn't the issue here, hence the barrier.  You need to be
looking at memory-barriers.txt, not atomic_bitops.txt.

We have two things to correctly order and set_bit() does not imply sufficient
barriering; test_and_set_bit() does, but not set_bit(), hence Linus's comment
about really wanting a set_bit_release().

> > +			smp_mb(); /* key->user before FINAL_PUT set. */
> > +			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> 
> Ditto.

Ditto. ;-)

> Nit: I'm just thinking should the name imply more like that "now
> key_put() is actually done". E.g., even something like KEY_FLAG_PUT_DONE
> would be more self-descriptive.

KEY_FLAG_PUT_DONE isn't right.  There can be lots of puts on a single key -
only the one that reduces it to 0 matters for this.  You could call it
KEY_FLAG_CAN_NOW_GC or KEY_FLAG_GC_ABLE.

David


