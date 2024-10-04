Return-Path: <stable+bounces-80764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1E9907DF
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760131F25862
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCFA1E32B1;
	Fri,  4 Oct 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh1Vd/yN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB181C303B
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056175; cv=none; b=AORfZ+EbuvH5MdfZBBhVUBJd9Dx0NfqwrrIZJk1oArnyI3fg+h7OvsWuST8tje8asUi8sijtooHTqpZtd7n0MUCQPOfJAhjIdanfT9LUq5sm7+YURmfSdSlSxHK0XkatngrmX/eZQe6THiTty9mKKQXOjbF+EdwkRepGoDiSpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056175; c=relaxed/simple;
	bh=Pc19oH7Ih4scqQQSq4nE+w2PUEeIHkT/kLjOwm8Auuw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RJH43axQSTcEr48c+qVsB9eGR5nYC2eMa7bIEhnn32+ub+G8ZLdWco161imHqU4G8OQkCJMEsVWyk/a/JxImmouhNHIbMZBcwKQIEDSRaFCxNWb9u33AYMR8IQ/GyW+uQUvzRc28vyWg4WX5K5VutirQyckHVMt7PrBE93aTnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sh1Vd/yN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728056172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEi5RExZjbpGuczCWNpHYgyJ/zRUFnev8Ha101ZiYXI=;
	b=Sh1Vd/yNOq56ifyylbM3UWdDvYw3qhf3NxZkg2n67iwzMQ3GghAUW1EZaicUDXjVtEl02w
	9ZUbq39I1fQjOINoUV3HIa+t+bO4V6kzErNYy9TaQtUIKdoHt/rdnLRcC8/rXCbv+y/Uyd
	K0Lf0BAiEfJAzCA5JuALl10RcC6Xs7Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-kZnPuEmfPOevldP0kGwdkQ-1; Fri,
 04 Oct 2024 11:36:11 -0400
X-MC-Unique: kZnPuEmfPOevldP0kGwdkQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41ED9195422F;
	Fri,  4 Oct 2024 15:36:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF9DD1956054;
	Fri,  4 Oct 2024 15:36:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241003010512.58559-1-batrick@batbytes.com>
References: <20241003010512.58559-1-batrick@batbytes.com>
To: Patrick Donnelly <batrick@batbytes.com>
Cc: dhowells@redhat.com, Xiubo Li <xiubli@redhat.com>,
    Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
    Patrick Donnelly <pdonnell@redhat.com>, stable@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix cap ref leak via netfs init_request
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3822869.1728056166.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Oct 2024 16:36:06 +0100
Message-ID: <3822870.1728056166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Patrick Donnelly <batrick@batbytes.com> wrote:

> Log recovered from a user's cluster:
> =

>     <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
>     <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
>     ...
>     <7>[ 5473.934609] ceph:   my wanted =3D Fr, used =3D Fr, dirty -
>     <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking =
Fr)
>     <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 000=
00000f7784259 issued pAsLsXs
>     <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe fil=
e_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsL=
sXsFsr  AUTHONLY NOINVAL FLUSH_FORCE
> =

> The MDS subsequently complains that the kernel client is late releasing =
caps.
> =

> Approximately, a series of changes to this code by the three commits cit=
ed
> below resulted in subtle resource cleanup to be missed. The main culprit=
 is the
> change in error handling in 2d31604 which meant that a failure in init_r=
equest
> would no longer cause cleanup to be called. That would prevent the
> ceph_put_cap_refs which would cleanup the leaked cap ref.
> =

> Closes: https://tracker.ceph.com/issues/67008
> Fixes: 49870056005ca9387e5ee31451991491f99cc45f ("ceph: convert ceph_rea=
dpages to ceph_readahead")
> Fixes: 2de160417315b8d64455fe03e9bb7d3308ac3281 ("netfs: Change ->init_r=
equest() to return an error code")
> Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_r=
equest() check caps on readahead")

Note that you only need the first 12 digits of the SHA1 sum.

> Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: David Howells <dhowells@redhat.com>


