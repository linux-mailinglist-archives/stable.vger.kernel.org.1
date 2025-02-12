Return-Path: <stable+bounces-115029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DFA321C0
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3021889D1E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8E205AD4;
	Wed, 12 Feb 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l5DppFAX"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EA1D86F2;
	Wed, 12 Feb 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351263; cv=none; b=VA4N2ms1uGGIpkktKNzPZgylqPc3XRc4DBKEelQeCcSeRjBkc0t2MrA7TGy76/4N+6P1ST6zFVdZ25CU3a6SWiorM8P9fE/OT22feHRbqBH4FobGJS3JH4y1RibDTndbs7/yN3AnsK6lIS/3xzfD4I+cNhOU4PgWzU9yUMkTvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351263; c=relaxed/simple;
	bh=4vWwTPj7CPp+P6c0oReSosDGvc+tz5Kxfec4CrpBq/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+fk0viqMqsBqL2j2FREtqEokm9TmGnv38iN2hCjnoSnrHLSd3YKn+iT7jF7/Z+2wvXN//FxuJXmmFA3oEbaWPILYOPt1plepIHktgl0jJbO+JMSbSmvGOMU3YGx6z2FwkRUiXSFP2zUyDJFhykyR4FBOJpbH+zG7EzaVZ+QJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l5DppFAX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EA6A204A8;
	Wed, 12 Feb 2025 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739351259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=goUycZkn0foMdzRm1ILExkPq1ZpIX7VLEl5diWuJzUI=;
	b=l5DppFAXBP9XMVJojhRDgAuY9zRuB+J0n9pa+IcFl+k182795VmZh7UeXjjMn5p6LkIs0g
	Nu0PcWy8SmyzIoDOTrhcFABom430/SwItcxqCQbi4QzrgfWPMGbBn4jPPNJTuCUjT9N1pY
	nqPm95X5HS1mP08yv7kLVtFKtWJkHmi9R0/IRNDUuacaSNHHcUr5HKGw+byAKzJBn7Mtg5
	/7++wEyky6rAfgBWlhn8kn3+d5Hu+qDZc2qx5SN7jP4FOrxHOsm7SNkQOJ0w4iTHwrLIQD
	dUsmCFXtGU5YiWfDYXsyaCtHinvNhi3Jz7fClMkUG425zU1TM6BIDFa0wCLXDg==
Message-ID: <edb5f1ba-52b8-4c18-be31-a24491c79d66@bootlin.com>
Date: Wed, 12 Feb 2025 10:07:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] rtnetlink: Fix rtnl_net_cmp_locks() when DEBUG is
 off
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexis.lothore@bootlin.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
 stable@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20250212-rtnetlink_leak-v1-1-27bce9a3ac9a@bootlin.com>
 <20250212084519.38648-1-kuniyu@amazon.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20250212084519.38648-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfehgefgteffkeehveeuvdekvddvueefgeejvefgleevveevteffveefgfehieejnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

On 2/12/25 9:45 AM, Kuniyuki Iwashima wrote:
> From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
> Date: Wed, 12 Feb 2025 09:23:47 +0100
>> rtnl_net_cmp_locks() always returns -1 if CONFIG_DEBUG_NET_SMALL_RTNL is
>> disabled. However, if CONFIG_DEBUG_NET_SMALL_RTNL is enabled, it returns 0
>> when both inputs are equal. It is then used by rtnl_nets_add() to call
>> put_net() if the net to be added is already present in the struct
>> rtnl_nets. As a result, when rtnl_nets_add() is called on an already
>> present net, put_net() is called only if DEBUG is on.
> 
> If CONFIG_DEBUG_NET_SMALL_RTNL is disabled, every duplicate net is
> added to rtnl_nets, so put_net() is expected to be called for each
> in rtnl_nets_destroy().

I see, sorry for the irrelevant series then ...

Best regards,
Bastien

