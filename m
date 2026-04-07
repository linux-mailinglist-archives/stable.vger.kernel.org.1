Return-Path: <stable+bounces-233603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB5+FvsL1WlQzwcAu9opvQ
	(envelope-from <stable+bounces-233603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:51:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94953AF7D5
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFF5E3036628
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F473859EC;
	Tue,  7 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="FuXuMQcZ"
X-Original-To: stable@vger.kernel.org
Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001721B4156
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569208; cv=none; b=PhMERtyHW/Ly9tlgjbJyW47QTrjBN6eBUPkaKQWJqgvVq49e2/e+te+TGK5KAHTzcU2gT4RFQa4eZZuUfFh+MeuT0vvl6gNUrrsdegE3IHhqBoBhIm8xtXvbWJ6bsNQcV9ncPlT6+fIzopIv3olhEKSf9r9/LJzeUd4xMvtfQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569208; c=relaxed/simple;
	bh=h+ePfXHfcakNzWR5crCa4estyFPye0IdQWd33adIaCA=;
	h=To:From:Message-Id:In-Reply-To:Mime-Version:References:Cc:Subject:
	 Content-Type:Date; b=Wky8idV9mBVNHlkDvAKi+HIT53M7tI36RtW46gBAiLCWhhVg7dOhlFvCzQbjps37E31twrfmEwDYZYy1nuEY/JtyAld4zEtPNnNnbtBdyyZbv60xvGijY2XaEe6fMhwmm7BiRHf3qKa2cbaWXAjI6v6a2CJMLlGobw6O29+jLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=FuXuMQcZ; arc=none smtp.client-ip=209.127.231.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1775569201;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jgUfPRtwVx3FDZm/OYDhN205bm4Nd8x121g53GOsjso=;
 b=FuXuMQcZdUprh1OjKBUMJe6tXB/LuF8IwUhatlvUsALhgpEXcahIFAQvJn2K20RYA++3U2
 jicJv/pFFbNRRIWs7evjxki6R4PKK1YFC8L3KF8Ry6IZqPmOAQixabDE9cRIiYZdhQ/3+x
 +zaV0lLFMCK8aDs2wqBuXyAFlbtDAaFvC+VEtNBK0FIWorazuQ5RteLbrJef6ZYoTvZWdu
 OG5zMe79FpHcScpz/T+Ll3qq1dD3R8YdyAZxLITKY8VE0rBxr3QVfLv5hEMFJdISO03xji
 m40LZF4i8OKWku/QOrIxt/6qn5jgcQW5Q+zgp0H4jn08XWmmW91AzrvLKaYisA==
To: "Chia-Ming Chang" <chiamingc@synology.com>, <song@kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <ede626d0-6e0a-43bf-8aa6-eba6f6dcd1fd@fnnas.com>
In-Reply-To: <20260402061406.455755-1-chiamingc@synology.com>
Received: from [192.168.1.104] ([39.182.0.129]) by smtp.feishu.cn with ESMTPS; Tue, 07 Apr 2026 21:39:58 +0800
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402061406.455755-1-chiamingc@synology.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: <linan122@huawei.com>, <shli@kernel.org>, <neil@brown.name>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "FengWei Shih" <dannyshih@synology.com>, 
	<yukuai@fnnas.com>
Subject: Re: [PATCH] md/raid5: fix soft lockup in retry_aligned_read()
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Lms-Return-Path: <lba+269d5092f+5f3bea+vger.kernel.org+yukuai@fnnas.com>
Date: Tue, 7 Apr 2026 21:39:55 +0800
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233603-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[fnnas.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:replyto,fnnas.com:mid,synology.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: C94953AF7D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026/4/2 14:14, Chia-Ming Chang =E5=86=99=E9=81=93:

> When retry_aligned_read() encounters an overlapped stripe, it releases
> the stripe via raid5_release_stripe() which puts it on the lockless
> released_stripes llist. In the next raid5d loop iteration,
> release_stripe_list() drains the stripe onto handle_list (since
> STRIPE_HANDLE is set by the original IO), but retry_aligned_read()
> runs before handle_active_stripes() and removes the stripe from
> handle_list via find_get_stripe() -> list_del_init(). This prevents
> handle_stripe() from ever processing the stripe to resolve the
> overlap, causing an infinite loop and soft lockup.
>
> Fix this by using __release_stripe() with temp_inactive_list instead
> of raid5_release_stripe() in the failure path, so the stripe does not
> go through the released_stripes llist. This allows raid5d to break out
> of its loop, and the overlap will be resolved when the stripe is
> eventually processed by handle_stripe().
>
> Fixes: 773ca82fa1ee ("raid5: make release_stripe lockless")
> Cc:stable@vger.kernel.org
> Signed-off-by: FengWei Shih<dannyshih@synology.com>
> Signed-off-by: Chia-Ming Chang<chiamingc@synology.com>
> ---
>   drivers/md/raid5.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
Applied to md-7.1

--=20
Thansk,
Kuai

