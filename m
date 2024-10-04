Return-Path: <stable+bounces-80762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701AE9907DA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3876C286662
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5801AA7B5;
	Fri,  4 Oct 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlZ8cWMn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689001C7610
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056106; cv=none; b=WEk4+BDbZ7i9786rbwIaAmXMGPMMSR7qqOOzcSoqMGeiUOKNIsCtFS/IBgT93U5lIQIcyqg38iLSP6+llWaxVDUzfJMVMRiA5Zo3ts3WRl/7H1p3XbklnlG2fIbL3+fYsa5tVZO2Q7AjndAsPt0LPcqyfkbBkjvM2+fSm36DREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056106; c=relaxed/simple;
	bh=C8llYOpldWyTgjkS+y2Bb2NUJan4HmYKi2tJF3oYoe8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=N++VbEQQXP1RPaY1nyQZ/bC8lSf5ElSJSRkC9NA/etJr/uJTYUKgzEPL9AM7IFZxu9VjQOtLR8vhkJyd8MZ7x7b2oFe2IqFbbcTArORez2y4w1E7Pwsh3abGWarniw3Vv6G1wRlOZThbIr9bzcSHkTlwE1wcgtRufB/V7p1YzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlZ8cWMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728056103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8llYOpldWyTgjkS+y2Bb2NUJan4HmYKi2tJF3oYoe8=;
	b=HlZ8cWMnKLKG/94k47d2ue1Wt8NU8kpFG9AXKExzWtOvnGdYX6FnFTo56Mp+SIi/1uYG4Y
	QxPot1TIgoEwfh35NCTub8rk52LKhXTFAk5bOr4QuXN47q5KVMfDPKYFuRLprw3SdBCVdU
	72gh/Wg90wOnL3quy1sLHVJt2DEDpls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-7XIRFWAGPSyhQoGuzjuxYQ-1; Fri,
 04 Oct 2024 11:35:00 -0400
X-MC-Unique: 7XIRFWAGPSyhQoGuzjuxYQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04CF61955EB3;
	Fri,  4 Oct 2024 15:34:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F35441956088;
	Fri,  4 Oct 2024 15:34:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com>
References: <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com> <20241002200805.34376-1-batrick@batbytes.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, Patrick Donnelly <batrick@batbytes.com>,
    Xiubo Li <xiubli@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>,
    stable@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix cap ref leak via netfs init_request
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3822583.1728056095.1@warthog.procyon.org.uk>
Date: Fri, 04 Oct 2024 16:34:55 +0100
Message-ID: <3822584.1728056095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Ilya Dryomov <idryomov@gmail.com> wrote:

> The actual problem is that netfs_alloc_request() just frees rreq if
> init_request() callout fails and ceph_netfs_free_request() is never
> called, right?

I could make it call ->free_request() in the case that ->init_request()
returns an error, though I'd prefer that the cleanup be done in
->init_request() rather than passing a partially set-up state to
->free_request().

David


