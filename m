Return-Path: <stable+bounces-73802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D496F92D
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B9EB21277
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D11D048E;
	Fri,  6 Sep 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdygw95e"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A31CCB45
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639731; cv=none; b=u9l7jW0i8g/aVecUjjn6pzjLy6mBitnmju6HIr4fYIqkDVeK9tAk1k/8Po4C1zh+o3+sw5W9M06HBlpEm2T7722XCcrYFmd/kBDMpwnsIV2pXrM//AZiunv+wht3LOBHgtm2JvGC9WrXQRD1xZ6BZkvoQkhvSGLwg3VkusGezwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639731; c=relaxed/simple;
	bh=TXuC/+F2XUyGn87egojk0ApoIHlgcbPmITN9HdFNYTc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZWjwbeuKAWuACOIIy23M+fofe+/Pm5kCkDcJymmIZARJOsx1wVSS9hO1NjUPCDccVetW+X2OAvlpZB31Wdsfa7k5ps0acFOMAwLrcApgLs6aa0xr5nKIeV3omt7gash9lEpbIeg1uoAhnEEnAEwX2PXOM4Wq1rPtnpWcNU7UeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tdygw95e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725639729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXuC/+F2XUyGn87egojk0ApoIHlgcbPmITN9HdFNYTc=;
	b=Tdygw95et035s9APEoWo8XrKC1rtCXfFeb4kWQ3tsZen1uZIg52CUEk58cn6zK+p+v/K36
	nHtsKLrroKf/Y9gmdqQaA7Le2RN/VVAd7lIDzOcUP/C3pnHDvlos1PUddEEbQ5TSTGDvOM
	E8ylqnxkQB50CsC7a8wgrBzGV550aiU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-kX2c_BokMaq0uFlzS0_0fg-1; Fri,
 06 Sep 2024 12:22:06 -0400
X-MC-Unique: kX2c_BokMaq0uFlzS0_0fg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AC4D19560B0;
	Fri,  6 Sep 2024 16:22:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05F4F19560AA;
	Fri,  6 Sep 2024 16:22:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8bce309d-f7ef-4929-bfad-6f0b5c55cfff@leemhuis.info>
References: <8bce309d-f7ef-4929-bfad-6f0b5c55cfff@leemhuis.info> <85bef384-4aef-4294-b604-83508e2fc350@proxmox.com> <0e60c3b8-f9af-489a-ba6f-968cb12b55dd@redhat.com> <1679397305.24654.1725606946541@webmail.proxmox.com> <5335cdb5-7735-463e-907b-617774d6f01a@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dhowells@redhat.com, Xiubo Li <xiubli@redhat.com>,
    Christian Ebner <c.ebner@proxmox.com>,
    Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
    ceph-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION]: cephfs: file corruption when reading content via in-kernel ceph client
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127683.1725639720.1@warthog.procyon.org.uk>
Date: Fri, 06 Sep 2024 17:22:00 +0100
Message-ID: <127684.1725639720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

"Linux regression tracking (Thorsten Leemhuis)" wrote:

> Thx. FWIW, there were some other corruption bugs related to netfs, one
> of them [1] was recently solved by c26096ee0278c5 ("mm: Fix
> filemap_invalidate_inode() to use invalidate_inode_pages2_range()");
> this is a v6.11-rc6-post commit.

filemap_invalidate_inode() is not used directly by ceph yet, and ceph doesn't
yet use the netfs DIO that would also use that.

David


