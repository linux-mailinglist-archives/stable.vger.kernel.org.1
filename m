Return-Path: <stable+bounces-114537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5FA2ED2D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D417A23B5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B981741;
	Mon, 10 Feb 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9To6MQP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5632236E2
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192712; cv=none; b=nIJXzk0wKw2qNz9zdrYjalERxAkYbxQmkkdBy4DrYfmwWXVuIEcAg0CacdqAVWoXS7MgnfIc3b3qZD2O0HI/v7h3maepQtiDC0pOBVUSQOAB8gCWltIJKRvabuYFBT3aFwCgNAt2J1rftVPsE4s6xoyX9z8qhuERnTXjYNfCpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192712; c=relaxed/simple;
	bh=dJY6FF+SXGDXT3/s4HkOYygQhgGqnCqkBjPdqKPssQs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=byr+SCCobNLShcKt5EmuJazBS0P13NpD4gQZ64Csn7sp4t5x4v5mtatI0Pypf7Y4ezZepWDf2bnZcJuKyAXc/3PjaMsq8LzDcavgN+F/SMOsohVlCs9B4trJ75eS8PoUn1QEtyZ7x4x1U32NLHinr1PBK14UBuDqPWbfbj8Xo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9To6MQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739192708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ziu5bYfChbk63QB3eLjGTLuS2tRlNRKizVuNnFhCyoI=;
	b=d9To6MQPdpK8LhPqT0m5vFcucFTokrK+pcOhmpK7Xl+Ip4ptd3x+d1JgIef2llyd69n2KP
	jynrm8ucR13/tIv0QUpzfrtEqH5T7KMbDuEcSzRz7JHVVyicNxJU1DGAftgTVtaSm/D86v
	x2b35LtAh4D7aFrrs/hoJKX8ukN2GJA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Ugwu3jE6PvmfWYrAi4VCGQ-1; Mon,
 10 Feb 2025 08:05:07 -0500
X-MC-Unique: Ugwu3jE6PvmfWYrAi4VCGQ-1
X-Mimecast-MFC-AGG-ID: Ugwu3jE6PvmfWYrAi4VCGQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAB7B1956088;
	Mon, 10 Feb 2025 13:05:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 869601800570;
	Mon, 10 Feb 2025 13:05:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mv4N9zFOKTxwdvk6ahAyjgpYULQp8iw2NMu3eB6FEXh0A@mail.gmail.com>
References: <CAH2r5mv4N9zFOKTxwdvk6ahAyjgpYULQp8iw2NMu3eB6FEXh0A@mail.gmail.com> <3bd10acc-2d7f-019a-3182-82ab647bc15a@huawei.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Wang Zhaolong <wangzhaolong1@huawei.com>,
    stable@vger.kernel.org, linux-cifs@vger.kernel.org,
    yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>,
    Paulo Alcantara <pc@manguebit.com>
Subject: Re: [BUG REPORT] cifs: Deadlock due to network reconnection during file writing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3049254.1739192701.1@warthog.procyon.org.uk>
Date: Mon, 10 Feb 2025 13:05:01 +0000
Message-ID: <3049256.1739192701@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is before cifs moved over to using netfslib (v6.9) and netfslib took over
all the dealing with the VFS/VM for I/O and the handling of pages/folios.  Do
you know if the same problem occurs after that point?

David


