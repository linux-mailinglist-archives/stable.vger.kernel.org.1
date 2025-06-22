Return-Path: <stable+bounces-155266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E1AE3273
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9694A3B0992
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67D1F2BAD;
	Sun, 22 Jun 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xdbX21Mh"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE411A0B08;
	Sun, 22 Jun 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628254; cv=none; b=Og+gS8pzCcCdP19vHybb3mkEyupDAZjTx3rr1ohCweoS1xk6I1xIU/FZS+qnnix5MYc8PzjwOgYRS3XytU5eFPjxZBUo1ZCdKURuY6noh1MGP92mlG1atQX0mu+U93lgcztMscANcZCFlOS5omuV7jLwn/aqXEM7cyi02QsNSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628254; c=relaxed/simple;
	bh=PiyYx0D7DHp1i6I7LGyVpcGHij0gzpGiuLrfKazlgOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQtFLDyDmNHchrY7r3CZUzwFjOfNJh/4mwyTY6ahJggADXWI/7fkJUliw+hG8/95ClPBAIYjpDCOeFx/FmDrdECNxKRflORQHqADgYn95NXdN146lR/4C3nnM1a3tZ1bR9W+iLq8y2ykV5IHvdUtb5hZYxT7nnFQvOS/DVXV++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xdbX21Mh; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 98E7F14C2D3;
	Sun, 22 Jun 2025 23:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750628250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXfWwuvWIHMt3iwfHv8lluOXP7T6x/8Jx+lA4Z3eTtA=;
	b=xdbX21MhbwhJpEGOoJ4ypwZ/5icCaQ/l63bipBrGLcSYHhZ3/ed3/C+zH1hTuj1K7/uoMQ
	DIWQoYsWkZ+7I06eVHGzOSnoXaCTUHSgFx/OFRu8sKYSdof86IJATFUBbWhbF1T3yKt/6L
	CVvYji5kYfdsYI+ciQ5qiLgd+ODviNW/joEjsYg3khD9jNT5PAficgcLx3cOOQPDuHQH5o
	5b6Q8lHzqzQ+rdRPN3UgfNiutQl8bLzldjCqUsnr4ctwp2MAzkY41XW4Ua0UVAOuK8R7hu
	biSGvEwK9CsRIyk3gfDSvqATq/hiG/5n4lIkO+/rJZNdQvXhfV8hC/ksD0Q7YA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f9ee9073;
	Sun, 22 Jun 2025 21:37:25 +0000 (UTC)
Date: Mon, 23 Jun 2025 06:37:10 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Kees Cook <kees@kernel.org>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	security@kernel.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFh3hqGbzC-K3ylo@codewreck.org>
References: <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
 <659844BA-48EF-47E1-8D66-D4CA98359BBF@kernel.org>
 <aFhqAergj6LowmyE@codewreck.org>
 <2332540.nosMkMiWtC@silver>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2332540.nosMkMiWtC@silver>

Christian Schoenebeck wrote on Sun, Jun 22, 2025 at 11:20:21PM +0200:
> On Sunday, June 22, 2025 10:39:29 PM CEST asmadeus@codewreck.org wrote:
> [...]
> > (... And this made me realize commit 60ece0833b6c ("net/9p: allocate
> > appropriate reduced message buffers") likely broke everything for
> > 9p/rdma 3 years ago, as rdma is swapping buffers around...
> > I guess it doesn't have (m)any users...)
> 
> That patch contains an RDMA exception:

Oh, thanks for pointing that out!


BTW I just tried __counted_by and it's not obvious because it's not
allocated with the fcall (fcall structs themselves are allocated in the
req, and each fcall gets a data buffer)

For everything other than RDMA it shouldn't be too difficult to bubble
the allocation up (fcall+data as a flexible array as a pointer in req),
but then with large "round" msizes we'd get into the next power of two
buckets so I think it's probably better to keep as is.
(.. that and I wouldn't look forward to rework the buffer swapping logic
with RDMA, even if it should be straightforward enough with a couple of
container_of()s...)

Perhaps when/if counted_by learns to apply to pointers:
---
.../include/net/9p/9p.h:558:13: error: ‘counted_by’ attribute is not allowed for a non-array field
  558 |         u8 *sdata __counted_by(capacity);
      |             ^~~~~
make[3]: *** [.../scripts/Makefile.build:287: trans_xen.o] Error 1
In file included from client.c:22:
---

Thanks,
-- 
Dominique Martinet | Asmadeus

