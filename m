Return-Path: <stable+bounces-134783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BAA95073
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940021883CA5
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A0264A90;
	Mon, 21 Apr 2025 11:51:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2321263C9B;
	Mon, 21 Apr 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236265; cv=none; b=LTnEe5S3H1OohT98SGfKliIQlA4GViJp/TUi/rin7X/FdKgeHRKuEjc1B4aLYTNtN8HYnP+aga9AYIzSGua2FXAz9Sz0UdtP6SBRcMjGbVcD/OfiKjfB/ePG3zOFy+158pqlwXsyyvCbc4pUnp7mRAuqfLMOsCWKKQHy4AZKgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236265; c=relaxed/simple;
	bh=xLSeYSn0wxwfBOXloKBUUIaklM5Lf3N9jYHxYSNill4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ExoaqWIgKPGmeTXXm+MffvwG8lQRQmqYF/0E5bZoLgPd+0cWAvQ+peRVnoy3jInZsbyNihQ5bgne06Sf7y/7PQK5eZpV6eI4F8EiLp98F/Cozrjm+tnj9cULvzsCL/mszel8x1vF4yGAwwoS4ZdjcvxKPyJATZ+Glxju0/2Q/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 670791255FA;
	Mon, 21 Apr 2025 13:50:53 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 32042601893B6;
	Mon, 21 Apr 2025 13:50:52 +0200 (CEST)
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
To: "Alan J. Wylie" <alan@wylie.me.uk>, Jamal Hadi Salim <jhs@mojatatu.com>,
 regressions@lists.linux.dev, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 stable@vger.kernel.org
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
Date: Mon, 21 Apr 2025 13:50:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421104019.7880108d@frodo.int.wylie.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2025-04-21 11:40, Alan J. Wylie wrote:
> #regzbot introduced: 6.14.2..6.14.3
> 
> Since 6.14.3 I have been seeing random panics, all in htb_dequeue.
> 6.14.2 was fine.

6.14.3 contains:
"codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()" aka
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/sched?h=linux-6.14.y&id=a57fe60ef4cf96bfbb6b58397ec28bdb5a5c6b31

Is your HTB backed by fq_codel by any chance? If so, try either
reverting the above or adding:
"sch_htb: make htb_qlen_notify() idempotent" aka
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ba8b837b522d7051ef81bacf3d95383ff8edce5

which was successfully not added to 6.14.3, along with the rest of the series:
https://lore.kernel.org/all/20250403211033.166059-2-xiyou.wangcong@gmail.com/

Hope this helps. I am running fq_codel without issue but not behind htb.

cheers
Holger

