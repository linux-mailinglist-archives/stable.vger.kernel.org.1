Return-Path: <stable+bounces-116406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6AA35DCE
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878683AE146
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C7263F41;
	Fri, 14 Feb 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyALb3t9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97103263F43
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536968; cv=none; b=hJYTrDt2f9IEkYbfVfymTVgbDq6DvA9qzPinKs4bpwLtaM1reCmQ0Mcv1GjqHbdi72DAu6t05dTFlcDjZ4RRwz6RmJ1k3Ti1n5dlLWqBJBaux4vK+Kk2DGkrzFOnkwX4UD6SBDji8NYHnjGxPtfY4Zz/rib79lkRbe59FYBCsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536968; c=relaxed/simple;
	bh=d11x50LxRQmrP1+dyTgBwa9f88B58AqvvEqtw+md3vo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=goUpGWemFj4VdavVlWSFKoSBcn8nxtKhEw3p0M7DS7Uvn8u18mw3CuaTBiHcC6619J/TmSMS9a7w0L5g6yps+5OtmuD+MHmRslNheNzDnFQpfW/5ldYdciOsaQHtQlHl98HvbtN1iv/CwNT8T5Z5E0sygihvKNtCDizHE9ye45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyALb3t9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739536965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeI2phbh9W6eJPANE+hSKKu7J5Y3ZY+RS2E2MDT+/Mg=;
	b=LyALb3t98TxxQD49E/sWFi19ZgwWEm5nos6PLFLXEjgjtTog/onBDx/BABbC2ARCAF/KOM
	d6bQMuvxlZrX0y3AJ8ZXg6etDInwYpnZyQvTxzskkxYXQFpPKLO30ECOv2mJetK+dZsYN8
	TGiGB+1fiYg+tLmy+AlKXc7+MLlYVbU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-a9oD0zXqNjK2Sbi1lAnHAA-1; Fri,
 14 Feb 2025 07:42:42 -0500
X-MC-Unique: a9oD0zXqNjK2Sbi1lAnHAA-1
X-Mimecast-MFC-AGG-ID: a9oD0zXqNjK2Sbi1lAnHAA_1739536961
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBD93180087F;
	Fri, 14 Feb 2025 12:42:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC8621955DCE;
	Fri, 14 Feb 2025 12:42:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250210223144.3481766-1-max.kellermann@ionos.com>
References: <20250210223144.3481766-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without `marks3`
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3977862.1739536957.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 12:42:37 +0000
Message-ID: <3977863.1739536957@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

> At the beginning of the function, folio queues with marks3==0 are
> skipped, but after that, the `marks3` field is ignored.  If one such
> queue is found, `slot` is set to 64 (because `__ffs(0)==64`), leading
> to a buffer overflow in the folioq_folio() call.  The resulting crash
> may look like this:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Signed-off-by: David Howells <dhowells@redhat.com>


