Return-Path: <stable+bounces-169700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74127B277E4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 06:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287ADAA0F4A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505C2185B8;
	Fri, 15 Aug 2025 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HTLgno2y"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0D10942;
	Fri, 15 Aug 2025 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755233481; cv=none; b=BMwJ/6AD9ID7euWcdfWq1KyWsxyLqh4wZqmWY+SL8VC7wJ53et4/PG1n1lWanEIEqxVnDpTEXfnMboSW5A+M6TT8NwviiT8UYBVgMi6wPeTbsCpbwELpq+uFb5bCxpqnPzYnbUDtakihlsJ5zFxCIXJdxrfBNaPbRggSBui1NoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755233481; c=relaxed/simple;
	bh=+UHYjqlJl2fb1gjhQSzprr6FAHW4wm7uqqAjUMY6fKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RucTVstJCkJ0FpaasVqyDZ+SGAE1gRGfyz+HSiMjnMOLfVnLvPsRwIH9+zYoXX0MZxsba2UTD5Tuf/R+VKSBc4ulwE+VaEzseVYn/agb3hpQBUdLXtNWrrQKj4JKr2KuJvJJ800d8hUnmiNFK5UJ3nassaiRGvXYcunDckB9YiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HTLgno2y; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 58D9D14C2D3;
	Fri, 15 Aug 2025 06:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755233476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uxBniPwyaO+yNFnnHEfGjdgeq+9rf4sD2sPCvixeD8=;
	b=HTLgno2y3nd+UN7LonYAuK4aFtjsMowRW84yZrbBavcnUHzgBmY4wQj4k4FoaLWhRZ9Wdi
	CR3kJYCAXWCccz8haAyzQYzVs44GGGqAkxAEDjM35BknSOOxJFdXPVqWQspt2yXEQnNtly
	XKSd3S5HPlMGTrBI5TU6wa5CTS/g1ATMY4FqLmGjhqUR2hUZ8Knx5iElg2SqsShxb2tYeS
	mmZj6I9WZ/il9u7zdM48Wb5yRsJn8gJTwCaqaFJ/XqoQNhYsyd1laLzOKszRgfnX59Q8Fh
	WeHxIcjsEO4AKiO98s09q8i3XHf1BKM0E9RqdDwQy/OagRuuW0DaEaINmtLKxg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e3824f1a;
	Fri, 15 Aug 2025 04:51:12 +0000 (UTC)
Date: Fri, 15 Aug 2025 13:50:57 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Cc: v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Wang Hai <wanghai38@huawei.com>,
	Latchesar Ionkov <lucho@ionkov.net>, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: fix double req put in p9_fd_cancelled
Message-ID: <aJ68sV1kH2CQ8eYr@codewreck.org>
References: <20250715154815.3501030-1-Sergey.Nalivayko@kaspersky.com>
 <aJ6U3DQn876wGS4C@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ6U3DQn876wGS4C@codewreck.org>

Dominique Martinet wrote on Fri, Aug 15, 2025 at 11:01:00AM +0900:
> > Add an explicit check for REQ_STATUS_ERROR in p9_fd_cancelled before
> > processing the request. Skip processing if the request is already in the error
> > state, as it has been removed and its resources cleaned up.
> 
> Looking at the other status, it's quite unlikely but if other thread
> would make it FLSHD we should also skip these -- and I don't think it's
> possible as far as the logic goes but if it's not sent yet we would have
> nothing to flush either, so it's probably better to invert the check,
> and make it `if (req != SENT) return` ?
> 
> client.c already checks `READ_ONCE(oldreq->status) == REQ_STATUS_SENT`
> before calling cancelled but that's without lock, so basically we're
> checking nothing raced since that check, and it's not limited to RCVD
> and ERROR.
> 
> If you can send a v2 with that I'll pick it up.

Actually it's just as fast if I do it myself, if you have time please
check this makes sense:
https://github.com/martinetd/linux/commit/afdaa9f9ea451a935e9b7645fc7ffd93d58cdfed

This is a fix but I don't believe it's urgent (can only happen with a
bogus server, and while in theory we should aim to be robust to an
adversary server I don't believe 9p is anywhere near that point), so
I'll push it along with other fixes next cycle as I missed the 5.17
train

Thanks,
-- 
Dominique Martinet | Asmadeus

