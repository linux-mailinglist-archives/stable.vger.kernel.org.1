Return-Path: <stable+bounces-47943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A508FB8D8
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F2C1C22EB0
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67215145B39;
	Tue,  4 Jun 2024 16:26:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27C26AF1
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518368; cv=none; b=F2muX/6pxbGBcj7KFEQy9qwKCQ4drbltDxDOZv4+egNt/zbGvLldY4nI/n2Qu+NPgCSjbopy2lS5kYZW6P/Yo5dPx+te4WYfqBENsln4wKrnVxuMY8Ny9C4GkJn+QYla4v07WHm/EN/1RJSrTkXdkrsX+dFTRZr9ChCxGOAIEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518368; c=relaxed/simple;
	bh=XPmGvOzNnrhwsTsD9EVleM2I5x8ndTBpgpCMcX5EwzQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iBKAw9aw9VimvBIdTqQQV0HCH8InLOKo7MdzTXpwzuBbEJqQ8tVadtHwJym8AoGo+1+Nadgsaq0q/HXIwWUOxVTwuPYl6fMJUXvvYLG/PF1Y1bKU+DuuRczLU1cSke25wJQZrQ0qNTovsFFF/RWi7MDiyVojhn7tpX1AJbkRw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7553.dip0.t-ipconnect.de [93.221.117.83])
	by mail.itouring.de (Postfix) with ESMTPSA id 7E89610376E;
	Tue,  4 Jun 2024 18:26:02 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 424BAF0160B;
	Tue, 04 Jun 2024 18:26:02 +0200 (CEST)
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
 <2024060452-headrest-deny-2a5b@gregkh>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
Date: Tue, 4 Jun 2024 18:26:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024060452-headrest-deny-2a5b@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-06-04 17:44, Greg KH wrote:
> On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffstätte wrote:
>>
>> Just ${Subject} since it's a fix for a potential security footgun/DOS, whereever
>> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
>> has been queued up.
> 
> Only applies to 6.9.y, have backports for older kernels?

No, sorry - I'm just the messenger here and moved everything to 6.9 already.
Cc'ing Jakub and Eric.

My understanding is that the previous commit was a performance enhancement,
so if this turns out to be too difficult then maybe 378979e94e95 ("tcp: remove
64 KByte limit for initial tp->rcv_wnd value") should just not be merged either.
I have both patches on 6.9 but really cannot say whether they should go to
older releases.

Let's wait for Jakub or Eric.

cheers
Holger

