Return-Path: <stable+bounces-58246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D892A91E
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7C0B20BF6
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997BD14B07B;
	Mon,  8 Jul 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o08N8XTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD015A8;
	Mon,  8 Jul 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464257; cv=none; b=LAtiXRSJ8dr6EFRUi0FxWSHRaM106BWfftiBsT61AD6dmnLuHnDYcQx/vR/nelPzA0PO/NPuy67p6zdBZdytDr1rhBRwOpCNdaL5dBlp9nxHyonUJDZukBZqt/+VII8v7gII8qUr72sp3oFC9ON0YlZ3uJEB8ySpsIBC6FcRTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464257; c=relaxed/simple;
	bh=mNG0KIu/DjBmGc0IwlHX9FVjXZZf9zNwgn+AhqYnOsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdVyyBm1fdACmpH2jJYVMJ3kEeR0sloW2VilZpc97Gah4wrDD9VStJeYen5qRkOQjshZ7Ou4dj5RDbr6yVNSqc+MhJP3WGAR4/Jwtn1VwWYCYK0s0oEq45b35SbsCol064g0ayXAPFefanvJSrWgDZ9tyvbkt8+sU3kd3JRNy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o08N8XTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96453C116B1;
	Mon,  8 Jul 2024 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720464256;
	bh=mNG0KIu/DjBmGc0IwlHX9FVjXZZf9zNwgn+AhqYnOsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o08N8XTrBR6/pQu0L8OcrJqzhAgsCBFW5/n7gax6NPpRFphe/LUGPG9QaCNpoAQH7
	 8hZsMCtJ46kHnaa8a0AbuoOl4UvpwjHi2GYlWP2LLvDJgVj/Xd8fy5NMH5dB62rJd0
	 EY69lABrnc8E+C1y9elcnpf0yBghlP32+F8mSNrYoqLy8A8IgA5AJSs9h+1w2d9VPx
	 UmF+KLfn7XQSAM4hl1l/yy7JsxOYgALiZex5AktBqu743tBapxiI3gJ/6gktrjq5+p
	 EVDwWEheYDxqhHogfwNwoMHhALGASQIm87UgVvdVfiMei+Uxmsha3C+Bz+e1NaoYsT
	 0L2EXICa3CGxw==
Message-ID: <9b223661-0fa1-4f9f-8d35-b134f312a491@kernel.org>
Date: Mon, 8 Jul 2024 12:44:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] ipv6: fix source address selection with route
 leak
To: nicolas.dichtel@6wind.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
 <35638894-254f-4e30-98ee-5a3d6886d87a@kernel.org>
 <10327c0a-acf8-4aa5-a994-3049a7cb5abd@6wind.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <10327c0a-acf8-4aa5-a994-3049a7cb5abd@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 12:15 PM, Nicolas Dichtel wrote:
>> !l3mdev; checkpatch should complain
> No. I was unaware of this preference, is there a rule written somewhere about this?

checkpatch


