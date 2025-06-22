Return-Path: <stable+bounces-155268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7CEAE329C
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EF716E48D
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F2A219A86;
	Sun, 22 Jun 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mJYQMNfa"
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423D1F875A;
	Sun, 22 Jun 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750629549; cv=none; b=pruHQVVYcEny6phdtMGbjVv+frJgQEFTuO8g9csO79IUQziyMz5hlpCGjVIhIArLPy1UIyT1Ifkb8VtuwIxwClWSzIkzIQ/DjGcf29h3Rd/dYhTvxZh8vU7SZWRh0Z5HsfRiFkYOlroQxLiZHRJ+zHPyVJ4DltjoAwDd7q9t9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750629549; c=relaxed/simple;
	bh=2OABZ5Aau9KbgR1Zm+cB9UU2hHSzuwXcK9yvNTrNohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPcFPqrIC7z//KJwDBhZ70QdgVXWqRniHwv+mdbdr42UixAXSLt12fCRi+qV2st+zj5KR7j0VnJv3TSMk/WXVQh6iE+0vTb3HC01y2EzXZbKZnL1Uw2ZRn4NZ5/qJXeNJHzw4w/xCnSjBEbKq7fcYcQ38tT/RBWss5by6vyJ8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=mJYQMNfa; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=pKwgu71A+gqWy3XaAtAsQgfZgUfP6EO1C/JNbWXZpdQ=; b=mJYQMNfazdYdrhU6fsqcc9pJkr
	ZMTjB3bZrpa4YZuawBirr5X73xMo3cJy4Raz1AAm/SsDWDxRLPBW75g12fA3Eivbgez+AOuEFudxD
	HFz1zaIXPSBXXu4JQIb1UcrWmSXR7SVayg8MpLoKQGeyCknhWJChf6zZWesbjee8emHW3LPtCJC7B
	lWklikeu+O6o4z/I6Fnza534h+xPMQYicGF8Uh4Mtx3JbbBLqzMEvUAFbnwOEj6u8d93Vbl6yyxtB
	yM3bf6M9JJzrD8KoPpF5YchEtGqoDu1i1K2rn/WjtifgfyG8DK/9TUsgV+rNcK8klosf3PNQruNEP
	qK3pm7uFp6WK2pGTVDx7NjwUbqfyYNjoEoi/3mf0kJY0cIb25+9y8YAxV7sl9XqlSunqdJewTA9Bi
	YMA54MYUJJe/SohLUOKv5ZG/Ormy/sApm/mizPUzyqgBAyDA3RPLXOe5NZz1mjMJP1wkML7YYP2Hq
	EmoGn2eoXveWWydSdzjd6zDfZI7J2rAMd765bQ9znOnqlWXJUrkOzuQBxnp89cLbG/IE5gOq13sO2
	WUYijHXfyGAEdtpfbyiy6Ps5X1aRFr5YuAYqCCtlL6BPodCGZwXzC4WmU0FwfTGSU5gefy8Yl85QB
	S2F2XQ4oXLLSKypN9whWapn+fM7Hes2Zl7cnSqcMc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org
Cc: Kees Cook <kees@kernel.org>,
 Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, stable@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, security@kernel.org,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/9p: Fix buffer overflow in USB transport layer
Date: Sun, 22 Jun 2025 23:20:21 +0200
Message-ID: <2332540.nosMkMiWtC@silver>
In-Reply-To: <aFhqAergj6LowmyE@codewreck.org>
References:
 <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
 <659844BA-48EF-47E1-8D66-D4CA98359BBF@kernel.org>
 <aFhqAergj6LowmyE@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 22, 2025 10:39:29 PM CEST asmadeus@codewreck.org wrote:
[...]
> (... And this made me realize commit 60ece0833b6c ("net/9p: allocate
> appropriate reduced message buffers") likely broke everything for
> 9p/rdma 3 years ago, as rdma is swapping buffers around...
> I guess it doesn't have (m)any users...)

That patch contains an RDMA exception:

@@ -645,9 +664,18 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
        int sigpending, err;
        unsigned long flags;
        struct p9_req_t *req;
+       /* Passing zero for tsize/rsize to p9_client_prepare_req() tells it to
+        * auto determine an appropriate (small) request/response size
+        * according to actual message data being sent. Currently RDMA
+        * transport is excluded from this response message size optimization,
+        * as it would not cope with it, due to its pooled response buffers
+        * (using an optimized request size for RDMA as well though).
+        */
+       const uint tsize = 0;
+       const uint rsize = c->trans_mod->pooled_rbuffers ? c->msize : 0;
 
        va_start(ap, fmt);
-       req = p9_client_prepare_req(c, type, c->msize, c->msize, fmt, ap);
+       req = p9_client_prepare_req(c, type, tsize, rsize, fmt, ap);
        va_end(ap);
        if (IS_ERR(req))
                return req;

/Christian



