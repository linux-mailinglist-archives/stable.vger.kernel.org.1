Return-Path: <stable+bounces-213134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGnlMLI8gWk8FAMAu9opvQ
	(envelope-from <stable+bounces-213134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:09:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64FD2D97
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F081D302A685
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CABE555;
	Tue,  3 Feb 2026 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBgtpe0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBA1391;
	Tue,  3 Feb 2026 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077272; cv=none; b=LwjFtT037etkfBy4qZeDzk2inO0Q89CGBfp8emJrvJhIwc0zmlC3zuRl7cH9RncKxan5QDcwbVvajbFIhuvJXy1c3cghgqeR5V+L9EG914EZ5b5SyjwKIThodsDXHjVXFJGqgu1lajv3HGKxcudjOTFQAlwKreBch2suBr8m8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077272; c=relaxed/simple;
	bh=nXqk8d1z2oz+UoGCCuqxysoycNxPHubr8IUMz/ULFgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noUzz/qNKCHuA9vZ24kCPoc4lFxqPC3M5W4tmu3zlkzk8nJTEB7c2vn4lSAyKxtyq9IbpzwhfGcbSNhFcC9CssFZFp5GAlmF4BB6fsbkijr8WHhUYStcMyROl/wdSkL1mUA4e3gMj3IPQE1k614MdrcjrrrgXWRcTAQ8xWP3OH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBgtpe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB0C116C6;
	Tue,  3 Feb 2026 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077271;
	bh=nXqk8d1z2oz+UoGCCuqxysoycNxPHubr8IUMz/ULFgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFBgtpe0XnEQfXrd+gJO5dWJ+hrMrwgxSojv3dFmcSPhw2KHVNTfbreEFbPU0Njjz
	 nvG5+uvdv0WldgD5IJAdtjVVeKUwgMq9tD5IsGga8IhdLZD1efoHIVSkmBKHMi3JaV
	 36SPMDYDfoIZPcCSxGfzgNzb0okwJ+gBvEzo+be2Gb2KH3tjywyAIOs6tIFpytw+0W
	 rODxjslQT1MRfqe+83fsY1kc4Q88KbziWsV7RzZIY+0DVy50/f5TAcViY8aSbBsaLi
	 WDE8GStBBWpLN4iRWevisau18U4ys9bf7ept/vH7KjD83kesN5hDfCyp1Yjm9ZRtfc
	 1pEw0azB8lGTw==
Date: Mon, 2 Feb 2026 16:07:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Yanteng Si
 <si.yanteng@linux.dev>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i
 to clk_csr_i
Message-ID: <20260202160749.454a7ffa@kernel.org>
In-Reply-To: <20260201023619.366505-1-chenhuacai@loongson.cn>
References: <20260201023619.366505-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D64FD2D97
X-Rspamd-Action: no action

On Sun,  1 Feb 2026 10:36:19 +0800 Huacai Chen wrote:
> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> so correct it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

The CC stable is unnecessary, please repost without it.
-- 
pw-bot: cr

