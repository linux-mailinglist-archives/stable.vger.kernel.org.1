Return-Path: <stable+bounces-69762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F369695909C
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 00:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF82B22BF9
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144511C8230;
	Tue, 20 Aug 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXI5hWWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858F3A8D2;
	Tue, 20 Aug 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193892; cv=none; b=VuwEURfRFVXny6vrxss2aWAHR9O04ayUT9ClO0qwURLOIEnn05Fg20VJFpB6cT3Kh/bxV8Tp8629o2+p/QZg9h9yRG4VzhfHbBOHgLXmAIZEZ7Q5WBYk0xw4jgv/zWVtaRMfaq3e0cSrZXC6wwnv0Yp7LovsKAsjc5hHLFuNFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193892; c=relaxed/simple;
	bh=n9+fi65MR0I0j9pznx9n5KquJh5DNSu+EH8YE0CR81Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD1LSr1+IC1KKmxzHWDGVNf6wx94VaHmyRuW7OY1Go9vnliyxUhGaE41bnMaN97NikjWvOxuenyVncuXUWXNzDWrj9cC2DiEw8r7IaACz/ud+oeOze/xDL3EGDIfUeBg/hA0CsLMRdyqy1k+a3BrG76VAQ2Xps6AcXxiUsb7LLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXI5hWWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9836AC4AF09;
	Tue, 20 Aug 2024 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193892;
	bh=n9+fi65MR0I0j9pznx9n5KquJh5DNSu+EH8YE0CR81Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXI5hWWz3T/cc79oFEX+JDfH2ONRcWe6PzTOjzKXsRaUn/PbwV0LYo0DNYuVgdsdl
	 2IP6RHW+RwTQTpkeh3wdryKoeN0ImHcMbdxDlgmMRd/wVDzoqSSLdCNOVuIGP+8R+A
	 T8llGuGy9tQf1QmuEECFV5TC/86/8yJGkmAqewjJLj2pMe4ubQ/HtHdoR2zyJNqJjn
	 BYQfwgrDzX8Q3ybmOt5ewf5YmA8kuT8TtH1wIQTvAMmZXjKTLUUFhfhVjsZYSzLF9c
	 0QHveWpa3Blx3Avcf3iUl6dA8U9JyVLhKEWXfQyAR0DH4A82fjY0OoYC4+9EXknTMe
	 E3zD+vGJBmxag==
Date: Tue, 20 Aug 2024 15:44:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org, Kumar Sanghvi
 <kumaras@chelsio.com>, Potnuri Bharat Teja <bharat@chelsio.com>, Rahul
 Lakkireddy <rahul.lakkireddy@chelsio.com>, Ganesh Goudar
 <ganeshgr@chelsio.com>, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH v2] cxgb4: add forgotten u64 ivlan cast before shift
Message-ID: <20240820154450.4a37077e@kernel.org>
In-Reply-To: <20240819075408.92378-1-kniv@yandex-team.ru>
References: <20240819075408.92378-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 10:54:08 +0300 Nikolay Kuratov wrote:
> It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
> There is no reason it should not be done here

The max value of the shift is 21. I wish you spent more than 5 min
looking at this code.

