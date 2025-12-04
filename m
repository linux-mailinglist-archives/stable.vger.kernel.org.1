Return-Path: <stable+bounces-200045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC3CA48A0
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BBF30A35C0
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908E2F3C25;
	Thu,  4 Dec 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThtB4NIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0diRqw4"
X-Original-To: stable@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417E2F360A
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865894; cv=none; b=DlP95aC5+BwSRk/P/ss/NVnCPrSICZUrAl/Cr+jKjA5LpDsX5wa7ZEO5wCWm1bY/oT+s1SecSIWA34WSarwwei0F/15BRjA8/gq5f3CUrRv0hQHhIlpYr9SVL5Fz+1Sz2mYInoab5L8Of6AqB5eapU1uHTJXUJjfSof6fAf5GwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865894; c=relaxed/simple;
	bh=KbEil2lubnfSakCS41E/8rJxcQMGzpPhzaGip53kKUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB6MhK4GJhN6ZmdK0TslszZyAIXFYW6FKK4zOYvxdB5++q+R/unyDV8Fe/9UvRKcAvum7g6xuW1ArqtkyTJjvcPj4+7AkXyexGUQatwC9TW8T8WGr1xbEyvNUV3bAScUcxTYllU0TPslbFWUzqOqn43nbsKa9weHiGW7nINCTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThtB4NIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0diRqw4; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 6C7AC138064B;
	Thu,  4 Dec 2025 11:31:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 04 Dec 2025 11:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764865891;
	 x=1764873091; bh=yqPGATl2rTanhgyzXYobGmpCO+TOPUonPFn5aoFMLVY=; b=
	ThtB4NIXPNYa40EfYlh+BiEzG68dWAVz6G/AD+8GiNFjL3uXDnBHwETKC5as6vFm
	oQq2hWW8xlCrtjV+h3ytU/wwxojPO7VQT+t2n3YTnbe6CWOKRCKlKIN+FQrFQ32L
	DR34evyQ/2EFRz7NgLY4lQh85iuAU1+2wJcVCspU7+dhDvORmoBKoHoqpvVausbZ
	2qOtd2lkyj0siQ8erFf2JNNTzLAuI/qp9M5MPAGcHiafYPC4PvtyRGYBvXr8bB9R
	9WxS6o+w4+pwrUziV/5lSoDBHZIx5TQdTYB9qVv7rPHa6i3C8CZksD2SZhBZtQ++
	l92tp1jr0KDT/VnEIc60zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764865891; x=
	1764873091; bh=yqPGATl2rTanhgyzXYobGmpCO+TOPUonPFn5aoFMLVY=; b=b
	0diRqw40g5HVole+KVyopWQh1aKjs8vazosmoYS4QgpTp6NCcJqVf6yW+lhHq3TE
	NYE8HY9IMzpRo+8Koo0+bTmT1xwIT8DLfE0xVyvLW1wkeNDaArgFmng/xsESetDk
	QlQDXLelfSsqwRsxrqNOmj9hZFeTFe2p6/vJVzlBhoMlDTgDvTRk5ExSQcxeyaBh
	4/do7V8fYPM4MG/tSt30cxLX/4nafajsrIUer8gzpxH4480/WhRsmk9TFLFoVTkE
	SHVZQKe6+jZdrc4OPvhcqerWsX5FatCeMD5jMaEk4zkbLK89rceMhFswWb78D4t1
	lLbJffj4I6lGrBTOeii2w==
X-ME-Sender: <xms:Y7cxac_HUVFuzguP8KI3RFqXgRRS83zo4UdAu6hsa_W4U14AMi32Bw>
    <xme:Y7cxaeB8F7LbTmC0nhqNT5WtF5ND_2IOw1JsU4s4I_Xj5GBWUcRvAWhrm38MV25mH
    zM2J1c3S5vRVF8uTSMxjUGqY80YyJa7fP63D0Yil0kPL71SsfFcXnA>
X-ME-Received: <xmr:Y7cxaZQ6J7N5d44Lu6lb5ClrSwl1c5Uj-b_30lyoJbxsA5_tq9yMDPP6qx2Uq4I0POByWPvWo7_QFN7fVL3TIUB06T1l8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefjeeggeehkefghfeviedvheeghfelleefkeeutedvtdffgfevheek
    iefgffdtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghttghhvg
    hssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphhhihhlihhpphdrghdr
    hhhorhhtmhgrnhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughomhhinhhikhdrkh
    grrhholhdrphhirghtkhhofihskhhisehprhhothhonhhmrghilhdrtghomhdprhgtphht
    thhopehlihhnuhigsehrohgvtghkqdhushdrnhgvth
X-ME-Proxy: <xmx:Y7cxadsH9W0ND_aPolSfbucC7Nf9aE0Y31crol8gSlZTGiDsy3zwiQ>
    <xmx:Y7cxad2QTywXBa7MWq-Gri0l7ldk2_KvN5oWkCkSQjDi8rS9Gt0OsA>
    <xmx:Y7cxaWVAkYraFO9XpzxBGVoCz2IHjoXkbnoMZCkCACeiE5LhlASRVg>
    <xmx:Y7cxaQIFE15XLqDb0SzbiqTNfE-RGdRSyQNhsiUkQh13WbwNqGyXpA>
    <xmx:Y7cxaY_dmHeMxvl_-cmHp-sF5i7hC-0xBaVvxsrZk3kh3K2jtL0Dyugq>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 11:31:30 -0500 (EST)
Message-ID: <d1588e38-c109-4784-86bc-a45d370430d7@pobox.com>
Date: Thu, 4 Dec 2025 08:31:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 114/132] [PATCH v6.12] staging: rtl8712: Remove
 driver using deprecated API wext
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251203152343.285859633@linuxfoundation.org>
 <20251203152347.516234988@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20251203152347.516234988@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 07:29, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> 
> commit e8785404de06a69d89dcdd1e9a0b6ea42dc6d327 upstream.

As far as I can tell, this isn't the correct upstream commit. Commit 
e8785404de06a69d89dcdd1e9a0b6ea42dc6d327 upstream is
"Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete"
and I think the actual upstream commit for this patch is 
41e883c137ebe6eec042658ef750cbb0529f6ca8.


Once the incorrect upstream commit ID caught my attention, I also 
noticed the following:

> The longterm kernels will still support this hardware for years.

The commit messages for the 5.15, 6.1, and 6.6 backports removed this 
line. (I'm mentioning this because I'm guessing the 6.12 backport commit 
message was also supposed to remove it.)

> Find further discussions in the Link below.
> 
> Link: https://lore.kernel.org/linux-staging/a02e3e0b-8a9b-47d5-87cf-2c957a474daa@gmail.com/T/#t
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> Tested-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> Link: https://lore.kernel.org/r/20241020144933.10956-1-philipp.g.hortmann@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [groeck: Resolved conflicts]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Another link that I believe does a better job of explaining why this 
driver is being removed from LTS kernels, and why now:

Link: https://lore.kernel.org/stable/20251204021604.GA843400@ax162/T/#t

-- 
-Barry K. Nathan  <barryn@pobox.com>

