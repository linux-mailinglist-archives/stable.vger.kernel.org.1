Return-Path: <stable+bounces-9144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA30820C01
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C681F214DA
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440479D4;
	Sun, 31 Dec 2023 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHosPwMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D768BFB;
	Sun, 31 Dec 2023 16:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BF1C433C7;
	Sun, 31 Dec 2023 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704040608;
	bh=xHR2BmGNhsT1V2gyQzJQlFuD7Bsc1mYJR1dfjZOk9ZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qHosPwMa46ex6qH+a3YY77ZIeHM/VQaKn4VyuTm4/ooSRe5U4aW4+Kgl2y8I65wbV
	 szkTrnilWGqu6xNF6ZGUfEkWON5/DpuOfBbV0huDPa1nQ6+R6t9MOzspy22W0L0TgE
	 6f4ZnAE8LTfGaDL7XupXIvQHgGHTwzz1gUPI35446FhU+Sm2c8BL7hwrkOZU2kWpht
	 QJ3lBEep3mO5f9SmOM+Tinp5AUyl/s2+pNRujecZPCa9Tgfn0qZ/yJRkdFY6A8kz+y
	 1krBbq4AeLeUXYLC7wlkdes9t/4aawHTS2xDNkoN8FXKWHy2T5/1LiVo/afgd+MKm5
	 RzAJ9KwNadXag==
Message-ID: <42ad4a1e-3a48-48aa-acd1-47d44b2ad0ba@kernel.org>
Date: Sun, 31 Dec 2023 09:36:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rtnetlink: allow to set iface down before enslaving
 it
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 5:08 AM, Nicolas Dichtel wrote:
> The below commit adds support for:
>> ip link set dummy0 down
>> ip link set dummy0 master bond0 up
> 
> but breaks the opposite:
>> ip link set dummy0 up
>> ip link set dummy0 master bond0 down
> 
> Let's add a workaround to have both commands working.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/core/rtnetlink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

add tests to tools/testing/selftests/net/rtnetlink.sh


