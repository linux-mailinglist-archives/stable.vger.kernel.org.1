Return-Path: <stable+bounces-145360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2884ABDB3C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5611618846FB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298962472A0;
	Tue, 20 May 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNfnWO2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB0246771;
	Tue, 20 May 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749949; cv=none; b=A4+snVGfUBA2i3GW4YEPOt8d9mW2ySk8QwKtA2uuNwyr7cwaSdrv+f+p1j6pkwxmgZGtmeJd243oV5cLry6QL1uNIU3XfRMBALgISNKXWYnLx65TGZVjbSb3lpAZH6bVBkKIeWjeyhOiObP2E9Z85vZxNK9KIpo4wcVvbYYsmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749949; c=relaxed/simple;
	bh=lrlaLs075/1+yI2CaTlSIMaGDptvalmCT50NYyZ+YnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbvYD/gte6ZhwNfR2GQuJrMadL4aHhyYhX7mOHWqvbACdVaeFisyQV6xj3wLEo1hEq02v5JilO271TstEuCxQs9Q9yKLggX62faPjY9sH2EFw0/Unm2a4VN5XJuShLhHbdiFhUWmEfz/+SOQtUNP0FNzuBO/1Dgf3egY+9N/S2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNfnWO2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCCEC4CEEB;
	Tue, 20 May 2025 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749949;
	bh=lrlaLs075/1+yI2CaTlSIMaGDptvalmCT50NYyZ+YnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNfnWO2iPC/6p2bZY8tsN1QlgILA1MTSns++SoE8iOaeBcnJHKtbI26yP/gkZWsPf
	 +A/kbUiU0RB3Q0o6DWGN5kWAqokAX3mztj4yAjcUxaJ32ZRNWJMnXao2vTZ4K71vW0
	 s8wGo2GWl8BXj1d3AOGa+XaEvpDGnAh/8OEnfbEDs19IJH33ixdZKHOr4/KhZxZKzZ
	 8XclYRdHl8L5GLG4EL7EETqgysjslK1V+N0oypPADh/WKkh2+ilueWWu35/Tc02Agl
	 1j/Dp2Afb+mLAB3XCyoZeemBsFgrSlUlbPKZ3ooXu5ifZcih+B5rlfdVwdTYgWZEla
	 l5azBxko/QuOw==
Date: Tue, 20 May 2025 10:05:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	mhocko@suse.com, Liam.Howlett@oracle.com, mjguzik@gmail.com,
	pasha.tatashin@soleen.com, alexjlzheng@tencent.com
Subject: Re: [PATCH AUTOSEL 5.4 66/79] exit: change the release_task() paths
 to call flush_sigqueue() lockless
Message-ID: <aCyMPJBQWOruA176@lappy>
References: <20250505232151.2698893-1-sashal@kernel.org>
 <20250505232151.2698893-66-sashal@kernel.org>
 <aBnwt9cbww5R6TnN@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aBnwt9cbww5R6TnN@redhat.com>

On Tue, May 06, 2025 at 01:21:27PM +0200, Oleg Nesterov wrote:
>I'm on PTO until May 15, can't read the code.
>
>Did you verify that 5.14 has all the necessary "recent" posixtimer changes?

You're right, I'll drop it. Thanks!

-- 
Thanks,
Sasha

